<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Basket.ascx.cs" Inherits="Basket" %>


    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Scripts>
            <asp:ScriptReference Path="~/Basket.js" />
        </Scripts>    
    </asp:ScriptManager>    

<style type="text/css">
        #whole_basket
        {
        	left: 650px;            /* Default Left Position for the basket */
            top: 200px;             /* Default Top Position for the basket */
        	position:fixed;            
        	width: 270px;           
        	border-style:solid;
        	border-width:1px;       
        	border-color:Red;       
            overflow:auto;          
            background-color: #FFFF99;  
        }
        

        #Header_Div         /* Basket Header Div Style */
        {
            position:relative;
	        height: 27px;
	        vertical-align: middle;
	        background-color: #EE3434;
        }

        .img_min_max            /* Minimize and Maximize image style */
        {
	        left:3px;
            position:absolute;
        }

        .Basket_Header_Label    /*The style of basket Header*/
        {
        	top:5px;
	        left:30px;
	        position:absolute;
	        color :White;
	        Font-Size:small; 
        }
        
        #Basket_body        /* the style of basket content*/
        {
	        position:relative;
	        font-size: 11px;
            height: 200px;
            visibility:visible; 
	        background-color: #FFFF99;
	    }
	    
	    .Column_header      /* Basket Column Header Product Name, Qty, Price */
	    {
	        color:Black;
	        font-weight:bold;
	    }

    </style>
    
<div id="whole_basket" style="top: 350px; left: 800px">
    
    <div id="Header_Div" onmousedown="begindrag(event)" onmouseup="rel_drag(event)" onmousemove= "mousepos(event)" style="cursor:hand;">
        <img id="imgShow" alt="" src="Images/min.jpg" onclick="javascript:showdiv('Basket_body')" class="img_min_max" />
        <img id="imgHide" alt="" src="Images/max.jpg" onclick="javascript:hidediv('Basket_body')" class="img_min_max"  />
        <asp:Label ID="lblHeaderLabel" runat="server" Text="Shopping Basket" CssClass="Basket_Header_Label" ></asp:Label>
    </div>        

    <script type="text/javascript">
        // The default status of the shopping basket to be maximize
        document.getElementById("imgShow").style.display = 'block';
     </script>
    
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div  id="Basket_body" >
                <table style="border:0; width:100%; " cellpadding ="3" cellspacing="2"  >
                    <ASP:REPEATER ID="rptShoppingCart" RUNAT="server" OnItemDataBound="rptShoppingCart_ItemDataBound">
                        <HeaderTemplate>
                            <tr>
                                <td width="40%" >
                                    <ASP:LABEL ID="lblMsg" RUNAT="server" Text="Product Name" 
                                        CssClass="Column_header"></ASP:LABEL>
                                </td>
                                <td width="20%" align="center">
                                    <asp:Label ID="lblIssue" runat="server" Text="Qty" 
                                        CssClass="Column_header"></asp:Label>
                                </td>

                                <td width="25%">
                                    <asp:Label ID="lblProdPrice" runat="server" Text="Price" 
                                        CssClass="Column_header"></asp:Label>
                                </td>                
                                <td width="15%">
                                </td>
                            </tr>
                       </HeaderTemplate>
            
                       <ItemTemplate>
                            <tr >
                                <td width="40%">
                                    <%# DataBinder.Eval(Container.DataItem,"Counter") %>
                                    .&nbsp;
                                    <%# DataBinder.Eval(Container.DataItem,"ProductName") %>
                                </td>
                                <td align="center" width="20%">
                                    <%# DataBinder.Eval(Container.DataItem,"Issue") %>
                                </td>               
                                <td width="20%">
                                    <%# "$ " + DataBinder.Eval(Container.DataItem,"prod_price") %>
                                </td>
                                <td width="20%">
                                     <a id="lnkRemove" href="<%# "javascript:deleteCookie('ShoppingCart'," + 
                                         DataBinder.Eval(Container.DataItem,"ProductID") + ",'" + 
                                         DataBinder.Eval(Container.DataItem,"ProductName") + "'," + 
                                         Convert.ToDecimal(DataBinder.Eval(Container.DataItem,"prod_price"))/ Convert.ToDecimal(DataBinder.Eval(Container.DataItem,"Issue")) + ")" %>" > 
                                            Remove
                                     </a>                        
                                </td>
                            </tr>
                       </ItemTemplate>
            
                       <FooterTemplate>
                            <tr>
                                <td colspan="4">
                                    <hr size="1" width="100%" />                     
                                </td>
                            </tr>

                            <tr>
                                <td> 
                                    <asp:Button ID="btnSubmit" runat="server" Text="Submit"  Font-Names="tahoma"
                                    onclick="btnSubmit_Click" BackColor="Red" BorderColor="White" 
                                    BorderStyle="Solid" BorderWidth="1px" ForeColor="White" CausesValidation="false" 
                                    UseSubmitBehavior="false"  />
                                 </td>
                                 <td colspan="3">
                                    <asp:Label ID="lblItemPrice" runat="server" Text="" Font-Bold="True"></asp:Label> 
                                 </td>
                             </tr>   
                        </FooterTemplate>
                    </ASP:REPEATER>
                </table>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>     

</div>    
   
