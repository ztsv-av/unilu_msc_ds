from pyspark import SparkContext
import re

def preprocess_line(line):
    words = re.findall(r'\b[a-z]{5,25}\b', line.lower())
    return words

def main():
    sc = SparkContext(appName="SparkWordCount")
    text_file = sc.textFile("enwiki-articles/AA/*")

    filtered_words_count = text_file.flatMap(preprocess_line) \
                              .map(lambda word: (word, 1)) \
                              .reduceByKey(lambda a, b: a + b) \
                              .filter(lambda pair: pair[1] >= 1000)
    
    filtered_words_broadcast = sc.broadcast(set(filtered_words_count.map(lambda pair: pair[0]).collect()))

    word_pairs_count = text_file.flatMap(lambda line: [
        ((min(word, next_word), max(word, next_word)), 1)
        for word, next_word in zip(preprocess_line(line), preprocess_line(line)[1:])
        if word in filtered_words_broadcast.value and next_word in filtered_words_broadcast.value
    ]) \
    .reduceByKey(lambda a, b: a + b) \
    .filter(lambda pair: pair[1] == 1000)
    
    top_100_words = filtered_words_count.sortBy(lambda pair: pair[1], ascending=False).take(100)


    print("Individual words with a count of exactly 1000:")
    for word, count in filtered_words_count.filter(lambda pair: pair[1] == 1000).collect():
        print(word, count)

    print("\nWord pairs with a count of exactly 1000:")
    for pair, count in word_pairs_count.collect():
        print(f"{pair[0]} {pair[1]}", count)

    print("\nTop-100 most frequent individual words:")
    for word, count in top_100_words:
        print(word, count)
                   

if __name__ == "__main__":
    main()
