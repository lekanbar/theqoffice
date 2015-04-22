<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Payment.aspx.cs" Inherits="Payment" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body style="background-color:#cccccc;">
<br /><br /><br />
    <center>
        <form id="form1" runat="server" name="submit2gtpay_form" action="https://gtpay.gtbank.com/public/tranx.jsp" method="post">
              
              <div style="width:600px; background-color:white; border:solid 6px #555555; padding:10px;">
                <div style="width:600px; height:150px; background-image:url(images/transHeader.jpg)">
                </div>
                <div style="padding:10px;">
                <br />
                                                
                  <input type="hidden" runat="server" id="gtpay_mert_id" name="gtpay_mert_id" value=""/>
                  <input type="hidden" runat="server" id="gtpay_item_name_1" name="gtpay_item_name_1" value=""/>
                  <input type="hidden" runat="server" id="gtpay_item_price_1" name="gtpay_item_price_1" value=""/>
                  <input type="hidden" runat="server" id="gtpay_cust_id" name="gtpay_cust_id" value=""/>
                  <input type="hidden" runat="server" id="gtpay_no_show_cust_id" name="gtpay_no_show_cust_id" value="yes"/>
                  <input type="hidden" runat="server" id="gtpay_tranx_noti_url" name="gtpay_tranx_noti_url" value=""/>
                  <input type="hidden" runat="server" id="gtpay_tranx_id" name="gtpay_tranx_id" value=""/>
                  <input type="hidden" runat="server" id="gtpay_tranx_amt" name="gtpay_tranx_amt" value=""/>
                    <img src="Images/iswitch.gif" />
                    <br />
                  <asp:Label ID="lblTitle" runat="server" Text="PAYMENTS"></asp:Label><br />
                  <table cellspacing="10">
                        <tr>
                            <td> Transaction ID </td>
                            <td>
                            <asp:Label ID="lblTID" runat="server" Font-Bold="True" 
                                Font-Italic="False"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td> Description </td>
                            <td>
                            <asp:Label ID="lblDescription" runat="server" Font-Bold="True" 
                                Font-Italic="False"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td> Amount Due </td>
                            <td> 
                            N<asp:Label ID="lblAmount" runat="server" Font-Bold="True" 
                                Font-Italic="False"></asp:Label>    
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2"> 
                            <center>
                                <input id="Submit1" type="submit" value="MAKE PAYMENT" /> 
                                </center>  
                            </td>
                    </tr>
                    </table>
              </div>
               </div>
        </form>
    </center>
</body>
</html>
