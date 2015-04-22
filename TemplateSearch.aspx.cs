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

public partial class Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
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

        if (Session["SelectedTemplate"] != null)
        {
            lblWebsiteDesign.Text = Session["SelectedTemplateName"].ToString();
            btnProgress.Enabled = true;
        }
        else
            btnProgress.Enabled = false;

        //load website domain
        if (Session["SelectedDomain"] != null)
            lblWebsiteAddress.Text = Session["SelectedDomain"].ToString();

        //load homepage design
        if (Session["SelectedDesign"] != null)
        {
            lblHomeDesign.Text = Session["SelectedDesignName"].ToString();
            btnProgress.Enabled = true;
        }


        //load website banner
        if (Session["TemplateBannerName"] != null)
            lblWebsiteBanner.Text = Session["TemplateBannerName"].ToString();

    }


    protected void btnProgress_Click(object sender, EventArgs e)
    {
        if (Session["SelectedDesign"] == null)
            Response.Redirect("HomeDesignSearch.aspx");
        else if (Session["TemplateBanner"] == null || Session["TemplateColour1"] == null
            || Session["TemplateColour2"] == null || Session["TemplateColour3"] == null)
            Response.Redirect("TemplateDesign.aspx");
        else if (Session["SelectedDomain"] == null)
            Response.Redirect("HomeDesignSearch.aspx");
        else
            Response.Redirect("Registration.aspx");
    }
    protected void SelectTemplate(object sender, ListViewCommandEventArgs e)
    {
        if (e.CommandName == "SelectTemplate")
        {
            string arg = e.CommandArgument.ToString();
            string[] args = arg.Split(new string[] { "**" }, StringSplitOptions.RemoveEmptyEntries);
            Guid TemplateID = new Guid(args[0]);
            Result.Message = args[1] + " template selected! please scroll below to continue";
            Result.Show();
            Session["SelectedTemplate"] = TemplateID;
            Session["SelectedTemplateName"] = args[1];
            lblWebsiteDesign.Text = args[1];
            btnProgress.Enabled = true;
        }
    }
    protected void LVTemplates_PagePropertiesChanged(object sender, EventArgs e)
    { //load templates into list view
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