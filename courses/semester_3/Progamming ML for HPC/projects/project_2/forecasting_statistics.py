import numpy as np

if __name__ == "__main__":
    print("forecasting_statistics.py is called!") # for debugging

    # Aggreate forecasters results from different files
    aggregated_forecasting = []
    for start_idx in range(0, 5000, 1000):
        end_idx = start_idx + 1000
        data = np.load(f"forecasting_results/results_{start_idx}_{end_idx}.npy")
        aggregated_forecasting.append(data)
    aggregated_forecasting = np.concatenate(aggregated_forecasting, axis=0)

    # Compute statistics
    mean_prediction = np.mean(aggregated_forecasting, axis=0)
    median_prediction = np.median(aggregated_forecasting, axis=0)
    std_prediction = np.std(aggregated_forecasting, axis=0)
    percentile_5th = np.percentile(aggregated_forecasting, 5, axis=0)
    percentile_95th = np.percentile(aggregated_forecasting, 95, axis=0)
    # Print statistics
    print(f"\nMean Prediction: {mean_prediction}")
    print(f"Median Prediction: {median_prediction}")
    print(f"Standard Deviation: {std_prediction}")
    print(f"5th Percentile: {percentile_5th}")
    print(f"95th Percentile: {percentile_95th}")
