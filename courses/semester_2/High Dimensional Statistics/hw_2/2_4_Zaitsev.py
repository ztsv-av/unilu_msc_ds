# Exercise 4

import numpy as np # use to compute mean, sum and std
import pandas as pd # use to create a table

from scipy.stats import f # F-distribution table


# define data
no_treatment = {
    "name": "No Treatment",
    "data": {
        1: 117,
        2: 124,
        3: 40,
        4: 88
    }
}
oestrogens_treatment = {
    "name": "Oestrogens Treatment",
    "data": {
        5: 440,
        6: 264,
        7: 221,
        8: 136
    }
}
progesterone_treatment = {
    "name": "Progesterone Treatment",
    "data": {
        9: 605,
        10: 626,
        11: 385,
        12: 475
    }
}

## Part 1

def calculateStats(treatment_data):
    """
    Calculate mean and standard deviation for a given treatment group data.

    Parameters:
    - treatment_data: A dictionary representing data for a specific treatment group.

    Returns:
    - mean: The mean of the data.
    - std: The standard deviation of the data.
    """
    values = list(treatment_data.values()) # get data for the specific treatment group
    mean = np.mean(values) # compute mean
    std = np.std(values) # compute std
    return mean, std

def generateStatsTable(*treatment_datasets):
    """
    Generate a table containing mean, standard deviation, number of observations for multiple treatment groups.

    Parameters:
    - *treatment_datasets: Variable number of dictionaries, each representing data for a specific treatment group.
                           Each dictionary should have keys "name", "data" (for treatment group name and data, respectively).

    Returns:
    - stats_table: A pandas DataFrame containing statistics for each treatment group.
    """
    stats = [] # define empty list of statistics
    for treatment_data in treatment_datasets: # iterate through treatment groups
        mean, std = calculateStats(treatment_data["data"]) # compute mean, std of a group
        stats.append([
            treatment_data["name"], 
            mean, 
            std, 
            len(treatment_data["data"])
        ]) # append data to the list of statistics
    stats_table = pd.DataFrame(
        stats, 
        columns=['Treatment', 'Mean', 'Standard Deviation', 'Number Observations']
    ) # create a table using Pandas library
    stats_table['Mean'] = stats_table['Mean'].round(2) # round up the means up to 2 decimal places
    stats_table['Standard Deviation'] = stats_table['Standard Deviation'].round(2) # round up the stds up to 2 decimal places
    return stats_table

stats_table = generateStatsTable(no_treatment, oestrogens_treatment, progesterone_treatment) # generate the statistics table

print(stats_table) # print the generated table

## Part 2

# We will use the one-way ANOVA test to determine 
#   whether there is any difference between the means of three treatment groups.
# We will use the following algorithm to perform the ANOVA test
#   (reference: https://www.cuemath.com/anova-formula/
#    notice that steps are the same as in Example 1.17,
#    but reformulated for easier programming computations):
# Step 1: calculate the mean for each group.
# Step 2: calculate the total mean.
# Step 3: calculate the SSB.
# Step 4: calculate the between groups degrees of freedom: number of observations for each group - 1
# Step 5: calculate the SSE.
# Step 6: calculate the degrees of freedom of errors: total number of observations - number of treatment groups
# Step 7: Determine the MSB and the MSE.
# Step 8: Find the f test statistic.
# Step 9: Using the f table for the specified level of significance alpha find the critical value. 
#         This is given by F(alpha, df_groups, df_errors).
# Step 10: If f > F, then we reject the null hypothesis.

DATA = [no_treatment, oestrogens_treatment, progesterone_treatment]
num_obs = stats_table.loc[:, 'Number Observations'] # number of observations for each group
means = stats_table.loc[:, 'Mean'] # mean of each group
alpha = 0.05 # significance level

mean_1, mean_2, mean_3 = stats_table.loc[:, 'Mean'] # step 1
total_mean = sum(means)/len(means) # step 2
ssb = np.sum(num_obs*(stats_table['Mean']-total_mean)**2) # step 3
df_groups = len(stats_table)-1 # step 4
sse = np.sum(np.sum([(list(group["data"].values())-np.mean(list(group["data"].values())))**2 for group in DATA], axis=1)) # step 5
df_errors = stats_table['Number Observations'].sum() - len(stats_table) # step 6
msb = ssb/df_groups # step 7
mse = sse/df_errors # step 7
f_stat = msb/mse # step 8
f_crit = f.ppf(1 - alpha, df_groups, df_errors) # step 9: get F-distribution critical value from table

# step 10: interpret the results
print("\nNull hypothesis: The means for treatment groups are equal, i.e. hormonal treatments do not affect the hormonal concentrations of the female dogs.\n")
print("Alternative hypothesis: The means for treatment groups are not equal, i.e. hormonal treatments affect the hormonal concentrations of the female dogs.\n")
# decide to reject or accept null hypothesis
print(f"F-statistic: {f_stat:.3f}")
print(f"Critical value: {f_crit:.3f}\n")
if f_stat > f_crit:
    print("Conclusion: There is significant evidence to reject the null hypothesis.")
    print("There is a statistically significant difference between at least one pair of treatment means.")
    print("With 95% confidence we deduce that the hormonal treatments AFFECT the hormonal concentrations of the female dogs.")
else:
    print("Conclusion: There is not enough evidence to reject the null hypothesis.")
    print("There is no statistically significant difference between the treatment means.")
    print("With 95% confidence we deduce that the hormonal treatments DO NOT AFFECT the hormonal concentrations of the female dogs.")
