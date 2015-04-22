<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="QueryTransaction.aspx.cs" Inherits="Secured_QueryTransaction" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div  style="margin-top:40px; border:solid 1px #ff6600; padding:10px;">
        <table>
            <tr>
    <td colspan="2">
    <div style="font-size:24px;">TRANSACTION QUERY DETAILS</div>
    </td>
</tr>
<tr>
    <td class="style1" >
       <i> Transaction ID:</i> 
        <asp:Label ID="lblTranxID" runat="server"></asp:Label>
                       <br />
                       <i> Name:</i> 
        <asp:Label ID="lblName" runat="server"></asp:Label>
                       <br />
                       <i> Email:</i> 
        <asp:Label ID="lblEmail" runat="server"></asp:Label>
                       <br />
                       <i> Item:</i> 
        <asp:Label ID="lblItem" runat="server" Text=""></asp:Label>
                       <br />
                       <i> Amount:</i> 
        <asp:Label ID="lblAmount" runat="server" Text=""></asp:Label>
                       <br />
                       <i style="color:Green;"> Previous Status:</i> 
        <asp:Label ID="lblPrevStatus" runat="server" Text=""></asp:Label>
                       <br />
                       <div style="font-size:12px; color:Maroon;">                       
                            <span class="right">
                            <i>date:</i> 
                                <asp:Label ID="lblDate" runat="server" Text="Label"></asp:Label>
                            </span>
                        </div>
    </td>
</tr>
<tr>
<td colspan="2">
<br />
<div style="font-size:24px;">CURRENT STATUS (WEBSERVICE CALL)</div></td>
</tr>
<tr>
<td>
<i style="color:Green;"> Response Code:</i> 
        <asp:Label ID="lblResponseCode" runat="server" Text=""></asp:Label>
                       <br />
 <i style="color:Green;"> Amount:</i> 
        <asp:Label ID="lblAppAmount" runat="server" Text=""></asp:Label>
                       <br />
<i style="color:Green;"> Current Status:</i> 
        <asp:Label ID="lblCurrStatus" runat="server" Text=""></asp:Label>
                       <br />
</td>
</tr>
<tr>
<td colspan="2" align="center">
    <br />  
    <asp:Button ID="btnOk" runat="server" Text="RETURN" onclick="btnOk_Click" />
</td>
</tr>
        </table>
    </div>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
    <TQO:ResultNotification ID="Notification" runat="server" />
    </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

