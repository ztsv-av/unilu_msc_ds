import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.ArrayList;
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

public class InvertedIndex1b {
    public static class TokenizerMapper
    extends Mapper < Object, Text, Text, Text > {
        private boolean caseSensitive = false;
        String stopwords = "";
        
        @Override
        public void map(
            Object key,
            Text value,
            Context context
        ) throws IOException,
        InterruptedException {
            String docId = "";

            String lines = value.toString();
            String[] lineArr = lines.split("\\n"); //splits each line
            String[] keywords = context.getConfiguration().getStrings("search.keywords", ""); //gets the array of keywords passed as command line arguments through the property

            for (int i = 0; i < lineArr.length; i++) { //loops over each article
                StringTokenizer token = new StringTokenizer(lineArr[i]);
                while (token.hasMoreTokens()) {
                    String word = token.nextToken();
                    if (word.contains("id=\"")) {    //gets the id of the article
                        docId = word;
                    }
                }
                for (int j = 0; j < keywords.length; j++) { //this loop checks if each keyword appears in the article and how many times
                    if (lineArr[i].contains(keywords[j])) {
                        int count = lineArr[i].split(keywords[j], -1).length-1; //Gets how many times a keyword appears in the article
                        while(count>0){
                        context.write(new Text(keywords[j]), new Text(docId)); //checks if keyword is present in the line and writes the keyword along with docid.
                        count--;
                        }
                    }
                }
            }
        }

        private String get_stopWords() {

            StringBuilder builder = new StringBuilder();
            try (BufferedReader buffer = new BufferedReader(
                new FileReader("/mnt/irisgpfs/users/sahil_mohammad/stopwords.txt"))) {
                String str;
                while ((str = buffer.readLine()) != null) {

                    builder.append(str).append("\n");
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
            return builder.toString();
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
                String fileName = v.toString();
                Integer count = map.get(fileName);
                if (count == null) {
                    count = 0;
                }
                map.put(fileName, count + 1); //Increments the count of keyword along with fileName(docId)
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

        Job job = Job.getInstance(conf, "InvertedIndex1b");
        int index = 0;
        ArrayList <String> keywords = new ArrayList <String> (); //Initialized arraylist to read all keywords from console.

        job.setJarByClass(InvertedIndex1b.class);
        job.setMapperClass(TokenizerMapper.class);
        job.setReducerClass(IntSumReducer.class);
        job.setOutputKeyClass(Text.class);
        job.setOutputValueClass(Text.class);

        for (int i = 0; i < args.length; ++i) {
           keywords.add(args[i]);  //reads the command line arguments and adds them to the list
        }
        String[] str = new String[keywords.size()];
        str = keywords.toArray(str);
        job.getConfiguration().setStrings("search.keywords", str); //sets the array as value of the property


        FileInputFormat.addInputPath(job, new Path(args[0]));
        FileOutputFormat.setOutputPath(job, new Path(args[1]));

        System.exit(job.waitForCompletion(true) ? 0 : 1);

    }

}