# Reproducing Few-Shot Learning Capability of Visual Ventral Pathway by Coupling Vision Transformer and Neural Fields

## Overview

This repository provides the implementation and experimental setup described in the paper:

> **Su, J., Xing, L., Li, T., Xiang, N., Shi, J., & Jin, D. (2025)**  
> *Reproducing Few-Shot Learning Capability of Visual Ventral Pathway by Coupling Vision Transformer and Neural Fields*.  
> Submitted to *Brain Sciences*.

We propose a brain-inspired model combining **Vision Transformers (ViT)** with **Neural Fields** to simulate the **ventral visual stream** of the human brain for **few-shot image classification**.

---

## Motivation

Humans can rapidly learn new concepts with very few samples. Inspired by the **ventral visual pathway** (retina → LGN → V1/V2 → V4/IT), we propose a macroscopic model to mimic this cognitive ability, addressing challenges in traditional deep neural networks such as:

- Dependence on large datasets
- Lack of interpretability
- High computational costs

---

## Methodology

### Architecture

- **Feature Extraction**: Vision Transformer (ViT) extracts hierarchical image features simulating V1/V2 areas.
- **Neural Fields**:
  - **Elementary Field**: Learns and stores sample features.
  - **High-level Field**: Classifies test samples via neuron activations based on Hebbian connections.

### Key Innovations

- **Hebbian-like learning rule**: For connecting neural fields based on sample-label pairs.
- **Static solution approximation**: Avoids solving differential equations directly, improving efficiency.
- **Scale adaptation strategy**: Dynamically adjusts interaction range (σ) to match activation states.

---

## Training & Prediction

- **Training**:
  - Construct weight matrix `W` between fields.
  - Feature vector and label co-activate neurons in the fields to form connections.

- **Prediction**:
  - Uses activation patterns in high-level field.
  - Adapts interaction parameter σ based on number of activated neurons.

---

## Experimental Setup

### Datasets

| Dataset       | Instances | Classes | Image Size |
|---------------|-----------|---------|-------------|
| CUB200-2011   | 11,788    | 200     | Various     |
| CIFAR-FS      | 60,000    | 100     | 32×32       |
| miniImageNet  | 60,000    | 100     | 84×84       |

- ViT-L/16 pretrained on I21K.
- Dimensionality reduction via Laplacian Eigenmaps (LE), reduced to 4D.
- Evaluation on 5-way 1-shot and 5-way 5-shot tasks.

---

## Results

### Accuracy Comparison

| Method (Backbone)     | CUB(5-1) | CIFAR-FS(5-1) | miniImageNet(5-1) |
|-----------------------|----------|----------------|-------------------|
| PMF-BPA (ViT)         | **0.9580** | 0.8710         | 0.9520            |
| MetaQDA (ViT)         | 0.8830   | 0.6040         | 0.8820            |
| **OURS (ViT)**        | 0.9242   | **0.9811**     | **0.9887**        |

- Our model achieves **state-of-the-art** performance on **CIFAR-FS** and **miniImageNet**.
- Slightly behind PMF-BPA on **CUB200-2011 (5-1)**.

---

## Ablation Studies

### Distance Metrics Impact

| Metric      | miniImageNet(5-1) |
|-------------|-------------------|
| Cosine      | **0.9887**        |
| Euclidean   | 0.7878            |
| Correlation | 0.9873            |

### Classifier Comparison (ViT as Encoder)

| Classifier | miniImageNet(5-1) |
|------------|-------------------|
| KNN        | 0.9720            |
| SVM        | 0.7914            |
| **OURS**   | **0.9887**        |

---

## Contributions

- **Model Design**: Jiayi Su, Dequan Jin  
- **Implementation**: Lifeng Xing, Jiacheng Shi  
- **Experiments**: Tao Li, Nan Xiang  
- **Supervision**: Dequan Jin

---

## Citation

If you find this work helpful, please cite:

```bibtex
@article{su2025reproducing,
  title={Reproducing Few-Shot Learning Capability of Visual Ventral Pathway by Coupling Vision Transformer and Neural Fields},
  author={Su, Jiayi and Xing, Lifeng and Li, Tao and Xiang, Nan and Shi, Jiacheng and Jin, Dequan},
  journal={Brain Sci.},
  year={2025},
  volume={1},
  pages={0},
  doi={10.3390/brainsci1010000}
}
