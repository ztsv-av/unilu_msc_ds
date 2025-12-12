---
title: Introduction to Graph Theory | Homework 2
author: Anton Zaitsev | 0230981826
date: \today{}
usepackage:
    - amsmath
    - geometry
    - float
header-includes: |
    \usepackage{caption}
    \usepackage{float}
    \usepackage{graphicx}
output: pdf_document
geometry: "left=25mm, right=25mm, top=10mm, bottom=10mm"
---

\pagebreak

# Exercise 1

Let $P=(4,4,4,3,3,5)$ a Prüfer sequence, $G=(V,E)$ labelled tree that admits $P$ as a Prüfer sequence. Let us reconstruct $G$ using $P$.

- Input: $P=(4,4,4,3,3,5), n=len(P)+2=8, D=(1,2,3,4,5,6,7,8), E=\emptyset, V=D=(1,2,3,4,5,6,7,8)$
- Algorithm: 
    - for $i$ in $D$:
        - if $len(D)=2$:
            - add edge to $E$ consisting of last two elements in $D$.
            - return $E$.
        - else:
            - find smallest element in $D$ which is not in $P$ and first element in $P$ and add an edge to $E$ consisting of these 2 elements.
            - delete these elements from $D$ and $P$, respectively.         
1. Iteration 1:
    - $E=\{(1,4)\}$
    - $P=(4,4,3,3,5), D=(2,3,4,5,6,7,8)$
2. Iteration 2:
    - $E=\{(1,4), (2,4)\}$
    - $P=(4,3,3,5), D=(3,4,5,6,7,8)$
3. Iteration 3:
    - $E=\{(1,4), (2,4), (6,4)\}$
    - $P=(3,3,5), D=(3,4,5,7,8)$
4. Iteration 4:
    - $E=\{(1,4), (2,4), (6,4), (4,3)\}$
    - $P=(3,5), D=(3,5,7,8)$
5. Iteration 5:
    - $E=\{(1,4), (2,4), (6,4), (4,3), (7,3)\}$
    - $P=(5), D=(3,5,8)$
6. Iteration 6:
    - $E=\{(1,4), (2,4), (6,4), (4,3), (7,3), (3,5)\}$
    - $P=\emptyset, D=(5,8)$
6. Iteration 7:
    - $E=\{(1,4), (2,4), (6,4), (4,3), (7,3), (3,5), (5,8)\}$

Output: $V=\{1,2,3,4,5,7,8\}, E=\{(1,4), (2,4), (6,4), (4,3), (7,3), (3,5), (5,8)\}$

```{=latex}
\begin{figure}[H]
\begin{center}
\caption{\label{figure-8}Graph of $G$}
\includegraphics[width=3in]{./image.png}
\hfill
\caption*{\textit{Graph of $G$ reconstructed from its Prüfer sequence.}}
\end{center}
\end{figure}
```

# Exercise 2

Since $G'$ is a tree, there exists only one simple path between $s$ and $t$. Let us call $W$ - the path from $s$ to $t$. Now, let us consider an edge $e'$ in path $W$ such that its capacity is minimal: $\min_{e \in E(W)}C(e) = C(e')$. Since $W$ is simple, the cut $(S,T)$ must intersect this path. In this case, the minimal cut would intersect path $W$ exactly and only at edge $e'$. Thus, we get

$$\sum_{\{e | e^- \in S, e^+ \in T\}}C(e)=C(e')=\min_{e \in E(W)}C(e)$$

Notice that the capacity function $C$ maps values to $\mathbb{R}^+_0$, meaning that the minimal value of an edge $e \in E$ is $0$. Thus, if there exists an edge $e'$, such that $C(e')=0$, then, by applying the previous reasoning, we have

$$\sum_{\{e | e^- \in S, e^+ \in T\}}C(e)=C(e')=0$$

# Exercise 3

For clarification, let us say that all verticies in $V$ are unique: $\forall x, y \in V, x\ne y$. Let us only consider $p\ge2$, since for $p=1$ we only have 1 edge connecting vertex $0$ with vertex $1$ and there is no cycle possible, and if $p=0$ we dont have any verticies. 

#### Girth

To find the girth of $G$ we can follow the following algorithm:

1. Create first vertex $X_1$ with $x_i=0, i=1,...,p$
2.  Create a second vertex $X_2$ with $x_1 = 1, x_i=0, i=2,...p$. Notice there is an edge $e_{12}=(X_1,X_2)$ since $||X_1 - X_2||=1$
3.  Create a third vertex $X_3$ with $x_1, x_2 = 1, x_i=0, i=3,...p$. If we tried to connect $X_3$ with $X_1$ to create a cycle with length $3$, then we would not be able to connect $X_3$ with $X_2$, since the distance between them would be $>1$, thus no cycle of length 3 possible. We are required to create an intermediate vertex $X_4$ that would connect $X_3$ with $X_0$ to create a cycle.
4.  Create a fourth vertex $X_4$ with $x_2=1, x_1=0, x_i=0, i=3,...,p$. Now there exists a set of edges $E=(X_1, X_2),(X_2, X_3),(X_3, X_4),(X_4, X_1)$, i.e. a cycle of length $4$, which is minimal, thus it is a girth of $G$.

#### Circumference

For $p\ge2$: Consider the verticies $(x_1,\dots,x_p)$, where $x_i \in \{0,1\}, i=1,\dots,p$. Each vertex represents a binary string of length $p$. The maximum number of elements in $V$ can be created by changing the value of each $x_i$ sequentially, i.e. start with $(0,0,\dots,0)$ and change the value of $x_1$, then $x_2$, and so on, until you reach $(1,1,\dots,1)$. The problem can be restated in the following way: how many ordered verticies of length $p$ can be formed where vertex' elements take values in the set $\{0,1\}$? This is exactly a number of permutations with repetition, which equals to

$$\max|V| = |\{0,1\}|^p = 2^p$$

Let us prove by induction that the circumference equals to the maximum number of verticies in graph $G$, which is $2^p$.

1. For $p=2$ the circumference is: $2^2=4$, which is true.
2. For $p=3$ the circumference is: $2^3=8$, which is also true.
3. Let us say that this holds for $n-1=p$ and prove it for $n=p+1$: Let $n=p+1$. Let us split the graph into 2 subgraphs: first subgraph, call it $G_0$, contains all verticies that end with $0$ and the second subgraph, call it $G_1$, contains all verticies that end with $1$. Note that for $G_0$ and $G_1$, the distances between two vertices are the same as in $G$, since we can disregard the last coefficient of each vertex. We have that the number of verticies in $G_0=G_1=\frac{2^n}{2}=2^{n-1}$. Since the statement holds for $n-1=p$, we have that the length of the longest cycle in $G_0=G_1=2^p$. Now, let us take two verticies in $G_0$ which are connected by an edge and remove this edge. Without loss of generality, say the first vertex is $V^0_0=\begin{bmatrix}0 \\ v_2 \\ \vdots \\ v_{n-1} \\0 \end{bmatrix}$ and the second vertex is $V^0_1=\begin{bmatrix}1 \\ v_2 \\ \vdots \\ v_{n-1} \\ 0 \end{bmatrix}, v_i=\{0,1\}, i=2,...,n-1$. Since we removed 1 edge from the cycle, we subtracted 1 from the circumference in $G_0$. Next, let us take two verticies in $G_1$ whose distances with $V_0^0$ and $V^0_1$ equal to 1 and which are connected by an edge and remove this edge. Again, without loss of generality, take verticies $V^1_0=\begin{bmatrix}0 \\ v_2 \\ \vdots \\ v_{n-1} \\1 \end{bmatrix}$ and $V^1_1=\begin{bmatrix}1 \\ v_2 \\ \vdots \\ v_{n-1} \\ 1 \end{bmatrix}, v_i=\{0,1\}, i=2,...,n-1$. Again, since we removed 1 edge from the cycle, we subtracted 1 from the circumference in $G_1$. Now, we connect $V^0_0$ with $V^1_0$ and $V^0_1$ with $V^1_1$ (added 2 new edges), since their distances are $1$, to obtain graph $G$. By connecting these verticies we obtain a cycle in $G$ which circumference equals to:

$$(2^{n-1}-1) + (2^{n-1} - 1) + 2 = 2\cdot2^{n-1}=2^{n}=2^{p+1}$$

Which proves the statement.
