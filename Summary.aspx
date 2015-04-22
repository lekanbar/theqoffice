<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Summary.aspx.cs" 
Inherits="Summary"  Title="The Q-Office -> Setup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

 <div class="NormalContentTitle">
 CREATE YOUR WEBSITE
 </div>
  
 <div  id="NormalContent">
  <div  class="NormalContentLeft">
ABOUT Q-OFFICE
<br /><br />

<div style="color:#000000;  "> 
Building a website for your business can be as easy as checking your email! All you have to do is choose a 
 website design and let the world know about your business.
 <br /><br />
 A Q-Office website offers an impressive array of business tools such as
 Personalized Email Accounts, News Gallery, Project Gallery, Media Room,
  Press Room (with bulk SMS and email Notification capabilities),
 Search Engine Optimization Assistant
   and so much more, you can be sure of a world-class business representation.
</div>
<br /><br />
<center>
<asp:HyperLink ID="lnkAbout" runat="server" NavigateUrl="~/About.aspx" ForeColor="Yellow">
CLICK HERE FOR <br />
*MORE INFORMATION*
</asp:HyperLink>
</center>
<br />
  </div>
  
  <div class="NormalContentRight">
  <div style="font-size:24px;">
  Please confirm all registration details
  <hr />
<table cellspacing="10">
<tr>
    <td> First Name </td>
    <td>
    <asp:Label ID="lblFirstName" runat="server" Font-Bold="True" 
        Font-Italic="False"></asp:Label>
    </td>
</tr>
<tr>
    <td>Last Name </td>
    <td> 
    <asp:Label ID="lblLastName" runat="server" Font-Bold="True" 
        Font-Italic="False"></asp:Label>    
    </td>
</tr>
<tr>
    <td>Company Name </td>
    <td> 
    <asp:Label ID="lblCompanyName" runat="server" Font-Bold="True" 
        Font-Italic="False"></asp:Label>    
    </td>
</tr>
<tr>
    <td>Email Address (for Login purposes)</td>
    <td>
    <asp:Label ID="lblEmail" runat="server" Font-Bold="True" 
        Font-Italic="False"></asp:Label>
    </td>
</tr>
<tr>
    <td>Domain Name </td>
    <td>
    <asp:Label ID="lblDomainName" runat="server" Font-Bold="True" 
        Font-Italic="False"></asp:Label>
    </td>
</tr>
<tr>
    <td>SMS Balance</td>
    <td>
    <asp:Label ID="lblSMSBalance" runat="server" Font-Bold="True" 
        Font-Italic="False"></asp:Label>
    </td>
</tr>
<tr>
    <td>Email Accounts</td>
    <td>
    <asp:Label ID="lblEmailAccounts" runat="server" Font-Bold="True" 
        Font-Italic="False"></asp:Label>
    </td>
</tr>
<tr>
    <td> Template Name</td>
    <td>
     <asp:Label ID="lblTemplateName" runat="server" Font-Bold="True" 
        Font-Italic="False"></asp:Label>
    </td>
</tr>
<tr>
    <td> Home Design Name</td>
    <td>
     <asp:Label ID="lblHomeDesign" runat="server" Font-Bold="True" 
        Font-Italic="False"></asp:Label>
    </td>
</tr>
<tr>
    <td> Banner Name</td>
    <td>
    <asp:Label ID="lblBanner" runat="server" style="font-weight: 700"></asp:Label>
    </td>
</tr>
<tr>
    <td> Gallery App</td>
    <td>
    <asp:Label ID="lblGalleryApp" runat="server" style="font-weight: 700"></asp:Label>
    </td>
</tr>
<tr>
    <td> Media App</td>
    <td>
    <asp:Label ID="lblMediaApp" runat="server" style="font-weight: 700"></asp:Label>
    </td>
</tr>
<tr>
    <td>Colors </td>
    <td>
       <asp:Table ID="tblColors" runat="server" Width="344px" CellSpacing="5" BorderWidth="1">
        <asp:TableRow runat="server">
            <asp:TableCell runat="server">
                <asp:Panel ID="Panel1" runat="server"   CssClass="labelBorder">
                </asp:Panel>
            </asp:TableCell>
            <asp:TableCell runat="server">
                <asp:Panel ID="Panel2" runat="server"   CssClass="labelBorder">
                </asp:Panel>
            </asp:TableCell>
            <asp:TableCell runat="server">
                <asp:Panel ID="Panel3" runat="server"   CssClass="labelBorder">
                </asp:Panel>
            </asp:TableCell>
        </asp:TableRow>
        </asp:Table>
    </td>
</tr>
<tr>
    <td>Contract Duration </td>
    <td>
     <asp:Label ID="lblConDuration" runat="server" Text="" style="font-weight: 700"></asp:Label>
    </td>
</tr>
<tr>
    <td> Amount Due</td>
    <td>
     <asp:Label ID="lblAmount" runat="server" Font-Bold="True" 
        Font-Italic="False"></asp:Label>
    </td>
</tr>

</table>
<br />
<center>
I have read all the <a href="about.aspx" target="_blank"> required information </a> about The Q-Office and
I subscribe to all the  <a href="Terms.aspx" target="_blank">Terms & Conditions </a>  associated with it. 
    <br />    
    <asp:RadioButton ID="rbtnAgree" runat="server" 
        GroupName="grp" Text="I Agree" />

    <asp:RadioButton ID="rbtnDAgree" runat="server" GroupName="grp" 
        Text="I Don't Agree" />
    <br />
</center>        
    <br />
    <hr />
    <asp:Button ID="lnkBack" runat="server" OnClick="lnkBack_Click"  Text="BACK << EDIT REGISTRATION DETAILS"  CssClass="greenSideBarButton left" />
    <asp:Button ID="btnConfirm" runat="server" Text="PROCEED >> CONFIRM REGISTRATION" CssClass="greenSideBarButton right" 
        onclick="btnConfirm_Click" />
        </div>
        </div>
        <TQO:ResultNotification ID="Notification" runat="server" />
</asp:Content>

