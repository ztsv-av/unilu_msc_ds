import org.apache.spark.ml.linalg.Vectors
import org.apache.spark.ml.Pipeline
import org.apache.spark.ml.feature.VectorAssembler
import org.apache.spark.ml.regression.{LinearRegression, LinearRegressionModel}
import org.apache.spark.mllib.regression.LabeledPoint
import org.apache.spark.ml.feature.HashingTF

val spamFile = sc.textFile("../Data/ham-spam/spam.txt")                                
val normalFile = sc.textFile("../Data/ham-spam/ham.txt")

// Map all email text to vectors of 100 features/dimensions  
val tf = new HashingTF().setNumFeatures(100).setInputCol("word").setOutputCol("feature")

// pos: Split email
val data_pos = spamFile.map(email => email.split(" "))
val data_pos_df = data_pos.toDF("word")
// pos: Create label
val data_pos_feature = tf.transform(data_pos_df).withColumn("label", lit(1))

// neg: Split email
val data_neg = normalFile.map(email => email.split(" "))
val data_neg_df = data_neg.toDF("word")
// neg: Create label
val data_neg_feature = tf.transform(data_neg_df).withColumn("label", lit(-1))

// Use the union of both as training data 
val trainingData = data_pos_feature.union(data_neg_feature) 

// Run Linear Regression
val lr = new LinearRegression()
  .setLabelCol("label")
  .setFeaturesCol("feature")
val model = lr.fit(trainingData)

// Test on a positive example (spam) and a negative one (normal).  
val pos_input = Seq("Viagra GET cheap stuff by sending money to ...".split(" ")).toDF("word")
val posTest = tf.transform(pos_input)

val neg_input = Seq("Hi Dad, I started studying Spark the other day.".split(" ")).toDF("word")
val negTest = tf.transform(neg_input)

val pos_predictions = model.transform(posTest)
val neg_predictions = model.transform(negTest)

// Finally show the results   
pos_predictions.show()
neg_predictions.show()

// Get the predicted value from the DataFrame
val pos_predictions_value = pos_predictions.select("prediction").head.getDouble(0)
val neg_predictions_value = neg_predictions.select("prediction").head.getDouble(0)

// Print the predicted value
println("Sentence: Viagra GET cheap stuff by sending money to ... \n" + "Prediction: " + pos_predictions_value)
println("Sentence: Hi Dad, I started studying Spark the other day.\n" + "Prediction: " + neg_predictions_value)
