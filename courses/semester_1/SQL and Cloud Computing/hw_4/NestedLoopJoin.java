import org.apache.hadoop.conf.Configuration;
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

public class NestedLoopJoin {

	// Static column family and qualifiers (same for both tables)
	static byte[] COLUMNFAMILY = Bytes.toBytes("data");
	static byte[] QUALIFIER = Bytes.toBytes("1");

	public static void main(String args[]) throws Exception {

		// Create a default HBase configuration & connection
		Configuration config = HBaseConfiguration.create();
		Connection connection = ConnectionFactory.createConnection(config);

		// Table 1 initialization
		Table name_basics = connection.getTable(TableName.valueOf("name_basics"));

		// Table 2 initialization
		Table table2 = connection.getTable(TableName.valueOf("test2"));

		// Initialize a scan over the entire first table
		Scan scan = new Scan();
		scan.addColumn(COLUMNFAMILY, QUALIFIER); // set the column we are interested in
		scan.setTimeRange(0, Long.MAX_VALUE); // retrieve the versions of a cell at all timestamps
		scan.setMaxVersions(Integer.MAX_VALUE); // retrieve all versions of a cell

		// Start the actual scanner
		ResultScanner scanner = name_basics.getScanner(scan);

		// Now join the two tables based on their row keys
		try {

			// Iterate over all result rows from the first table
			for (Result result1 : scanner) {

				// Get the raw cells (bytes) of the first row
				Cell[] cells1 = result1.rawCells();

				// Look up the key-value pairs by the key of the first result row
				// in the other table, if any
				Get g = new Get(result1.getRow());
				Result result2 = table2.get(g);

				// Do we have a match?
				if (result2.getRow() != null) {

					System.out.println("MATCHING ROWKEY: " + Bytes.toString(result1.getRow()));

					// Get the raw cells (bytes) of the second row
					Cell[] cells2 = result2.rawCells();

					// Iterate over all versions of the first cell
					for (int i = 0; i < cells1.length; i++) {

						// Read the value and timestamp of the first cell
						String value1 = Bytes.toString(CellUtil.cloneValue(cells1[i]));
						long timestamp1 = cells1[i].getTimestamp();

						// Iterate over all versions of the second cell
						for (int j = 0; j < cells2.length; j++) {

							// Read the value and timestamp of the second cell
							String value2 = Bytes.toString(CellUtil.cloneValue(cells2[j]));
							long timestamp2 = cells2[j].getTimestamp();

							System.out.println("TABLE1: " + value1 + " @ " + timestamp1 + " <=> TABLE2: " + value2
									+ " @ " + timestamp2);
						}
					}
				}
			}

		} finally {
			scanner.close();
			table1.close();
			table2.close();
		}
	}
}
