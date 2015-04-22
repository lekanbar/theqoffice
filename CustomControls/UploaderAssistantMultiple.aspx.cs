using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;

public partial class CustomControls_UploaderAssistantMultiple : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        GenerateUploadForm();
    }

    private void GenerateUploadForm()
    {
        // if querystring parameter "MODE" is set to "IFRAME" 
        // then just display file upload panel (pnlFileUpload) and hide everything else
        String mode = Request.QueryString["MODE"];

        if (mode != "IFRAME") return;

        pnlFileUpload.Visible = true;

        if (!IsPostBack) Session["UploadedFiles"] = null;
    }

    protected void btnUpload_Click(Object sender, System.EventArgs e)
    {
        HttpFileCollection hfc = Request.Files;

        // when upload button is clicked, save the filename to the session
        if (hfc.Count == 0) return;

        Session["UploadedFiles"] = hfc;
        // the following code triggers upload completion event in client side
        ClientScript.RegisterStartupScript(Page.GetType(), "Upload Completed", "window.parent.iFrame_OnUploadComplete();", true);
    }

}
