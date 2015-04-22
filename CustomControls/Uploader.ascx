<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Uploader.ascx.cs" Inherits="CustomControls_Uploader" %>
<%@ Register Src="~/CustomControls/ResultNotification.ascx" TagName="ResultNotification" TagPrefix="TQO" %>
<script language="javascript">
function iFrame_OnUploadComplete() { 
    document.getElementById('<%= btnUploaded.ClientID %>').click();
}
function iFrame_OnResetComplete() { 
    document.getElementById('<%= btnRefresh.ClientID %>').click();
}
</script>
<!-- an iframe that loads the same page, but just displays file upload panel (pnlFileUpload) -->
<asp:Panel ID="pnlIFrame" runat="server">
        <asp:UpdatePanel ID="UpdatePanelUploadedImage" runat="server">
        <ContentTemplate>
            <asp:Panel ID="pnlImage" runat="server" Visible="false">
            <center style="margin-top:5px;">
                <asp:Image ID="imgUploadedImage" runat="server" Width="80px" Height="70px" ImageUrl="images/noimage.jpg" />
            
            </center>
            </asp:Panel>
        </ContentTemplate>
        </asp:UpdatePanel>
            
        

        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
        <asp:Panel ID="pnlC1" runat="server">
	    <iframe src="<%= TQO_Classes.Utility.DomainList.ClientSiteURL() %>/CustomControls/UploaderAssistant.aspx?MODE=IFRAME" style=" height:80px;" frameborder="0">
		    Your browser does not support iframes
	    </iframe>
	    </asp:Panel>
	    
        <asp:Panel ID="pnlFileUploadDetails" Visible="false" runat="server">
            <center>
                A file has been uploaded
                <br />
                size: <asp:Label ID="lblSize" runat="server" ForeColor="Maroon" ></asp:Label>
                ||
                type: <asp:Label ID="lblType" runat="server" ForeColor="Maroon" ></asp:Label>
            <br />
		    <asp:Button ID="Button1" Text="Delete File" runat="server"
		    OnClientClick= '<%# "if(confirm(\"Delete File and Upload again?\")==false){event.returnValue=false;return false;}else{return true;}" %>'                
            OnClick="btnReset_Click" />
            </center>
            
        </asp:Panel>
        </ContentTemplate>
        </asp:UpdatePanel>
    
</asp:Panel>

<asp:Panel ID="pnlIFrameMultiple" runat="server" Visible="false">  
 
	    
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
        <asp:Panel ID="pnlC2" runat="server">         
	    <iframe src="<%= TQO_Classes.Utility.DomainList.ClientSiteURL() %>/CustomControls/UploaderAssistantMultiple.aspx?MODE=IFRAME" style=" height:auto; overflow:visible;" frameborder="0">
		    Your browser does not support iframes
	    </iframe>
	    </asp:Panel>
	    
        <asp:Panel ID="pnlFileUploadDetails2" Visible="false" runat="server">
        <center>
            All files have been uploaded
        <br />
		<asp:Button ID="btnReset" Text="Delete All Files" runat="server"
		OnClientClick= '<%# "if(confirm(\"Delete All files and Upload again?\")==false){event.returnValue=false;return false;}else{return true;}" %>'                
        OnClick="btnReset2_Click" />
        </center>
        
        </asp:Panel>
        </ContentTemplate>
        </asp:UpdatePanel>

</asp:Panel>
	
<asp:UpdatePanel ID="pnlAjax" runat="server">
	
	<ContentTemplate>	
			
		<!-- a button that raises its click event after file upload in iframe is complete -->
		<asp:Button ID="btnUploaded" style="display:none;" UseSubmitBehavior="false" runat="server" OnClick="btnUploaded_Click" />		
			
		<!-- a button that raises its click event after file upload refresh in iframe is complete -->
		<asp:Button ID="btnRefresh" style="display:none;" UseSubmitBehavior="false" runat="server" OnClick="btnRefresh_Click" />		
			
	</ContentTemplate>
		
	<Triggers>
		<asp:AsyncPostBackTrigger ControlID="btnUploaded" EventName="Click" />
	</Triggers>
	
</asp:UpdatePanel>
