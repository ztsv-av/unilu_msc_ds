---
title: High Dimensional Statistics | Prof. Dr. Podolskij Mark | Homework 3
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

Let data $X \sim \mathbb{P}_\theta, \theta \in \Theta$. Let $\theta_0$ true parameter, $\hat{\theta}_{\text{ML}}$ the maximum likelihood estimator of $\theta_0$. Let $f: \Theta \to \tilde{\Theta}$ a bijective function. We denote $\mathcal{L}_{\mathbb{X}}(\theta_0)$ as the likelihood function of the parameter $\theta_0$ and data $\mathbb{X}=(X_1,\dots,X_n)$.


We denote $\tilde{\theta}_0 = f(\theta_0)$. Since $f$ is bijective, the inverse of $f$ exists, i.e. $\theta_0 = f^{-1}(f(\theta_0))$ and thus: $\theta_0=f^{-1}(\tilde{\theta}_0)$. By the definition of the likelihood function, we have the following:

\
\begin{equation}
\mathcal{L}_{\mathbb{X}}(\theta_0)=\prod^n_{i=1}p_{\theta_0}(X_i)=\prod^n_{i=1}p_{f^{-1}(\tilde{\theta}_0)}(X_i)=\mathcal{L}_{\mathbb{X}}(f^{-1}(\tilde{\theta}_0)),
\end{equation}
\

with $p_{\theta_0}(X_i)$ - probability density function of $X_i$.


Since $\hat{\theta}_{\text{ML}}$ is the maximum likelihood estimator of $\theta_0$, it verifies:

\
\begin{equation}
\mathcal{L}_{\mathbb{X}}(\hat{\theta}_{\text{ML}}) \ge \mathcal{L}_{\mathbb{X}}(\theta), \space \forall \theta \in \Theta
\end{equation}
\

In particular, $\mathcal{L}_{\mathbb{X}}(\hat{\theta}_{\text{ML}}) \ge \mathcal{L}_{\mathbb{X}}(\theta_0)$. Thus, $(1)$ is **maximized** when:

$$
\theta_0 = \hat{\theta}_{\text{ML}} \iff f^{-1}(\tilde{\theta}_0)=\hat{\theta}_{\text{ML}} \iff \tilde{\theta}_0=f(\hat{\theta}_{\text{ML}})
$$

Therefore, the maximum likelihood estimator for $\tilde{\theta}_0 = f(\theta_0)$ is $f(\hat{\theta}_{\text{ML}})$.
