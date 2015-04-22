<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="CustomRegistration.aspx.cs" Inherits="CustomRegistration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .style1x
        {
            width: 200px;
        }
        
        .txt2
        {
            font-size:16px;    
        }
    </style>
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
  <div style=" font-size:24px; ">
      <asp:UpdatePanel ID="UpdatePanel5" runat="server">
      <ContentTemplate>
CHOOSE YOUR WEBSITE ADDRESS
<br />
<table>
<tr>
<td>
www.
</td>
<td>
<asp:TextBox ID="txtDomainName" runat="server" Width="340px"></asp:TextBox>     
</td>
<td>

    <asp:DropDownList ID="DDLDomain" runat="server">
    <asp:ListItem Text=".COM" Value=".com" Selected="True" ></asp:ListItem>
    <asp:ListItem Text=".NET" Value=".net" ></asp:ListItem>
    <asp:ListItem Text=".ORG" Value=".org" ></asp:ListItem>
    <asp:ListItem Text=".BIZ" Value=".biz" ></asp:ListItem>
    </asp:DropDownList>
</td>
<td>
    <asp:Button ID="btnSearch" runat="server" ForeColor="White" BackColor="Black"  ValidationGroup="grpAdd"
          Text="START SEARCH" onclick="btnSearch_Click" /> 

</td>
</tr>
<tr> 
<td></td>
<td>
    <asp:RequiredFieldValidator ID="reqxx"  Display="Dynamic" Font-Size="12px"
    runat="server" ErrorMessage="enter a value"  ControlToValidate="txtDomainName" 
       ValidationGroup="grpAdd" ></asp:RequiredFieldValidator>
    <asp:RegularExpressionValidator ID="req1" runat="server"  ValidationGroup="grpAdd" Font-Size="12px"
    ErrorMessage="only numbers and alphabets allowed" ControlToValidate="txtDomainName" Display="Dynamic"
     ValidationExpression="^[\d\w]+">
    </asp:RegularExpressionValidator>
    </td>
<td></td>
<td></td>
</tr>
</table>
          
          </ContentTemplate>
          </asp:UpdatePanel>
<br />
    SEARCH RESULTS<hr />
      <asp:UpdatePanel ID="UpdatePanel6" runat="server">
      <ContentTemplate>
      <div style="font-size:24px;">
          <asp:Label ID="lblDomainResult" runat="server" ForeColor="Green" Text="No search made yet"></asp:Label>
    </div>
      </ContentTemplate>
      </asp:UpdatePanel>

</div>
<div  style="margin-top:40px; border:solid 1px #ff6600; padding:10px;">
<table>
<tr>
    <td colspan="2">
    <div style="font-size:24px;">ACCOUNT REGISTRATION</div>
    </td>
</tr>
<tr>
    <td class="style1" >
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
    <td class="style1">
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
    <td class="style1">
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
    <td class="style1">
    PHONE NUMBER
    </td>      
    <td>
        <asp:TextBox ID="txtPhoneNumber" runat="server" CssClass="texts1" ></asp:TextBox>
    </td>
</tr> 
<tr>
    <td colspan="2" class="notificationRow">
        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="enter a value" Display="Dynamic"
         ValidationGroup="grpReg" ControlToValidate="txtPhoneNumber"></asp:RequiredFieldValidator>
    </td>
</tr>
<tr> 
    <td class="style1">
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
    <td class="style1">
    COMPANY EMAIL ADDRESS
    </td>       
    <td>
        <asp:TextBox ID="txtCompanyEmail" runat="server" CssClass="texts1" ></asp:TextBox>
        <asp:UpdatePanel ID="UpdatePanel7" runat="server">
      <ContentTemplate>
        <asp:Label ID="lblDomain" runat="server" Text=""></asp:Label>
        </ContentTemplate>
        </asp:UpdatePanel>
        <br />
        <span style="font-size:12px">(This is default company email address that would be created 
        for your new website e.g. info@yourbusiness.com. You would still have four free email addresses left)</span>
    </td>
</tr> 
<tr>
    <td colspan="2" class="notificationRow">
        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="enter a value" Display="Dynamic"
         ValidationGroup="grpReg" ControlToValidate="txtCompanyEmail"></asp:RequiredFieldValidator>
         <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server"  ControlToValidate="txtCompanyEmail"
         ErrorMessage="invalid email address"  ValidationGroup="grpReg" Display="Dynamic"
            ValidationExpression="\w+([-+.']\w+)*"></asp:RegularExpressionValidator>
    </td>
</tr>
<tr>    
    <td class="style1">
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
    </td>
</tr>
<tr>  
    <td class="style1">
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
    </td>
</tr>
<tr>
    <td class="style1">
        APPLICATIONS GALLERY
    </td>
    <td>
        <asp:CheckBoxList ID="ChkLstAppGallery" runat="server" Width="309px">
            <asp:ListItem Value="1">Download Gallery</asp:ListItem>
            <asp:ListItem Value="2">News Gallery</asp:ListItem>
            <asp:ListItem Value="3">Picture Gallery</asp:ListItem>
            <asp:ListItem Value="4">Product Gallery</asp:ListItem>
            <asp:ListItem Value="5">Project Gallery</asp:ListItem>
            <asp:ListItem Value="6">Service Gallery</asp:ListItem>
            <asp:ListItem Value="7">Video Gallery</asp:ListItem>
            <asp:ListItem Value="10">Testimonials</asp:ListItem>
        </asp:CheckBoxList>
    </td>
</tr>
<tr>
    <td colspan="2">
    NB: Please choose only the galleries that you want for your website, so that it can be custom designed for you.
    </td>
</tr>
<tr>
    <td colspan="2">
    <hr />
    </td>
</tr>
<tr>
    <td class="style1">
    WEBSITE DESCRIPTION
    </td>
    <td>
    <asp:TextBox ID="txtWebDesc" runat="server" CssClass="texts1" TextMode="MultiLine" 
            Height="180px" Width="408px" Font-Size="16px"></asp:TextBox>
    </td>
</tr>
<tr>
    <td colspan="2">
    NB: Please make sure you enter a comprehensive description of what you want for your website, so that our support team
    will follow up with you ASAP, through the email you provide.
    </td>
</tr>
<tr>
<td colspan="2">
<hr />
NB: We advise that you use a discount code to register for our limited promo offer of N35,000/year, 
and N20,000 for custom design please send us an email to confirm your eligibility.
<hr />
</td>
</tr>
<tr>
    <td class="style1">
    CONTRACT DURATION 
    </td>
    <td>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
        <asp:DropDownList ID="DDLDuration" runat="server" CssClass="DDL1" >
        <asp:ListItem Text="One Year" Value="1" Selected="True"></asp:ListItem>
        <asp:ListItem Text="Two Years" Value="2"></asp:ListItem>
            
        </asp:DropDownList>
        </ContentTemplate>
        </asp:UpdatePanel>
        
    </td>
</tr>
<tr>
    <td class="style1">
        DISCOUNT CODE (optional)
    </td>
    <td>
        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
        <ContentTemplate>
            <asp:TextBox ID="txtDiscountCode" runat="server"  CssClass="texts1"  
            ValidationGroup="markt" Width="200px"></asp:TextBox>
        </ContentTemplate>
        </asp:UpdatePanel>
    </td>
</tr>
<tr>
    <td colspan="2" align="center">
        <asp:UpdatePanel ID="UpdatePanel4" runat="server">
        <ContentTemplate>
        <asp:LinkButton ID="lnkMarketerCode" runat="server" OnClick="lnkMarketerCode_Click" >
        CLICK HERE TO CALCULATE PAYMENT
        </asp:LinkButton>  
        <br />
        <span style="font-size:12px">(you must calculate payment before you can complete registration)</span>
        </ContentTemplate>
        </asp:UpdatePanel>
        
    </td>
</tr>
<tr>
    <td class="style1">
    AMOUNT DUE (<s>N</s>) 
    </td>
    <td>
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
            <asp:TextBox ID="lblAmount" runat="server" CssClass="texts1" Text="unavailable"  Width="200px"  Enabled="false"
             ReadOnly="true"></asp:TextBox>
           
        </ContentTemplate>
        </asp:UpdatePanel>
     </td>
</tr>

<tr>
    <td colspan="2" align="center">
    <hr />
        <asp:HyperLink ID="lnkInstructions" runat="server" NavigateUrl="~/AboutPayments.aspx" Target="_blank">
        IMPORTANT! CLICK HERE TO READ PAYMENT INSTRUCTIONS       
        </asp:HyperLink>
    </td>
</tr>
<tr>
    <td colspan="2">
    <hr />
    </td>
</tr>
</table>
<br /><center>
I have read all the <a href="about.aspx" target="_blank"> required information </a> about The Q-Office and
I subscribe to all the  <a href="Terms.aspx" target="_blank">Terms & Conditions </a>  associated with it. 
    <br />   <br /> 
    <asp:RadioButton ID="rbtnAgree" runat="server" 
        GroupName="grp" Text="I Agree" />

    &nbsp;

    <asp:RadioButton ID="rbtnDAgree" runat="server" GroupName="grp" 
        Text="I Don't Agree" />
    <br />
</center>
</div>
        <asp:UpdatePanel ID="UpdatePanelNotification" runat="server">
        <ContentTemplate>
      <TQO:ResultNotification ID="Notification" runat="server" />
            </ContentTemplate>
            </asp:UpdatePanel>
<br />
<hr />
    <div class="right">
    <asp:Button ID="btnComplete" runat="server"  Text="COMPLETE REGISTRATION" CssClass="greenSideBarButton"
      onclick="btnComplete_Click"  /> 
    </div>
    
</div>
</div>
</asp:Content>

