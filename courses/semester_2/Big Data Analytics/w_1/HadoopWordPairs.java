import java.io.IOException;
import java.util.TreeMap;

import javax.naming.Context;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.conf.Configured;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.input.TextInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.mapreduce.lib.output.TextOutputFormat;
import org.apache.hadoop.util.Tool;
import org.apache.hadoop.util.ToolRunner;

public class HadoopWordPairs extends Configured implements Tool {

	public static class Map extends Mapper<LongWritable, Text, Text, IntWritable> {
		private final static IntWritable one = new IntWritable(1);
		private Text pair = new Text();
		private Text lastWord = new Text();

		@Override
		public void map(LongWritable key, Text value, Context context) throws IOException, InterruptedException {

			String[] splitLine = value.toString().split(" ");
			for (String token : splitLine) {
				// check if the token is a number
				if (token.matches("\\d+")) {
					// if the previous token is not empty and it is a word
					if (lastToken.getLength() > 0 && lastToken.toString().matches("[a-zA-Z]+")) {
						// emit the pair with the number as the first token and the word as the second token
						pair.set(token + ":" + lastToken);
						context.write(pair, one);
					}
				// if the token is not a number, we check if it is a word
				} else if (token.matches("[a-zA-Z]+")) {
					// if the previous token is not empty and it is a number
					if (lastToken.getLength() > 0 && lastToken.toString().matches("\\d+")) {
						// emit the pair with the number as the first token and the word as the second token
						pair.set(lastToken + ":" + token);
						context.write(pair, one);
					}
				}
				// update last token
				lastToken.set(token);
			}
		}
	}

	public static class Reduce extends Reducer<Text, IntWritable, Text, IntWritable> {

		// create a tree map to keep track of top 100 words by occurance
		// note that tree map automatically sorts key-value pairs by their sum value
		private TreeMap<Long, Text> top100Words = new TreeMap<>();

		@Override
		public void reduce(Text key, Iterable<IntWritable> values, Context context)
				throws IOException, InterruptedException {
			
			int sum = 0;

			for (IntWritable value : values)
				sum += value.get();
			
			// add new key-value pair to the tree, which will be placed in sorted order based on the sum
			top100Words.put(sum, new Text(key));
			// if we have more that 100 items in the tree, cut the value with the lowest sum
			if (top100Words.size() > 100) {
				top100Words.remove(top100Words.firstKey());
			}
		}

		protected void cleanup(Context context) throws IOException, InterruptedException {
			// output the top 100 words
			for (Text word : top100Words.values()) {
				context.write(word, new LongWritable(top100Words.lastKey()));
			}
		}
	}

	@Override
	public int run(String[] args) throws Exception {
		Job job = Job.getInstance(new Configuration(), "HadoopWordPairs");
		job.setJarByClass(HadoopWordPairs.class);

		job.setOutputKeyClass(Text.class);
		job.setOutputValueClass(IntWritable.class);
		job.setMapperClass(Map.class);
		job.setCombinerClass(Reduce.class);
		job.setReducerClass(Reduce.class);

		job.setInputFormatClass(TextInputFormat.class);
		job.setOutputFormatClass(TextOutputFormat.class);

		FileInputFormat.setInputPaths(job, args[0]);
		FileOutputFormat.setOutputPath(job, new Path(args[1]));

		job.waitForCompletion(true);
		return 0;
	}

	public static void main(String[] args) throws Exception {
		int ret = ToolRunner.run(new Configuration(), new HadoopWordPairs(), args);
		System.exit(ret);
	}
}
