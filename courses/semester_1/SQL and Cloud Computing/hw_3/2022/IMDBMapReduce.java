import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.ArrayList;
import java.util.StringTokenizer;
import java.io.BufferedReader;
import java.io.FileReader;
import java.util.TreeMap;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.io.DoubleWritable;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.input.FileSplit;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;

public class IMDBMapReduce {
    public static class TokenizerMapper extends Mapper < Object,
        Text, Text, DoubleWritable > {

            private TreeMap < Double,
            String > movieMap; //Use TreeMap because it provides a way to store key-value pairs in sorted order

            @Override
            public void setup(Context context) throws IOException,
            InterruptedException {
                movieMap = new TreeMap < Double, String > ();
            }

            @Override
            public void map(Object key, Text value,
                Context context) throws IOException,
            InterruptedException {
                String[] tokens = value.toString().split("\t"); //Read the input and split it for Movie Id and rating

                String movie_id = tokens[0];
                double ratings = Double.parseDouble(tokens[1]);

                movieMap.put(ratings, movie_id); //Store Key-Values in map. The map sorts according to keys so we put ratings as keys.

                if (movieMap.size() > 20) //need the top 20 so remove first Key if size greater than 20
                {
                    movieMap.remove(movieMap.firstKey());
                }
            }

            @Override
            public void cleanup(Context context) throws IOException,
            InterruptedException {
                for (Map.Entry < Double, String > entry: movieMap.entrySet()) {

                    double rating = entry.getKey();
                    String movie_id = entry.getValue();

                    context.write(new Text(movie_id), new DoubleWritable(rating)); //Write to the context for all key-value pairs.
                }
            }
        }

    public static class IntSumReducer extends Reducer < Text,
        DoubleWritable, DoubleWritable, Text > {
            private TreeMap < Double,
            String > reduceMap;

            @Override
            public void setup(Context context) throws IOException,
            InterruptedException {
                reduceMap = new TreeMap < Double, String > ();
            }

            @Override
            public void reduce(Text key, Iterable < DoubleWritable > values,
                Context context) throws IOException,
            InterruptedException {

                String movie_id = key.toString(); // getsMovieId and ratings from mapper.
                double rating = 0;

                for (DoubleWritable val: values) {
                    rating = val.get();
                }

                reduceMap.put(rating, movie_id); //insert data again to the map, with ratings as key so that the sorting order is maintained

                if (reduceMap.size() > 20) //Remove the top key if size is more than 20
                {
                    reduceMap.remove(reduceMap.firstKey());
                }
            }

            @Override
            public void cleanup(Context context) throws IOException,
            InterruptedException {

                for (Map.Entry < Double, String > entry: reduceMap.entrySet()) {

                    double rating = entry.getKey();
                    String movie_id = entry.getValue();
                    context.write(new DoubleWritable(rating), new Text(movie_id)); //Finally write back to context
                }
            }
        }

    public static void main(String[] args) throws Exception {

        Configuration conf = new Configuration();

        Job job = Job.getInstance(conf, "IMDBMapReduce");
        job.setJarByClass(IMDBMapReduce.class);
        job.setMapperClass(TokenizerMapper.class);
        job.setReducerClass(IntSumReducer.class);

        job.setMapOutputKeyClass(Text.class);
        job.setMapOutputValueClass(DoubleWritable.class);
        job.setOutputKeyClass(DoubleWritable.class);
        job.setOutputValueClass(Text.class);

        FileInputFormat.addInputPath(job, new Path(args[0]));
        FileOutputFormat.setOutputPath(job, new Path(args[1]));

        System.exit(job.waitForCompletion(true) ? 0 : 1);

    }

}