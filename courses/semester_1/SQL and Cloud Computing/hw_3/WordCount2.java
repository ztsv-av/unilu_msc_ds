import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.net.URI;
import java.util.HashSet;
import java.util.Set;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.util.StringUtils;

public class WordCount2 {

	public static class TokenizerMapper extends Mapper<Object, Text, Text, IntWritable> {

		private boolean caseSensitive = false;
		private String[] keywords;

		@Override
		public void setup(Context context) throws IOException, InterruptedException {
			Configuration conf = context.getConfiguration();
			caseSensitive = conf.getBoolean("wordcount.case.sensitive", false);
			// check if any keywords passed
			if (conf.getBoolean("wordcount.detect.keywords", false)) {
				String keywordsAllStrings = conf.get("wordcount.keywords");
				// split input keywords by comma
				keywords = keywordsAllStrings.split(",");
			}
		}

		@Override
		public void map(Object key, Text value, Context context) throws IOException, InterruptedException {
			String document = caseSensitive ? value.toString() : value.toString().toLowerCase();
			// split input document by new lines
			String[] lines = document.split("\n");
			// iterate for each line in document
			for (String line : lines) {
				// split line by spaces
				String[] word_id_sum = line.split("\\s+");
				// iterate for each keyword in input keywords
				for (String keyword : keywords) {
					// check if token in keywords
					if (word_id_sum[0].equals(keyword)) {
						// separate line by tab (spaces) and pick only string consisting of article_id, sum
						String id_sum = word_id_sum[1];
						// split article_id,sum,article_id,sum,... by comma
						String[] values = id_sum.split(",");
						// every even index is article_id, every odd (next) index is sum
						for (int i = 0; i < values.length; i += 2) {
							String id = values[i];
							int sum = Integer.parseInt(values[i + 1]);
							// pass article_id, sum to the reducer
							context.write(new Text(id), new IntWritable(sum));
						}
					}
					else {
						continue;
					}
				}
			}
		}	
	}

	public static class IntSumReducer extends Reducer<Text, IntWritable, Text, IntWritable> {
		private IntWritable result = new IntWritable();

		public void reduce(Text key, Iterable<IntWritable> values, Context context)
				throws IOException, InterruptedException {
			int sum = 0;
			for (IntWritable val : values) {
				sum += val.get();
			}
			result.set(sum);
			context.write(key, result);
		}
	}

	public static void main(String[] args) throws Exception {

		Configuration conf = new Configuration();
		Job job = Job.getInstance(conf, "WordCount2");
		job.setJar("WordCount2.jar");

		job.setMapperClass(TokenizerMapper.class);
		// job.setCombinerClass(IntSumReducer.class); // enable to use 'local aggregation'
		job.setReducerClass(IntSumReducer.class);

		job.setOutputKeyClass(Text.class);
		job.setOutputValueClass(IntWritable.class);

		for (int i = 0; i < args.length; ++i) {
			if ("-keywords".equals(args[i])) {
				job.getConfiguration().setBoolean("wordcount.detect.keywords", true);
				job.getConfiguration().set("wordcount.keywords", args[i+1]);
				System.out.println("USING ONLY KEYWORDS: " + args[i+1]);
			} else if ("-casesensitive".equals(args[i])) {
				job.getConfiguration().setBoolean("wordcount.case.sensitive", true);
				System.out.println("USING CASE SENSITIVE TOKENS: " + "-casesensitive".equals(args[i]));
			}
		}

		FileInputFormat.addInputPath(job, new Path(args[0]));
		FileOutputFormat.setOutputPath(job, new Path(args[1]));

		System.exit(job.waitForCompletion(true) ? 0 : 1);
	}
}
