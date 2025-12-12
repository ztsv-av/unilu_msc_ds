model_name =  "google/vit-base-patch16-224-in21k"  # Vision Transformer Model

# PROCESSES CONFIG <----- DeepSpeed
import os
os.environ["HF_DATASETS_CACHE"] = "/tmp/"

pconfig = dict()
pconfig["master_addr"] = os.getenv("MASTER_ADDR", "localhost")
pconfig["master_port"] = int(os.getenv("MASTER_PORT", 9994))
pconfig["rank"] = int(os.getenv("RANK", "0"))
pconfig["local_rank"] = int(os.getenv("LOCAL_RANK", "0"))
pconfig["world_size"] = int(os.getenv("WORLD_SIZE", "1"))
print(pconfig)

# DETERMINISM FOR COMPARING CONVERGENCE
from transformers import enable_full_determinism
enable_full_determinism(42)

# DATA LOADING
from datasets import load_dataset
dataset = load_dataset("cifar10", cache_dir="/tmp/")
print(dataset["train"][0])  # Check a single sample
print(dataset["test"][0])  # Check a single sample
print(dataset.shape)

# MODEL LOADING & PREPROCESSING
from transformers import AutoImageProcessor, ViTForImageClassification
# Load image processor
image_processor = AutoImageProcessor.from_pretrained(model_name)
# Instantiate the model with correct number of labels
model = ViTForImageClassification.from_pretrained(model_name, num_labels=10)

# DATA PROCESSING
# We will apply transforms to the dataset so that it returns pixel values and labels.
def transform(examples):
    images = examples["img"]
    outputs = image_processor(images, return_tensors="pt")
    examples["pixel_values"] = outputs["pixel_values"]
    examples["labels"] = examples["label"]
    return {"pixel_values": examples["pixel_values"], "labels": examples["labels"]}
processed_train = dataset["train"].map(transform, batched=True, remove_columns=["img"])
processed_test = dataset["test"].map(transform, batched=True, remove_columns=["img"])
# Create a small subset for testing
n_rows = 2048
small_train_dataset = processed_train.select(range(n_rows)).shuffle(seed=42)
small_eval_dataset = processed_test.select(range(n_rows)).shuffle(seed=42)
from transformers import default_data_collator
data_collator = default_data_collator

# MODEL TRAINING CONFIGURATION <----- DeepSpeed
bs = 16  # Global batch size
lbs = bs // pconfig["world_size"]
ds_config = {
    "per_device_train_batch_size": lbs,
    "train_batch_size": bs,
    "train_micro_batch_size_per_gpu": lbs,
    "optimizer": {"type": "Adam"},
    "zero_optimization": {
        "stage": 3,
        "offload_optimizer": {
            "device": "cpu",
            "pin_memory": True
        },
        "offload_param": {
            "device": "cpu",
            "pin_memory": True
        },
        "overlap_comm": True,
        "contiguous_gradients": True
    }
}
from transformers import TrainingArguments
training_args = TrainingArguments(
    output_dir="test_trainer-vit",
    evaluation_strategy="epoch",
    learning_rate=1e-4,
    weight_decay=0.01,
    per_device_train_batch_size=lbs,
    deepspeed=ds_config # <----- DeepSpeed
)
from transformers import Trainer
trainer = Trainer(
    model=model,
    args=training_args,
    train_dataset=small_train_dataset,
    eval_dataset=small_eval_dataset,
    data_collator=data_collator,
)
trainer.train()
eval_results = trainer.evaluate()
print(f"Eval Loss: {eval_results['eval_loss']:.2f}")
