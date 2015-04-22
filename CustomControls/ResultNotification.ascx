<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ResultNotification.ascx.cs" Inherits="CustomControls_ResultNotification" %>


<style type="text/css">

.Notification
{
    position:fixed;
    top:5px;
    left:5px;
    z-index:5;
    width:300px;
    font-size:16px;
}

</style>
<asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UPNotification">
<ProgressTemplate>
</ProgressTemplate>
</asp:UpdateProgress>
    <asp:UpdatePanel ID="UPNotification" runat="server">
    <ContentTemplate>
    
    <asp:Panel ID="pnlNotification" runat="server" CssClass="Notification" Visible="false" >
       
      <div style="background-color:White;  width:98%; float:right; padding:1%;    border:solid 1px black;">
        <div style="direction:rtl; width:96%; background-color:black; color:White; padding:2%;">
        
        <asp:ImageButton ID="btnNotificationCancel" runat="server" ImageAlign="Left"  
                ImageUrl="~/images/btnCautionCancel.jpg" style="height: 16px" 
                onclick="btnNotificationCancel_Click" />
       NOTICE
       </div>    
        <asp:Label ID="lblNotification" runat="server" ></asp:Label>
      </div>
   
    </asp:Panel>
    
    </ContentTemplate>
    </asp:UpdatePanel>