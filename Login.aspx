<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login"
 Title="The Q-Office -> Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
 
    <div class="NormalContentTitle">
 CREATE YOUR WEBSITE
 </div>
  
 <div  id="NormalContent">
  <div  class="NormalContentLeft">
HAVE YOU FORGOTTEN YOUR PASSWORD?
<br /><br />

<div style="color:#000000;  ">
After the existence of your account has been confirmed, we'd send a new password to your email address
with which you can regain access to your account. Your would be required to change your new password when you login.
</div>
<br />
<center>
ENTER YOUR EMAIL ADDRESS
<br />
    
</center>

<asp:UpdatePanel ID="UpdatePanel2" runat="server">
<ContentTemplate>

<center>
<asp:TextBox ID="txtRecoveryEmail" runat="server"></asp:TextBox>
  <br /><br />
      <asp:Button ID="recBtn" runat="server" Text="RECOVER PASSWORD" 
        CssClass="greenSideBarButton" ValidationGroup="grpRecovery" 
        onclick="recBtn_Click" />
<br />
      <asp:RequiredFieldValidator ID="recRq1" runat="server" ErrorMessage="enter an email address"  ValidationGroup="grpRecovery"
       ControlToValidate="txtRecoveryEmail" >
      </asp:RequiredFieldValidator>
      <asp:RegularExpressionValidator
          ID="recRg1" runat="server" ErrorMessage="invalid email"  
        ValidationGroup="grpRecovery" ControlToValidate="txtRecoveryEmail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" 
           ></asp:RegularExpressionValidator>
      <br />
  </center>
  
</ContentTemplate>
    </asp:UpdatePanel>
  </div>
  
    
    <asp:UpdatePanel ID="UpdatePanelCaptcha" runat="server">
    <ContentTemplate>
        <asp:Panel ID="pnlCaptcha" runat="server" Visible="false" >
        <div class="back">    
        </div>
            <div class="popup">
                <table>
                <tr>
                <td colspan="2">
                <asp:Label ID="lblCaptcha" runat="server" Text="...JUST CHECKING THAT YOU'RE HUMAN"></asp:Label>
                </td>
                </tr>
                <tr>
                <td>
                    <asp:UpdatePanel ID="UpdatePanelCaptchaImage" runat="server" >
                        <ContentTemplate>
                            <asp:Image ID="imgCaptcha" runat="server" alt="captcha image" />
                        </ContentTemplate>
                    </asp:UpdatePanel>
                 </td>
                <td align="right">
                    <asp:TextBox ID="txtCaptcha" runat="server" Height="24px" Width="200px" Font-Size="21px"
                      ForeColor="CadetBlue" MaxLength="5"  onfocus="javascript:this.value=''"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqCaptcha" runat="server" ErrorMessage="*" Display="Dynamic"
                     ControlToValidate="txtCaptcha" ValidationGroup="grpCaptcha" ></asp:RequiredFieldValidator>
                </td>
                </tr>
                <tr>
                <td></td>
                <td align="right">
                    <asp:ImageButton ID="btnCaptcha" runat="server" ImageUrl="images/btnCaptcha.png"  ValidationGroup="grpCaptcha"
                     OnClick="btnCaptcha_Click" BackColor="#FF6600" />
                </td>
                </tr>
                </table>        
            </div>
        </asp:Panel>
    
    </ContentTemplate>
    </asp:UpdatePanel>
    
  
  <div class="NormalContentRight">
  <div style="font-size:24px;">
CHOOSE YOUR WEBSITE ADDRESS
<br />
<asp:TextBox ID="txtDomainName" runat="server" Width="340px"></asp:TextBox>
    <asp:DropDownList ID="DDLDomain" runat="server">
    <asp:ListItem Text=".COM" Value=".COM" ></asp:ListItem>
    <asp:ListItem Text=".NET" Value=".NET" ></asp:ListItem>
    <asp:ListItem Text=".ORG" Value=".ORG" ></asp:ListItem>
    <asp:ListItem Text=".BIZ" Value=".BIZ" ></asp:ListItem>
    <asp:ListItem Text=".EDU" Value=".EDU" ></asp:ListItem>
    </asp:DropDownList>
    <asp:Button ID="btnSearch" runat="server" ForeColor="White" BackColor="Black" Text="START SEARCH" 
     PostBackUrl="DomainSearch.aspx" /> 
</div>
  </div>
  
  
  <div class="NormalContentRight" style="margin-top:30px; border:solid 1px #ff6600">
    <div style="font-size:24px;">
    ABOUT Q-OFFICE
    </div><hr />
<div style=" text-align:justify; ">
 Building a website for your business can be as easy as checking your email! All you have to do is choose a 
 website design and let the world know about your business.
 <br /><br />
 A Q-Office website offers an impressive array of business tools such as:
 <ul>
 <li>
 Personalized Email Accounts
 </li>
 <li>
 News Gallery
 </li>
 <li>
 Product/Service Gallery
 </li>
 <li>
  Project Gallery
 </li>
 <li>
  Media Room
 </li>
 <li>
 Press Room (with bulk SMS and email Notification capabilities)
 </li>
 <li>
 Search Engine Optimization Assistant
 </li>
 </ul>
   and so much more, you can be sure of a world-class business representation.
 </div>
 </div>
</div>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
    
<TQO:ResultNotification ID="Notification" runat="server" />
    </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

