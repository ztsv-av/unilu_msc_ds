# Optimization

Let $|| \cdot ||$ be a norm on $\mathbb{R}^d$, and $f : \mathbb{R}^d \to \mathbb{R}$ be a function. The aim of optimization is to solve the minimization (resp. maximization) problem $(P)$:

$$\min_{x \in A} f(x)$$

or

$$\max_{x \in A} f(x)$$

where:
- $f : \mathbb{R}^d \to \mathbb{R}$ is a cost/objective/criterion function,
- $A \subset \mathbb{R}^d$ is the set of constraints,
- Any point $x \in A$ is called an admissible point of problem $(P)$.

If $A$ is **open** - we have **unconstrained** problem of optimization, if $A$ is **not** **open** - we have optimization **with** **constraints**.

## Key Issues

- **Existence**: Can we find $x^* \in A$ s.t. $f(x^*) = \min_{x \in A}f(x)$ ?
- **Necessary conditions**: What properties, conditions must an admissible point fulfil to be a minimizer?
- **Sufficient conditions**: Can we find some properties s.t. if admissible point fulfills them, then it is a minimizer?

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

## Not Open Set

1. If $A$ is **bounded + closed**: Let $A$ be compact, not void subset of $(\mathbb{R}^d, ||\cdot||)$ and $f$ continious, then

$$\exists x^* \in A \text{ s.t. } f(x^*) = \min_{x\in A}[f(x)]$$

#### Example

$f(x) = (x-2)(x-1)(x+2)(x+3)$\
$A = [-4,3]$\
$f$ is continious, $A$ is compact\
$=> \exists x^* \in A \text{ s.t. } f(x^*) = \min_{x\in A}[f(x)]$

2. If $A$ is **closed**: Let $A$ be closed, non void subset of $(\mathbb{R}^d, ||\cdot||)$ and functions $f: A \to \mathbb{R}$ and $g: \mathbb{R} \to \mathbb{R}$ s.t.

$$f(x) \ge g(||x||) \quad \forall x \in \mathbb{R}^d$$
$$\lim_{t\to +\infty}g(t) = +\infty$$

We say $f$ is infinite at infinity, i.e.

$$\lim_{x \in A, ||x|| \to + \infty}f(x) = +\infty$$

In dimension 1, to prove that $f$ is infinite at infinity, it is sufficient to prove that 

$$\lim_{|x| \to \infty}f(x) = + \infty$$

$$<=> \begin{cases}
  \lim_{x \to \infty}f(x) = + \infty \\
  \lim_{x \to -\infty}f(x) = + \infty
\end{cases}$$

#### Examples

$\mathbb{R}^3,f(x,y,z) = \sqrt{x^2 + y^2 + z^2}$\
$g(t) = t, =>f(x,y,z) = ||x,y,z|| = g(||x,y,z||)$\
$\lim_{t\to \infty}g(t) = +\infty$\
$=> f$ is infinite at infinity.

$\mathbb{R}^2,f(x,y) = e^{-(x^2+y^2)}=e^{-(||x,y||^2)}$\
$g(t) = e^{-t^2}, => f(x,y) = g(||x,y||)$\
$\lim_{t\to \infty}g(t) = 0$\
$=> f$ is not infinite at infinity.

3. If $A$ is **unbounded and closed**: If $A$ is unbounded, closed, non void subset and $f$ is continious and **infinite at infinity**, then $\exists x^* \in A$

$$\min_{x\in A}[f(x)] = f(x^*) \quad$$

The point $x^*$ is **global minimum** of $A$.

### Convexity and Optimization

Let $(P)$ be a minimization problem, and let $x^*$ be a local minimum of $(P)$.

- If $(P)$ is convex, then $x^*$ is a global minimum.
- If $(P)$ is strictly convex, then $x^*$ is the unique global minimum.

# Unconstrained Optimization

- $O$ is open 
- $f$ is differentiable.
- $f: O \to \mathbb{R}$
- We say $x^* \in O$ is **local** minimum if $f(x^*) \le f(x) \quad \forall x \in B_{||\cdot||}(x^*, r)$ (neighborhood of $x$)
- We say $x^* \in O$ is **global** minimum if $f(x^*) \le f(x) \quad \forall x \in O$ (neighborhood of $x$) 

### Necessary Condition

Let $O$ be a non void open subset of $(R^d, || \cdot ||)$ and $f \in C^0(O, \mathbb{R})$ ( - continious). Let $x^* \in O$. If $f \in C^1(O, \mathbb{R})$ (all first order partial derivatives exist and are continious) and $x^*$ is a local minimum of $f$, then $\nabla f(x^*)=0$ ($x^*$ is called **critical point**).

### Sufficient Condition

Let $f \in C^2(O, \mathbb{R})$.If $\nabla f(x^*) = 0$ and $Hf(x^*)$ is positive (resp. negative) definite, then $x^*$ is a local minimum (resp. maximum) of $f$.

*Recall that for convexity $Hf(x)$ is positive (definite) at $\forall x \in O$, but for local min we have $Hf(x^*)$ only at $x^*$*.

### Saddle Point

Saddle point is a critical point where it is a minimum for one direction and maximum for other one.

### Global Minimum | Unique

Let $C$ be a non-empty convex set in $\mathbb{R}^d$.

1. If $f : C \to \mathbb{R}$ is a convex and has a local minimum, then this minimum is global.

2. If $f : C \to \mathbb{R}$ is a **strictly** convex function and has a local minimum, then this minimum is both global and **unique**.

3. If $C$ is open in $\mathbb{R}^d$ and $f \in C^1(C, \mathbb{R})$, and $f$ is **convex**, then
$$\forall x^* \in C, \nabla f(x^*) = 0 \iff f(x^*) = \min_{x \in C}f(x)$$

Example:\
$f: (x,y) \in \mathbb{R}^2 \to x^2+y^2-xy$\
$\nabla f(x,y) = 0$\
$\nabla f(x,y) = \begin{bmatrix}
  2x - y \\ 2y - x
\end{bmatrix} = \begin{bmatrix}
  0 \\ 0
\end{bmatrix}$\
$2x=y$\
$2y=x$\
$4y - y =0$\
$=> x=0, y=0$\
$=> x^*=(0,0)$ is a critical point. To prove that it is local minumum:\
$Hf(x,y) = \begin{bmatrix}
  2 & -1 \\ -1 & 2
\end{bmatrix} \quad \forall x,y \in \mathbb{R}^2$\
$Hf(0,0) = \begin{bmatrix}
  2 & -1 \\ -1 & 2
\end{bmatrix}$\
By Sylvester's Criterion:\
$\det(2) = 2 > 0$\
$\det(Hf(0,0))$ = 3 > 0\
$Hf(x^*)$ is positive definite\
$=> f$ is strictly positive\
$=> x^*$ is unique global minimum

## RECAP

1. $f: C \to \mathbb{R}$ is convex (resp. strictly convex) $\iff \forall x \in C, Hf(x)$ is positive (resp. positive definite).
2. $x^*$ is local minimum $<=>$ $\nabla f(x^*) = 0$ and $Hf(x^*)$ is positive definite
3. If $O$ is open in $\mathbb{R}^d$ and $f \in C^1(O, \mathbb{R})$, and $f$ is **convex**, then
$$\forall x^* \in O, \nabla f(x^*) = 0 \iff f(x^*) = \min_{x \in O}f(x)$$
4. If $f : C \to \mathbb{R}$ is a convex and has a local minimum, then this minimum is global
5. If $f : C \to \mathbb{R}$ is a **strictly** convex function and has a local minimum, then this minimum is both global and **unique**.

## Algorithms for Unconstrained Optimization

Determining the exact solution of a minimization
problem is impossible (in most cases). Descent algorithms can provide an
approximation of this.

### Descent Algorithm | Fidning **Local** Minimum

Choose $x_{\text{start}}$. Descent algorithm generates a sequence $(x_k)_{k \in N}$ defined by
$$x_{k+1} = x_k + s_kd_k$$
$$f(x_{k+1}) \le f(x_k)$$
,where
- $d_k$ is the descent **direction**
- $s_k$ is the descent **step** or **learning rate**

#### General Algorithm

*Input*: $f$ differentiable on $R^d$, $x_{\text{start}}$ initial point, $\varepsilon > 0 \approx 0$ **precision**.
*Output*: approximation of $\min_{x \in R^d}f(x)$

**Algorithm** $\text{DA}(f, x_{\text{start}}, \varepsilon)$ with fixed learning rate:
- Initialize $x_0 = x_{\text{start}}, k:= 0$
- While $||\nabla f(x_k)|| > \varepsilon$ (**stop condition**)
  - Find $d_k$ s.t. $\nabla f(x_k)^Td_k < 0$ $(<\nabla f(x_k), d_k> < 0)$ 
  - Choose $s_k > 0$ in direction $d_k$ s.t. $f(x_k + s_kd_k) < f(x_k)$ (**descent property**)
  - $x_{k+1} := x_k + s_kd_k$ (**update**)
  - $k := k + 1$
- Return $x_k$

We find $d_K$ s.t. $<\nabla f(x_k), d_k> < 0$ because by Taylor:
$$f(x_{k+1}) = f(x_k + s_kd_k) = f(x_k) + s_{k_\text{greater than 0}} <f(x_k), d_k>_{\text{should be less than 0}} + \text{ remainder }$$
$$f(x_k + 1) \le f(x_k)$$

#### Stop Conditions

One or the combination of the following criteria can be used to stop
the iterations of a descent algorithm:

- Since $\nabla f(x_k) \to \nabla f(x^*) = 0$ we can set:
$$||\nabla f(x_k)|| \le \varepsilon_1$$ 
- We have $x_k \to x^*$, so that we can choose
$$||x_k - x_{x+1}|| \le \varepsilon_2$$
- We also have $f(x_k) \to f(x^*)$ so we can use:
$$||f(x_k) - f(x_{k+1})|| \le \varepsilon_3$$

#### Gradient Algorithm

Take $d_k = -\nabla f(x_k)$\
$<\nabla f(x_k), -\nabla f(x_k)> = - ||\nabla f(x_k)||^2 < 0$\
$x_{k+1} = x_k - s \cdot \nabla f(x_k)$

*Input*: $f$ differentiable on $R^d$, $x_{\text{start}}$ initial point, $\varepsilon > 0 \approx 0$ **precision**.
*Output*: approximation of $\min_{x \in R^d}f(x)$

**Algorithm** $\text{GD}(f, x_{\text{start}})$ with fixed learning rate:
- Initialize $x_0 = x_{\text{start}}, k:= 0$
- While $||\nabla f(x_k)|| > \varepsilon$ (**stop condition**)
  - $x_{k+1} := x_k - s\nabla f(x_k)$ (**update**)
  - $k := k + 1$
- Return $x_k$

<div style="text-align: center;">
  <img src="ims/image-10.png" alt="ims/image Description" />
</div>

**Note: choosing good starting point $x_{\text{start}}$ and learning rate $s_k$ is very important. If otherwise, the algorithm might not converge if the learning rate too large. The algorithm might converge slowly, if learning rate is too small. If starting point is chosen wisely, the algorithm might even converge to a global minimum, not local.**

### Gradient Descend Convergence

#### Lipschitz Gradient

Let $f: R^d \to R$ differentiable function. If $\exists L \in R^*_+$ s.t.
$$\frac{||\nabla f(x) - \nabla f(y)||}{||x-y||} \le L, \quad x\ne y, \forall (x,y) \in R^d$$

then $f$ is dierentiable with continuous $L$-Lipschitz gradient.

Let $f: R^d \to R$ differentiable function with $L$-Lipschitz continious gradient. Then
$$f(y) \le f(x) + <\nabla f(x), y-x> + \frac{L}{2}||y-x||^2, \quad \forall (x,y) \in R^d$$

#### Optimal Step

The optimal step is defined by
$$s^* = \argmin_{s>0}f(x - s\nabla f(x))$$

#### Convergence of GD

We have convergent GD $\iff ||\nabla f(x_k)|| < \varepsilon$ at some point $x_k$.

Let a function $f$ bounded below, of class C1 with gradient Lipschitz of constant $L > 0$. Then:

1. If $\forall k, s_k = s < \frac{2}{L}$ the GD algorithm with constant step **converges globally** and
$$0 < s||\nabla f(x_k)||^2 - \frac{Ls^2}{2}||\nabla f(x_k)||^2 \le f(x_k) - f(x_{k+1})$$

Proof:\
We know: $f(y) \le f(x) + <\nabla f(x), y-x> + \frac{L}{2}||y-x||^2$\
Let $y = x_{k+1}, x = x_k$. Then\
$f(x_{k+1}) \le f(x_k) + <\nabla f(x_k), x_{k+1}-x_k> + \frac{L}{2}||x_{k+1}-x_k||^2$\
We know that $x_k - x_{k+1} = s\nabla f(x_k)$. Then\
$f(x_{k+1}) \le f(x_k) - <\nabla f(x_k), s\nabla f(x_k)> + \frac{L}{2}||s\nabla f(x_k)||^2$\
$f(x_{k+1}) - f(x_k)\le - s<\nabla f(x_k), \nabla f(x_k)> + \frac{Ls^2}{2}||\nabla f(x_k)||^2$\
$f(x_k) - f(x_{k+1})\ge s||\nabla f(x_k)||^2 - \frac{Ls^2}{2}||\nabla f(x_k)||^2$


2. The **optimal constant step** is defined by $s_k = s^* = \frac{1}{L} \forall k \in N$ and
$$\frac{1}{2L}||\nabla f(x_k)||^2 \le f(x_k) - f(x_{k+1})$$

#### Wolfe's Condition

The direction $d$ and the step $s$ of a descent algorithm with linear search satisfy Wolfe’s conditions if there exists $(\varepsilon_1, \varepsilon_2) \in (0, 1)^2$ such that $\varepsilon_1 < \varepsilon_2$ and

1. $f(x + sd) \le f(x) + \varepsilon_1 s(\nabla f(x)^Td)_{\text{linear}}$
2. $\nabla f(x + sd)^Td \ge \varepsilon_2(\nabla f(x)^Td)$

**The GD algorithm with Wolfe’s step globally converges.**

### Newton's Method

By Taylor:

$$f(x) \approx f(x_k) + f'(x_k)(x-x_k) +$$

$$+ \frac{f''(x_k)}{2}(x-x_k)^2 =: q(x)$$

Here, $f(x_k) + f'(x_k)(x-x_k)$ - linear approximateion of the function in a neighborhood of $x+k$.

The necessary condition for optimization is $q'(x)=0$, $f'(x) \approx q'(x)$.

$$q'(x) = f'(x_k) + f''(x_k)(x-x_k)$$

If $f''(x_k) > 0$, $q$ achieves a minimum at

$$x = x_k - \frac{f'(x_k)}{f''(x_k)}$$

<div style="text-align: center;">
  <img src="ims/image-11.png" alt="ims/image Description" />
</div>

#### Newton's Algorithm

- input: $f$ **twice differentiable** on $R^d, x_{start}$ initial point, $\varepsilon > 0$
- output: approximation of $\min_{x \in R^d}f(x)$

Algorithm:
1. initialize $x_0 = x_{start}, k =0$
2. While $||\nabla f(x_k)||>\varepsilon$ (stop criterion)
   1. $x_{k+1} = x_k - [Hf(x_k)]^{-1}\nabla f(x_k)$
   2. $k = k+1$
3. return $x_k$

Newton's direction is: $d_k = [Hf(x_k)]^{-1}\nabla f(x_k)$

### Link Between GD and Newton's

<div style="text-align: center;">
  <img src="ims/image-12.png" alt="ims/image Description" />
</div>

- If $f$ is smooth enough (atleast twice differentiable), then Newton's method is faster (quadratic convergence)
- Both methods have a drawback, since they only provide local minimum.

### Gauss-Newton Method

$$r: R^d \to R^d, \text{differentiable}$$

$$f(x) = \frac{1}{2}||r(x)||^2_2$$

**Idea**: replace at each iteration the non-linear LS problem by an
approximate linear LS problem (by Taylor). Let $x_k$ be the current iterate. Replace
in a neighbourhood of $x_k$, the problem by

$$\min_{y \in R^d}\tilde{f}(y) = \frac{1}{2}||r(x_k) + J_r(x_k)(y-x_k)||^2_2$$

$$y = x_{k + 1}$$

$$x_{k + 1} = (J_r^T(x_k)J_r(x_k))^{-1}(J_r^T(x_k)J_r(x_k)x_k - J_r^T(x_k)r(x_k))$$

The direction $d_k=x_{k+1} - x_k$ is called Gauss-Newton direction.

#### Gauss-Newton Algorithm

- input: $r$ differentiable on $R^d, x_{start}$ initial point, $\varepsilon > 0$ precision.
- output: approximation of $\min_{x \in R^d}f(x)$

Algorithm:
1. initialize $x_0 = x_{start}, k=0$
2. while $||\nabla f(x_k)|| > \varepsilon$
   1. $x_{k + 1}= x_k - [J_r(x_k)^TJ_r(x_k)]^{-1}J_r(x_k)^Tr(x_k)$
   2. k = k + 1
3. return $x_k$

# Constrained Optimization

## Optimization with (In)equality Constrains

$$\min_{x \in A}f(x) (\text{resp.} \max_{x \in A}f(x))$$

$$f: R^d \to R$$

- $f$ a **cost/objective function**, $A \subset R^d$ is the **admissible set**. 
- The **optimal value** of $(P)$ is 

$$p^*=\inf_{x \in A}f(x)$$

We allow $p^*=\plusmn\infty$

- A point $x^*$ is **optimal** if $x^*$ is **admissible** and $f(x^*)=p^*$. The set of all points is the **optimal set**. Point $x^*$ is **admissible** if it satisfies some constrains.

### Example

- **objective function**: $f(x,y) = y+1$
- **constraint functions**:
  - $x - y \le 0, g_1(x,y) = x-y$
  - $4 - y - 2x \le 0, g_2(x,y) = 4-y-2x$
  - $-x \le 0, g_3(x,y) = -x$
  - $y-2 \le 0, g_4(x,y) = y-2$

### Admissible Direction

Let $x \in A$. A direction $d \in R^d$ is admissble at $x$ if there exists $\overline{s} > 0$ s.t. $x + sd$ is admissible for all $s \in (0, \overline{s}]$

Remember: $A$ is convex, $x,y \in A; (1-t)x + ty \in A, \forall t \in [0,1]\
Let $t=1, d=y-x, s=t$, then: $x + t(y-x) \in A; => y-x$ admissible at $x$

### Tangent Cone

Let $A \subset R^d$ and $x\in A$. The vector $d \in R^d$ is tangent to $A$ at $x$ if and only if there exist sequences

- $(x_n)_{n \in N_0}$ of elements of $A$
- $(\lambda_n)_{n \in N_0}$ of positive numbers

s.t.

$$x_n \to_{n \to +\infty}x \text{ and } \lambda_n(x_n - x) \to_{n \to +\infty} d$$

The set $T_x(A)$ is called the **tangent** **cone** to $A$ at $x$.

The vector $d$ is called a **tangent direction** to $A$ at $x$.

#### Examples

1. $A = \{x=(x_1, x_2) \in R^2: -x_1^3 + x_2 \le 0, -x_2 \le 0\}, x=(0,0)$

We are looking for a direction at $(0,0)$ tangent to the intersection of the graphs.

$$(x_1^n, x_2^n)\in A \to (0,0)$$

$$\lambda_n((x_1^n, x_2^n) - (0,0)) \to d$$

Let $x_1^n = \frac{1}{n}, x_1^n \to_{n \to \infty} 0$\
Let $x_2^n = \frac{1}{n^3}, x_2^n \to_{n \to \infty} 0$

$$(-\frac{1}{n})^3  + \frac{1}{n^3}=0 => \in A (-x_1^3 + x_2 \le 0)$$

Let $\lambda_n = n$, then

$$n(1/n, 1/n^3)=(1,1/n^2) \to (1,0)$$

$=> d=(1,0) \in T_x(A)$

2. $A = \{x=(x_1, x_2) \in R^2: x_1^2 \le x_2^2\} \iff \{x=(x_1, x_2) \in R^2: |x_1| \le |x_2|\}$

Looking for a direction vector at $(0,0)$ tangent to the intersection of graphs.

Let $x_1^n = \frac{1}{n} x_1^n \to_{n \to \infty} 0$\
Let $x_2^n = \frac{1}{n}, x_2^n \to_{n \to \infty} 0$

$$1/n - 1/n = 0 => \in A$$

Let $\lambda_n = n$, then

$$n(1/n, 1/n)=(1,1) \to (1,1)$$

$=> d=(1,1) \in T_x(A)$

### Necessary Optimality Condition

Let $x^*$ be a local minimum of $(P)$. Then

$$\forall v \in T_{x^*}(A), <\nabla f(x^*), v> \ge 0$$

### Frame

We consider the constrained optimization problem

$$(P) \text{ minimize } f(x) \text{ subject to }  \begin{cases}
  g_i(x) \le 0, i=1,...,m \\
  h_j(x) = 0, j=1,...,p
\end{cases}$$

where

- for $i=1,...m, [g_i(x) \le 0]$ is an **inequality constraint** and $g_i: R^d \to R$ an **inequality constraint function** assumed to be **differentiable**.
- for $j=1,...p, [h_j(x) = 0]$ is an **equality constraint** and $h_j: R^d \to R$ an **equality constraint function** assumed to be **differentiable**.

*Remark: if $m=p=0, (P)$ is an unconstrained optimization problem.*

### Terminology

1. The domain of the problem $(P)$ is

$$D = Dom f \cap (\bigcap^m_{i=1}Dom\space g_i) \cap (\bigcap^p_{j=1}Dom\space h_j)$$

2. A point $x \in D$ is **admissible** if $x \in A$ where

$$A = \{ x \in D: g_i(x) \le 0, h_j(x) = 0\}$$

$$A^+ = \{ x \in D: g_i(x) < 0, h_j(x) = 0\}$$

3. The constraint $g_i$ is **active**(saturated) at $x \in A$ if $g_i(x) =0$ and we note 
 
$$I(x) = \{ i=1,...,m: g_i(x)=0\}$$

### Qualification of Constraints

1. The constraints of $(P)$ are qualified at $x \in A$ if 

$$T_x(A) = \{d \in R^d:$$

$$\forall j \in\{1,...,p\}, <\nabla h_j(x), d> = 0\,$$

$$\forall i \in I(x), <\nabla g_i(x), d> \le 0\}$$

This set is called the **polyhedron** of constraints of $F_x(A)$.

That means that the constraints are qualified at $x$ if the tangent cone consists of directions $d$ s.t.

$$<\nabla h_j(x), d> = 0, \quad \forall j \in\{1,...,p\}$$

$$<\nabla g_i(x), d> \le 0 \quad \forall i \in I(x)$$

2. We say that the constaints $(P)$ are qualified at $x \in A$ if

$$\{\nabla h_j(x), j = 1,...,p\} \cup \{\nabla g_i(x), i \in I(x)\}$$

are **linearly independent**.

### Convex Optimization Problem

A convex problem is a problem where the **objective** function is **convex**, the **inequality** constraint functions are **convex** and the **equality** constraint functions are **affine**:

$$h_j(x) = a_j^Tx - b_j, x \in R^d$$

$$\begin{bmatrix}
  h_1(x) \\ \vdots \\ h_p(x)
\end{bmatrix} = 0 \iff Ax=b, A = \begin{bmatrix}
  a_1^T \\ \vdots \\ a_p^T
\end{bmatrix}$$

### Slater Condition

In the case of convex problem, a simple constraint qualification is the **Slater** **condition**: 

$$\exists x \in \overset{\circ}{D} \text{ s.t. }$$
$$\forall j=1,...,p, h_j(x) = 0 $$
$$g_i(x) < 0, i=1,...,m$$

Slater’s condition can be refined when there exists $k \in \{1,...,m\}$ s.t. $g_1,...,g_k$ are affine. Slater's condition is then:

$$\exists x \in \overset{\circ}{D} \text{ a solution to } (P) \text{ s.t. }$$

$$g_i(x) \le 0; i = 1,...,k$$

$$g_i(x) < 0, i = k+1,...,m$$

$$h_j(x) = a_j^Tx - b_j, x \in R^d$$

**If $f(x)$ is not convex, we cannot do Slater condition**.

#### Example

Show that the Slater's condition holds.

1. Check that the problem is convex.
2. Check that Slater's condition holds at all points $(x, -1/2) \in A$

$f(x,y) = x^2 + 2y^2 + x$\
$g_1(x,y) = -x+y^2$\
$g_2(x,y) = -x-y$

1. 

Is $f$ convex?

$Hf(x,y) = \begin{bmatrix}
  2 && 0 \\ 0 && 4
\end{bmatrix}$

$Hf(x,y)$ is pos. def. $=>$ $f$ is convex.

Is $g_1$ convex?

$Hg_1(x,y) = \begin{bmatrix}
  0 && 0 \\ 0 && 2
\end{bmatrix}$

$Hf(x,y)$ is semi-pos. def. $=>$ $g_1$ is convex.

Is $g_2$ convex?

$g_2(x,y) = -x-y = [-1, -1]\begin{bmatrix}
  x \\ y
\end{bmatrix}$ affine $=>$ convex.

$=> (P)$ is convex.

2. 

Consider points $(x,-1/2) \in A$. We have that $g_2$ is affine. Assume $g_2$ is active at $(x,-1/2)$. That means that $g_2(x,-1/2) = 0 \iff -x+1/2 = 0 \iff x=1/2$

$g_1(1/2,-1/2) = -1/4 < 0$

We have that $g_1$ is not active at $(1/2, -1/2)$, so we cannot check linear independency, but, thanks to the Slater's condition, the constraints are indeed qualified at $(1/2, -1/2)$

### Lagrangian

The Lagrangian associated to $(P)$ is the function $\mathcal{L} : R^m \times R^p \to R$ defined for $(\gamma, \lambda) \in R^m \times R^p$ by

$$\mathcal{L}(x,\gamma, \lambda) = f(x) + \sum^m_{i=1}\gamma_ig_i(x) + \sum^p_{j=1}\lambda_jh_j(x)$$

where
- $f(x)$ - objective function
- $g_i(x), h_j(x)$ - constraint functions.
- $x \in R^d$
- $\gamma \in R^m$
- $\lambda \in R^p$

### Karush-Kuhn-Tucker CN

Let $x^* \in A$ be an admissible point of $(P)$. Assume that the constraints are qualified at $x^*$. If $x^*$ is a **local minimum** of $f$ on $A$,
there exist $(\gamma^*, \lambda^*) \in R^m \times R^p$ such that

$$\text{KKT }\begin{cases}
  \nabla_x\mathcal{L}(x^*,\gamma^*, \lambda^*) = 0, \\
  h_j(x^*) = 0, \\
  \gamma^*_ig_i^*(x^*) = 0, \\
  \gamma_i^* \ge 0, \\
  j = 1,...,p \\
  i = 1,...,m
\end{cases}$$

They are referred as the Karush-Kuhn-Tucker (KKT) conditions.

### SNC Condition in a Convex Problem

Assume that $(P)$ is a convex problem. Let $x^*\in A$ be an admissible point of $(P)$ where the constraints are qualified.
Then, $x^*$ is a **global minimum** of $f$ on $A$ if and only if the KKT conditions hold at $x^*$.

### 2nd-order Sufficient Condition

Define the Hessian of the Lagrangian by

$$H\mathcal{L}(x,\gamma, \lambda) = Hf(x) + \sum^m_{i=1}\gamma_iHg_i(x) + \sum^p_{j=1}\lambda_jHh_j(x)$$

Let $x^* \in A$ s.t.
- $(x^*,\gamma, \lambda)$ satisfy KKT conditions
- $H\mathcal{L}$ is positive definite on $T_{x^*}^+(A)$ (where $x^*$ is qualified by linear independence or $F_{x^*}^+$)

Then, $x^*$ is a **strict local minimum** of $(P)$ (strict = unique in a neighborhood of $x^*$).

### Lagrangian Duality

The Langrange dual function associated to $(P)$ is the function $\phi: R^m_+ \times R^p \to R$ s.t.

$$\phi(\gamma, \lambda) = \inf_{x\in D}L(x,\gamma, \lambda)$$

When the Lagrangian is unbounded from below in $x, \phi(\gamma, \lambda) = -\infty$. The dual admissible domain is

$$A^* = \{(\gamma, \lambda)\in R^m_+ \times R^p: \phi(\gamma, \lambda) > - \infty\}$$

### Dual Problem

Since $A \subseteq D$:

$$\inf_{x\in D}L(x,\gamma, \lambda) \le \inf_{x\in A}L(x,\gamma, \lambda) \le \inf_{x \in A}f(x)$$

$$d^*=\sup_{\gamma \in R^m, \lambda \in R^p}\phi(\gamma, \lambda) \le \inf_{x \in A}f(x) = p^*$$

$$d^* \le p^*$$

$$(P): \min_{x\in A}f(x) = p^* - \text{ primal problem}$$

$$(D): \max_{\gamma \in R^m, \lambda \in R^p}\phi(\gamma, \lambda) = d^* - \text{ dual problem}$$

The Langrange dual function provides a lower bound for the optimization problem $(P)$.

#### Example

$$\text{ minimize }f(x) = c^Tx\text{ subject to }Ax = b, x \ge 0$$

$$x \in R^d, A\in M^{p \times d}, b,c \in R^p$$

$L(x, \gamma, \lambda) = c^Tx + \sum^d_{i=1}\gamma_i(-x_i) + \sum^d_{j=1}\lambda_j(A_j^Tx - b_j)=c^Tx - \gamma^Tx + \lambda^T(Ax-b)$

$\phi(\gamma, \lambda) = \inf_{x \in R^d}L(x,\gamma, \lambda)=\inf_{x \in R^d}[c^Tx - \gamma^Tx + \lambda^T(Ax-b)]$

We have that $c^Tx, \gamma^Tx$ and $\lambda^T(Ax-b)$ are linear.

$\inf_{x \in R^d}[(c-\gamma+A\lambda^T)x - \lambda^Tb]$

We have that $[(c-\gamma+A\lambda^T)x - \lambda^Tb]$ is affine.

To find the minimum of affine function, we need to look at $\nabla=0$.

$\nabla_xL(x,\gamma,\lambda) = c -\gamma+A^T\lambda=0$

$=>\inf_{x \in R^d}L(x,\gamma,\lambda) = \begin{cases}
  -\lambda^Tb,\text{ if }c -\gamma+A^T\lambda=0 \\ -\infty
\end{cases}$

#### Conjugate Function

The conjugate of a function $f: R^d \to R$ is the function $f^*$ defined by

$$f^*(y) = \sup_{x\in D(f)}(y^Tx-f(x))$$

The Lagrange dual function and conjugate function are closely related.

$$\inf(\dots) = -\sup(- \dots)$$

#### Example

$\phi(\gamma, \lambda)=\inf_{x \in R^d}L(x,\gamma, \lambda)=\inf_{x \in R^d}[c^Tx-\gamma^Tx+(A^T\lambda)^T x - \lambda^Tb] = - \lambda^Tb+\inf_{x \in R^d}[c^Tx-\gamma^Tx+(A^T\lambda)^T x]=-\lambda^Tb-\sup_{x \in R^d}[-c^Tx+\gamma^Tx-(A^T\lambda)^T x]$

$f(x) = -c^Tx, y^Tx = \gamma^Tx-(A^T\lambda)^T x$

$=> \phi(\gamma, \lambda)=-\lambda^Tb-\sup_{x \in R^d}[y^Tx-f(x)] = -f^*(\gamma-A^T\lambda)-\lambda^Tb$

### Dual Problem

The (Lagrange) dual problem $(D)$ associated to the primal problem $(P)$ is defined by

$$\text{maximize }\phi(\gamma,\lambda)\text{ subject to }(\gamma,\lambda) \in R^m_+ \times R^p$$

We denote $d^*$ the optimal value of $(D)$ i.e.

$$d^* = \sup_{(\gamma,\lambda)\in R^m_+ \times R^p}\phi(\gamma,\lambda)$$

The dual problem is convex, since $\sup_{\dots}\phi(\dots)=-\inf_{\dots}-\phi(\dots)$. Since $\phi$ is concave, then $-\phi$ is convex.

**Question**: under which conditionsdo we have $d^*=p^*?$

### Saddle Points of the Lagrangian

- For any $(\gamma,\lambda) \in \mathbb{R}^m_+ \times \mathbb{R}^p$, the map $x \in D \to L(x, \gamma,\lambda)$ is convex

- For any $x \in D$, the map $(\gamma,\lambda) \in \mathbb{R}^m_+ \times \mathbb{R}^p \to L(x, \gamma,\lambda)$ is concave.

An element $(x^*, \gamma^*,\lambda^*) \in D \times R^m_+, R^p$ is a saddle point of $L$ if

- $L(x^*, \gamma,\lambda) \le L(x^*, \gamma^*,\lambda^*), \forall \gamma \in R^m_+, \lambda \in R^p (\text{maximizes})$
- $L(x^*, \gamma^*,\lambda^*) \le L(x, \gamma^*,\lambda^*), \forall x \in D (\text{minimizes})$

### Weak Duality

The following weak principle holds:

$$\forall \gamma, \lambda: \phi(\gamma, \lambda)\le p^*, \quad d^* \le p^*$$

The duality gap is $p^* - d^*$

### Strong Duality

The duality gap is $0: p^*=d^*$

Let $x^* \in D, (\gamma^*, \lambda^*) \in R^m_+ \times R^p$. The point $(x^*, \gamma^*, \lambda^*)$ is a saddle point of $L$ if and only if

- $x^*$ is a solution $(P)$,
- $(\gamma^*, \lambda^*)$ is a solution of $(D)$
- The duality gap is $0: p^*=d^*$

Moreover, we have

$$p^* = f(x^*) - \inf_{x \in A}\left[\sup_{(\gamma, \lambda)\in R^m_+ \times R^p}L(x,\gamma,\lambda)\right]$$

#### Example

$$(P) = \begin{cases}
  \text{minimize }f(x,y) = x^2-2y^2 + x \\
  g_1(x,y) = -x+y^2 \\ g_2(x,y) = -x -y
\end{cases}$$

We saw $(1/2, 1/\sqrt{2})$ is a critical point with $\gamma_1=2, \gamma_2=0$. We couldn't tell anything else since the Hessian was semi-positive definite. But now we can prove that if the point $(1/2, 1/\sqrt{2})$ is saddle, then it is the global minimum of the problem.

$$L((x,y),\gamma_1,\gamma_2) = x^2-2^2+x+\gamma_1 g_1(x,y) + \gamma_2 g_2(x,y)$$

1. $L((1/2, 1/\sqrt{2}), \gamma_1, \gamma_2) \le L((1/2, 1/\sqrt{2}), 2, 0) ?$
   1. $L((1/2, 1/\sqrt{2}), 2, 0) = -1/4$
   2. $L((1/2, 1/\sqrt{2}), \gamma_1, \gamma_2) = -1/4 - \gamma_2(1/2 + 1/\sqrt{2})$
   3. $L((1/2, 1/\sqrt{2}), \gamma_1, \gamma_2) \le L((1/2, 1/\sqrt{2}), 2, 0), \forall \gamma_1, \gamma_2 \ge 0$
2. $L((1/2, 1/\sqrt{2}), 2, 0) \le L((x, y), 2, 0) ?$
   1. $L((1/2, 1/\sqrt{2}), 2, 0) = -1/4$
   2. $L((x, y), 2, 0) = x(x-1) (\text{doesn't depend on y})$
   3. $=> L((x, y), 0, 2) \le L((1/2, 1/\sqrt{2}), 2, 0), \forall x, y\in D$

$=> ((1/2, 1/\sqrt{2}), 2, 0)$ is saddle

$(x^*, \gamma^*) = \left( \begin{bmatrix}
  1/2 \\ 1/\sqrt{2}
\end{bmatrix}, \begin{bmatrix}
  2 \\ 0
\end{bmatrix}\right)$ - global minimum.

Also notice that we have strong duality, since $p^* = d^*$

$$p^* = f(x^*)= L(x^*, \gamma^*, \lambda^*) = d^* = \inf_{x \in D}L(x, \gamma^*, \lambda^*)$$

### CNS Strong Duality

In practise, Strong duality theorem does not indicate how to compute the saddle points of the Lagrangian but we have the following:

1. If $(P)$ has an optimal solution, so does $(D)$ and $p^*=d^*$
2. $x^*$ is a solution of $(P)$ and $(\gamma^*, \lambda^*)$ is a solution of $(D)$ if and only if
   1. $x^* \in A$
   2. $\gamma \ge 0$
   3. The following holds

$$f(x^*) = L(x^*, \gamma^*, \lambda^*) = \inf_{x\in R^d}L(x, \gamma^*, \lambda^*)$$

### Slater's Convex Condition

1. $f(x)$ convex
2. $g_i(x), i=1,\dots,m, g_i:R^d \to R$ convex
3. $h_j(x), j=1,\dots,p, h_j:R^d \to R^d$ affine: $\exists (a_j, b_j) \in R^d \times R^d$ s.t. $h_j(x)=a_j^Tx - b_j, x\in R^d$

$=> \exists x_0 \in D$ s.t:
   1. $h_j(x_0) = 0, \forall j=1,\dots,p$
   2. $g_i(x_0)<0, \forall i=1,\dots,m$

### Slater's Theorem

If $f(x)$ convex, $g_i(x)$ convex + Slater's condition ($h_j(x)=0, g_i(x)<0$), then

1. $p^*=d^*$
2. $\exists \gamma^* \in R^m_+$ s.t. $(x^*, \gamma^*)$ is a saddle point of the Lagrangian and
   - $\nabla f(x^*) + \sum^m_{i=1}\gamma_i^*\nabla g_i(x^*)+ \sum^p_{j=1}\lambda_j^*\nabla h_i(x^*)=0$
3. $(x^*, \gamma^*, \lambda^*)$ is a critical point of KKT.

a

1. A point is **admissible** if it belongs to the set of admissible points: $x \in A, A=\{x \in D: g_i(x) < 0, i=1,\dots,m \text{ and }h_j(x)=0,j=1,\dots,p\}$
2. Constraints are **qualified** at a point if:
   1.  $\{\nabla h_j(x), j=1,\dots,p\}\cup\{\nabla g_i(x), i \in I(x) (g_i(x) =0)\}$ are linearly independent.
   2.  $T_x(A) = \{d \in R^d:\forall j \in\{1,...,p\}, <\nabla h_j(x), d> = 0\,\forall i \in I(x), <\nabla g_i(x), d> \le 0\}$.
   3. Use Slater condition:
      1. Check if problem is convex: 
         1. $f(x)$ is convex
         2. $g_i(x), i=1,\dots,m$ are convex
         3. $h_j(x)=a_j^Tx-b_j, j=1,\dots,p, (h_1(x),\dots,h_p(x))=0 \iff Ax=b$ are affine.
      2. Check if Slater condition holds:
         1. There exists $x \in D$ s.t. $g_i(x)<0, i=1,\dots, m$ and $h_j(x)=0, j=1,\dots, p (Ax=b)$
         2. If there exists $k\in\{1,\dots,m\}$ s.t. $g_1,\dots,g_k$ are affine, then there exists $x \in D$ s.t.  $g_i(x)\le0, i=1,\dots, k$, $g_i(x)<0,i=k+1,\dots,m$ and $h_j(x)=0, j=1,\dots, p (Ax=b)$.
3. **Tangent** **cone** to $A$ at $x^*$: $T_{x^*}(A) = \{d \in R^d:\forall j \in\{1,...,p\}, <\nabla h_j(x^*), d> = 0,\forall i \in I(x^*), <\nabla g_i(x^*), d> \le 0\}$.
4. **Lagrangian**: $\mathcal{L}(x,\gamma, \lambda) = f(x) + \sum^m_{i=1}\gamma_ig_i(x) + \sum^p_{j=1}\lambda_jh_j(x)$
5. **KKT** conditions: if $x^*$ is a local minimum of $f$ on $A$, then $\exist (\gamma^*, \lambda^*) \in R^m \times R^p$ s.t.:
   1. $x^* \in A$ admissible, constrains are qualified at $x^*$
   2. $\nabla_x\mathcal{L}(x^*,\gamma^*, \lambda^*) = 0$
   3. $h_j(x^*) = 0$
   4. $\gamma^*_ig_i^*(x^*) = 0$
   5. $\gamma_i^* \ge 0$
   6. $j = 1,...,p$
   7. $i = 1,...,m$
6. If $(P)$ is convex, $x^*$ is admissible, constraints at $x^*$ are qualified and KKT conditions hold at $x^*$, then $x^*$ is **global minimum**.
7. If $x^*$ is admissible, constraints at $x^*$ are qualified, KKT conditions hold at $x^*$ and $HL$ is positive definite on $T_{x^*}^+(A)$ (where $x^*$ is qualified by linear independence), then $x^*$ is a **strict local minimum**.
8. 
9. To determine if $x^*$ is local or global minimum of $(P)$:
   1. if $(P)$ is not convex:
      1. $x^*$ is local minimum if:
         1. $\forall v \in T_{x^*}(A), <\nabla f(x^*), v>\ge0$
      2. $x^*$ is global minimum of $(P)$ if
         1. $(x^*,\gamma^*, \lambda^*)$ is saddle point
   2. If $(P)$ is convex:
      1. $x^*$ is global minimum of $f$ on $A$ if:
         1. $\iff$ KKT conditions hold at $x^*$
      2. $x^*$ is (strict) local minimum of $(P)$ if
         1. $H\mathcal{L}$ is positive definite on $T^+_{x^*}(A)$, **where $x^*$ is qualified by linear independence**
         2. $H\mathcal{L}$ is given by: $H\mathcal{L}(x,\gamma, \lambda) = Hf(x) + \sum^m_{i=1}\gamma_iHg_i(x) + \sum^p_{j=1}\lambda_jHh_j(x)$

### Algorithm to Find Local Minimum through

1. Check if $f(x)$ is convex.
   1. If convex $=>$ do Slater condition
2. If not convex, calculate Lagrangian.  
3. Calculate $\nabla$ of Lagrangian
4. Find critical points by KKT.
5. Find minimum among the critical points (where $f(x)$ takes minimal value).
6. Compute Hessian of the Lagrangian at the point
7. Check if Hessian is positive definite
   1. If positive definite $=>$ then $x$ is strict local minimum
   2. If not positive definite, cannot say anything.
