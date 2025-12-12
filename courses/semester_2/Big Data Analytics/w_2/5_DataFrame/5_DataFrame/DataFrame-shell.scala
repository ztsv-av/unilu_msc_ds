// Header of CSV file is: PassengerId,Survived,Pclass,Name,Sex,Age,SibSp,Parch,Ticket,Fare,Cabin,Embarked

val dataframe = spark.read.option("inferSchema", true).option("header", true).csv("../Data/titanic.csv")
dataframe.show
dataframe.createOrReplaceTempView("titanic")

val names = spark.sql("SELECT name FROM titanic")
names.show()
