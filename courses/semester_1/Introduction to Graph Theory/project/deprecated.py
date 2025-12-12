# used to calculate the gini impurity score of the dataset
def gini_impurity(labels):
    total_samples = len(labels)
    if total_samples == 0:
        return 0

    class_counts = {label: labels.count(label) for label in set(labels)}
    impurity = 1.0
    for label in class_counts:
        probability = class_counts[label] / total_samples
        impurity -= probability ** 2

    return impurity
