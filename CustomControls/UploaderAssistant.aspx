<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UploaderAssistant.aspx.cs" Inherits="Client_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
<head>
<title>::Upload::</title>
</head>
<body>
<form id="form1" target="_self" runat="server">
    
	<!-- a panel for file upload section -->
	<asp:Panel ID="pnlFileUpload" Visible="false" runat="server">
	
		<asp:FileUpload ID="fileTestUpload" runat="server" />
		<div style="margin-top:5px;">
		<asp:Button ID="btnUpload" Text="Upload" runat="server" OnClick="btnUpload_Click" />
		</div>
	</asp:Panel>


</form>


</body>
</html>
