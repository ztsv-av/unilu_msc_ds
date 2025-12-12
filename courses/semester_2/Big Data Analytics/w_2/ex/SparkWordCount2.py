from pyspark import SparkContext
import re

def preprocess_line(line):
    tokens = re.findall(r'\b(?:\d{2,12}|\b[a-z]{5,25})\b', line.lower())
    return tokens

def generate_number_word_pairs(line):
    tokens = preprocess_line(line)
    pairs = []
    for i in range(len(tokens) - 1):
        first_token, second_token = min(tokens[i], tokens[i+1]), max(tokens[i], tokens[i+1])
        if re.match(r'\b\d{2,12}\b', first_token) and re.match(r'\b[a-z]{5,25}\b', second_token):
            pairs.append(((first_token, second_token), 1))
    return pairs

def main():
    sc = SparkContext(appName="SparkWordCount2")
    text_file = sc.textFile("enwiki-articles/AA/*")

    number_word_pairs = text_file.flatMap(generate_number_word_pairs) \
                                 .reduceByKey(lambda a, b: a + b) \
                                 .sortBy(lambda pair: pair[1], ascending=False) \
                                 .take(100)


    print("Top-100 most frequent number-word pairs:")
    for pair, count in number_word_pairs:
        print(f"{pair[0]} {pair[1]}", count)


if __name__ == "__main__":
    main()
