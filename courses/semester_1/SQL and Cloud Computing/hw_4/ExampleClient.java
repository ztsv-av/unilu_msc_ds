import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.hbase.HBaseConfiguration;
import org.apache.hadoop.hbase.HColumnDescriptor;
import org.apache.hadoop.hbase.HTableDescriptor;
import org.apache.hadoop.hbase.TableName;
import org.apache.hadoop.hbase.client.Admin;
import org.apache.hadoop.hbase.client.Connection;
import org.apache.hadoop.hbase.client.ConnectionFactory;
import org.apache.hadoop.hbase.client.Get;
import org.apache.hadoop.hbase.client.Put;
import org.apache.hadoop.hbase.client.Result;
import org.apache.hadoop.hbase.client.Table;
import org.apache.hadoop.hbase.util.Bytes;

public class ExampleClient {
	
	public static void main(String args[]) throws Exception {
		Configuration config = HBaseConfiguration.create();
		Connection connection = ConnectionFactory.createConnection(config);
		Admin admin = connection.getAdmin();

		HTableDescriptor table = new HTableDescriptor(TableName.valueOf("myTable"));
		table.addFamily(new HColumnDescriptor("data"));

		if (admin.tableExists(table.getTableName())) {
			admin.disableTable(table.getTableName());
			admin.deleteTable(table.getTableName());
		}
		admin.createTable(table);

		Table table1 = connection.getTable(TableName.valueOf("myTable"));

		byte[] row1 = Bytes.toBytes("row1");
		Put p1 = new Put(row1);

		p1.addColumn(Bytes.toBytes("data"), Bytes.toBytes("1"), Bytes.toBytes("value1"));
		table1.put(p1);

		Get g = new Get(row1);
		Result result = table1.get(g);
		System.out.println("Get : " + result);
		table1.close();

		admin.disableTable(table1.getName());
		admin.deleteTable(table1.getName());
	}
}
