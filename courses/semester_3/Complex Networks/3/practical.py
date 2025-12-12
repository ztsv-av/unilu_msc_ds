import networkx as nx
import matplotlib.pyplot as plt
import random
import numpy as np

N = 8
k = 4
nodes = np.arange(N)
edges_circle = []
for node in nodes:
    if node == 0:
        edges_circle.append((node, nodes[node + int(k/2)]))
        edges_circle.append((node, nodes[node + int(k/4)]))
        edges_circle.append((node, nodes[node - int(k/2)]))
        edges_circle.append((node, nodes[node - int(k/4)]))
    elif node == 1:
        edges_circle.append((node, nodes[node + int(k/2)]))
        edges_circle.append((node, nodes[node + int(k/4)]))
        edges_circle.append((node, nodes[node - int(k/2)]))
    elif node >= 2 and node < N - 2:
        edges_circle.append((node, nodes[node + int(k/2)]))
        edges_circle.append((node, nodes[node + int(k/4)]))
    elif node == N - 2:
        edges_circle.append((node, nodes[node + int(k/4)]))

p = 0.5
edges_ws = edges_circle.copy()
for i, edge in enumerate(edges_ws):
    if random.uniform(0, 1) > 0.5:
        random_selection = np.random.choice(nodes, 2, replace=False)
        edges_ws[i] = (random_selection[0], random_selection[1])

# Create a graph object
Gc = nx.Graph()
Gws = nx.Graph()
# Add edges to the graph
Gc.add_edges_from(edges_circle)
Gws.add_edges_from(edges_ws)
# Draw the graph
plt.figure(figsize=(8, 6))
nx.draw(Gc, with_labels=True, node_color='lightblue', node_size=500, font_size=10, font_weight='bold', edge_color='gray')
plt.title("Graph Representation of Connections")
plt.show()
plt.figure(figsize=(8, 6))
nx.draw(Gws, with_labels=True, node_color='lightblue', node_size=500, font_size=10, font_weight='bold', edge_color='gray')
plt.title("Graph Representation of Connections")
plt.show()