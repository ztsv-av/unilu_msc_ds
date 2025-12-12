---
title: High Dimensional Statistics | Prof. Dr. Podolskij Mark | Homework 2
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

# Exercise 1

Let $Z \sim \mathcal{N}_n(0, \Sigma)$. We aim to show that $Z^T\Sigma^{-1}Z \sim \mathcal{X}_n^2$.

## Proof

First, we can rewrite $Z$ as: $Z = \Sigma^{\frac{1}{2}}X$, where $X\sim \mathcal{N}_n(0, I_n)$ with $\Sigma^{\frac{1}{2}}=PD^{\frac{1}{2}}P^T$, where $P$ an orthogonal matrix and $D$ is a diagonal matrix s.t. $\Sigma=PDP^T$. Since $\Sigma$ is positive definite, $D=diag(\lambda_1,\dots,\lambda_n)$ and $D^{\frac{1}{2}}=diag(\pm\sqrt{\lambda_1},\dots,\pm\sqrt{\lambda_n})$ with $\lambda_1, \dots, \lambda_n>0$ - eigenvalues of $\Sigma$.

Thus, $Z^T\Sigma^{-1}Z$, which is a quadratic form of a random variable $Z$, can be rewritten as:

$$\begin{aligned}
Z^T\Sigma^{-1}Z 
    &= \left(\Sigma^{\frac{1}{2}}X\right)^T\Sigma^{-1}\Sigma^{\frac{1}{2}}X \\
    &= X^T\left(\Sigma^{\frac{1}{2}}\right)^T\Sigma^{-1}\Sigma^{\frac{1}{2}}X \\
    &= X^T\left(PD^{\frac{1}{2}}P^T\right)^T\left(PDP^T\right)^{-1}PD^{\frac{1}{2}}P^TX \\
    &= X^TP\left(D^{\frac{1}{2}}\right)^TP^T(P^T)^{-1}D^{-1}(P)^{-1}PD^{\frac{1}{2}}P^TX
\end{aligned}$$

Notice that $\left(D^{\frac{1}{2}}\right)^T=D^{\frac{1}{2}}$ since $D$ is diagonal and $P^T(P^T)^{-1}=I_n,P(P)^{-1}=I_n$. Thus:

$$\begin{aligned}
Z^T\Sigma^{-1}Z 
    &= X^TP\left(D^{\frac{1}{2}}\right)^TP^T(P^T)^{-1}D^{-1}(P)^{-1}PD^{\frac{1}{2}}P^TX\\
    &= X^TPD^{\frac{1}{2}}D^{-1}D^{\frac{1}{2}}P^TX
\end{aligned}$$

Now, the product $D^{\frac{1}{2}}D^{-1}D^{\frac{1}{2}}=I_n$, since $D$ is diagonal (for each diagonal element we would get the multiplication $\sqrt{\lambda_i}\frac{1}{\lambda_i}\sqrt{\lambda_i}=1$ for $1\le i \le n$). Thus, we get:

$$\begin{aligned}
Z^T\Sigma^{-1}Z 
    &= X^TPD^{\frac{1}{2}}D^{-1}D^{\frac{1}{2}}P^TX\\
    &= X^TPP^TX \\
    &= X^TX,
\end{aligned}$$

with $PP^T=I_n$, since $P$ is an orthogonal matrix.

Since $X^TX=\sum^n_{i=1}X_i^2$, then by the definition of a chi-squared distribution, the sum of $n$ squared random variables following standard normal follows a chi-squared distribution with $n$ degrees of freedom. Thus:

$$
Z^T\Sigma^{-1}Z=\sum^n_{i=1}X_i^2 \sim \mathcal{X}_n^2
$$
