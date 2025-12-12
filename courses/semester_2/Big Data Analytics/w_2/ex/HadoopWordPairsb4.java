import java.io.IOException;
import java.util.PriorityQueue;
import java.util.Comparator;

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

public class HadoopWordPairsb4 extends Configured implements Tool {

	public static class Map extends Mapper<LongWritable, Text, Text, IntWritable> {
		private final static IntWritable one = new IntWritable(1);
		private Text pair = new Text();
		private Text lastToken = new Text();

		@Override
		public void map(LongWritable key, Text value, Context context) throws IOException, InterruptedException {

			// lowercase everything
			String line = value.toString().toLowerCase();
			// split by everything that is not a-z (not a word) and not a number
			String[] tokens = line.split("[^a-z0-9]+");
			for (String token : tokens) {
				// check if the token is a number
				if (token.matches("[0-9]{2,12}")) {
					// if the previous token is not empty and it is a word
					if (lastToken.getLength() > 0 && lastToken.toString().matches("[a-z]{5,25}")) {
						// emit the pair with the number as the first token and the word as the second token
						pair.set(token + ":" + lastToken);
						context.write(pair, one);
					}
				// if the token is not a number, we check if it is a word
				} else if (token.matches("[a-z]{5,25}")) {
					// if the previous token is not empty and it is a number
					if (lastToken.getLength() > 0 && lastToken.toString().matches("[0-9]{2,12}")) {
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

		// create a priority queue to keep track of top 100 words by occurance
		// note that we use Comparator so that the priority queue compares right element in the pair <String, Integer> to store
		//  values with the lowest count at the top of the queue
		// 	and with the highest value at the bottom of the queue
		private PriorityQueue<String[]> top100Words = new PriorityQueue<>(Comparator.comparingInt(arr -> Integer.parseInt(arr[1])));

		@Override
		public void reduce(Text key, Iterable<IntWritable> values, Context context)
				throws IOException, InterruptedException {
			
			int sum = 0;

			for (IntWritable value : values)
				sum += value.get();

			// add the current word and its count to the priority queue
			top100Words.offer(new String[]{key.toString(), String.valueOf(sum)});

			// if the size of the priority queue exceeds 100, remove the word with the lowest count
			if (top100Words.size() > 100) {
				top100Words.poll();
			}
		}

		// called after all the reducers have finished processing their input
		// it iterates over the PriorityQueue containing the top 100 words and emits them with their frequencies,
		// 	starting with the word with the lowest frequency
		protected void cleanup(Context context) throws IOException, InterruptedException {
			// output the top 100 words
			while (!top100Words.isEmpty()) {
				String[] pair = top100Words.poll();
				context.write(new Text(pair[0]), new IntWritable(Integer.parseInt(pair[1])));
			}
		}
	}

	@Override
	public int run(String[] args) throws Exception {
		Job job = Job.getInstance(new Configuration(), "HadoopWordPairsb4");
		job.setJarByClass(HadoopWordPairsb4.class);

		job.setOutputKeyClass(Text.class);
		job.setOutputValueClass(IntWritable.class);
		job.setMapperClass(Map.class);
		job.setReducerClass(Reduce.class);

		job.setInputFormatClass(TextInputFormat.class);
		job.setOutputFormatClass(TextOutputFormat.class);

		FileInputFormat.setInputPaths(job, args[0]);
		FileOutputFormat.setOutputPath(job, new Path(args[1]));

		job.waitForCompletion(true);
		return 0;
	}

	public static void main(String[] args) throws Exception {
		int ret = ToolRunner.run(new Configuration(), new HadoopWordPairsb4(), args);
		System.exit(ret);
	}
}
