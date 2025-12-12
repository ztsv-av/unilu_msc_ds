import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Comparator;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.Collections;

import javax.naming.Context;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;

public class WordCount {

	public static class TokenizerMapper extends Mapper<Object, Text, Text, Text> {

		String one = "1";

		@Override
		public void map(Object key, Text value, Context context) throws IOException, InterruptedException {
			String line = value.toString().toLowerCase();
			// split .1lineperdoc file by new line
			String[] articles = line.split("\\n");
			// iterate through all articles splitted
			for (String article : articles) {
				// define regex pattern to split the current article
				// this regex will match a number inside the first group, which is (\\d+)
				// and also match a string inside the doc tags, which is (.*?)
				String regex = "<doc id=\"(\\d+)\"[^>]*>(.*?)</doc>";
				Pattern pattern = Pattern.compile(regex);
				Matcher matcher = pattern.matcher(article);
				if (matcher.find()) {
					String id = matcher.group(1);
					String text = matcher.group(2).trim();
					String[] tokens = text.split("[^\\w']+");
					// iterate though every word (token) in the current article
					//     and return ((token, id), 1)
					for (String token : tokens) {
						String token_id = token + "," + id;
						context.write(new Text(token_id), new Text(one));
				}
				} else {
					continue;
				}
			}
		}
	}

	// use to convert ((token, id), 1) pairs into (token, (id, sum))
	// here sum - sum for all same (token, id) pairs
	public static class Combine extends Reducer<Text, Text, Text, Text> {
		private Text result = new Text();

		public void reduce(Text key, Iterable<Text> values, Context context)
				throws IOException, InterruptedException {
			int sum = 0;
			for (Text val : values) {
				sum += Integer.parseInt(val.toString());
			}
			String article_id = key.toString().split(",")[1];

			result.set(article_id + "," + String.valueOf(sum));
			context.write(new Text(key.toString().split(",")[0]), result);
		}

	}

	public static class Reduce extends Reducer<Text, Text, Text, Text> {

		@Override
		public void reduce(Text key, Iterable<Text> values, Context context)
			throws IOException, InterruptedException {
	
			List<String> postingsList = new ArrayList<>();

			// iterate through postings and append to the new postings list
			for (Text value : values) {
				postingsList.add(value.toString());
			}
	
			// sort postings in increasing order of article-id
			Collections.sort(postingsList, Comparator.comparing(text -> {
				String artcile_id = text.split(",")[0];
				return Integer.parseInt(artcile_id);
			}));
			
			// append sorted postings to the StringBuilder
			//     and separate each (id, sum) tuple by comma
			StringBuilder sortedPostingsList = new StringBuilder();
			for (String posting : postingsList) {
				sortedPostingsList.append(posting).append(",");
			}
	
			// remove the trailing comma
			if (sortedPostingsList.length() > 0) {
				sortedPostingsList.setLength(sortedPostingsList.length() - 1);
			}
			
			context.write(key, new Text(sortedPostingsList.toString()));
		}

	}

	public static void main(String[] args) throws Exception {

		Configuration conf = new Configuration();
		Job job = Job.getInstance(conf, "WordCount");
		job.setJar("WordCount.jar");

		job.setMapperClass(TokenizerMapper.class);
		job.setCombinerClass(Combine.class);
		job.setReducerClass(Reduce.class);

		job.setOutputKeyClass(Text.class);
		job.setOutputValueClass(Text.class);

		// specify all articles subfolders as arguments
		FileInputFormat.addInputPath(job, new Path(args[0]));
		FileInputFormat.addInputPath(job, new Path(args[1]));
		FileInputFormat.addInputPath(job, new Path(args[2]));
		FileInputFormat.addInputPath(job, new Path(args[3]));
		FileInputFormat.addInputPath(job, new Path(args[4]));
		FileInputFormat.addInputPath(job, new Path(args[5]));
		FileInputFormat.addInputPath(job, new Path(args[6]));
		FileInputFormat.addInputPath(job, new Path(args[7]));
		FileInputFormat.addInputPath(job, new Path(args[8]));
		FileInputFormat.addInputPath(job, new Path(args[9]));
		FileInputFormat.addInputPath(job, new Path(args[10]));
		// specify output directory
		FileOutputFormat.setOutputPath(job, new Path(args[11]));

		System.exit(job.waitForCompletion(true) ? 0 : 1);
	}
}
