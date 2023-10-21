using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Market
{
    public partial class Form1 : Form
    {
        static string connString = "Data Source=SERG-PC\\SQLEXPRESS;Initial Catalog=Market;Integrated Security=True;Connect Timeout=30;Encrypt=False;TrustServerCertificate=False;ApplicationIntent=ReadWrite;MultiSubnetFailover=False";
        SqlDataAdapter adapter;
        DataSet db;
        SqlConnection connect = new SqlConnection(connString);
        string commandText = "";

        public Form1()
        {
            InitializeComponent();
        }

        private void Start_Click(object sender, EventArgs e)
        {
            button_Start.Visible = false;
            label1.Visible = true;
            comboBox1.Visible = true;
            button_FillGrid.Visible = true;
            dataGridView1.Visible = true;

            commandText = "select table_name from information_schema.tables";       // запит назв таблиць з бази даних

            adapter = new SqlDataAdapter(commandText, connect);
            db = new DataSet();
            adapter.Fill(db);
            DataTableReader reader = db.CreateDataReader();

            while (reader.Read())                   // заповнення comboBox назвами таблиць
            {
                comboBox1.Items.Add((string)reader["TABLE_NAME"]);
            }
            reader.Close();
            connect.Close();
            GetTablesFromDB();
           
        }

        private void GetTablesFromDB()
        {
            commandText = @"select* from Sellers; 
                         select * from Buyers; 
                         select (Sellers.Name + ' ' + Sellers.Surname) as Seller_name, 
	                            (Buyers.Name + ' ' + Buyers.Surname) as Buyer_name, 
	                            Sales.Summ, 
	                            Sales.Data
                         from Sales inner join Sellers on Sellers.ID = Sales.SellerID
		                            inner join Buyers on Buyers.ID = Sales.BuyerID;";


            adapter = new SqlDataAdapter(commandText, connect);
            db = new DataSet();

            var tableNames = comboBox1.Items.Cast<object>().ToArray();      // формування масиву з назвами таблиць БД
            int i = 0;
            foreach (var tableName in tableNames)                           // заповнення колекції TableMappings назвами таблиць
            {
                if (i == 0)
                    adapter.TableMappings.Add("Table", tableName.ToString());
                else
                    adapter.TableMappings.Add("Table" + i, tableName.ToString());
                i++;
            }

            adapter.Fill(db);
        }

        private void button_FillGrid_Click(object sender, EventArgs e)
        {
            // зчитування поточної вибраної назви таблиці з comboBox 
            string selectedTable = comboBox1.SelectedItem.ToString();

            // заповнення GridView даними з таблиці, що визначається по назві
            dataGridView1.DataSource = db.Tables[selectedTable];
        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            dataGridView1.DataSource = null;        // очищення GridView при виборі нової таблиці
        }
    }
}
