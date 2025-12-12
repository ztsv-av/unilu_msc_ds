val textFile = sc.textFile("../Data/enwiki-articles/AA")
val counts = textFile.flatMap(line => line.split(" ")).map(word => (word, 1)).reduceByKey(_ + _)
counts.saveAsTextFile("wordcounts")
