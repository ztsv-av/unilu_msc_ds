import time
from pyspark.sql import SparkSession

t0 = time.time()

spark = SparkSession.builder \
    .appName("ex3_b") \
    .getOrCreate()

df = spark.read.csv('titanic.csv', header=True, inferSchema=True)

df.createOrReplaceTempView("titanic")

result_df = spark.sql(
    """
    SELECT DISTINCT 
        SPLIT(Name, ',')[0] AS last_name
    FROM 
        titanic 
    WHERE
        Age > (SELECT AVG(Age) FROM titanic)
    """
)

result_df.show()

spark.stop()

t1 = time.time()

print(f"The code took: {t1 - t0}s to execute")



