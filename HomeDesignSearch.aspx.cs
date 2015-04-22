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
            //load designs into list view

            HomeDesign design = new HomeDesign();
            design.GetAll();

            List<HomeDesign> designList = design.DesignCollection;
            if (designList.Count > 0)
            {
                LVTemplates.DataSource = designList;
                LVTemplates.DataBind();
            }
        }

        if (Session["SelectedDesign"] != null)
        {
            lblHomeDesign.Text = Session["SelectedDesignName"].ToString(); 
            btnProgress.Enabled = true;
        }
        else
            btnProgress.Enabled = false;

        //load website domain
        if (Session["SelectedDomain"] != null)
            lblWebsiteAddress.Text = Session["SelectedDomain"].ToString();

        //load website design theme
        if (Session["SelectedTemplate"] != null)
             lblWebsiteDesign.Text = Session["SelectedTemplateName"].ToString();

        //load website banner
        if (Session["TemplateBannerName"] != null)
            lblWebsiteBanner.Text = Session["TemplateBannerName"].ToString();
    }


    protected void btnProgress_Click(object sender, EventArgs e)
    {
        if (Session["SelectedTemplate"] == null)
            Response.Redirect("TemplateSearch.aspx");
        else if (Session["TemplateBanner"] == null || Session["TemplateColour1"] == null
            || Session["TemplateColour2"] == null || Session["TemplateColour3"] == null)
            Response.Redirect("TemplateDesign.aspx");
        else if (Session["SelectedDomain"] == null)
            Response.Redirect("DomainSearch.aspx");
        else
            Response.Redirect("Registration.aspx");
    }
    protected void SelectTemplate(object sender, ListViewCommandEventArgs e)
    {
        if (e.CommandName == "SelectDesign")
        {
            string arg = e.CommandArgument.ToString();
            string[] args = arg.Split(new string[] { "**" }, StringSplitOptions.RemoveEmptyEntries);
            Guid DesignID = new Guid(args[0]);
            Result.Message = args[1] + " template selected! please scroll below to continue";
            Result.Show();
            Session["SelectedDesign"] = DesignID;
            Session["SelectedDesignName"] = args[1];
            lblHomeDesign.Text = args[1];
            btnProgress.Enabled = true;
        }
    }
    protected void LVTemplates_PagePropertiesChanged(object sender, EventArgs e)
    { //load templates into list view

        HomeDesign design = new HomeDesign();
        design.GetAll();

        List<HomeDesign> designList = design.DesignCollection;
        if (designList.Count > 0)
        {
            LVTemplates.DataSource = designList;
            LVTemplates.DataBind();
        }
    }
}