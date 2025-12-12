$$
\mathbb{E}\left[\left|\zeta_1\right|^k\right] = \mathbb{E}\left[\left| K_h(X_1-x_0)-\mathbb{E}[K_h(X_1-x_0)]\right|^k\right]
$$

By triangle inquality:

$$\begin{aligned}
\left| K_h(X_1-x_0)-\mathbb{E}[K_h(X_1-x_0)]\right|^k 
    &\le \left( |K_h(X_1-x_0)|+|\mathbb{E}[K_h(X_1-x_0)]|\right)^k\\
    &\quad= \sum^k_{i=0}\binom{k}{i}|K_h(X_1-x_0)|^i|\mathbb{E}[K_h(X_1-x_0)]|^{k-i}
\end{aligned}$$

With the latest equality by the Binomial Theorem. Notice that since $||K||_\infty$ is bounded, we have that $|K_h(X_1-x_0)| \le ||K||_\infty$ and:

$$
|K_h(X_1-x_0)|^i \le ||\frac{K}{h}||_\infty^i
$$

Thus:

$$
\left| K_h(X_1-x_0)-\mathbb{E}[K_h(X_1-x_0)]\right|^k \le \sum^k_{i=0}\binom{k}{i}||\frac{K}{h}||_\infty^i|\mathbb{E}[K_h(X_1-x_0)]|^{k-i}
$$

## 3.

Let $y = \sqrt{\frac{2vx}{n}}+\frac{cx}{n}, v,c, x>0$. Then:

$$\begin{aligned}
e^{\frac{-ny^2}{2(v+cy)}}
    &= e^{\frac{-n\left(\frac{2vx}{n}+\frac{2cx}{n}\sqrt{\frac{2vx}{n}}+\frac{c^2x^2}{n^2}\right)}{2v + 2c\sqrt{\frac{2vx}{n}}+\frac{2c^2x}{n}}}\\
    &= e^{\frac{-x\left(2v + 2c\sqrt{\frac{2vx}{n}}+\frac{c^2x}{n}\right)}{2v + 2c\sqrt{\frac{2vx}{n}}+\frac{2c^2x}{n}}}\\
    &\le e^{-x}
\end{aligned}$$

Notice that $2v + 2c\sqrt{\frac{2vx}{n}}+\frac{c^2x}{n} <= {2v + 2c\sqrt{\frac{2vx}{n}}+\frac{2c^2x}{n}}$ since $c, x > 0$. Thus:

$$\begin{aligned}
e^{\frac{-ny^2}{2(v+cy)}}
    &= e^{\frac{-x(2v + 2c\sqrt{\frac{2vx}{n}}+\frac{c^2x}{n})}{2v + 2c\sqrt{\frac{2vx}{n}}+\frac{2c^2x}{n}}}\\
    &\le e^{-x}
\end{aligned}$$

Thus, for $y>0$:

$$
\mathbb{P}\left[\frac{1}{n}\sum^n_{i=1}X_i > y\right] \le e^{\frac{-ny^2}{2(v+cy)}}
$$

with $y = \sqrt{\frac{2vx}{n}}+\frac{cx}{n}, v,c, x>0$:

$$\begin{aligned}
\mathbb{P}\left[\frac{1}{n}\sum^n_{i=1}X_i > \sqrt{\frac{2vx}{n}}+\frac{cx}{n}\right] 
    &\le e^{-x}
\end{aligned}$$
