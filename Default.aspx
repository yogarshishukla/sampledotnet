<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>
<%@ Register src="Basket.ascx" tagname="Basket" tagprefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Testing The Shopping Card</title>

</head>
<body >
    <form id="form1" runat="server" >
      
        
        <div align="left" style="width: 312px;  " >
            <b>The List Of Products</b>
            
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                    Width="100%" GridLines="None" Height="562px" >
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <div style="padding:  5 0 0 10px; font-family: Verdana, Geneva, Arial, Helvetica, sans-serif;">
                                <img alt="" src="Images/right_arrow_box.gif" width="20" height="19"  />
                                <asp:Label ID="Label1" runat="server" 
                                                Text='<%# ((System.Data.DataRowView)Container.DataItem)[0] %>'>
                                </asp:Label>
                            </div> 
                            <div style="padding: 0 0 0 35px;">
                                <asp:Label ID="Label2" runat="server" 
                                     Text='<%# ((System.Data.DataRowView)Container.DataItem)[1] %>' >
                                </asp:Label>
                           </div>
                            <div style="padding: 0 0 0 35px;" >
                                        
                                        <a id="A1" href="<%# "javascript:addCookie('ShoppingCart'," 
                                            +  ((System.Data.DataRowView)Container.DataItem)[2] + ",'" + 
                                            ((System.Data.DataRowView)Container.DataItem)[0]  + "'," +
                                            ((System.Data.DataRowView)Container.DataItem)[3] + ")" %>"  
                                            style="font-style: normal; font-variant: normal; border-style: none; font-style:normal; font-weight:normal; text-decoration: none;"  >
                                            add to the cart
                                            <img alt="" src="Images/Basket.bmp" style="border-width: 0px; text-decoration: none; " />
                                        </a>
                             </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                 </Columns>
            </asp:GridView>
            <div>
                <uc1:Basket ID="Basket1" runat="server"  />
            </div>
        </div>
    </form>
</body>
</html>
