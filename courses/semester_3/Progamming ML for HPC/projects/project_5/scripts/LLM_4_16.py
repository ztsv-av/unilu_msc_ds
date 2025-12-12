

model_name="facebook/opt-125m" # <--- select your LLM model


# PROCESSES CONFIG <----- DeepSpeed
import os
os.environ["HF_DATASETS_CACHE"] = "/tmp/"

pconfig=dict()
pconfig["master_addr"] = os.getenv("MASTER_ADDR", "localhost")
pconfig["master_port"] = int(os.getenv("MASTER_PORT", 9994))
pconfig["rank"] = int(os.getenv("RANK", "0"))
pconfig["local_rank"] = int(os.getenv("LOCAL_RANK", "0"))
pconfig["world_size"] = int(os.getenv("WORLD_SIZE", "1"))
print(pconfig)

# DETERMINISM FOR COMPARING CONVERGENCE
from transformers import enable_full_determinism
enable_full_determinism(42)

# DATA LOADING (takes 1 minute)
from datasets import load_dataset
dataset = load_dataset("yelp_review_full",  cache_dir="/tmp/")
print(dataset["train"][10])
print(dataset.shape)


# DATA PROCESSING (TOKENIZATION) 
# Remove the 'label' feature from the dataset because we are not doing classification
dataset = dataset.remove_columns('label')

# ## Tokenize dataset according to pre-trained model
from transformers import AutoTokenizer
tokenizer = AutoTokenizer.from_pretrained("facebook/opt-125m", model_max_length=512)
tokenizer.pad_token = tokenizer.eos_token
def tokenize_function(examples):
    return tokenizer(examples["text"], padding="max_length", truncation=True)

# Tokenization
tokenized_datasets = dataset.map(tokenize_function, batched=True)
n_rows = 2048
small_train_dataset = tokenized_datasets["train"].shuffle(seed=42).select(range(n_rows))
small_eval_dataset = tokenized_datasets["test"].shuffle(seed=42).select(range(n_rows))

# ## Data collating
from transformers import DataCollatorForLanguageModeling
data_collator = DataCollatorForLanguageModeling(tokenizer=tokenizer, mlm=False)


# MODEL LOADING
# ## Load OPT Model of 125m parameters
from transformers import AutoModelForCausalLM
model = AutoModelForCausalLM.from_pretrained(model_name)

# MODEL TRAINING CONFIGURATION <----- DeepSpeed
bs=16 # <-------------------------------------------- HARD CODED GLOBAL BATCH SIZE. ADAPT IF NEEDED.
lbs=bs//pconfig["world_size"] # compute automatically the local batch size
ds_config={
    "per_device_train_batch_size":lbs,
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
    output_dir="test_trainer-125m_4_16",
    evaluation_strategy="epoch",
    learning_rate=1e-4,
    weight_decay=0.01,
    per_device_train_batch_size=lbs,
    deepspeed=ds_config # <----- DeepSpeed
)


# TRAINING
from transformers import Trainer
#from accelerate import Accelerator # <-- Disable accelerator with DeepSpeed
#accelerator = Accelerator()
#model = accelerator.prepare(model)

trainer = Trainer(
    model=model,
    args=training_args,
    train_dataset=small_train_dataset,
    eval_dataset=small_eval_dataset,
    data_collator=data_collator,
)

trainer.train()

# Cleanup accelerator resources
#accelerator.wait_for_everyone()

# TESTING
print(model.eval())
eval_results = trainer.evaluate()
print(f"Loss: {eval_results['eval_loss']:.2f}")

