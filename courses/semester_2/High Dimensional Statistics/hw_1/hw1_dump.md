# Exercise 2

Let $Y \sim \mathcal{N}_n(0, \Sigma), \Sigma \in \mathbb{R}^{n \times n}$ positive definite, $A, B \in \mathbb{R}^{n\times n}$. Show that it holds that

$$cov(Y^TAY, Y^TBY)=tr(A\Sigma B\Sigma)+tr(A^T\Sigma B\Sigma)$$

## Proof

Let us decompose the $cov(Y^TAY, Y^TBY)$:

$$\begin{align*}
cov(Y^TAY, Y^TBY)& =\mathbb{E}[(Y^TAY-\mathbb{E}[Y^TAY])(Y^TBY-\mathbb{E}[Y^TBY])] \\
    & = \mathbb{E}[Y^TAYY^TBY] - \mathbb{E}[Y^TAY]\mathbb{E}[Y^TBY]
\end{align*}$$

Same as in *Exercise 1*, notice that $\mathbb{E}[Y^TAYY^TBY]$ is a $1 \times 1$ matrix. Thus, we can apply the trace operator on it and observe the following:

$$\begin{align*}
\mathbb{E}[Y^TAYY^TBY]& =\mathbb{E}[tr(Y^TAYY^TBY)]\\
    &=\mathbb{E}[tr(ABYY^TYY^T)]\\
    &=\mathbb{E}[AB\cdot tr(YY^TYY^T)]\\
    &=tr(AB\cdot \mathbb{E}[YY^TYY^T])
\end{align*}$$

For the second term, we know from *Exercise 1* that $\mathbb{E}[Y^TAY]=\mu^TA\mu + tr(A\Sigma)$. Since in this case $\mu=0$, we get:

$$\begin{align*}
\mathbb{E}[Y^TAY]\mathbb{E}[Y^TBY]&=(\mu^TA\mu + tr(A\Sigma))(\mu^TB\mu + tr(B\Sigma))\\
    &=tr(A\Sigma)tr(B\Sigma)\\
    &=tr(A\Sigma B\Sigma)
\end{align*}$$
