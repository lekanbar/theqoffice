<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Registration.aspx.cs" 
Inherits="Registration"  Title="The Q-Office -> Registration" %>

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
WEBSITE ADDRESS: 

    <asp:HyperLink ID="lnkDomainEdit" runat="server" CssClass="right"  Style="margin-left:5px" ToolTip="Change"
     NavigateUrl="~/DomainSearch.aspx">
        <asp:Image ID="imgDomainEdit" runat="server"  ImageUrl="images/minibtnEdit.jpg" AlternateText="change"
         Height="20px" Width="20px"/>
     </asp:HyperLink>
     
<asp:Label ID="lblWebsiteAddress" runat="server" ForeColor="Blue" CssClass="right" ></asp:Label>

<br />

WEBSITE DESIGN THEME:  

    <asp:HyperLink ID="lnkTemplateEdit" runat="server" CssClass="right"  Style="margin-left:5px" ToolTip="Change"
     NavigateUrl="~/TemplateSearch.aspx">
        <asp:Image ID="imgTemplateEdit" runat="server"  ImageUrl="images/minibtnEdit.jpg" AlternateText="change"
         Height="20px" Width="20px"/>
     </asp:HyperLink>

<asp:Label ID="lblWebsiteDesign" runat="server" ForeColor="Green" CssClass="right" ></asp:Label>

<br />

    WEBSITE BANNER:      

    <asp:HyperLink ID="lnkWebsiteBanner" runat="server" CssClass="right"  Style="margin-left:5px" ToolTip="Change"
     NavigateUrl="~/TemplateDesign.aspx">
        <asp:Image ID="imgBannerEdit" runat="server"  ImageUrl="images/minibtnEdit.jpg" AlternateText="change"
         Height="20px" Width="20px"/>
     </asp:HyperLink>
     
    <asp:Label ID="lblWebsiteBanner" runat="server" ForeColor="Maroon" CssClass="right"
    Text="None selected yet"  ></asp:Label>
    
<br />

    HOMEPAGE DESIGN THEME:      

    <asp:HyperLink ID="lnkDesignEdit" runat="server" CssClass="right"  Style="margin-left:5px" ToolTip="Change"
     NavigateUrl="~/HomeDesignSearch.aspx">
        <asp:Image ID="imgDesignEdit" runat="server"  ImageUrl="images/minibtnEdit.jpg" AlternateText="change"
         Height="20px" Width="20px"/>
     </asp:HyperLink>
     
    <asp:Label ID="lblHomeDesign" runat="server" ForeColor="Maroon" CssClass="right"
    Text="None selected yet"  ></asp:Label>
    
    
<hr />


<table>
<tr>
    <td >
    FIRST NAME
    </td>
        
    <td>
        <asp:TextBox ID="txtFName" runat="server" CssClass="texts1" ></asp:TextBox>
    </td>
</tr>  
<tr>
    <td colspan="2" class="notificationRow">
        <asp:RequiredFieldValidator ID="reqFName" runat="server" ErrorMessage="enter a value" Display="Dynamic"
         ValidationGroup="grpReg" ControlToValidate="txtFName"></asp:RequiredFieldValidator>
    </td>
</tr>
<tr>  
    <td>
    LAST NAME
    </td>      
    <td>
        <asp:TextBox ID="txtLName" runat="server" CssClass="texts1" ></asp:TextBox>
    </td>
</tr> 
<tr>
    <td colspan="2" class="notificationRow">
        <asp:RequiredFieldValidator ID="reqLName" runat="server" ErrorMessage="enter a value" Display="Dynamic"
         ValidationGroup="grpReg" ControlToValidate="txtLName"></asp:RequiredFieldValidator>
    </td>
</tr>
<tr>  
    <td>
    COMPANY NAME
    </td>      
    <td>
        <asp:TextBox ID="txtCompanyName" runat="server" CssClass="texts1" ></asp:TextBox>
    </td>
</tr> 
<tr>
    <td colspan="2" class="notificationRow">
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="enter a value" Display="Dynamic"
         ValidationGroup="grpReg" ControlToValidate="txtCompanyName"></asp:RequiredFieldValidator>
    </td>
</tr>
<tr> 
    <td>
    EMAIL ADDRESS
    </td>       
    <td>
        <asp:TextBox ID="txtEmail" runat="server" CssClass="texts1" ></asp:TextBox>
    </td>
</tr> 
<tr>
    <td colspan="2" class="notificationRow">
        <asp:RequiredFieldValidator ID="reqEmail" runat="server" ErrorMessage="enter a value" Display="Dynamic"
         ValidationGroup="grpReg" ControlToValidate="txtEmail"></asp:RequiredFieldValidator>
         <asp:RegularExpressionValidator ID="RegEmail" runat="server"  ControlToValidate="txtEmail"
         ErrorMessage="invalid email address"  ValidationGroup="grpReg" Display="Dynamic"
            ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
    </td>
</tr>
<tr>    
    <td>
    PASSWORD
    </td>  
    <td>
        <asp:TextBox ID="txtPassword1" runat="server" CssClass="texts1"  TextMode="Password"></asp:TextBox>
    </td>
</tr> 
<tr>
    <td colspan="2" class="notificationRow">
        <asp:RequiredFieldValidator ID="reqPass1" runat="server" ErrorMessage="enter a value" Display="Dynamic"
         ValidationGroup="grpReg" ControlToValidate="txtPassword1"></asp:RequiredFieldValidator>
         <asp:RegularExpressionValidator
             ID="regx1" runat="server" ErrorMessage="must be at least 6 characters" ValidationExpression="^.{6,}"
             ValidationGroup="grpReg" ControlToValidate="txtPassword1"></asp:RegularExpressionValidator>
    </td>
</tr>
<tr>  
    <td>
    CONFIRM PASSWORD
    </td>
    <td>
        <asp:TextBox ID="txtPassword2" runat="server" CssClass="texts1" TextMode="Password" ></asp:TextBox>
    </td>
</tr>
<tr>
    <td colspan="2" class="notificationRow">
        <asp:RequiredFieldValidator ID="reqPass2" runat="server" ErrorMessage="enter a value" Display="Dynamic"
         ValidationGroup="grpReg" ControlToValidate="txtPassword2"></asp:RequiredFieldValidator>         
        <asp:CompareValidator ID="CompPasswords" runat="server" ValidationGroup="grpReg"  Display="Dynamic"
         ErrorMessage="inconsistent passwords" ControlToCompare="txtPassword1" ControlToValidate="txtPassword2">
         </asp:CompareValidator>
    </td>
</tr>
<tr>
<td colspan="2">
<hr />
NB: You can only choose two applications from below. You can have access to more 
    apps by upgrading to the Custom Website.
    <hr />
</td>
</tr>
<tr>  
    <td>
    CHOOSE APPS(FREE)
    </td>
    <td>
        GALLERY APPS<br />
        <asp:DropDownList ID="ddlGalleryApps" runat="server" CssClass="DDL1">
            <asp:ListItem Text="News Gallery" Value="2" Selected="True"></asp:ListItem>
            <asp:ListItem Text="Download Gallery" Value="1"></asp:ListItem>
            <asp:ListItem Text="Product Gallery" Value="4"></asp:ListItem>
            <asp:ListItem Text="Project Gallery" Value="5"></asp:ListItem>
            <asp:ListItem Text="Service Gallery" Value="6"></asp:ListItem>
        </asp:DropDownList>
        <br /><br />
        MEDIA APPS<br />
        <asp:DropDownList ID="ddlMediaApps" runat="server" CssClass="DDL1">
            <asp:ListItem Text="Picture Gallery" Value="3" Selected="True"></asp:ListItem>
            <asp:ListItem Text="Video Gallery" Value="7"></asp:ListItem>
        </asp:DropDownList>
    </td>
</tr>
<tr>
    <td colspan="2" align="center">
        <hr />
    </td>
</tr>
</table>

        <asp:UpdatePanel ID="UpdatePanelNotification" runat="server">
        <ContentTemplate>
      <TQO:ResultNotification ID="Notification" runat="server" />
            </ContentTemplate>
            </asp:UpdatePanel>
<br />
<hr />
    <div class="right">
    <asp:Button ID="btnComplete" runat="server"  Text="COMPLETE REGISTRATION" CssClass="greenSideBarButton"
      ValidationGroup="grpReg" onclick="btnComplete_Click"  /> 
    </div>
    
</div>
  </div>
  
  
</div>
</asp:Content>

