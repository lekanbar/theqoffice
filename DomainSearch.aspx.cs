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
        //load website domain
        if (Session["SelectedDomain"] != null)
        {
            lblWebsiteAddress.Text = Session["SelectedDomain"].ToString();
            btnProgress.Enabled = true;
        }

        else
        {
            btnProgress.ToolTip = "Please select a domain";
            btnProgress.Enabled = false;
        }

         //load website template
        if (Session["SelectedTemplate"] == null)
            btnProgress.Text = "PROCEED >> CHOOSE YOUR WEBSITE DESIGN";
        else
        {
            btnProgress.Text = "PROCEED >> REGISTER WEBSITE ACCOUNT";
            lblWebsiteDesign.Text = Session["SelectedTemplateName"].ToString();
        }

        //load homepage design
        if (Session["SelectedDesign"] != null)
        {
            lblHomeDesign.Text = Session["SelectedDesignName"].ToString();
            btnProgress.Enabled = true;
        }

        //load website banner
        if (Session["TemplateBannerName"] != null)
            lblWebsiteBanner.Text = Session["TemplateBannerName"].ToString();

        if (Page.PreviousPage != null)
        {
            txtDomainName = (TextBox)Page.PreviousPage.FindControl("ctl00$ContentPlaceHolder1$txtDomainName");
            //DDLDomain = (DropDownList)Page.PreviousPage.FindControl("ctl00$ContentPlaceHolder1$DDLDomain");

            object obj = new object();
            EventArgs ee = new EventArgs();
            btnSearch_Click(obj, ee);
        }
        
    }

     protected void btnProgress_Click(object sender, EventArgs e)
     {
         if (Session["SelectedTemplate"] == null)
             Response.Redirect("TemplateSearch.aspx");
         else if(Session ["SelectedDesign"] == null)
             Response.Redirect("HomeDesignSearch.aspx"); 
         else if (Session["TemplateBanner"] == null || Session["TemplateColour1"] == null
             || Session["TemplateColour2"] == null || Session["TemplateColour3"] == null)
             Response.Redirect("TemplateDesign.aspx");
         else
             Response.Redirect("Registration.aspx");
                        
     }

     protected void btnSearch_Click(object sender, EventArgs e)
     {
         //DomainSearchResult result = new DomainSearchResult();
         string domain = txtDomainName.Text.ToLower() + ".theqoffice.com" ;
         //bool result = QOffice.Utility.Misc.IsSiteURLAvailable(domain);

         //if (result)
         //{
             lblDomainResult.Text = "Congratulations! " + domain.ToUpper() + " is available";
             Session["SelectedDomain"] = domain;
             lblWebsiteAddress.Text = domain;
             btnProgress.Enabled = true;
             btnProgress.ToolTip = "Click to continue";
         //}

         //else
         //{ 
         //   lblDomainResult.Text = "Sorry, This domain name is already taken";
         //}
         
     }
     protected void GVDomains_RowCommand(object sender, GridViewCommandEventArgs e)
     {
         if (e.CommandName == "Select")
         { 
            string domainName = e.CommandArgument.ToString();
            Result.Message =  domainName + " will be registered after registration is completed, \n please scroll down to continue";
            Result.Show(); 
            Session["SelectedDomain"] = domainName;
         }

     }
     protected void GVDomains_RowCreated(object sender, GridViewRowEventArgs e)
     {
         
     }
}


