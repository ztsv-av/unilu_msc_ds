To find the MLE, we will take the gradient of the loglikelihood with respect to $\Sigma$:

$$\begin{aligned}
\nabla_\Sigma\log f^n_{\mu, \Sigma}(X_1,\dots,X_n)  
    &=-\frac{n}{2}\nabla_\Sigma\left(\log(\det\Sigma)\right)-\frac{1}{2}\nabla_{\Sigma^{-1}}\left(\sum^n_{i=1}(X_i-\mu)^T\Sigma^{-1}(X_i-\mu)\right)
\end{aligned}$$

Next, we will use the following properties:

1. For $A$ an invertible (non-singular) square matrix:

$$
\det A^{-1} = \frac{1}{\det A}
$$

2. The gradient of the trace of the product of two matrices $A$ and $B$ with respect to $A$ is

$$
\nabla_A\text{tr}(BA)=B^T
$$

3. The gradient of the natural logarithm of the determinant of $A$ is

$$
\nabla_A\log(\det(A))=(A^{-1})^T
$$

4. If the product $ABC \in \mathbb{R}$, then $ABC=\text{tr}(ABC)=\text{tr}(CAB)=\text{tr}(BCA)$

Thus:

$$\begin{aligned}
\nabla_\Sigma\log f^n_{\mu, \Sigma}(X_1,\dots,X_n)  
    &=\frac{n}{2}\nabla_{\Sigma^{-1}}\left(\log(\det\Sigma^{-1})\right)-\frac{1}{2}\nabla_{\Sigma^{-1}}\left(\sum^n_{i=1}(X_i-\mu)^T\Sigma^{-1}(X_i-\mu)\right)\\
    &=\frac{n}{2}\Sigma^T-\frac{1}{2}\nabla_{\Sigma^{-1}}\text{tr}\left(\sum^n_{i=1}(X_i-\mu)^T\Sigma^{-1}(X_i-\mu)\right)\\
    &=\frac{n}{2}\Sigma^T-\frac{1}{2}\nabla_{\Sigma^{-1}}\text{tr}\left(\sum^n_{i=1}(X_i-\mu)(X_i-\mu)^T\Sigma^{-1}\right)\\
    &=\frac{n}{2}\Sigma^T-\frac{1}{2}\left(\sum^n_{i=1}(X_i-\mu)(X_i-\mu)^T\right)^T
\end{aligned}$$

We then set the gradient of the loglikelihood to zero to find the maximum:

$$
\nabla_\Sigma\log f^n_{\mu, \Sigma}(X_1,\dots,X_n) = 0\\
\iff\\
\frac{n}{2}\Sigma^T-\frac{1}{2}\left(\sum^n_{i=1}(X_i-\mu)(X_i-\mu)^T\right)^T=0\\
\iff\\
\frac{n}{2}\Sigma=\frac{1}{2}\sum^n_{i=1}(X_i-\mu)(X_i-\mu)^T\\
\iff\\
\Sigma=\frac{1}{n}\sum^n_{i=1}(X_i-\mu)(X_i-\mu)^T
$$

Thus, the MLE for $\Sigma$ is given by:
$$\begin{aligned}
\hat{\Sigma}_{\text{ML}} 
    &=\argmax_{\Sigma \in \mathbb{R}^{k\times k}}\log f^n_{\mu, \Sigma}(X_1,\dots,X_n)\\
    &=\frac{1}{n}\sum^n_{i=1}(X_i-\mu)(X_i-\mu)^T
\end{aligned}$$
