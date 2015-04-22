<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UploaderAssistantMultiple.aspx.cs" Inherits="CustomControls_UploaderAssistantMultiple" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
 .texts1
{
    font-size:14px;
    color:#666666;
    width:250px;
}
</style>
</head>
<body>
    <form id="form1" target="_self" runat="server" enctype="multipart/form-data">
    
	<!-- a panel for file upload section -->
	<asp:Panel ID="pnlFileUpload" Visible="false" runat="server">
	    <div id="upload-area" style=" border:solid 1px #cccccc;">
	    <center id="upload-area-position">
	       <p id="dynamic0">
               <input id="File1" type="file" runat="server" class="texts1" />
           </p>
           </center>
        </div>
        <p>
            <center>
               <input id="AddFile" type="button" value="Add extra file" onclick="addFileUploadBox()" />
                &nbsp;
               <asp:Button ID="btnUpload" runat="server" onclick="btnUpload_Click" Text="Upload" />
               &nbsp;
               <input id="RemFile" type="button" value="Refresh" onclick="javascript:location.reload(true);" />
           </center>
        </p>
	</asp:Panel>

    
    <script type="text/javascript">
    function addFileUploadBox()
    {
        if (!document.getElementById || !document.createElement)
            return false;
    		
        var uploadArea = document.getElementById ("upload-area-position");
    	
        if (!uploadArea)
            return;
        
        //var newLine = document.createElement ("br");
        //uploadArea.appendChild (newLine);
    	
        var newUploadBox = document.createElement ("input");
    	
        // Set up the new input for file uploads
        newUploadBox.type = "file";
    	
        // The new box needs a name and an ID
        if (!addFileUploadBox.lastAssignedId)
            addFileUploadBox.lastAssignedId = 1;
    	    
        newUploadBox.setAttribute ("id", "dynamix" + addFileUploadBox.lastAssignedId);
        newUploadBox.setAttribute ("name", "dynamix:" + addFileUploadBox.lastAssignedId);
        newUploadBox.setAttribute("class", "texts1");
        
        var dP = document.createElement("p");
    	
    	if (!addFileUploadBox.lastPId)
            addFileUploadBox.lastPId = 1;
            
        dP.setAttribute("id", "dynamic" + addFileUploadBox.lastPId);
        dP.appendChild(newUploadBox);
        
        //var newLine = document.createElement ("br");
        //dP.appendChild (newLine);
        
        uploadArea.appendChild (dP);
        //addFileUploadBox.lastAssignedId++;
        addFileUploadBox.lastPId++;
    }
</script>
</form>
</body>
</html>
