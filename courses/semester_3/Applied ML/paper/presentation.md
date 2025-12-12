---
marp: true
theme: default
paginate: true
header: Paper Review: MODALS
math: mathjax
backgroundImage: url('ims/background.jpg')
---

<style>
img[alt~="center"] {
  display: block;
  margin: 0 auto;
}
</style>

<!-- color: black -->
<!-- _class: title-slide -->

# Paper Review : Modality-agnostic Automated Data Augmentation in the Latent Space (MODALS)

### Anton Zaitsev | Othmane Mahfoud  


###### University of Luxembourg

---

## Problem: Data

- Deep learning models need a lot of **good quality training data**.
- Labelled data is **scarce and expensive**.

![width:1000px height:325px center](ims/mri_audio_text.png)

---

## Solution: Data Augmentation

- **Data augmentation** is a way to **increase the size of training datasets**.

![width:900px height:450px center](ims/data_aug.png)

---

## Data Augmentation Problems

![bg right:53% width:650px height:450px](ims/text_img_aug.png)

- Data augmentation methods are **manually designed** and evaluated **for different modalities** separately.
- **Modalities are different types of data**, such as images, text, or audio.
- We **cannot use** the **same data augmentation techniques for different modalities**, e.g., images and text.

---

## Solution: MODALS

![bg right:59% width:730px height:500px](ims/modals_idea.png)

- **MODALS: Modality-agnostic Automated Data Augmentation in the Latent Space**.
- MODALS transforms data in the **latent space**.
- MODALS works with **any data modality**.

---

## MODALS Results Teaser

- MODALS was tested on **text, tabular, time-series, and image** datasets.
- It **outperformed** baseline methods **in most cases**.

![width:1000px height:300px center](ims/modals_tabular_results.png)

---

## MODALS Algorithm: Overview

![width:750px height:265px center](ims/simple_pipeline.png)

![width:750px height:265px center](ims/transform_pipeline.png)

---

## MODALS Algorithm: Overview

![width:1000px height:500px center](ims/modals_pipeline.png)

---

## MODALS Algorithm: Step 1

![width:1200px height:500px center](ims/modals_example_1.png)

---

## MODALS Algorithm: Step 2

![width:850px height:550px center](ims/modals_example_2.png)

---

## MODALS Algorithm: Step 2, Triplet Loss

![width:900px height:500px center](ims/triplet_loss.png)

---

## MODALS Algorithm: Step 3

![width:1200px height:425px center](ims/modals_example_3.png)

---

## MODALS Algorithm: Step 4

![width:850px height:350px center](ims/modals_example_4.png)

---

## MODALS Algorithm: Step 5

![width:1000px height:500px center](ims/modals_pipeline.png)

---

## MODALS Results

![width:1100px height:250px center](ims/modals_results.png)

![width:900px height:225px center](ims/modals_losses.png)

---

## Conclusions

- MODALS is an **automatic data augmentation technique**.
- MODALS can be used for **any data type**, since it transforms data in the **latent space**.
- MODALS achieves **best results** on text, tabular, time-series data and **competitive results** on image data (compared to baseline augmentation techniques).
- MODALS can be **easily intergrated** into any **deep learning pipeline**.
- MODALS might be the **best solution** yet for:
  - Data modalities where input space **augmentation** is **difficult to define**.
  - **Scarce** and **imbalanced** **datasets**.

---

## How MODALS can Impact the ML World?

- Enable deep learning for **new data modalities**.
- Advance deep learning for domains with **difficult data modalities** (e.g., medical imaging or NLP for low-resource languages).
- Boost efficiency in **multi-modal** applications.

![width:850px height:280px center](ims/mri_audio_text.png)


---

# Thank you
