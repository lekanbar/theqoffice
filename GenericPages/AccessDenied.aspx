<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="AccessDenied.aspx.cs"
 Inherits="GenericPages_AccessDenied"  Title="The Q-Office -> XX" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<script language="javascript">
	$(document).ready( function() {
		$("#<%= txtEmailSub.ClientID %>").watermark("NEW EMAIL ADDRESS");
	});
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

 <div class="NormalContentTitle">
 ACCESS DENIED
 </div>
  
 <div  id="NormalContent">
  <div  class="NormalContentLeft">
RECURRING PROBLEM?
<br /><br />

<div style="color:#000000;  "> 
Even the Q-Office experience might come with challenges but we're dedicated 
to ensuring that they're eliminated for that super-smooth service that you deserve
 <br /><br />
 We're always doing our best and looking for new ways to improve. Have any ideas? Please send us an email at
 support@theqoffice.com and we'd be glad to hear from you.
</div>
<br />
  </div>
  
  <div class="NormalContentRight" >
  <div style="font-size:24px;">
We're sorry
<hr />
</div>

Due to security constraints, you are not allowed to view the requested resource.
<br /><br />
Why?
<br />
<asp:Label ID="lblSorry" runat="server" CssClass="ErrorText" ></asp:Label>
<br /><br />
Here's what you can do:
<br />

<asp:Panel ID="pnlIncompleteRegistration" runat="server" Visible="false" >
<div class="ErrorText">
    <asp:UpdatePanel ID="UpdatePanelIncompleteRegistration" runat="server">
        <ContentTemplate>
            
            Please check your email address for an account verfication email we forwarded to you on registration.
            If you cannot see the verification email in your inbox, please check your spam
            folder. 
            <p>
            If you still haven't received any such email, or you have previously tried completing your registration unsuccessfully,
            please click 
            <asp:LinkButton ID="btnResendEmail" runat="server" Text="here" 
                onclick="btnResendEmail_Click"></asp:LinkButton>
                &nbsp;to resend to the registered email address,
            </p>
            else,
            <br />
            Please give us an email address to complete the registration process. We would forward another confirmation email 
            (it could be the email address you registered with or a replacement )
            <br />
            <table class="right">
            <tr>
                <td>
                    <asp:TextBox ID="txtEmailSub" runat="server"  ></asp:TextBox>
                    <asp:RequiredFieldValidator ID="req1" runat="server"  ErrorMessage="*"
                     ControlToValidate="txtEmailSub" ValidationGroup="Sub1"></asp:RequiredFieldValidator>
                </td>
                <td>
                    <asp:Button ID="btnEmailSub" runat="server" Text="CONTINUE"
                     ValidationGroup="Sub1" onclick="btnEmailSub_Click" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                        ControlToValidate="txtEmailSub" ErrorMessage="Invalid email" 
                        ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" 
                        ValidationGroup="Sub1"></asp:RegularExpressionValidator>
                </td>
            </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</div>
</asp:Panel>

</div>

</div>
</asp:Content>

