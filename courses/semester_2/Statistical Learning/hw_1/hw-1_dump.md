---

### (c) 

We aim to prove that 

$$\mathcal{R}(A \cup -A) = \mathbb{E}_\epsilon\left[\sup_{a \in A}|\langle a, \epsilon\rangle|\right],$$

and we will give an example to justify that in general 

$$\mathcal{R}(A \cup -A) \neq \mathcal{R}(A)$$

**Proof**

By the definition of Rademacher complexity:

$$
\mathcal{R}(A \cup -A) = \mathbb{E}_\epsilon\left[\sup_{a \in A\cup -A}\langle a, \epsilon\rangle\right]
$$

Notice that:

$$
\sup_{a \in A\cup -A}\langle a, \epsilon\rangle=\sup\left\{\sup_{a \in A}\langle a, \epsilon\rangle, \sup_{a \in -A}\langle a, \epsilon\rangle\right\}
$$

Since for any $a \in -A, -a \in A$ we have $\langle -a, \epsilon\rangle=-\langle a, \epsilon\rangle$, we get that $\sup_{a \in -A}\langle a, \epsilon\rangle=\sup_{a \in A}\langle -a, \epsilon\rangle=\sup_{a \in A}-\langle a, \epsilon\rangle=-\inf_{a \in A}\langle a, \epsilon\rangle$ and thus:

$$\begin{aligned}
\sup_{a \in A\cup -A}\langle a, \epsilon\rangle
    &=\sup\left\{\sup_{a \in A}\langle a, \epsilon\rangle, \sup_{a \in -A}\langle a, \epsilon\rangle\right\}\\
    &=\sup\left\{\sup_{a \in A}\langle a, \epsilon\rangle, -\inf_{a \in A}\langle a, \epsilon\rangle\right\}\\
    &=\left|\sup_{a \in A}\langle a, \epsilon\rangle\right|\\
    &=\sup_{a \in A}\left|\langle a, \epsilon\rangle\right|
\end{aligned}$$

Thus, we get:

$$\begin{aligned}
\mathcal{R}(A \cup -A)
    &=\mathbb{E}_\epsilon\left[\sup_{a \in A\cup -A}\langle a, \epsilon\rangle\right]\\
    &=\mathbb{E}_\epsilon\left[\sup_{a \in A}|\langle a, \epsilon\rangle|\right]
\end{aligned}$$
