---
title: High Dimensional Statistics | Prof. Dr. Podolskij Mark | Homework 4
author:
- Anton Zaitsev | 0230981826 | anton.zaitsev.001@student.uni.lu | University of Luxembourg
date: \today{}
usepackage:
    - amsmath
    - geometry
    - float
header-includes: |
    \usepackage{caption}
    \usepackage{float}
    \usepackage{graphicx}
    \usepackage{amsmath}
output: pdf_document
geometry: "left=25mm, right=25mm, top=10mm, bottom=25mm"
---

\pagebreak

# Exercise 3

Let $X_1,\dots, X_n \in \mathbb{R}^k$ a sequence of i.i.d. random variables following $\mathcal{N}_k(\mu, \Sigma)$ with $\mu \in \mathbb{R}^k$ known. We need to show that MLE for $\Sigma \in \mathbb{R}^{k\times k}$ is given by $\hat{\Sigma}_{\text{ML}}=\frac{1}{n}\sum^n_{i=1}(X_i-\mu)(X_i-\mu)^T$.

The likelihood function is given by:

$$\begin{aligned}
f^n_{\mu, \Sigma}(X_1,\dots,X_n)
    &=\prod^n_{i=1}f_{\mu, \Sigma}(X_i)\\
    &=\left(\det\Sigma\right)^{-\frac{n}{2}}(2\pi)^{-\frac{nk}{2}}\exp\left[-\frac{1}{2}\sum^n_{i=1}(X_i-\mu)^T\Sigma^{-1}(X_i-\mu)\right]
\end{aligned}$$

The loglikelihood function is given by:

$$\begin{aligned}
\log f^n_{\mu, \Sigma}(X_1,\dots,X_n)
    &=\log \left\{\prod^n_{i=1}f_{\mu, \Sigma}(X_i)\right\}\\
    &=-\frac{n}{2}\log(\det\Sigma)-\frac{nk}{2}\log(2\pi)-\frac{1}{2}\sum^n_{i=1}(X_i-\mu)^T\Sigma^{-1}(X_i-\mu)
\end{aligned}$$

We look for $\Sigma$ that maximizes the likelihood (loglikelihood) function:

$$
\hat{\Sigma}_{\text{ML}} = \argmax_{\Sigma \in \mathbb{R}^{k\times k}}\log f^n_{\mu, \Sigma}(X_1,\dots,X_n)
$$

Let $A = \sum^n_{i=1}(X_i-\mu)(X_i-\mu)^T \in \mathbb{R}^{k\times k}$ - a positive definite matrix. We will also use the following properties of the trace operator: 

1. If $A \in R: A=tr(A)$
2. $\text{tr}(ABC)=\text{tr}(CAB)=\text{tr}(BCA)$

Then:

$$\begin{aligned}
\hat{\Sigma}_{\text{ML}} 
    &= \argmax_{\Sigma \in \mathbb{R}^{k\times k}}\log f^n_{\mu, \Sigma}(X_1,\dots,X_n)\\
    &=\argmax_{\Sigma \in \mathbb{R}^{k\times k}}\left\{-\frac{n}{2}\log(\det\Sigma)-\frac{nk}{2}\log(2\pi)-\frac{1}{2}\sum^n_{i=1}(X_i-\mu)^T\Sigma^{-1}(X_i-\mu)\right\}\\
    &=\argmax_{\Sigma \in \mathbb{R}^{k\times k}}\left\{-n\log(\det\Sigma)-\text{tr}\left(\sum^n_{i=1}(X_i-\mu)^T\Sigma^{-1}(X_i-\mu)\right)\right\}\\
    &=\argmax_{\Sigma \in \mathbb{R}^{k\times k}}\left\{-n\log(\det\Sigma)-\text{tr}\left(\Sigma^{-1}\sum^n_{i=1}(X_i-\mu)(X_i-\mu)^T\right)\right\}\\
    &=\argmax_{\Sigma \in \mathbb{R}^{k\times k}}\left\{-n\log(\det\Sigma)-\text{tr}\left(\Sigma^{-1}A\right)\right\}\\
\end{aligned}$$

We try to maximize function $g(\Sigma):=-n\log(\det\Sigma)-\text{tr}\left(\Sigma^{-1}A\right)$ in $\Sigma$.

Since $A$ is positive definite almost surely, then there exists matrix $B$ s.t. $A=BB^T$ and we define $H=B^T\Sigma^{-1}B$. Then: $\Sigma=BH^{-1}B^T$ and $\det(\Sigma)=\det(BH^{-1}B^T)=\frac{\det(BB^T)}{\det(H)}=\frac{\det(A)}{\det(H)}$ and $\text{tr}(\Sigma^{-1}A)=\text{tr}(\Sigma^{-1}BB^T)=\text{tr}(B^T\Sigma^{-1}B)=\text{tr}(H)$. Then:

$$
g(\Sigma)=-n\log\left(\frac{\det(A)}{\det(H)}\right)-\text{tr}\left(H\right)=-n\log\left(\det(A)\right)+n\log(\det(H))-\text{tr}\left(H\right)
$$

The Cholesky decomposition states that any positive definite matrix can be decomposed into the product of a lower triangular matrix and its conjugate transpose. Thus, there exists a lower triangular matrix $C$ s.t. $H=CC^T$. Then:

$$\begin{aligned}
g(\Sigma)
    &=-n\log\left(\det(A)\right)+n\log(\det(C)^2)-\text{tr}\left(CC^T\right)\\
\end{aligned}$$

Since $C$ is lower triangular matrix, its determinant is the product of its diagonal elements. The trace of the product $CC^T$ is the sum of the squares of all elements of $C$ along its main diagonal and below. Then:

$$\begin{aligned}
g(\Sigma)
    &=-n\log\left(\det(A)\right)+n\log(\prod^k_{j=1}C_{jj}^2)-\sum^k_{j=1}C^2_{jj}\\
    &=-n\log\left(\det(A)\right)+\sum^k_{j=1}n\log C^2_{jj}-\sum^k_{j=1}C^2_{jj}-\sum^k_{i\neq j}C^2_{ij}\\
    &=-n\log\left(\det(A)\right)+\sum^k_{j=1}\left(n\log C^2_{jj}-C^2_{jj}\right)-\sum^k_{i\neq j}C^2_{ij}
\end{aligned}$$

By maximizing above equality, we get that $C_{ij}=0$ for $i\neq j$ and $C^2_{jj}=n (\text{since }\frac{d}{dx}\left(n\log x-x\right)=0 \iff \frac{n}{x}-1=0 \iff x=n)$, making $C$ take the form:

$$
C=\begin{bmatrix}
\sqrt{n} & 0 & \cdots & 0 \\
0 & \sqrt{n} & \cdots & 0 \\
\vdots & \vdots & \ddots & \vdots \\
0 & 0 & \cdots & \sqrt{n}
\end{bmatrix}
$$

Then: $H=n\cdot I_k$, with $I_k-$$k$-dimensional identity matrix, and $\Sigma=\frac{1}{n}BB^T=\frac{1}{n}A$. Thus, $g(\Sigma)$ is maximized with $\Sigma=\frac{1}{n}A$ and $\hat{\Sigma}_{\text{ML}}=\frac{1}{n}A=\frac{1}{n}\sum^n_{i=1}(X_i-\mu)(X_i-\mu)^T$
