---
title: Introduction to Graph Theory | Homework 1
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
geometry: "left=25mm, right=25mm, top=10mm, bottom=25mm"
---

\pagebreak

# Exercise 1

## (i)

Let $G=(V,E), v=\{1,2\}, E=\{(1,2)\}$. Then $V'=\{(1,2)\}, E'=\emptyset$.

Clearly, $G'$ is Hamiltonian, while $G$ is not Eulerian (no edge from $v_2=2$ to $v_1=1$). Thus, if $G'$ is Hamiltonian, it does not imply that $G$ is Eulerian.

## (ii)

Since $G$ is Eulerian, then we visit each edge exactly once. We also know that $V'=E =>$ we visit each vertex of $G'$ exactly once. Let us call the walk where we visit each vertex of $G'$ as $W$. To prove that $W$ is Hamiltonian cycle, we need to prove that the walk $W$ is closed. $G$ has an Eulerian cycle: $v_0, e_1, v_1, e_2, v_2, \dots, v_{n-1}, e_n, v_n$, where $v_n=v_0$. Thus, we have a vertex in $G'$ $v_n' = (v_{n-1}, v_n)=(v_{n-1}, v_0)$ and a vertex $v_0' = (v_0, v_1)$. Since $(v_{n-1, v_0}) \cap (v_0, v_1) \neq \emptyset$, it belongs to $E'$.

Thus, $W$ is closed and it is a Hamiltonian cycle and $G'$ is Hamiltonian.

# Exercise 2

Since $K_n$ is a complete graph, there are $n^{n-2}$ spanning trees, each with $(n-1)$ edges. Thus, we have $(n-1)\cdot n^{n-2}$ total number of edges contained in spanning trees.

For a complete graph with $n$ verticies, there are $\binom{n}{2}$ pairs that must be connected by an edge. Thus, we have that there are $\binom{n}{2}=\frac{n(n-1)}{2}$ edges in $K_n$.

Let us define $t$ as the number of spanning trees of $K_n$. Each edge of $K_n$ is contained in $t$ number of spanning trees. Thus, we have $t\cdot\frac{n(n-1)}{2}$ edges contained in the spanning trees.

Thus, we get

$$(n-1)\cdot n^{n-2}=t\cdot\frac{n(n-1)}{2}$$

$$t = 2n^{n-3}$$

If we delete an edge from a complete graph, we remove $t$ number of trees containing this edge. Thus, when we remove an edge $e$ from a complete graph $K_n$ we get

$$n^{n-2} - t\space\text{(total number of trees minus trees that contained edge e)}=$$
 
$$=n^{n-2} - 2n^{n-3} = n^{n-3}(n-2)$$

$n^{n-3}(n-2)$ is the number of spanning trees of graph $K_n - e$.

\pagebreak

# Exercise 3

Let us define $e = (u,v), w(e) = w(u) + w(v).$

By contradiction, assume $T$ is not unique. Then, $\exists T_1, T_2, T_1 \neq T_2$, both distinct minimum spanning trees. Since $T_1 \neq T_2$, there must exist at least one edge that belongs to either $E(T_1)$ or $E(T_2)$.

Consider such an edge of minimum weight and, without loss of generality, assume it belongs to $E(T_1)$. Define it as $e_1$.

Also, since $T_1 \neq T_2, \exists e_2 \in E(T_2), e_2 \notin E(T_1)$. We know that $w(e_1) < w(e_2)$. Then, we have that $T_m = T_2 \cup \{e_1\} \backslash \{e_2\}$ a spanning tree, whose total weight is less than of $T_2$. However, this is a contradiction, since we chose $T_2$ as minimum spanning tree.

Thus, $T$ is unique.

# Exercise 4

First, since $G$ contains no cycle and adding an edge $e, e \notin E(G)$, to graph $G$, by Proposition $3.4 (4)$ we have that $G$ is a tree.

Second, since isomorphism $\phi: G \to G$ preserves structural properties, we have that $\forall v \in V(G), deg_G(v) = 1: deg_{\phi(G)}(\phi(v)) = 1$ (all end verticies in $G$ are also end verticies in $\phi(G)$).

Third, let us define $T_0 = G$ an initial graph (tree) and $T_0' = \phi(T_0)$. We have that the set of verticies with degree $1$ is the same in $T_0$ and $T_0'$. Let us define $V_0$ and $V_0'$ as such sets and let us remove these sets from $T_0$ and $T_0'$, respectively: define $T_1 = T_0 \backslash V_0, T_1' = T_0' \backslash V_0'$. Since $T_0$ and $T_0'$ are trees and $V_0$ and $V_0'$ are sets of end verticies, by Lemma $3.2$ we have that $T_1$ and $T_1'$ are also trees.

Next, let us again remove the sets of end verticies from $T_1$ and $T_1'$ and define $T_2 = T_1 \backslash V_1$ and $T_2' = T_1' \backslash V_1'$. Again, $T_2$ and $T_2'$ are trees.

We iterative removal step unti we are left with either $1$ or $2$ verticies. Let us say that we arrive at these conditions at step $n$.

1. In case when $|V_n| = 1$: since there is only one vertex left, the isomorphism $\phi: G \to G$ maps vertex $v_n$ to itself: $\phi(v_n) = v_n$. Thus, $\exists v \in V$ s.t. $\phi(v) = v$.
2. In case when $|V_n| = 2$: since $T_n$ is still a tree, there exists a last edge connecting two last verticies in $T_n$, let us call it $e_n$. Since isomorphism preserves edges, we have that $\phi(e_n) = e_n$. Thus, $\exists e \in E$ s.t. $\phi(e) = e$
