# Zaitsev Anton | Exercise 1

## General Information

This exercise focuses on constructing and analyzing social networks (*Facebook* and *Twitter*) using data from *.edges* files. These networks are constructed using the *networkx* library in Python, and the analysis includes calculating the number of nodes and edges, finding the maximum and average degrees and extracting partial subgraphs.

## Network construction

The *.edges* file is used to add both the nodes and the edges the between nodes. We do not consider *ego* node and *.feat* files (based on the feedback).

## Answer to question *c*

Adjacency matrix provides a straightforward way to represent the connections in a network. With the adjacency matrix of a given graph we can reconstruct the original graph, since we have a direct access to the edges of the graph (there is an edge between nodes $i$ and $j$ if $A[i,j] \neq 0$, with $A$ - adjacency matrix). Besides, we can use adjacency matrix to perform matrix operations to analyze the graph, e.g. find shortest path between nodes, perform clustering or to find isolated nodes, i.e. tell if the graph is connected or not. Generally, if the network is not big, adjacency matrix is a efficient way to perform matrix-based calculations to analyze networks.
