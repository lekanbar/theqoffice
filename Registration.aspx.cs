using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.IO;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using TQO_Classes;
using QOffice.Utility;

public partial class Registration : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["SelectedTemplateName"] == null || Session["SelectedTemplate"] == null)
            Response.Redirect("TemplateSearch.aspx");
        else if (Session["SelectedDomain"] == null)
            Response.Redirect("DomainSearch.aspx");
        else
        {
            lblWebsiteAddress.Text = Session["SelectedDomain"].ToString();
            lblWebsiteDesign.Text = Session["SelectedTemplateName"].ToString();
        }

        //load homepage design
        if (Session["SelectedDesign"] != null)
            lblHomeDesign.Text = Session["SelectedDesignName"].ToString();

        //load website banner
        if (Session["TemplateBannerName"] != null)
            lblWebsiteBanner.Text = Session["TemplateBannerName"].ToString();
    }
    //protected void DDLDuration_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    if (DDLDuration.SelectedIndex == 1 && txtDiscountCode.Text == "")
    //    {
    //        SitePrice price = new SitePrice();
    //        price.Category = "Normal";
    //        price.Load();
    //        price = price.LoadedItem;
    //        lblAmount.Text = price.Price;
    //    }
    //    else if (DDLDuration.SelectedIndex == 1 && txtDiscountCode.Text != "")
    //    {
    //        Marketer marketer = new Marketer();
    //        marketer.Code = txtDiscountCode.Text;
    //        marketer.Load();
    //        marketer = marketer.LoadedItem;

    //        if (marketer != null)
    //        {
    //            SitePrice price = new SitePrice();
    //            price.Category = "Regular";
    //            price.Load();
    //            price = price.LoadedItem;
    //            lblAmount.Text = price.Price;
    //        }
    //        else
    //        {
    //            SitePrice price = new SitePrice();
    //            price.Category = "Normal";
    //            price.Load();
    //            price = price.LoadedItem;
    //            lblAmount.Text = price.Price;

    //            Notification.Message = "The Marketer's code specified is not valid!!. Please go back and try again.";
    //            Notification.Show();
    //            return;
    //        }
    //    }
    //    else if (DDLDuration.SelectedIndex == 2 && txtDiscountCode.Text == "")
    //    {
    //        SitePrice price = new SitePrice();
    //        price.Category = "Regular";
    //        price.Load();
    //        price = price.LoadedItem;
    //        lblAmount.Text = (double.Parse(price.Price) * 2).ToString();
    //    }
    //    else if (DDLDuration.SelectedIndex == 2 && txtDiscountCode.Text != "")
    //    {
    //        Marketer marketer = new Marketer();
    //        marketer.Code = txtDiscountCode.Text;
    //        marketer.Load();
    //        marketer = marketer.LoadedItem;

    //        if (marketer != null)
    //        {
    //            SitePrice price = new SitePrice();
    //            price.Category = "Regular";
    //            price.Load();
    //            price = price.LoadedItem;
    //            lblAmount.Text = (double.Parse(price.Price) * 2).ToString();
    //        }
    //        else
    //        {
    //            SitePrice price = new SitePrice();
    //            price.Category = "Regular";
    //            price.Load();
    //            price = price.LoadedItem;
    //            lblAmount.Text = (double.Parse(price.Price) * 2).ToString();

    //            Notification.Message = "The Marketer's code specified is not valid!!. Please go back and try again.";
    //            Notification.Show();
    //            return;
    //        }
    //    }
    //    else
    //    {
    //        Notification.Message = "You have to select a contract duration.";
    //        Notification.Show();
    //    }
    //}
    //protected void lnkMarketerCode_Click(object sender, EventArgs e)
    //{

    //    if (txtDiscountCode.Text != "")
    //    {
    //        Marketer marketer = new Marketer();
    //        marketer.Code = txtDiscountCode.Text;
    //        marketer.Load();
    //        marketer = marketer.LoadedItem;

    //        if (marketer != null)
    //        {
    //            if (DDLDuration.SelectedIndex == 0)
    //            {
    //                SitePrice price = new SitePrice();
    //                price.Category = "Discounted";
    //                price.Load();
    //                price = price.LoadedItem;
    //                lblAmount.Text = double.Parse(price.Price).ToString();
    //                Notification.Message = "Discount code applied!";
    //                Notification.Show();
    //                return;
    //            }
    //            else if (DDLDuration.SelectedIndex == 1)
    //            {
    //                SitePrice price = new SitePrice();
    //                price.Category = "Discounted";
    //                price.Load();
    //                price = price.LoadedItem;
    //                lblAmount.Text = (double.Parse(price.Price) * 2).ToString();
    //                Notification.Message = "Discount code applied!";
    //                Notification.Show();
    //                return;
    //            }
    //        }
    //        else
    //        {
    //            if (DDLDuration.SelectedIndex == 0)
    //            {
    //                SitePrice price = new SitePrice();
    //                price.Category = "Regular";
    //                price.Load();
    //                price = price.LoadedItem;
    //                lblAmount.Text = double.Parse(price.Price).ToString();
    //                Notification.Message = "Invalid discount code!";
    //                Notification.Show();
    //                return;
    //            }
    //            else if (DDLDuration.SelectedIndex == 1)
    //            {
    //                SitePrice price = new SitePrice();
    //                price.Category = "Regular";
    //                price.Load();
    //                price = price.LoadedItem;
    //                lblAmount.Text = (double.Parse(price.Price) * 2).ToString();
    //                Notification.Message = "Invalid discount code!";
    //                Notification.Show();
    //                return;
    //            }
    //        }
    //    }
    //    else
    //    {
    //        if (DDLDuration.SelectedIndex == 0)
    //        {
    //            SitePrice price = new SitePrice();
    //            price.Category = "Regular";
    //            price.Load();
    //            price = price.LoadedItem;
    //            lblAmount.Text = double.Parse(price.Price).ToString();
    //            Notification.Message = "No dicounts available!";
    //            Notification.Show();
    //            return;
    //        }
    //        else if (DDLDuration.SelectedIndex == 1)
    //        {
    //            SitePrice price = new SitePrice();
    //            price.Category = "Regular";
    //            price.Load();
    //            price = price.LoadedItem;
    //            lblAmount.Text = (double.Parse(price.Price) * 2).ToString();
    //            Notification.Message = "No disounts available!";
    //            Notification.Show();
    //            return;
    //        }

    //    }


    //}
    protected void btnComplete_Click(object sender, EventArgs e)
    {
        string email = txtEmail.Text;
        UserBase uzer = new UserBase();
        uzer.Email = txtEmail.Text;
        uzer.CheckEmail();
        if (uzer.LoadedItem == null)
        {
            Session["FirstName"] = txtFName.Text;
            Session["LastName"] = txtLName.Text;
            Session["Password"] = txtPassword1.Text;
            Session["ConDuration"] = "2";
            Session["MarketCode"] = "";
            Session["Email"] = txtEmail.Text;
            Session["AmountDue"] = "0.0";
            Session["CompanyName"] = txtCompanyName.Text;
            Session["App1"] = ddlGalleryApps.SelectedValue;
            Session["App1Name"] = ddlGalleryApps.SelectedItem.Text;
            Session["App2"] = ddlMediaApps.SelectedValue;
            Session["App2Name"] = ddlMediaApps.SelectedItem.Text;
            
            Response.Redirect("~/Summary.aspx", false);
        }
        else
        {
            Notification.Message = "Your Email address has been already been used!" +
                " \n Please register with another email address";
            Notification.Show();
        }
    }
}
