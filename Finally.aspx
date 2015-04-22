<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Finally.aspx.cs" 
Inherits="Secured_Finally"  Title="The Q-Office -> Setup" %>

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
        <asp:Label ID="Label1" runat="server" Text="" ></asp:Label>
<hr />
        <asp:Label ID="Label2" runat="server" Text=""></asp:Label>
  </div>
  </div>
</asp:Content>

