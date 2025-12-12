# GoodYear EVP

- Responsible Operations: Operate safely, protecting people, customers, the environment, and the company’s reputation.
- Advanced Mobility: Promote sustainable, energy-efficient solutions that are safe, durable, affordable, and accessible.
- Inspiring Culture: Build a diverse, inclusive workplace that supports growth, well-being, and positive contributions.
- Sustainable Sourcing: Consider environmental and social impacts, risks, and opportunities in sourcing practices.

# Non-Technical Questions

### Can you briefly introduce yourself and tell us why you’re interested in this internship at Goodyear?

- currently graduate student at uni.lu in data science
- work at vr/ar lab and currently specializing in eye tracking in vr.
- for my bachelors, i did my bachelors in US, colorado in computer science. during that time i was working full time in a small computer hardware retail business.
- ive been studying data science for the last i would say 4-5 years.
- i started with coursera, i hold 3 specialization certificates and 2 course certificates.
- then i started competing in kaggle competitions, where I mostly focused on computer vision and signal analysis. there was also i think 1 regression task.
- then i started working on my own projects and eventually moved to luxembourg.

### How do you stay updated with new developments in data science, especially image processing?

Transformers: not designed for image data, but can be used for image data. Take visual transformers, ViT and DeiT (data efficient), that hold state of the art in image classification tasks (OmniVec). For image detection, again, visual transformer, Co-DETR.

- Looking for interesting papers. I recently read the one about data augmentation in latent space which can be used for any application practially.
- Follow newsletters, like the one from deeplearning.ai (THE BATCH). I think the last news was about robots on the loading dock: Autonomous vehicles, robotic cranes, and computer vision systems increasingly manage the flow of goods in and out of ports worldwide. Also about AI Acts
- I also just attended virutal webinar in computer vision hosted by amazon science.

### Describe a project where you worked with image data. What challenges did you face, and how did you overcome them?

1. HappyWhale:
   1. Imbalanced Data
      1. Data Augmentation, ArcFace, F1 Score
   2. Focusing on Fins
      1. YOLOv5 to crop images and isolate fin area
   3. Model Architecture
      1. I think we used EfficientNetB7 with ArcFace head, which is designed to maximize the margin between different classes in the feature space, improving the model's ability to distinguish between individuals. This is good for imbalance data too. Also ArcFace is good for fine-grained recognition, like face or fin identification.

### This role involves collaboration within a multicultural team. How do you approach teamwork and handle conflicts when working with people from different backgrounds?



### How would you ensure that your work aligns with business objectives, especially in a domain like tire damage detection?

- Learn About the Tire Industry.
- Learn more about the project objectives.
- Keep regular communication with my team regarding the work i am doing.
- Proper documentation.
- Stay informed and educated.

# Technical Questions

## Data Science and Image Processing

### What steps do you follow when starting a new image processing project?

1. Brainstorming
    - Identify the task, discuss data requirements, model options, evaluation metrics, and deployment plan.
    - Engage stakeholders if applicable to align project goals with business needs.

2. Data Assessment
    - Assess data availability and quality, including bias checks.
    - Identify if additional data or augmentations are needed. 
    - Consider consulting domain experts for feature interpretation.

3. Technique Selection
    - Determine if traditional imaging techniques can solve the task efficiently, or if ML/DL is required.

4. Data Preparation
    - Clean and preprocess data: remove NaNs, incorrect images, and split into training, validation, and test sets.
    - Ensure testing data remains untouched during training and evaluation.
    - Set up preprocessing (normalization/standardization) and augmentation pipelines.

5. Training Configuration
    - Define model training specifications: metrics, optimizer, loss functions.

6. Model Training
    - Train the model, monitor for overfitting/underfitting using learning curves.

7. Model Evaluation
    - Evaluate model on validation set using defined metrics.
    - Analyze errors (false positives/negatives) if performance is unsatisfactory.

8. Iteration
    - If evaluation results are poor, revisit data, preprocessing, or model configurations.

9. Deployment
    - Deploy the model with continuous monitoring to track production performance.

### Explain how convolutional neural networks (CNNs) work and why they’re effective for image data.

Convolutional Neural Networks (CNNs) are specialized neural networks particularly suited to image data due to their unique layers called convolutional layers. These layers use filters or kernels that act as pattern detectors, each storing weights that learn features through matrix multiplications with portions of the image. Early layers capture simple patterns (e.g., edges), while deeper layers identify complex features like shapes and objects.

CNNs are highly effective for image data because they capture spatial hierarchies of features, learning simple patterns (like edges) in early layers and complex structures (like shapes or objects) in deeper layers. By using shared weights across the image, CNNs are also parameter-efficient, reducing computation and overfitting. This shared weight mechanism makes CNNs translation-invariant, so they can recognize features anywhere in the image.

Pooling layers further reduce the spatial dimensions, helping the model focus on important features and increasing robustness to small shifts or rotations. Inspired by the human visual system, CNNs provide a structured approach to visual data, achieving high accuracy with less computational cost compared to fully connected layers.

**Translation Invariance**: CNNs are naturally translation-invariant because they apply the same filters across the entire image. This allows them to recognize objects regardless of their location within the image, which is especially useful for tasks like object detection and classification, where objects can appear in various positions.

### Can you describe data preprocessing steps specific to image data?

- Normalization: Scaling pixel values, often between 0 and 1, to improve training stability.
- Standardization: Centering images by setting a mean of 0 and standard deviation of 1, which is often preferred for images to make models converge faster.
- Data Augmentation: Generating variations of images through techniques like rotation, flipping, brightness adjustments, and cropping to improve generalization.
- Data Cleaning: Ensuring image-label correspondence, removing corrupted or misclassified images, and verifying overall quality.
Resizing/Reshaping: Ensuring all images are of consistent size and shape, as CNNs require fixed dimensions.
- Color Channel Adjustments: Convert images to the required color space (e.g., grayscale or RGB). Some models may also benefit from color space conversions like LAB or HSV if color features are crucial.
- Histogram Equalization: Useful for enhancing contrast, especially in images where features may be hard to distinguish due to lighting.
- Image Denoising: Removing noise can improve model performance, especially in low-quality images. Techniques include Gaussian blurring or median filtering.
- Normalization to Pretrained Model Standards: If using a pretrained model (e.g., ResNet), images should often be normalized to the same mean and standard deviation values that were used during the model's original training.
- **Segmentation or Cropping**: For tasks that focus on specific image regions, cropping or segmenting parts of the image can reduce irrelevant information and improve accuracy.


### What metrics would you use to evaluate the performance of a model that detects tire damage? Why?

In tire damage detection, there are two possible tasks:

1. Binary Classification: Classifying each image as “damaged” or “not damaged.” For this, metrics like Recall and F1 Score are critical because:
- Recall emphasizes identifying all damaged tires, minimizing missed detections, which is essential for safety.
- F1 Score balances precision and recall, useful if we need to manage both false positives and false negatives.
- Precision-Recall AUC (PRAUC) provides a comprehensive view of the model’s performance when there’s class imbalance, such as fewer damaged tires in the dataset.
2. Object Detection: Identifying and localizing specific damage areas on a tire. Common metrics here include:
- Intersection over Union (IoU): Calculates the overlap between the predicted bounding box and the actual damage area, a key metric for evaluating localization accuracy: $\text{IoU}=\frac{\text{Area of Overlap}}{\text{Area of Union}}$
- Mean Average Precision (mAP): Measures the model’s accuracy in locating and classifying damage within specific regions.
  - First calculate $\text{IoU}$ and see where score $> \text{threshold}$. Then calculate PRAUC.

### If you encountered an imbalanced dataset with very few instances of damaged tires, how would you handle it?

- Outsource Additional Data:
  - Searching for publicly available datasets.
  - Collaborating with other companies or departments to gather more data.
- Data Augmentation: e.g., flipping, rotation, scaling, oversampling, undersampling.
- Class-Balanced Model Training: Train models on various class balances (1:1, 2:1, 3:1, etc.).
- Use Class Weights and Appropriate Metrics: class weights inversely proportional to class frequency; Recall, F1 Score, PRAUC
- Anomaly Detection Approach: Since damaged tires might be rare, consider framing the problem as an anomaly detection task. Train the model on normal (non-damaged) tires and use it to identify deviations (potential damage).
- Ensemble models.
- Synthetic Data Generation: GANs, VAEs, Diffusion Models (GANs can be challenging to train due to issues like mode collapse, diffusion models tend to be more stable).
- Cross-Validation with Stratified Splits: Ensure each fold has a similar representation of damaged and non-damaged tires
- Transfer Learning.

### Have you worked with any image data augmentation techniques? Which ones would you use for tire image data, and why?

- For tire image data, simple augmentation techniques like rotation, flipping, scaling, cropping, brightness contrast adjustment, blur effects, noise, **CUTOUT OR OCCLUSION** are particularly effective. Rotation is ideal for tires since they are circular, allowing the model to learn features from different angles without introducing bias. Edge detection can also help emphasize damages, such as holes or tears, by highlighting contours and boundaries.
- Additionally, synthetic data generation could be useful, especially for rare damage types. Techniques like GANs, VAEs, or diffusion models can be explored to create realistic images of uncommon damages, which would enhance the model’s ability to detect these instances in a balanced way.

## Statistics and Model Evaluation

### What is precision-recall trade-off, and when might it be more relevant than accuracy?

Recall measures the model's ability to correctly identify positive instances, calculated as: $\frac{TP}{TP + FN}$. It’s useful when we want to ensure that all actual positives are detected, even if some false positives occur.

Precision measures the accuracy of the positive predictions, calculated as: $\frac{TP}{TP+FP}$. Precision is relevant when we want to assess how reliably the model identifies positives without including false positives.

In cases where increasing recall lowers precision (or vice versa), we encounter the precision-recall trade-off. This trade-off is especially important for imbalanced datasets, where a focus on accuracy can mask poor performance on the minority class.

### Could you explain what overfitting is and how you might prevent it when training deep learning models?

Overfitting occurs when a model learns the details and noise in the training data to the extent that it negatively impacts the model’s performance on new data. Essentially, the model becomes too “specialized” in the training set, resulting in a low error on training data but a high error on unseen data, indicating poor generalization.

To prevent overfitting in deep learning:
1. Regularization Techniques:
- L2 Regularization (weight decay) penalizes large weights, encouraging the model to learn simpler patterns.
- Dropout randomly drops neurons during training, forcing the network to learn more robust features.
2. Validation Set & Early Stopping:
- Use a validation set to monitor performance during training. If validation loss starts increasing while training loss decreases, it indicates overfitting.
- Early Stopping halts training when validation loss stops improving, preserving the model at its best generalization point.
3. Data Augmentation and Increasing Data Size:
- For smaller datasets, data augmentation techniques can artificially expand the dataset, helping the model generalize better.
- If possible, gather more data to reduce the risk of overfitting.
4. Reduce model complexity (sparse neural networks).
5. Cross-validation (subsets for training).
6. Adversarial attacks (adversarial training can be computationally expensive, as it requires generating adversarial examples for each training batch).
7. Ensemble methods.
8. Batch normalization (slight regularization).
9. Transfer learning.

### Imagine you’ve trained a model that predicts tire wear patterns. How would you validate its accuracy statistically?

- Regression:
  - Residual analysis (normally distributed)
  - Confidence intervals (prediction +- statistic).
  - Hypothesis testing.
- Categorical:
  - Confusion matrix.
  - Class-specific metrics.
  - Chi-Square Test: If you have expected frequencies for each category, the chi-square test can assess if there’s a significant difference between predicted and actual distributions, indicating any systematic misclassifications.

## Exploratory Data Analysis

### How would you go about performing exploratory data analysis (EDA) on a new dataset of tire images?

1. Visual Inspection:
- Plot a sample of images to get a general sense of content, quality, and variety.
- Check for anomalies or outliers visually (e.g., unusual colors, rotations, extreme wear patterns) that could affect model training.
2. Analyze Image Properties:
- Examine the shapes, sizes, and aspect ratios of images to determine if resizing or cropping will be needed.
- Calculate basic statistics on pixel values (e.g., mean, standard deviation) to detect unusual brightness or contrast variations that might indicate differences in lighting or image quality.
3. Distribution Analysis:
- Plot histograms of pixel intensity distributions or color channels (RGB) to identify any irregularities in color or brightness across images.
- Check for the presence of extreme outliers by looking at images that fall outside the normal range of these distributions.
4. Clustering for Visual Grouping:
5. Label Analysis:
- Examine the distribution of labels (e.g., “damaged” vs. “not damaged”) to identify any class imbalances.
- If there are subcategories of damage, explore the frequency of each type to understand the diversity in damage types.
6. Comparative Analysis:
- If an older dataset exists, compare summary statistics (e.g., mean, standard deviation of pixel values, label distribution) between the old and new datasets to ensure consistency or identify shifts.
7. Metadata Analysis (if available):
- If metadata is available (e.g., tire age, manufacturer), analyze it alongside image data to identify patterns that could be relevant for modeling.

### What specific visualizations might help you understand patterns or anomalies in tire image data?

Histograms, sample image grids, PCA plots, bounding boxes heatmaps to see the most common locations and sizes of damages, bounding box size distribution.

### Have you used PCA or any other dimensionality reduction techniques with image data before? How could they be helpful here?

- PCA used on extracted features rather than the original pixel data. First extract features using NN, then apply PCA to reduce the dimensionality. Once we have lower-dimensional representations, we can apply clustering algorithms to group similar images. 
- If memory is a concern, PCA can be used to compress high-dimensional image data, making it faster to process. 
- **PCA can help remove noise by preserving only the top principal components, which represent the most significant patterns in the data.**


# High-Performance Computing (HPC)

### This project might involve processing high-resolution images, which can be computationally intensive. Have you used any HPC resources or techniques (like parallel computing or GPU acceleration) in your past work?

- GPU Parallelization: I’ve utilized GPUs to accelerate model training.
- I’m familiar with submitting and managing jobs on HPC clusters using job scheduling systems, SLURM.

### Can you explain the difference between CPU and GPU processing and why GPUs are often preferred for deep learning tasks?

- CPUs have a few powerful cores designed for sequential processing, making them ideal for handling general-purpose tasks that require complex, branching logic.
- GPUs have thousands of smaller, less powerful cores optimized for parallel processing. This makes them highly effective for tasks with massive parallelism, like matrix multiplications in deep learning.
- **Deep learning involves a large number of operations (forward/backward prop.) on matrices and tensors, which can be processed in parallel.**
- GPUs generally have higher memory bandwidth than CPUs, enabling them to transfer large amounts of data between memory and processing cores quickly.
- GPUs are more energy-efficient for these types of parallel tasks, providing better performance per watt.

### What is batch processing in the context of deep learning, and how does it affect memory usage?

Batch processing is a compromise between memory constraints and computational efficiency. Instead of processing the entire dataset at once (which is memory-intensive and often impossible with large datasets) or one sample at a time (which is slow), we use batches that fit comfortably into memory and allow for efficient training.

**Batch processing also affects training stability and convergence. Using batch gradients (rather than single-sample gradients) smooths out updates (averaging gradients across the batch, thus reducing the noise), often leading to more stable and faster convergence.**


# Project Workflow and Industrialization

### Describe a typical ML pipeline for image processing, from data ingestion to deployment.

- Loading data.
- Data pipeline definition.
  - Data preprocessing.
- Model definition.
- Metrics definition (loss, metrics)
- Model training & evaluation.
- Deployment.
- Monitoring.
- Enhancing.

### What does model industrialization mean to you, and what might it involve for this tire detection and classification project?'

Model industrialization involves preparing the model for real-world, ongoing use in a production environment. It includes adapting the model to be both highly specific to the task and scalable for deployment at an industrial level. 
1. Data Pipeline and Preprocessing: automated pipelines
2. Converting the model to a deployment-friendly format and optimizing for inference speed.
3. Ensuring the model can handle large volumes of images if needed -> distributed systems.
4. Monitoring the model’s performance on live data to detect any drift or changes in accuracy.
5. Set up retraining pipelines.
6. Embedding the model into the company’s operational workflow
7. Documentation and compliance with standards.

### How would you handle model retraining and updating in an industrial setting?

In an industrial setting, model retraining and updating involve a structured, automated process to ensure continuous accuracy and relevance.
- Ensure that any new data undergoes the same preprocessing steps as the original training data.
- Decide between incremental training (updating the model on only new data) or full retraining. Fine-tune the model on new data if only minor adjustments are needed, or conduct full retraining if significant changes have occurred in the data distribution.
- Continuously monitor the model’s performance on new data to detect model drift or accuracy drops. Set up alerts if performance falls below a threshold.
- Aggregate new labeled data, if available, to use in retraining. This could be done periodically (e.g., monthly) or triggered by performance metrics.
- Evaluate the retrained model against the previous version using a hold-out test set.
- Deploy the updated model while retaining the previous version in case a rollback is needed.
- Use version control for models to track changes and ensure smooth transition.
- Set up a retraining pipeline.

# Wrap-Up Questions

### If given a large dataset of tire images tomorrow, what would be your first steps?

1. Data inspection and quality check.
2. Comparative analysis to old data.
3. Data alignment or preprocessing for training.
4. Decision on model update strategy.
  - Fine tuning.
  - New model -> ensemble.

### What are some risks in image-based tire damage detection, and how would you mitigate them?

1. Risk of Misclassification:
- Problem: The model might classify damaged tires as undamaged, which could lead to safety risks if damaged tires are mistakenly used.
- Mitigation: To reduce this risk, we could set a confidence threshold where tires with low-confidence predictions undergo a secondary inspection by a specialist. This would add an extra layer of quality control, especially for cases where the model is uncertain.
2. Incomplete or Hidden Damages:
- Problem: Some types of damage, such as deep cuts or internal stress fractures, might not be visible from certain angles or on the surface. Image-based models may struggle to detect these types of damages accurately.
- Mitigation: To handle this limitation, image-based detection could be combined with other assessment methods, such as physical stress testing or pressure sensors, to ensure comprehensive damage detection.
3. Variability in Image Quality and Environmental Factors:
- Problem: Variations in lighting, angle, or image quality could lead to inconsistent results. Poor-quality images could make it harder for the model to detect fine details.
- Mitigation: We can address this by training the model on augmented data with a wide range of lighting and environmental conditions, improving its robustness.
4. Class Imbalance:
- Problem: If there are significantly fewer examples of damaged tires, the model may not learn to identify damage accurately, especially for rare types.
- Mitigation: To address this, techniques like data augmentation, oversampling damaged tire images, and using synthetic data generation (e.g., GANs or VAEs) could help balance the dataset and improve model performance on damage cases.

### Do you have any questions about the project or team?

