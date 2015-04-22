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
        if (Session["SelectedTemplate"] == null)
            Response.Redirect("TemplateSearch.aspx");
        else if (Session["SelectedDesign"] == null)
            Response.Redirect("HomeDesignSearch.aspx");
        else
        {
            lblWebsiteDesign.Text = Session["SelectedTemplateName"].ToString();
            lblHomeDesign.Text = Session["SelectedDesignName"].ToString();
        }

        //load website domain
        if (Session["SelectedDomain"] != null)
            lblWebsiteAddress.Text = Session["SelectedDomain"].ToString();

        if (!Page.IsPostBack)
        {
            //recommend default colours if none are selected
            if (Session["TemplateColour1"] == null)
            {
                Session["TemplateColour1"] = "#2F4F4F";
                Session["TemplateColour1Name"] = "Dark Slate Gray";
            }
            if (Session["TemplateColour2"] == null)
            {
                Session["TemplateColour2"] = "#FFA500";
                Session["TemplateColour2Name"] = "Orange";
            }
            if (Session["TemplateColour3"] == null)
            {
                Session["TemplateColour3"] = "#87CEFA";
                Session["TemplateColour3Name"] = "Light Sky Blue";
            }

            //load all colors into listview
            Colour colour = new Colour();
            colour.GetAllColours();
            List<Colour> colourList = colour.ColourCollection;
            if (colourList != null)
            {
                LVColours.DataSource = colourList;
                LVColours.DataBind();
            }

            BindBannerList();


            //load DDL categories
            
        }

        if (Session["TemplateBannerName"] != null)
            lblBannerChoice.Text = Session["TemplateBannerName"].ToString();


            //load colors into color panels

        if (Session["TemplateColour1"] != null)
        {
            pnlColour1.BackColor = System.Drawing.ColorTranslator.FromHtml(Session["TemplateColour1"].ToString());
            lblColour1.Text = Session["TemplateColour1Name"].ToString();
        }
        if (Session["TemplateColour2"] != null)
        {
            pnlColour2.BackColor = System.Drawing.ColorTranslator.FromHtml(Session["TemplateColour2"].ToString());
            lblColour2.Text = Session["TemplateColour2Name"].ToString();
        }
        if (Session["TemplateColour3"] != null)
        {
            pnlColour3.BackColor = System.Drawing.ColorTranslator.FromHtml(Session["TemplateColour3"].ToString());
            lblColour3.Text = Session["TemplateColour3Name"].ToString();
        }


        TestConfig();

        //access control based on registration progress achieved
        //if (Session["SelectedDomain"] == null)
        //    Response.Redirect("DomainSearch.aspx");
        //if (Session["SelectedTemplate"] == null)
        //    Response.Redirect("TEmplateSearch.aspx"); 


    }

    protected void btnProgress_Click(object sender, EventArgs e)
    {
        if (Session["SelectedDomain"] == null)
            Response.Redirect("DomainSearch.aspx");
        else
            Response.Redirect("Registration.aspx");

    }

    private void TestConfig()
    {
        if (Session["TemplateColour1"] != null && Session["TemplateColour2"] != null && Session["TemplateColour3"] != null
            && Session["SelectedDesign"] != null && Session["TemplateBannerName"] != null)
        {
            imgTestRun.NavigateUrl =
          TQO_Classes.Utility.DomainList.ClientSiteURL() + "/Templates/" + Session["SelectedTemplateName"].ToString()
           + "/" + "Preview.aspx?MODE=TestRun&BID=" + Session["TemplateBannerName"].ToString()
           + "&C1=" + HttpUtility.UrlEncode(Session["TemplateColour1"].ToString())
           + "&C2=" + HttpUtility.UrlEncode(Session["TemplateColour2"].ToString())
           + "&C3=" + HttpUtility.UrlEncode(Session["TemplateColour3"].ToString())
           + "&DID=" + HttpUtility.UrlEncode(Session["SelectedDesign"].ToString());
            imgTestRun.Enabled = true;
        }
        else
        {
            imgTestRun.Enabled = false;
        }
    }


    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("TemplateSearch.aspx");
    }

    protected void SelectColour(object sender, ListViewCommandEventArgs e)
    {
        
        if (e.CommandName == "_SelectColour")
        {
            string arg = e.CommandArgument.ToString();
            string[] args = arg.Split(new string[] { "**" }, StringSplitOptions.RemoveEmptyEntries);
            if (Session["currentButton"] != null)
            {
                string btn = Session["currentButton"].ToString();
                switch (btn)
                {
                    case "1":
                        Session["TemplateColour1"] = args[1];
                        Session["TemplateColour1Name"] = args[0];
                        pnlColour1.BackColor = System.Drawing.ColorTranslator.FromHtml(args[1]);
                        lblColour1.Text = args[0];
                        break;
                    case "2":
                        Session["TemplateColour2"] = args[1];
                        Session["TemplateColour2Name"] = args[0];
                        pnlColour2.BackColor = System.Drawing.ColorTranslator.FromHtml(args[1]);
                        lblColour2.Text = args[0];
                        break;
                    case "3":
                        Session["TemplateColour3"] = args[1];
                        Session["TemplateColour3Name"] = args[0];
                        pnlColour3.BackColor = System.Drawing.ColorTranslator.FromHtml(args[1]);
                        lblColour3.Text = args[0];
                        break;
                    default:
                        break;
                }
                UpdatePanel2.Update();
                //Result.Message = args[0] + " colour selected!";
                //Result.Show();
            }
        }
        pnlColours.Visible = false;
        BindBannerList();
        UpdatePanelBanners.Update();
        TestConfig();
    }
    protected void SelectBanner(object sender, ListViewCommandEventArgs e)
    {
        
            if (e.CommandName == "_SelectBanner")
            {
                string arg = e.CommandArgument.ToString();
                string[] args = arg.Split(new string[] { "**" }, StringSplitOptions.RemoveEmptyEntries);

                Session["TemplateBanner"] = args[0];
                Session["TemplateBannerName"] = args[1];
                Result.Message = args[1] + " banner selected!";
                Result.Show();
                BindBannerList();
                imgTestRun.NavigateUrl =
              TQO_Classes.Utility.DomainList.ClientSiteURL() + "/Templates/" + Session["SelectedTemplateName"].ToString()
               + "/" + "Preview.aspx?MODE=TestRun&BID=" + Session["TemplateBannerName"].ToString()
               + "&C1=" + HttpUtility.UrlEncode(Session["TemplateColour1"].ToString())
               + "&C2=" + HttpUtility.UrlEncode(Session["TemplateColour2"].ToString())
               + "&C3=" + HttpUtility.UrlEncode(Session["TemplateColour3"].ToString())
               + "&DID=" + HttpUtility.UrlEncode(Session["SelectedDesign"].ToString());
                imgTestRun.Enabled = true;
                lblBannerChoice.Text = Session["TemplateBannerName"].ToString().ToLower() + " banner selected";
            }
            TestConfig();
    }
    protected void LVColours_PagePropertiesChanged(object sender, EventArgs e)
    { //load templates into list view
        Colour colour = new Colour();
        colour.GetAllColours();
        List<Colour> colourList = colour.ColourCollection;
        if (colourList != null)
        {
            LVColours.DataSource = colourList;
            LVColours.DataBind();
        }
    }
    protected void LVBanners_PagePropertiesChanged(object sender, EventArgs e)
    {
        BindBannerList();
    }
    protected void btnColour1_Click(object sender, EventArgs e)
    {
        Session["currentButton"] = "1";        
        pnlColours.Visible = true;
    }
    protected void btnColour2_Click(object sender, EventArgs e)
    {
        Session["currentButton"] = "2";
        pnlColours.Visible = true;
    }
    protected void btnColour3_Click(object sender, EventArgs e)
    {
        Session["currentButton"] = "3";
        pnlColours.Visible = true;
    }
    protected void btnCloseColourPanel_Click(object sender, ImageClickEventArgs e)
    {
        pnlColours.Visible = false;
    }

    private void BindBannerList()
    {
        //load templates into list view
        Banner banner = new Banner();
        banner.GetAllBanners();
        List<Banner> bannerList = banner.BannerCollection;
        if (bannerList != null)
        {
            LVBanners.DataSource = bannerList;
            LVBanners.DataBind();
        }
    }
    protected void DDLCategories_SelectedIndexChanged(object sender, EventArgs e)
    {
        int index = DDLCategories.SelectedIndex + 1;
        if (index == 22)
            BindBannerList();
        else
        {
            Banner banner = new Banner();
            banner.CategoryID= index;
            banner.GetBannersByCategory();

            List<Banner> bannerList = banner.BannerCollection;
            if (bannerList != null)
            {
                LVBanners.DataSource = bannerList;
                LVBanners.DataBind();
            }
        }
    }
}


