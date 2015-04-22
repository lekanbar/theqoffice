<%@ Page Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" 
Inherits="Secured_Default"  Title="The Q-Office -> Admin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div style=" width:700px;">
<div class="PageTitle">
ADMIN LOGIN
</div>
<br />
<div class="PageDescription">
    Please enter the following details to access your account:
</div>

    <div>
    <center>
    <br />
    <table width="320px;">
        <tr>
            <td>
            EMAIL:
            </td>
        </tr>
            <tr>
            <td>
            <asp:TextBox ID="txtEmail" runat="server" CssClass="texts1"></asp:TextBox>
                     <asp:RequiredFieldValidator ID="req1" runat="server"                      
                        ErrorMessage="*" ControlToValidate="txtEmail"  Display="Dynamic"
                         ValidationGroup="grpLogin"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
            PASSWORD:
            </td>
        </tr>
        <tr>
            <td>
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="texts1"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="req2" runat="server" 
                        ErrorMessage="*" ControlToValidate="txtPassword" Display="Dynamic"
                         ValidationGroup="grpLogin"></asp:RequiredFieldValidator>
            </td>
        </tr>
    </table>
    <br />
                      <asp:Button ID="Button1" runat="server" Text="PLEASE LOGIN"  Width="300px"
                        CssClass="greenSideBarButton" ValidationGroup="grpLogin" 
                        onclick="btnLogin_Click" />
    </center>
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
    
       <br />
       <hr />
       <br />
<div class="PageTitle">
PASSWORD RECOVERY
</div>
<br />
<div class="PageDescription">
    Please enter your email address below to reset your password.
    </div>
    <br /><br />
<center>
    <table>
        <tr>
            <td>
            EMAIL:
            </td>
        </tr>
        <tr>
            <td>
                <asp:TextBox ID="txtRecoveryEmail" runat="server" CssClass="texts1"></asp:TextBox>            
            </td>
        </tr>
    </table>
      <asp:RequiredFieldValidator ID="recRq1" runat="server" ErrorMessage="enter an email address"  ValidationGroup="grpRecovery"
       ControlToValidate="txtRecoveryEmail" Display="Dynamic" >
      </asp:RequiredFieldValidator>
      <asp:RegularExpressionValidator
          ID="recRg1" runat="server" ErrorMessage="invalid email"   Display="Dynamic" 
        ValidationGroup="grpRecovery" ControlToValidate="txtRecoveryEmail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator><br />
      <asp:Button ID="recBtn" runat="server" Text="RECOVER PASSWORD" Width="300px" 
        CssClass="greenSideBarButton" ValidationGroup="grpRecovery" 
        onclick="recBtn_Click" />
<br />
  </center>
</div>
    
                    <asp:UpdatePanel ID="UpdatePanelNotification" runat="server" >
                        <ContentTemplate>
    <TQO:ResultNotification ID="Notification" runat="server"  />
                        </ContentTemplate>
                    </asp:UpdatePanel>
<br /><br />
</asp:Content>

