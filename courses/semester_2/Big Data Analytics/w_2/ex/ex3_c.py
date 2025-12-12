from pyspark.sql import SparkSession
from pyspark.sql.functions import pandas_udf, PandasUDFType
from pyspark.sql.types import DoubleType
import pandas as pd
import time

t0 = time.time()
@pandas_udf(DoubleType(), PandasUDFType.GROUPED_AGG)
def AgeAverage(ages: pd.Series) -> float:
    ages_filled = ages.fillna(23)
    return ages_filled.mean()

spark = SparkSession.builder \
    .appName("ex3_c") \
    .getOrCreate()

spark.udf.register("AgeAverage", AgeAverage)

df = spark.read.csv('titanic.csv', header=True, inferSchema=True)

df.createOrReplaceTempView("titanic")

avg_df = spark.sql("SELECT AgeAverage(Age) as average_age FROM titanic")

avg_df.show()

result_df = spark.sql(
    """
    SELECT DISTINCT 
        SPLIT(Name, ',')[0] AS last_name
    FROM 
        titanic 
    WHERE
        Age > (SELECT AgeAverage(Age) FROM titanic)
    """
)

result_df.show()

spark.stop()

t1 = time.time()

print(f"The code took: {t1 - t0}s to execute")