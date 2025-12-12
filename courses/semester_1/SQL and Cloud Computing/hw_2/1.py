# Problem 1

import random
import time
import pandas as pd
import matplotlib.pyplot as plt

# (a)
# runtime: 281.5735309123993 seconds
def problem_a():

    start_time = time.time()

    genders = list(range(1, 3))
    ages = list(range(1, 129))
    countries = list(range(1, 193))
    num_records = 10**8

    with open('records.txt', 'w') as file:
        for _ in range(num_records):
            gender = random.choice(genders)
            age = random.choice(ages)
            country = random.choice(countries)
            record = f'{gender}, {age}, {country}\n'
            file.write(record)
    
    elapsed_time = time.time() - start_time
    with open('1_a_elapsed_time.txt', 'w') as time_file:
        time_file.write(f"elapsed time: {elapsed_time} seconds\n")

# (b) and (c)
# runtimes:
#   10^6: 2.0140044689178467 seconds
#   5*10^6: 9.255245685577393 seconds
#   10^7: 14.650994777679443 seconds
#   5*10^7: 82.12499928474426 seconds
#   10^8: 182.385014295578 seconds
def problem_b():

    dict_map = {
        'genders': {1: 0, 2: 0},
        'ages': {i: 0 for i in range(1, 129)},
        'countries': {i: 0 for i in range(1, 193)}
    }
    num_records_steps = [10**6]# , 5*10**6, 10**7, 5*10**7, 10**8]
    for num_records in num_records_steps:
        start_time = time.time()
        with open('data/records.txt', 'r') as file:
            for i, line in enumerate(file):
                if i >= num_records:
                    break
                gender, age, country = line.strip().split(', ')
                gender = int(gender)
                age = int(age)
                country = int(country)
                dict_map['genders'][gender] += 1
                dict_map['ages'][age] += 1
                dict_map['countries'][country] += 1

        # columns = ['gender', 'age', 'country']
        # data_df = pd.DataFrame(data_txt, columns=columns)

        # median_age_by_gender = data_df.groupby('gender')['age'].median()
        # median_age_by_country = data_df.groupby('country')['age'].median()

        # median_age_by_gender.to_csv(f'median_age_by_gender_{num_records}.txt', sep=' ', header=False)
        # median_age_by_country.to_csv(f'median_age_by_country_{num_records}.txt', sep=' ', header=False)

        elapsed_time = time.time() - start_time
        with open(f'1_b_elapsed_time_{num_records}.txt', 'w') as time_file:
            time_file.write(f"elapsed time: {elapsed_time} seconds\n")

def problem_c():

    num_records = [10**6, 5*10**6, 10**7, 5*10**7, 10**8]
    elapsed_time = [2.0140044689178467, 9.255245685577393, 14.650994777679443, 82.12499928474426, 182.385014295578]

    plt.bar([str(n) for n in num_records], elapsed_time)
    plt.xlabel('Number of Records')
    plt.ylabel('Elapsed Time (seconds)')
    plt.title('Elapsed Time vs. Number of Records')
    plt.show()

# (d)  
# Interpret your runtime results and 
#   briefly explain them in terms of Amdhal’s 
#   and Gustafson’s laws, respectively.
# That is, would you indeed expect a linear speedup 
#   by parallelizing your computations, and what
#   could be the constants p and s in this case? 
# Amdahl's Law
#   Parallelization of computational tasks 
#   is limited by the sequential proportion of the task.
# Gustafson's Law
#   For sufficiently large computational tasks, 
#   the sequential proportion of the tasks is usually negligible.
