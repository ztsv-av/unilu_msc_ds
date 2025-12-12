import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.StringTokenizer;
import java.io.BufferedReader;
import java.io.FileReader;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.input.FileSplit;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;

public class InvertedIndex1a {

    public static class TokenizerMapper
    extends Mapper < Object, Text, Text, Text > {
        private boolean caseSensitive = false;
        String stopwords = ""; // initialize the string

        @Override
        public void setup(Context context) throws IOException,
        InterruptedException {
            Configuration conf = context.getConfiguration();
            caseSensitive = conf.getBoolean("wordcount.case.sensitive", false); //checks the property and defaults to false.
            if (conf.getBoolean("wordcount.skip.patterns", false)) {
                System.out.println("Skipping Stopwords..."); //for debugging
                stopwords = get_stopWords(); //reads the stopwords from stopwords.txt only if the property is enabled.
            }
        }

        @Override
        public void map(
            Object key,
            Text value,
            Context context
        ) throws IOException,
        InterruptedException {
            String fileName = ((FileSplit) context.getInputSplit()).
            getPath().getName();
            StringTokenizer i = new StringTokenizer(value.toString());
            while (i.hasMoreTokens()) {
                String word = i.nextToken();
                if (word.contains("id=\"")) {
                    fileName = word; //gets the id of the article
                }
                word = word.replaceAll("[\\W]+", ""); //creates words without additional characters.
                if (!stopwords.contains(word)) { //This condition prevents the stopwords from being counted
                    if (caseSensitive) {
                        System.out.println("Converting tokens to lower case..."); //for debugging
                        word = word.toLowerCase(); //If the property was enabled, this is where the token is converted to lower string
                    }
                    context.write(
                        new Text(word),
                        new Text(fileName)
                    );
                }
            }
        }



        private String get_stopWords() {

            StringBuilder builder = new StringBuilder();
            try (BufferedReader buffer = new BufferedReader(
                new FileReader("/mnt/irisgpfs/users/sahil_mohammad/stopwords.txt"))) { //Reads the stopwords from the text file. The file should be present in the workspace.
                String str;
                while ((str = buffer.readLine()) != null) {
                    builder.append(str).append("\n");
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
            return builder.toString(); //returns all the stopwords read as a string
        }

    }

    public static class IntSumReducer
    extends Reducer < Text, Text, Text, Text > {

        @Override
        public void reduce(
            Text key,
            Iterable < Text > values,
            Context context
        ) throws IOException,
        InterruptedException {

            Map < String, Integer > map = new HashMap < > ();

            for (Text v: values) {
                String articleId = v.toString();
                Integer count = map.get(fileName);
                if (count == null) {
                    count = 0;
                }
                map.put(articleId, count + 1); //increments the count of each article
            }

            StringBuilder sb = new StringBuilder();
            for (Map.Entry < String, Integer > e: map.entrySet()) {
                sb.append(e.getKey());
                sb.append(": ");
                sb.append(e.getValue());
                sb.append(" ");
            }

            context.write(
                key,
                new Text(sb.substring(0, sb.length() - 1))
            );

        }

    }

    public static void main(String[] args) throws Exception {

        Configuration conf = new Configuration();

        Job job = Job.getInstance(conf, "InvertedIndex1a");

        job.setJarByClass(InvertedIndex1a.class);
        job.setMapperClass(TokenizerMapper.class);
        job.setReducerClass(IntSumReducer.class);
        job.setCombinerClass(IntSumReducer.class);
        job.setOutputKeyClass(Text.class);
        job.setOutputValueClass(Text.class);

        for (int i = 0; i < args.length; ++i) { //reads all the arguments passed from console
            if ("-skippatterns".equals(args[i])) { //marks the property true if -skippatterns is passed as argument 
                job.getConfiguration().setBoolean("wordcount.skip.patterns", true);
            } else if ("-casesensitive".equals(args[i])) { //marks the property true if -casesensitive is passed as argument
                job.getConfiguration().setBoolean("wordcount.case.sensitive", true);
            }
        }

        FileInputFormat.addInputPath(job, new Path(args[0]));
        FileOutputFormat.setOutputPath(job, new Path(args[1]));

        System.exit(job.waitForCompletion(true) ? 0 : 1);

    }

}