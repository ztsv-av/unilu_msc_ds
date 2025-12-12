from pyspark.sql import SparkSession
from pyspark.sql.functions import avg
import time

t0 = time.time()

spark = SparkSession.builder \
    .appName("ex3_d") \
    .getOrCreate()

df = spark.read.csv('titanic.csv', header=True, inferSchema=True)

avg_age_survived = df.filter(df['Survived'] == 1).select(avg('Age')).collect()[0][0]

avg_age_not_survived = df.filter(df['Survived'] == 0).select(avg('Age')).collect()[0][0]

print(f"Average age of passengers who survived: {avg_age_survived}")
print(f"Average age of passengers who did not survive: {avg_age_not_survived}")


difference = abs(avg_age_survived - avg_age_not_survived)
print(f"Difference in average ages: {difference}")

spark.stop()

t1 = time.time()

print(f"The code took: {t1 - t0}s to execute")