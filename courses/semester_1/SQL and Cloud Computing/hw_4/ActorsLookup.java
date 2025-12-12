import java.io.IOException;

import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.hbase.Cell;
import org.apache.hadoop.hbase.CellUtil;
import org.apache.hadoop.hbase.HBaseConfiguration;
import org.apache.hadoop.hbase.TableName;
import org.apache.hadoop.hbase.client.Connection;
import org.apache.hadoop.hbase.client.ConnectionFactory;
import org.apache.hadoop.hbase.client.Get;
import org.apache.hadoop.hbase.client.Result;
import org.apache.hadoop.hbase.client.ResultScanner;
import org.apache.hadoop.hbase.client.Scan;
import org.apache.hadoop.hbase.client.Table;
import org.apache.hadoop.hbase.util.Bytes;
import org.apache.hadoop.hbase.mapreduce.TableMapReduceUtil;


public class ActorsLookup {

	public static class ActorMapper extends Mapper<LongWritable, Text, Text, Text> {

        private Table name_basics;

        @Override
        protected void setup(Context context) throws IOException, InterruptedException {
            Configuration config = HBaseConfiguration.create();
            Connection connection = ConnectionFactory.createConnection(config);
            name_basics = connection.getTable(TableName.valueOf("name_basics"));
        }

        @Override
        protected void map(LongWritable key, Text value, Context context) throws IOException, InterruptedException {
            String line = value.toString();
            String[] columns = line.split("\t");

            if (columns.length >= 3) {
                String nconst = columns[2];

                // perform HBase lookup, i.e. find person in name_basics by current nconst from title_principles
                Get get = new Get(Bytes.toBytes(nconst));
                Result result = name_basics.get(get);

                // check if the person is found in name_basics by nconst
                if (!result.isEmpty()) {
                    // get primaryProfession from lookup
                    byte[] primaryProfessionBytes = result.getValue(Bytes.toBytes("info"), Bytes.toBytes("primaryProfession"));
                    // check if the person's profession is not null
                    if (primaryProfessionBytes != null) {
                        String primaryProfession = Bytes.toString(primaryProfessionBytes);
                        // check if person's profession is actor or actress
                        if (primaryProfession.contains("actor") || primaryProfession.contains("actress")) {
                            // get actor's name from lookup
                            byte[] nameBytes = result.getValue(Bytes.toBytes("info"), Bytes.toBytes("primaryName"));
                            String name = Bytes.toString(nameBytes);
                            String tconst = columns[0];
                            // emit actor's name and corresponding tconst
                            context.write(new Text(name), new Text(tconst));
                        }
                    }
                }
            }
        }

        @Override
        protected void cleanup(Context context) throws IOException, InterruptedException {
            // clean up resources allocated for name_basics
            name_basics.close();
        }
    }

    public class MoviesReducer extends Reducer<Text, Text, Text, Text> {

        @Override
        protected void reduce(Text actor, Iterable<Text> movies, Context context) throws IOException, InterruptedException {
            int movieCount = 0;

            // Count the number of distinct movie ids for each actor
            for (Text movie : movies) {
                movieCount++;
            }

            // Emit only those actors who occurred in at least 100 movies
            if (movieCount >= 100) {
                context.write(actor, new Text(Integer.toString(movieCount)));
            }
        }
    }

    public static void main(String[] args) throws Exception {
        Configuration config = HBaseConfiguration.create();
        Job job = Job.getInstance(config, "ActorsLookup");
        job.setJar("ActorsLookup.jar");

        // set the Mapper and Reducer classes
        job.setMapperClass(ActorMapper.class);
        job.setReducerClass(MoviesReducer.class);

        // set the output key and value classes for the Mapper
        job.setMapOutputKeyClass(Text.class);
        job.setMapOutputValueClass(Text.class);

        // set the output key and value classes for the Reducer
        job.setOutputKeyClass(Text.class);
        job.setOutputValueClass(Text.class);

        // set the input and output paths
        FileInputFormat.addInputPath(job, new Path("./title_principals.tsv"));
        FileOutputFormat.setOutputPath(job, new Path(args[0]));

        // Submit the job and wait for it to complete
        System.exit(job.waitForCompletion(true) ? 0 : 1);
    }

}
