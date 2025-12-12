# General Theorems

## Squeeze Theorem

$$a_n \le b_n \le c_n$$

$$\lim{a_n} \le \lim{b_n} \le \lim{c_n}$$

## Hölder's Inequality

Let $p$ and $q$ be positive real numbers such that $\frac{1}{p} + \frac{1}{q} = 1$. For any two sequences of real numbers $a_1, a_2, \ldots, a_n$ and $b_1, b_2, \ldots, b_n$, Hölder's inequality states:

$$
\sum_{i=1}^{n} |a_i b_i| \leq \left(\sum_{i=1}^{n} |a_i|^p\right)^{\frac{1}{p}} \left(\sum_{i=1}^{n} |b_i|^q\right)^{\frac{1}{q}}
$$

In this inequality:

- $p$ and $q$ are positive real numbers such that $\frac{1}{p} + \frac{1}{q} = 1$. These numbers are called conjugate exponents of each other.

- $a_i$ and $b_i$ are elements of the sequences $a_1, a_2, \ldots, a_n$ and $b_1, b_2, \ldots, b_n$, respectively.

# Affine Function

Affine - linear map + constant $C$. $f: \mathbb{R} \to \mathbb{R}$
$$f=g + C$$

# Taylor Formula

$$f(x+h) = f(x) + Df(x)(h)+$$

$$+\frac{1}{2}D^2f(x)(h,h) + o(||h||^2)=$$

$$=f(x) + <\nabla f(x),h> + \frac{1}{2}h^THf(x)h + o(||h||^2)=$$

$$=f(x) + \sum^p_{i=1}h_i\frac{\partial f}{x_i}(x)+$$

$$+\frac{1}{2}\sum_{i,j}h_ih_j\frac{\partial^2f}{\partial x_j\partial x_i}(x) + o(||h||^2)$$

$f: \mathbb{R}^d \to \mathbb{R}, C^1$\
$f(x+h) = f(x) + f'(x)h + o(|h|)$

$f: \mathbb{R} \to \mathbb{R}, C^2, h \in \mathbb{R}^d$\
$f(x+h) = f(x) + f'(x)h + f''(x)\frac{h^2}{2} + o(h^2)$

# Norm | Inner Product

## Norm

A mapping $\|\cdot\|:\mathbb{R}^d\to\mathbb{R}$ is a norm on $\mathbb{R}^d$ if
- For all $x\in\mathbb{R}^d$, $\|x\|\geq 0$ and $\|x\|=0\iff x=0$
- For all $x\in\mathbb{R}^d$ and $\lambda\in\mathbb{R}$, $\|\lambda x\|=|\lambda|\|x\|$
- For all $x,y\in\mathbb{R}^d$, $\|x+y\|\leq\|x\|+\|y\|$ (Triangle inequality)

For $\mathbb{R}^1$ we have $(\mathbb{R}, | \cdot |)$ normed space.\
For $\mathbb{R}^2$ we have:
1. Euclidian norm: $x=(x_1,x_2): ||x||_2 = \sqrt{x_1^2 + x_2^2}$
2. $||x||_1 = |x_1| + |x_2|$
3. $||x||_\infty = max(|x_1|, |x_2|)$

$(\mathbb{R}, ||\cdot||_1)$ and $(\mathbb{R}, ||\cdot||_2)$ are both normed spaces, but defined by different normes, thus different.

For $\mathbb{R}^d$ we have: $x=(x_1,x_2)$:
1. $||x||_1 = |x_1| + ... + |x_d|$
2. $||x||_2 = \sqrt{x_1^2 + ... + x_d^2}$
3. $||x||_\infty = max(|x_1|, ..., |x_d|)$
4. $||x||_p=(\sum^d_{i=1}x_i^p)^{\frac{1}{p}}, p \ge 1$

The pair $(\mathbb{R}^d,\|\cdot\|)$ is a normed vector space.\
Change norm $=>$ normed space changes.

## Inner Product

Let $\mathbb{R}^d$ be a vector space. A mapping $\langle \cdot, \cdot \rangle : (\mathbb{R}^d)^2 \to \mathbb{R}$ is an inner product on $\mathbb{R}^d$ if:
- For all $x, y \in \mathbb{R}^d$, $\langle x, y \rangle = \langle y, x \rangle$ (symmetry).
- For all $x, y, z \in \mathbb{R}^d$ and $\lambda \in \mathbb{R}$, $\langle x + y, z \rangle = \langle x, z \rangle + \langle y, z \rangle$ (left linearity).
- For all $x \in \mathbb{R}^d$, $\langle x, x \rangle \geq 0$, and $\langle x, x \rangle = 0$ if and only if $x = 0$ (positive definiteness).

Symmetry + left linearity defines bilinearity.

Inner product:
$$\mathbb{R}: \langle x,y\rangle = xy$$
$$\mathbb{R}^d: \langle x,y\rangle = \sum^d_{i=1}x_iy_i$$

### Cauchy-Schwarz Inequality

$$|\langle x,y\rangle|^2 \le \langle x,x \rangle \langle y,y \rangle, \forall x,y \in \mathbb{R}^d$$

With **equality** $\iff$ $x$ and $y$ are **linearly** **independent**.

### Canonical Norm

Let $\langle \cdot, \cdot \rangle$ be the usual inner product on $\mathbb{R}^d$. The mapping 
$$\| \cdot \| : x \in \mathbb{R}^d \mapsto \sqrt{\langle x, x \rangle}$$ 
is a norm on $\mathbb{R}^d$, the **canonical** norm associated with $\langle \cdot, \cdot \rangle$.


$||x|| = \sqrt{\langle x,x \rangle}$\
$|\langle x,y \rangle|^2 \le \langle x,x \rangle \langle y,y \rangle$\
$|\langle x,y \rangle|^2 \le || x ||^2 \space || y ||^2$\
$|\langle x,y \rangle| \le || x || \space || y ||$

# Topology

## Open Ball

Let $\| \cdot \|$ be a norm on $\mathbb{R}^d$.

$$\forall a \in \mathbb{R}^d, r > 0, B_{\| \cdot \|}(a, r) = \{x \in \mathbb{R}^d : \|x - a\| < r\}$$ 

$$B_{| \cdot |}(a, r) = (a-r, a + r)$$

is the open ball of $(\mathbb{R}^d, \| \cdot \|)$ with center $a$ and radius $r$. From the definition we see that balls depend on the defined norm. In other words, distance from any $x$ to center is less than $r$.

## Closed Ball

Let $\| \cdot \|$ be a norm on $\mathbb{R}^d$.

$$\forall a \in \mathbb{R}^d, r > 0, \overline{B}_{\| \cdot \|}(a, r) = \{x \in \mathbb{R}^d : \|x - a\| \le r\}$$ 
is the closed ball of $(\mathbb{R}^d, \| \cdot \|)$ with center $a$ and radius $r$.

$$\overline{B}_{\| \cdot \|}(a, r) = [a-r, a+r]$$

## Neighbourhood of a Point

Let $\| \cdot \|$ be a norm on $\mathbb{R}^d$. A subset $V \subset \mathbb{R}^d$ is a neighborhood of $a \in \mathbb{R}^d$ if 

$$\forall r > 0 : B_{\| \cdot \|}(a, r) \subset V$$

## Open Set

Let $\| \cdot \|$ be a norm on $\mathbb{R}^d$.

A subset $O \subset \mathbb{R}^d$ is an open set of $(\mathbb{R}^d, \| \cdot \|)$ if
$$\forall a \in O, \, \exists r > 0 : B_{\| \cdot \|}(a, r) \subset O$$

We can find any open ball with small $r$ s.t. for any point in $O$ open ball will be a subset of $O$. **Frontier not included.**

## Closed Set

A subset $F \subset \mathbb{R}^d$ is a closed set of $(\mathbb{R}^d, \| \cdot \|)$ if its complement $(F^c := \mathbb{R}^d \setminus F)$ is an open set of $(\mathbb{R}^d, \| \cdot \|)$.

If we take a ball, where center is on the frontier, we will notice that some part of the ball is not in the set ($r > 0$) $=>$ we have closed set.

### Open & Closed Set Properties

- An open set is a set which is a neighborhood of all its points
- Any open ball is open
- Any closed ball is closed
- In $\mathbb{R}^d$ a **compact** set is a set which is **closed** and **bounded**.

**Remark**: If $F$ is closed $=> F^c$ is open.

### Interior of a Set

Let $\|\cdot\|_{\mathbb{R}^d}$ be a norm on $\mathbb{R}^d$ and $A \subseteq \mathbb{R}^d$. The interior of $A$ is the largest open subset of $\mathbb{R}^d$ contained in $A$ (it exists) and is denoted by $\overset{\circ}{A}$

*Remarks*: $\overset{\circ}{A}$ is open and $\overset{\circ}{A} \subset A$

Example: $A = [1,3]$, $\overset{\circ}{A} = (1,3)$, $B = (1,3)$, $\overset{\circ}{B} = (1,3)$

### Closure of a Set

Let $\|\cdot\|_{\mathbb{R}^d}$ be a norm on $\mathbb{R}^d$ and $A \subseteq \mathbb{R}^d$. The closure of $A$ is the smallest closed subset of $\mathbb{R}^d$ containing $A$ (it exists) and is denoted by $\overline{A}$

*Remarks*: $\overline{A}$ is closed and $A \subset \overline{A}$

Example: $A = (1,3]$, $\overline{A} = [1,3]$

### Frontier of a Set

Let $\|\cdot\|_{\mathbb{R}^d}$ be a norm on $\mathbb{R}^d$ and $A \subseteq \mathbb{R}^d$. The frontier of $A$ is $\delta A = \overline{A} \setminus \overset{\circ}{A}$

Example: $A = [1, 3)$, $\delta A  = \{1,3\}$ (points 1 and 3)

### Family of Open Sets

Let $(O_\alpha)_{\alpha \in I}$ be a family of open sets, then

$$\bigcup_{\alpha \in I}O_\alpha$$ 

is also open (infinite sets).

Let $(A_\delta)_{\delta \in \Delta}$ be a family of open sets s.t. $|\Delta| < +\infty$ , then

$$\bigcap_{\delta \in \Delta}A_\delta$$

is also open (finite sets).

### Sequential Characterization of Closed Set

Let $(\mathbb{R}^d, || \cdot ||)$ be a normed space. $F \subseteq \mathbb{R}^d$ is closed $\iff \forall (x_n)_{n \ge 1} \subseteq F$ s.t. $x_n \to l$ then $l \in F$

# Sequences and Mappings

## Convergent Sequence

Let $\|\cdot\|_{\mathbb{R}^d}$ be a norm on $\mathbb{R}^d$. A sequence $(x_n)_{n\in\mathbb{N}}$ of elements of $\mathbb{R}^d$ converges if there exists $x \in \mathbb{R}^d$ such that

$$\forall \varepsilon > 0, \exists N \in \mathbb{N}: \forall n \in \mathbb{N}, n \geq N, \|x_n - x\| < \varepsilon$$

## Limit of Convergent Sequence

Let $\|\cdot\|_{\mathbb{R}^d}$ be a norm on $\mathbb{R}^d$, and let $(x_n)_{n\in\mathbb{N}}$ be a sequence of elements of $\mathbb{R}^d$

If $(x_n)_{n\in\mathbb{N}}$ converges, it has a unique limit denoted $\lim_{n\to\infty} x_n$

Furthermore,
$$x = \lim_{n\to\infty} x_n \iff \lim_{n\to\infty} \|x_n - x\| = 0$$

### Proposition

Let $\|\cdot\|$ be a norm on $\mathbb{R}^d$, $\|\cdot\|'$ be a norm on $\mathbb{R}^k$, and $f : \mathbb{R}^d \to \mathbb{R}^k$ be a function. The function has the limit $l$ in $\mathbb{R}^k$ at $a \in \mathbb{R}^d$ if

$$\forall \varepsilon > 0, \exists \delta > 0: \forall x \in \mathbb{R}^d$$

$$\|x - a\| < \delta \Rightarrow \|f(x) - l\|' < \varepsilon$$

If it exists, the limit $l$ is unique and is denoted $\lim_{x \to a} f(x)$

### Proposition

Let $\|\cdot\|$ be a norm on $\mathbb{R}^d$, $\|\cdot\|'$ be a norm on $\mathbb{R}^k$, and $f : \mathbb{R}^d \to \mathbb{R}^k$ be a function. The function has the limit $l$ in $\mathbb{R}^k$ at $a \in \mathbb{R}^d \iff$ for any sequence $(x_n)_{n\in\mathbb{N}}$ of elements of $\mathbb{R}^d$,

$$\lim_{n\to\infty}\|x_n - a\| = 0 \iff ||f(x) - l\|' = 0$$

### Continious Function

Let $\|\cdot\|$ be a norm on $\mathbb{R}^d$, $\|\cdot\|'$ be a norm on $\mathbb{R}^k$, and $f : \mathbb{R}^d \to \mathbb{R}^k$ be a function. The function $f$ is continuous at a point $a$ in $\mathbb{R}^d$ if

$$\lim_{x \to a} f(x) = f(a)$$

Let $O$ be an open subset of $\left(\mathbb{R}^d, \|\cdot\|\right)$. The function $f$ is continuous on $O$ if $f$ is continuous at any point of $O$.

## To Compute the Limit of $f$ at the Given Point $x_0$

$$\lim_{x\to x_0}\frac{g(x) - g(x_0)}{x} = g'(x_0)$$

# Differential Calculus

## $f: (\mathbb{R}^d, ||\cdot||) \to (\mathbb{R}^k, ||\cdot||')$

$f$ is differentiable on $a \in \mathbb{R}^d$ if $\exists L \in \mathcal{L}(\mathbb{R}^d, \mathbb{R}^k)$ s.t.
$$\lim_{h\to0}\frac{||f(a+h) - f(a) - L(h)||'}{||h||}=0$$
We say $L$ is differential of $f: L = Df(a)$

## $f: \mathbb{R}^d\to \mathbb{R}^k$ Linear Map

If $f$ is a linear map, then $f$ is differentiable on $\mathbb{R}^d$ and then
$$Df(a)(h) = f(h) \quad \forall a \in \mathbb{R}^d, \forall h \in \mathbb{R}^d$$

## $f: \mathbb{R}\to \mathbb{R}$

$f$ is derivable on $a$ if and only if $f$ is differentiable on $a$ and
$$Df(a)(h) = f'(a)h$$

## Chain Rule: $f: \mathbb{R} \to \mathbb{R}, g: \mathbb{R} \to \mathbb{R}$

If $f$ is derivable on $a$ and $g$ is derivable on $f(a)$, then $g \circ f$ is derivable on $a$ and:
$$(g \circ f)'(a) = g'(f(a))f'(a)$$
$$D(g \circ f)(a)(h) = [Dg(f(a))] (Df(a)(h))$$

## First Order Directional Derivative

A mapping $f : \mathcal{O} \rightarrow \mathbb{R}^k$ is differentiable at $a \in \mathcal{O}$ along a given direction $h \in \mathbb{R}^d$ if the limit

$$D_h f(a) = \lim_{{t \to 0}} \frac{f(a + th) - f(a)}{t}$$

exists and is finite.

If a mapping $f : \mathcal{O} \rightarrow \mathbb{R}^k$ is differentiable at $a \in \mathcal{O}$, then $f$ is differentiable at $a$ along all directions, and

$$D_h f(a) = Df(a)(h); \quad \forall h \in \mathbb{R}^d.$$

**Note: if $f$ is differentiable at $a$, then $f$ is differentiable along all directions at $a$, but if $f$ is differentiable along all directions at $a$ != $f$ is differentiable at $a$**

## $f: \mathbb{R}^d\to \mathbb{R}, \nabla$

If all partial derivatives $\frac{\partial}{\partial x_i}f, \forall 1 \le i \le d$ exist and continious, then $f$ is differentiable and

$$Df(a)(h) = <\nabla f(a), h>$$

$$Df(a) = \begin{bmatrix}
  \frac{\partial}{\partial x_i}f(a) \\ \vdots \\ \frac{\partial}{\partial x_d}f(a)
\end{bmatrix}$$

## $f: \mathbb{R}\to \mathbb{R}^d$

$$f(x) = f(x * 1) = xf(1)$$

$$f(x) = cx \quad \forall x \in R, c \in R^d$$

$$Df(x)(h) = Df(x)(1)h$$

## $f: \mathbb{R}^d\to \mathbb{R}^k, J$

$x \to f(x) = (f_1(x),...,f_k(x))$\
If all partial derivatives exist and continious:  
$$\frac{\partial}{\partial x_j}f_i, \quad \forall 1 \le i \le k, \space \forall 1 \le j \le d$$
Then $f$ is differentiable and 

$$Df(a)(h) = J_f(a)(h), \quad J_f(a) = (k \times d), h = (d \times 1)$$

$$J_f(a) = \left(\frac{\partial}{\partial x_j}f_i(a)\right)$$

$$=_{\begin{align*}
  1\le i \le k \\ 1 \le j \le d
\end{align*}} \begin{bmatrix}\frac{\partial}{\partial x_1} f_1(a) && \ldots && \frac{\partial}{\partial x_d} f_1(a) \\ \vdots && \ddots && \vdots \\ \frac{\partial}{\partial x_1} f_k(a) && \ldots && \frac{\partial}{\partial x_d} f_k(a)\end{bmatrix}$$

$$Df(a) \in \mathcal{L}(\mathbb{R}^d, \mathbb{R}^k)$$

$$Df(a)(h) \to \mathbb{R}^d, \space \forall h \in \mathbb{R}^d$$

## Class $C^1$

Let $O$ an open subset of $\mathbb{R}^d$. A function $f: O \to \mathbb{R}^k$ is of class $C^1$ on $O$ if all partial derivatives exist and are continious.

Let $O$ an open subset of $\mathbb{R}^d$ and a function $f: O \to \mathbb{R}^k$ is of class $C^1$. Then $f$ is differentiable on $O$.

A function $f: \mathbb{R}^d \to \mathbb{R}$ of class $C^1$. Then $f$ is differentiable on $\mathbb{R}^d$ and
$$Df(a)(h) = <\nabla f(a), h>$$

## Twice Differentiable Map

If all 2nd order partial derivatives of $f$ on $a, \forall a \in R^d$ continious, then $f$ is twice differentiable.

## Second Order Directional Derivative

A map $f: O \to R^k$ is twice differentiable at $a \in O$ in the direction $h \in R^d$, then in the direction $n \in R^d$ if
$$D_{h,n}f(a) = D_nD_hf(a)$$
We first differentiate along the direction $h$ and then along the direction $n$

## Schwarz Theorem

If map $f: O \to R^k$ has continious second order partial derivatives on $O$ then for all $a \in O$:

$$\partial^2_{jl}f(a) = \partial^2_{lj}f(a), \quad \forall(l,j) \in \{1,...,d\}^2$$

In other words, we can switch the order when we differentiate and get the same result.

## $f: \mathbb{R}^d\to \mathbb{R}, H$

If all second partial derivatives exist and continious:  

$$\frac{\partial^2}{\partial x_i \partial x_j}f, \quad \forall 1 \le i,j \le d$$

Then:

$$\frac{\partial^2}{\partial x_i \partial x_j}f = \frac{\partial^2}{\partial x_j \partial x_i}f$$

and $f$ is twice differentiable and

$$D^2f(a)(h,k) = k^TH_f(a)h$$

$$D^2f(a) \in \mathcal{L}_2(\mathbb{R}^d, \mathbb{R}^k)$$

$$H_f(a) = \left(\frac{\partial^2}{\partial x_i \partial x_j}f(a)\right) =$$

$$\begin{bmatrix}\frac{\partial^2}{\partial^2 x_{11}} f(a) && \ldots && \frac{\partial^2}{\partial x_1 \partial x_d} f(a) \\ \vdots && \ddots && \vdots \\ \frac{\partial^2}{\partial x_d \partial x_1} f(a) && \ldots && \frac{\partial^2}{\partial^2 x_{dd}} f(a)\end{bmatrix}$$

# Convex Sets and Functions

## Convex Set

A subset $C \subset \mathbb{R}^d$ is convex if

$$\forall x,y \in C, \forall t \in [0,1], (1-t)x + ty \in C$$

In simpler terms, $C$ is convex $\iff$ any time we pick and two points, their segment stays in $C$

If $C$ is convex:

$$\forall n \in \mathbb{N}, x_1,...,x_n \in C, t_1,...,t_n \in \mathbb{R}_+, t_1 +...+t_n = 1$$

$$\sum^n_{k=1}t_kx_k \in C$$

$\sum^n_{k=1}t_kx_k \in C$ is called **convex combination** ($\sum^n_{k=1}t_kx_k \in C$ is a linear combination, and when $t_k \ge 0$ then it is convex combination).

## Particular Convex Sets

Following sets are convex:

- Vector subspaces of $\mathbb{R}^d$
- Intersection of two convex sets of $\mathbb{R}^d$
- Translation of convex set is also a convex set

- The open $B_{||\cdot||}(a,r) = \{x \in \mathbb{R}^d: ||x-a||< r\}$ and closed balls $\overline{B}_{||\cdot||}(a,r) = \{x \in \mathbb{R}^d: ||x-a||\le r\}$ of $(\mathbb{R}^d, || \cdot ||)$ are convex

Proof for closed ball:\
$\overline{B}_{||\cdot||}(a,r) = a + \overline{B}_{||\cdot||}(0,r)$ - translation by $a$, still convex. Now prove that $\overline{B}_{||\cdot||}(0,r)$ is convex.\
Let $x,y \in \overline{B}_{||\cdot||}(0,r)$ and let $t \in [0,1]$\
$(1-t)x + ty \in \overline{B}_{||\cdot||}(0,r)$\
$||(1-t)x + ty - 0|| \le r$\
$||(1-t)x + ty - 0|| \le ||(1-t)x|| + ||ty||=|(1-t)|||x|| + |t|||y|| = (1-t)||x|| + t||y||$\
Since $x,y \in \overline{B}_{||\cdot||}(0,r) => ||x|| \le r, ||y|| \le r, ||x-0|| \le r, ||y-0||\le r$\
$=> ||(1-t)x + ty - 0|| \le (1-t)r + tr = r$\
$=> (1-t)x + ty \in \overline{B}_{||\cdot||}(0,r)$

## Convex Function

A function $f: \mathbb{R}^d \to \mathbb{R}$ is convex if the following set is convex:

$$\{(x,y) \in \mathbb{R}^d \times \mathbb{R}: f(x) \le y\}$$

We also have:

$$\forall x,y \in \mathbb{R}^d, t\in[0,1]$$

$$f((1-t)x + ty) \le (1-t)f(x) + tf(y)$$

Example:\
$f(x) = x^2$\
$\forall x,y \in \mathbb{R}, t \in[0,1]$\
$((1-t)x + ty)^2 \le (1-t)x^2 + ty^2$\
$\alpha + \beta = 1$\
$(\alpha x + \beta y)^2 \le \alpha x^2 + \beta y^2$

## Convexity and Derivative

We have $(\mathbb{R}^d, ||\cdot||)$ and $O$ open and convex, $f\in C^1(O, \mathbb{R})$
1. $f$ is convex if and only if

$$f(y) \ge f(x) + <\nabla f(x), y-x >; \forall x,y \in O$$

2. The map $\nabla f$ is monotone:

$$<\nabla f(y) - \nabla f(x), y-x> \ge 0; \forall x,y \in O$$

Examples:

$f: \mathbb{R} \to \mathbb{R}$\
$f'(x)$ is non-decreasing (respectively increasing) $=>$ $f$ is convex (respectively strictly convex).

$f(x) = x^2$\
$f'(x) = 2x \uparrow \space => f(x)$ is convex\
$f'(x) \uparrow \iff \forall x < y => f'(x) \le f'(y) \iff \forall x,y \in \mathbb{R}: (x-y)|f'(x)-f'(y)| \ge 0$

$f: \mathbb{R} \to \mathbb{R}, C^2$\
if $f''(x) \ge 0, \forall x \in \mathbb{R}$\
$=> f'(x)$ is non-decreasing\
$=> f(x)$ is convex

$f(x) = x^2, f'(x) = 2x, f''(x) = 2$\
$=> f(x)$ is convex.

## Convexity and Second Derivative

Let $O$ open set of $(\mathbb{R}^d, ||\cdot||)$, $f \in C^2(O, \mathbb{R})$. 
1. $f$ is convex $\iff Hf(x)$ is positive, meaning $\forall h \in \mathbb{R}^d: h^THf(x)H \ge 0$ or $sp[Hf(x)] \subset \mathbb{R}_+ \forall x \in O$ (eigenvalues are real and positive)
2. The function $f$ is strictly convex $\iff Hf(x)$ is positive definite, meaning $\forall h \in \mathbb{R}^d: h^THf(x)H > 0$ or $sp[Hf(x)] \subset \mathbb{R}^*_+ \forall x \in O$

*Remark: to prove that $f$ is convex, use Propositions 18 or 19, and then use Proposition 17 for something else.*

## Hilbert Projection

Let $||\cdot||_2$ the Euclidean norm on $\mathbb{R}^d$. Let $C$ non-empty closed convex subset of $\mathbb{R}^d$.
1. . There exists a unique element $x_0 \in C$ s.t.

$$||x-x_0||_2 = d(x, C):=\inf_{y \in C}||x-y||_2$$

2. For all $y \in C$

$$<x - x_0, y - x_0> \le 0$$

# Optimization

Let $|| \cdot ||$ be a norm on $\mathbb{R}^d$, and $f : \mathbb{R}^d \to \mathbb{R}$ be a function. The aim of optimization is to solve the minimization (resp. maximization) problem $(P)$:

$$\min_{x \in A} f(x)$$

or

$$\max_{x \in A} f(x)$$

where:
- $f : \mathbb{R}^d \to \mathbb{R}$ is a cost/objective/criterion function,
- $A \subset \mathbb{R}^d$ is the set of constraints,
- Any point $x \in A$ is called an admissible point of problem $(P)$.

If $A$ is open - we have unconstrained problem of optimization, if $A$ is not open - we have optimization with constraints.

## Key Issues

- Existence: Can we find $x^* \in A$ s.t. $f(x^*) = \min_{x \in A}f(x)$ ?
- Necessary conditions: What properties, conditions must an admissible point fulfil to be a minimizer?
- Sufficient conditions: Can we find some properties s.t. if admissible point fulfills them, then it is a minimizer?

## Local, Global Extremum

Let $|| \cdot ||$ be a norm on $\mathbb{R}^d$, and $f : \mathbb{R}^d \to \mathbb{R}$ be a function.

- An element $x^* \in \mathbb{R}^d$ is a local minimum (resp. local maximum) of $f$ if there exists $r > 0$ such that:
$$f(x^*) \leq f(x) (\text{resp. }f(x^*) \geq f(x))$$
$$\forall x \in B_{|| \cdot ||}(x^*, r) \text{ - neighborhood of $x^*$ open ball with center $x^*$ and radius $r$}$$

- An element $x^* \in \mathbb{R}^d$ is a global minimum (resp. global maximum) of $f$ if:

$$f(x^*) \leq f(x) (\text{resp. }f(x^*) \geq f(x))$$

$$\forall x \in \mathbb{R}^d \text{ - whole $\mathbb{R}$}$$

- An element $x^* \in \mathbb{R}^d$ is an extremum of $f$ if it is either a minimum or a maximum of $f$.

*Remark: the problems $\min_{x \in A}[f(x)]$ and $-max_{x \in A}[-f(x)]$ are equivalent*.

## Optimization with Constraints

1. If $A$ is **bounded + closed**: Let $A$ be compact, not void subset of $(\mathbb{R}^d, ||\cdot||)$ and $f$ continious, then

$$\exists x^* \in A \text{ s.t. } f(x^*) = \min_{x\in A}[f(x)]$$

Example:\
$f(x) = (x-2)(x-1)(x+2)(x+3)$\
$A = [-4,3]$\
$f$ is continious, $A$ is compact\
$=> \exists x^* \in A \text{ s.t. } f(x^*) = \min_{x\in A}[f(x)]$

2. If $A$ is **closed**: Let $A$ be closed, non void subset of $(\mathbb{R}^d, ||\cdot||)$ and functions $f: A \to \mathbb{R}$ and $g: \mathbb{R} \to \mathbb{R}$ s.t.

$$f(x) \ge g(||x||) \quad \forall x \in \mathbb{R}^d$$

$$\lim_{t\to +\infty}g(t) = +\infty$$

  We say $f$ is infinite at infinity, i.e.

$$\lim_{x \in A, ||x|| \to + \infty}f(x) = +\infty$$

Example:\
$\mathbb{R}^3$\
$f(x,y,z) = \sqrt{x^2 + y^2 + z^2}$\
$g(t) = t$\
$f(x,y,z) = ||x,y,z|| = g(||x,y,z||)$\
$\lim_{t\to \infty}g(t) = +\infty$\
$=> f$ is infinite at infinity.

In dimension 1, to prove that $f$ is infinite at infinity, it is sufficient to prove that $\lim_{|x| \to \infty}f(x) = + \infty$

$$=> \begin{cases}
  \lim_{x \to \infty}f(x) = + \infty \\
  \lim_{x \to -\infty}f(x) = + \infty
\end{cases}$$

3. If $A$ is **unbounded and closed**: If $A$ is unbounded, closed, non void subset and $f$ is continious and **infinite at infinity**, then $\exists x^* \in A$

$$\min_{x\in A}[f(x)] = f(x^*) \quad$$

  The point $x^*$ is **global minimum** of $A$.

### Convexity and Optimization

Let $(P)$ be a minimization problem, and let $x^*$ be a local minimum of $(P)$.

- If $(P)$ is convex, then $x^*$ is a global minimum.
- If $(P)$ is strictly convex, then $x^*$ is the unique global minimum.

## Unconstrained Optimization

- $O$ is open 
- $f$ is differentiable.
- $f: O \to \mathbb{R}$
- We say $x^* \in O$ is **local** minimum if $f(x^*) \le f(x) \quad \forall x \in B_{||\cdot||}(x^*, r)$ (neighborhood of $x$)
- We say $x^* \in O$ is **global** minimum if $f(x^*) \le f(x) \quad \forall x \in O$ (neighborhood of $x$) 

### Necessary Condition

Let $O$ be a non void open subset of $(R^d, || \cdot ||)$ and $f \in C^0(O, \mathbb{R})$ (continious).\
Let $x^* \in O$.\
If $f \in C^1(O, \mathbb{R})$ (all first order partial derivatives exist and are continious) and $x^*$ is a local minimum of $f$, then $\nabla f(x^*)=0$ ($x^*$ is called **critical point**).

### Suficient Condition

Let $f \in C^2(O, \mathbb{R})$.\
If $\nabla f(x^*) = 0$ and $Hf(x^*)$ is positive (resp. negative) definite, then $x^*$ is a local minimum (resp. maximum) of $f$.\
*Recall that for convexity $Hf(x)$ is positive (definite) at $\forall x \in O$, but for local min we have $Hf(x^*)$ only at $x^*$*.

Example:\
$\mathbb{R}^2, f \in C^2$\
$f(x^* + h) = f(x^*) + \nabla f(x^*)^Th + h^THf(x)h + o(||h||) \quad \forall h \in B_{||\cdot||}(0,r)$\
$f(x^* + h) \ge f(x^*)$

### Sylvester's Criterion

Used to prove that matrix is positive definite.

$A = \begin{bmatrix}
  a_{11} & a_{12} & a_{13} \\ a_{21} & a_{22} & a_{23} \\ a_{31} & a_{32} & a_{33}
\end{bmatrix}$

$\det a_{11} = a_{11} > 0$\
$\det \begin{bmatrix}
  a_{11} & a_{12} \\ a_{21} & a_{22}
\end{bmatrix} > 0$\
$\det A > 0$

### Global Minimum | Unique

Let $C$ be a non-empty convex set in $\mathbb{R}^d$.

1. If $f : C \to \mathbb{R}$ is a convex and has a local minimum, then this minimum is global

2. If $f : C \to \mathbb{R}$ is a **strictly** convex function and has a local minimum, then this minimum is both global and **unique**.

3. If $C$ is open in $\mathbb{R}^d$ and $f \in C^1(C, \mathbb{R})$, and $f$ is **convex**, then

$$\forall x^* \in C, \nabla f(x^*) = 0 \iff f(x^*) = \min_{x \in C}f(x)$$

# RECAP

## Optimization with Constraints

1. If $A$ is **bounded + closed**: Let $A$ be compact, not void subset of $(\mathbb{R}^d, ||\cdot||)$ and $f$ continious, then

$$\exists x^* \in A \text{ s.t. } f(x^*) = \min_{x\in A}[f(x)]$$

2. If $A$ is **closed**: Let $A$ be closed, non void subset of $(\mathbb{R}^d, ||\cdot||)$ and functions $f: A \to \mathbb{R}$ and $g: \mathbb{R} \to \mathbb{R}$ s.t.

$$f(x) \ge g(||x||) \quad \forall x \in \mathbb{R}^d$$

$$\lim_{t\to +\infty}g(t) = +\infty$$

$$\lim_{x \in A, ||x|| \to + \infty}f(x) = +\infty$$

$$(\text{ we say $f$ is infinite at infinity })$$

3. If $A$ is **unbounded and closed**: If $A$ is unbounded, closed, non void subset and $f$ is continious and **infinite at infinity**, then $\exists x^* \in A$

$$\min_{x\in A}[f(x)] = f(x^*)$$

$$(\text{ the point $x^*$ is global minimum of $A$. })$$

## Optimization without Constraints

1. $f: C \to \mathbb{R}$ is convex (resp. strictly convex) $\iff \forall x \in C, Hf(x)$ is positive (resp. positive definite).
2. $x^*$ is local minimum $<=>$ If $\nabla f(x^*) = 0$ and $Hf(x^*)$ is positive definite
3. If $C$ is open in $\mathbb{R}^d$ and $f \in C^1(C, \mathbb{R})$, and $f$ is **convex**, then
$$\forall x^* \in C, \nabla f(x^*) = 0 \iff f(x^*) = \min_{x \in C}f(x)$$
4. If $f : C \to \mathbb{R}$ is a convex and has a local minimum, then this minimum is global
5. If $f : C \to \mathbb{R}$ is a **strictly** convex function and has a local minimum, then this minimum is both global and **unique**.

# Finding Local Extrema, Global or Unique

1. $\nabla f(x^*) = 0$ - critical point
2. $Hf(x^*)$ if Hessian is positive definite $=>$ $x^*$ is local minimum
3. if $f(x)$ is convex $\forall x \in R^d$, i.e. $Hf(x)$ is semi-positive definite $=>$ $x^*$ is global minimum.
4. if $f(x)$ is strictly convex $\forall x \in R^d$, i.e. $Hf(x)$ is positive definite $=>$ $x^*$ is unique global minimum.
