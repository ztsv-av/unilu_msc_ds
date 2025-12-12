import time

from pyspark.sql import SparkSession
from pyspark.sql.functions import split, avg, col

t0 = time.time()

spark = SparkSession.builder \
    .appName("ex3_a") \
    .getOrCreate()

df = spark.read.csv('titanic.csv', header=True, inferSchema=True)

df.show()

average_age = df.select(avg("Age")).collect()[0][0]

filtered_df = df.filter(df["Age"] > average_age)

result_df = filtered_df.withColumn("last_name", split(col("Name"), ",")[0]) \
    .select("last_name") \
    .distinct()

result_df.show()

spark.stop()

t1 = time.time()

print(f"The code took: {t1 - t0}s to execute")
