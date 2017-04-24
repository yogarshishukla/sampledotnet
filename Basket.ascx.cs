using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.HtmlControls;

public partial class Basket : System.Web.UI.UserControl
{
    //page level variable to save the total price when the event rptShoppingCart_ItemDataBound fired.
    decimal decPriceSum;
    
    // the below code read the purchased items from cookies  ShoppingCart  and put it in data table dt_final then 
    // bind it to a data repeater control rptShoppingCart
    protected void Page_Load(object sender, EventArgs e)
    {
        // To Make sure the cookie is not empty
        if (Request.Cookies["ShoppingCart"] != null)
        {
            HttpCookie oCookie = (HttpCookie)Request.Cookies["ShoppingCart"];
            string sProductID = oCookie.Value.ToString();
            DataTable dt_final = new DataTable();

            // which means the user remove all products and he is adding a new product
            // in this case i need to remove the ",". otherwise the '' will be considered as item.
            if (sProductID.IndexOf(",") == 0)
            {
                sProductID=sProductID.Remove ( 0,  1);
            }

            if (sProductID != "")
            {
                char[] sep = { ',' };
                // split the cookie values into array
                string[] sArrProdID = sProductID.Split(sep);

                //create datatable for purchased items
                DataTable dt = new DataTable();
                dt.Columns.Add(new DataColumn("Counter"));
                dt.Columns.Add(new DataColumn("ProductID"));
                dt.Columns.Add(new DataColumn("ProductName"));
                dt.Columns.Add(new DataColumn("Issue"));
                dt.Columns.Add(new DataColumn(("prod_price"), System.Type.GetType("System.Decimal")));

                // to map the values from  array of string(sArrProdID) to datatable
                int counter = 1;
                for (int i = 0; i < sArrProdID.Length - 1; i = i + 3)
                {
                    DataRow dr = dt.NewRow();
                    dr["Counter"] = counter;
                    dr["ProductID"] = sArrProdID[i];
                    dr["ProductName"] = sArrProdID[i + 1].Replace("%20", " "); 
                    dr["Issue"] = 1;
                    dr["prod_price"] = sArrProdID[i + 2];
                    dt.Rows.Add(dr);
                    counter++;
                }

                //temp table to return the distinct values only
                DataTable dtTemp = new DataTable();
                string[] col = { "ProductID", "ProductName", "prod_price" };
                dtTemp = dt.DefaultView.ToTable(true, col);

                dt_final = dt.Clone();

                //to calculate the number of issued items
                counter = 1;
                foreach (DataRow dr in dtTemp.Rows)
                {
                    DataRow dr_final = dt_final.NewRow();
                    dr_final["ProductID"] = dr["ProductID"];
                    dr_final["ProductName"] = dr["ProductName"];
                    dr_final["Issue"] = dt.Compute("count(ProductID)", "ProductID='" + dr["ProductID"] + "'").ToString();
                    dr_final["Counter"] = counter;
                    dr_final["prod_price"] = dt.Compute("sum(prod_price)", "ProductID='" + dr["ProductID"] + "'");
                    dt_final.Rows.Add(dr_final);
                    counter++;
                }
            }

            // to bind the datatable to data repeater control rptShoppingCart
            rptShoppingCart.DataSource = dt_final;
            rptShoppingCart.DataBind();

        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        // here the submit page once the user finshed the shopping
        Response.Redirect("submit.aspx", false);
    }

    //to calculate the total money for purchased items
    protected void rptShoppingCart_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        // To reset the counter incase of header
        if (e.Item.ItemType == ListItemType.Header)
        {
            decPriceSum = 0;
        }

        // to add the product price to the sum variable (decPriceSum)
        else if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType ==
        ListItemType.AlternatingItem)
        {
            decPriceSum +=
            (decimal)((DataRowView)e.Item.DataItem)["prod_price"];

        }
        // to view the total incase of footer
        else if (e.Item.ItemType == ListItemType.Footer)
        {
            Label lblSum = e.Item.FindControl("lblItemPrice") as Label;
            lblSum.Text = "Total Price: $ " + decPriceSum;
        }
    } 
}
