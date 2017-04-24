using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO ;
using System.Configuration;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            
            // the shopping items saved in XML file to make it easy for testing the application
            // note that it use to saved in database in real live scenario
            string myXMLfile = "XMLFile.xml";

            DataSet ds = new DataSet();
            // Create new FileStream with which to read the schema.
            System.IO.FileStream fsReadXml = new System.IO.FileStream
            (myXMLfile, System.IO.FileMode.Open);
            ds.ReadXml(fsReadXml);
            GridView1.DataSource = ds.Tables[0];
            GridView1.DataBind();
            fsReadXml.Close();
        }
    }
}
