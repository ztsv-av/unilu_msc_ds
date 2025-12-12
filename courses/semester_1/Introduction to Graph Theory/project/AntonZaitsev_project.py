# Implementation of CART Algorithm using Gini Impurity measurement.
# Note: Even though we work with just 1D features, 
#   the implementation is optimized for features with dimension >=1
# Note: Tree Usage.
#   To print tree structure, one can use tree.print_tree() method.
#   To access nodes' parent, one can use node.parent instance.
#   For example, one can initialize node=tree.left.right.left node and use node.print_tree().
#   Then call node.parent to access its parent node.

import pandas as pd
import numpy as np


# ----------------2.1----------------

# define training data
DATA = pd.read_csv('data/project.csv').drop('Unnamed: 0', axis=1)
# define data features
DATA_FEATURES = DATA.iloc[:, :-1].values
# define data labels
DATA_LABELS = DATA.iloc[:, -1].values
# define alpha (given in problem description)
ALPHA = 8

# ----------------2.2----------------

# Algorithm Idea
# We start with find_best_split(), passing in data values, data labels and alpha=8
# In find_best_split():
#   1) we check if the number of observations is < alpha 
#      if it is less, than we create a leaf node
#      in other words, once we achieve a split with 8 or less observations, we create a leaf node
#   2) we iterate for every feature in data (in our case it is just 1) (loop for feature_index in range(n))
#      1) we iterate though every value at specific feature in data (loop for threshold in unique_values)
#         1) take current value as a threshold
#         2) assign all values that less than threshold to the left split, all values that are more that threshold to the right
#         3) calculate P1, Q1, p1, q1 and current gini impurity score
#         4) determinte the best gini score, i.e. the minimum between the current gini score and best gini score
#         5) if we found the better gini score, we assign the new split value
#   3) once we found the best split value, we split the data into two sets
#        and call find_best_split() on the first (left) and second (right) sets
#   4) the algorithm will split the data until it reaches a leaf node,
#        then recursively iterate up the tree, creating upper nodes, until it reaches a first, i.e. root, node

# define decision tree class
class DecisionTree:
    def __init__(self, feature_index=None, threshold=None, left=None, right=None, label=None, parent=None):
        # index of the feature used for splitting
        self.feature_index = feature_index 
        # threshold value for the split
        self.threshold = threshold
        # left child (subset with feature values below the threshold)
        self.left = left 
        # right child (subset with feature values above the threshold)
        self.right = right
        # majority label for leaf nodes
        self.label = label
        # add parent parameter to access nodes' parent (not used, but might be useful)
        self.parent = parent

    # class function used to print built decision tree,
    #   specifically nodes' threshold and label
    def print_tree(self, depth=0, branch_indicator="0: "):
        indent = "  " * depth
        print(indent + f"{branch_indicator}feature {self.feature_index}, threshold {self.threshold}, label {self.label}")

        if self.left:
            self.left.print_tree(depth + 1, branch_indicator=str(depth + 1) + " L: ")
        if self.right:
            self.right.print_tree(depth + 1, branch_indicator=str(depth + 1) + " R: ")

    # class function used to predict the labels of given data
    def predict(self, observation):
        if self.left is None and self.right is None:
            # leaf node, return the majority label
            return self.label
        if observation[self.feature_index] < self.threshold and self.left is not None:
            return self.left.predict(observation)
        elif observation[self.feature_index] >= self.threshold and self.right is not None:
            return self.right.predict(observation)

# function used to build a decision tree based on given data
def find_best_split(features, labels, alpha, parent=None):
    m, n = features.shape
    majority_label = np.argmax(np.bincount(labels))
    if m < alpha:
        # create a leaf node
        return DecisionTree(label=majority_label, parent=parent)

    best_gini = float('inf')
    best_split = None

    for feature_index in range(n):
        unique_values = set(features[:, feature_index])

        for threshold in unique_values:
            left_mask = features[:, feature_index] < threshold
            right_mask = ~left_mask

            P1, Q1 = sum(left_mask), sum(right_mask)
            p1 = sum(labels[left_mask]) / P1 if P1 > 0 else 0
            q1 = sum(labels[right_mask]) / Q1 if Q1 > 0 else 0

            current_gini = P1 * p1 * (1 - p1) + Q1 * q1 * (1 - q1)

            if current_gini < best_gini:
                best_gini = current_gini
                best_split = (feature_index, threshold)

    if best_gini == float('inf'):
        # no split found, create a leaf node
        return DecisionTree(label=majority_label, parent=parent)

    feature_index, threshold = best_split
    left_mask = features[:, feature_index] < threshold
    right_mask = ~left_mask

    left_child = find_best_split(features[left_mask], labels[left_mask], alpha)
    right_child = find_best_split(features[right_mask], labels[right_mask], alpha)
    right_child.parent = DecisionTree(feature_index=feature_index, threshold=threshold, left=left_child, right=right_child)
    left_child.parent = DecisionTree(feature_index=feature_index, threshold=threshold, left=left_child, right=right_child)

    return DecisionTree(feature_index=feature_index, threshold=threshold, left=left_child, right=right_child, parent=parent)

def build_decision_tree(features, labels, alpha):
    return find_best_split(features, labels, alpha)

# build decision tree
tree = build_decision_tree(DATA_FEATURES, DATA_LABELS, alpha=ALPHA)

# ----------------2.3----------------

# create a simple function that would predict the label for each data instance
#   by calling tree.predict function on the current data instance
def predict_labels(data):
    predictions = []
    for data_instance in data:
        predicted_label = tree.predict(data_instance)
        predictions.append({'value': data_instance, 'predicted_label': predicted_label})
    return predictions

# define testing data
# use given data from 2.3 and custom data to test the efficiency of the algorithm
test_data = [[1.2], [-4], [3], [-3.9], [-6.5], [-3.36], [-3.28], [-3.11], [5.50], [2.28], [2.255], [6], [6.13], [6.14]]
predictions = predict_labels(test_data)
for prediction in predictions:
    print(f"value: {prediction['value']}, predicted_label: {prediction['predicted_label']}")

# As we can see, the algorithm predicts labels fairly well.
# This was checked by prediction output and project.csv values close to the values in test_data.
