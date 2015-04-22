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
using System.Collections.Generic;
using TQO_Classes;
using QOffice.Utility;

public partial class _Default : MDetectPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        this.FireEvents();

        if (!Page.IsPostBack)
        {
            //load templates into list view
            TemplateSite template = new TemplateSite();
            template.GetAll();
            List<TemplateSite> templateList = template.TemplateSiteCollection;
            if (template != null)
            {
                LVTemplates.DataSource = templateList;
                LVTemplates.DataBind();
            }
        }
    }
    protected override void OnInit(EventArgs e)
    {
        base.OnInit(e);

        //As a test, let's listen for any WebKit-based device. 
        //OnDetectWebkit += new DetectWebkitHandler(MDetect_OnDetectWebkit);
        OnDetectBlackBerry += new DetectBlackBerryHandler(_Default_OnDetectBlackBerry);
        OnDetectBlackBerryWebkit += new DetectBlackBerryWebkitHandler(_Default_OnDetectBlackBerryWebkit);
        OnDetectAndroid += new DetectAndroidHandler(MDetect_OnDetectAndroid);
        OnDetectS60OssBrowser += new DetectS60OssBrowserHandler(MDetect_OnDetectS60OssBrowser);
        OnDetectSmartphone += new DetectSmartphoneHandler(_Default_OnDetectSmartphone);
        OnDetectSymbianOS += new DetectSymbianOSHandler(_Default_OnDetectSymbianOS);
        OnDetectDetectIPhoneOrIpod += new DetectIPhoneOrIpodHandler(_Default_OnDetectDetectIPhoneOrIpod);
        OnDetectPalmOS += new DetectPalmOSHandler(_Default_OnDetectPalmOS);
        OnDetectPalmWebOS += new DetectPalmWebOSHandler(_Default_OnDetectPalmWebOS);
        OnDetectOperaMobile += new DetectOperaMobileHandler(_Default_OnDetectOperaMobile);
        OnDetectWapWml += new DetectWapWmlHandler(_Default_OnDetectWapWml);
        OnDetectWindowsMobile += new DetectWindowsMobileHandler(_Default_OnDetectWindowsMobile);
        OnDetectBrewDevice += new DetectBrewDeviceHandler(_Default_OnDetectBrewDevice);
    }

    void _Default_OnDetectBrewDevice(object page, MDetectPage.MDetectArgs args)
    {
        Response.Redirect("http://m.theqoffice.com", false);
    }
    void _Default_OnDetectWindowsMobile(object page, MDetectPage.MDetectArgs args)
    {
        Response.Redirect("http://m.theqoffice.com", false);
    }
    void _Default_OnDetectWapWml(object page, MDetectPage.MDetectArgs args)
    {
        Response.Redirect("http://m.theqoffice.com", false);
    }
    void _Default_OnDetectOperaMobile(object page, MDetectPage.MDetectArgs args)
    {
        Response.Redirect("http://m.theqoffice.com", false);
    }
    void _Default_OnDetectPalmWebOS(object page, MDetectPage.MDetectArgs args)
    {
        Response.Redirect("http://m.theqoffice.com", false);
    }
    void _Default_OnDetectPalmOS(object page, MDetectPage.MDetectArgs args)
    {
        Response.Redirect("http://m.theqoffice.com", false);
    }
    void _Default_OnDetectDetectIPhoneOrIpod(object page, MDetectPage.MDetectArgs args)
    {
        Response.Redirect("http://m.theqoffice.com", false);
    }
    void _Default_OnDetectBlackBerryWebkit(object page, MDetectPage.MDetectArgs args)
    {
        Response.Redirect("http://m.theqoffice.com", false);
    }
    void _Default_OnDetectBlackBerry(object page, MDetectPage.MDetectArgs args)
    {
        Response.Redirect("http://m.theqoffice.com", false);
    }
    void _Default_OnDetectSymbianOS(object page, MDetectPage.MDetectArgs args)
    {
        Response.Redirect("http://m.theqoffice.com", false);
    }
    void _Default_OnDetectSmartphone(object page, MDetectPage.MDetectArgs args)
    {
        Response.Redirect("http://m.theqoffice.com", false);
    }
    void MDetect_OnDetectS60OssBrowser(object page, MDetectPage.MDetectArgs args)
    {
        Response.Redirect("http://m.theqoffice.com", false);
    }
    void MDetect_OnDetectWebkit(object page, MDetectPage.MDetectArgs args)
    {
        Response.Redirect("http://m.theqoffice.com", false);
    }
    void MDetect_OnDetectAndroid(object page, MDetectPage.MDetectArgs args)
    {
        Response.Redirect("http://m.theqoffice.com", false);
    }
    protected void SelectTemplate(object sender, ListViewCommandEventArgs e)
    {
        if (e.CommandName == "SelectTemplate")
        {
            string arg = e.CommandArgument.ToString();
            string[] args = arg.Split(new string[] { "**" }, StringSplitOptions.RemoveEmptyEntries);
            Guid TemplateID = new Guid(args[0]);

            Session["SelectedTemplate"] = TemplateID;
            Session["SelectedTemplateName"] = args[1];
            Response.Redirect("TemplateDesign.aspx");
        }
    }
    protected void btnMiniSearch_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Search.aspx?q=" + HttpUtility.HtmlEncode(txtMiniSearch.Text));
    }
}
