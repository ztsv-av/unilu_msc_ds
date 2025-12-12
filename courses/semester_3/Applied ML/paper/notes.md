## Data Augmentation Problems

1. Existing data augmentation methods are manually designed for different data modalities separately.
2. Data modalities are different forms of data, for example images, text, or audio
3. And the fact that we cannot use same data augmentation techniques for different modalities is a problem.
   1. For example, for images we have rotations, right. We flip an image, the image remains the same, but its good for the moodel.
   2. If we take text data and rotate words in a sentence, the meaning will change, it is not a good augmentation technique.

## Solution: MODALS

- There is a solution for that, and its MODALS.
- MODALS is a modality-agnostic automated data augmentation framework that performs data augmentation in the latent space. 
    1. **Modality-agnostic** refers to being **independent of any type of form of data** being processed (modality=data, agnostic=independent). 
    2. **Automated** means you do not need to manually define data augmentation functions, MODALS **searches for the optimal augmentation strategies** by itself.

### Latent Space

- What is latent space? Latent space is just a compressed representation of data. Think of an encoder model that transforms input image into a vector through some layers.

### Solution: MODALS

- So, it transforms the data in the latent space, meaning that MODALS works with ANY TYPE OF DATA MODALITY.
- For example, we take any type of data, we pass it through an encoder NN, this gives us a latent vector, we augment it and then pass it through an output layer, some classification head.

## MODALS Algorithm: Simple Examples

1. So lets try to understand how MODALS works.
1. First lets examine traditional machine leanring pipelines. 
2. We have input X, we run it through a feature extractor (an encoder NN without head layer), we obtain latent vector. Then we pass this latent vector to head layer.
3. Another way is to first transform the input data, i.e. augment it, and then perform the same steps as before, making the model more robust and train it on a more diverse set.

## MODALS Algorithm: Overview

1. Now to the MODALS pipeline. The steps are relatively the same, but with small smart adjustments. Instead of transforming the input data, we transform the latent vector, from $z \to \hat{z}$. Then we use classification head on this $\hat{z}$ vector. 
2. Now you might ask what are those Triplet Selector, Discriminator and Policy. Why do we need them.
3. Lets go step by step and understand the algorithm

### MODALS Algorithm: Step 1

1. First we have some input data, like an image, and we pass it through a feature extractor neural network. We get latent vector $z$.

### MODALS Algorithm: Step 2.1

1. Then we pass this latent vector to Triplet Selector. 
2. Triplet loss encourages the model to make latent representations of the same class closer together and those of different classes further apart. 
3. This way new augmented representations stay within the correct class and maintain label consistency.

### MODALS Algorithm: Step 2.1: Triplet Selector

1. So lets see this on a figure: If we use Triplet Loss, then class clusters are more defined and separated from each other, which is exactly want we want to achieve, right?
2. We dont want to augment the data and accidently augment it in a way that the vector is MORE SIMILAR TO ANOTHER CLASS.

### MODALS Algorithm: Step 2.2

1. OK, now that we understand what the triplet loss is, lets talk about the Discriminator. For those of you who don't know, the Discriminator is a neural network trained in a way that tries to fool another part of the network to ensure that the latent representations $z$ follows a desired distribution, like Gaussian. 
2. We use the Discriminator here so that the Feature Extractor produces latent vectors follow Gaussian (point to Gaussian N on the figure) distribution. This way, when we modify the latent representations, the changes are smooth and produce realistic variations between data points. This is important, right.

### MODALS Algorithm: Step 4

1. So now we have the whole pipeline. Just to repeat: we have any input modality, e.g. image or audio vector. We pass it through a Feature Extractor neural network. Then, if we are training, we compute Triplet Loss to make latent representations more class clustered and Discriminator Loss, to make latent representations follow Gaussian distribution.
2. Then we Augment the latent vector $z$ using the PBA Policy.
3. Finally, we pass the augmented latent vector $\hat{z}$ through some Dense Layer.

## How MODALS can Impact the ML World?

1. We truly believe MODALS can make a great impact on the machine learning world. It is a very smart algorithm that achieves great results.
2. With MODALS we might be able to enable deep learning for any data modality, the ones that are very scarce and low in dataset size.
3. We can also advance in domains with difficult data modalites, like low-resource languages, or MEDICAL IMAGES OR DATA FOR VERY RARE DISEASE.
4. And, of course, with MODALS we can boost efficiency of deep learning in multi-modal applications.

## How MODALS can Impact the ML World?

1. With this we finish our presentation and overview of MODALS and hope that with our explanation you understood what MODALS is. Thank you!
