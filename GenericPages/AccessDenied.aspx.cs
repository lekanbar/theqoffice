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
using TQO_Classes;
using QOffice.Utility;

public partial class GenericPages_AccessDenied : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["ErrorType"] != null)
            if (Request.QueryString["ErrorType"] == "IncompleteRegistration" && Request.QueryString["UID"] != null)
            {
                Session["UserID"] = Request.QueryString["UID"];
                UserBase user = new UserBase();
                user.UserID = new Guid(Session["UserID"].ToString());
                user.Load();
                if (user.LoadedItem != null)
                    Session["UserName"] = user.LoadedItem.FirstName;
                
                lblSorry.Text = "You have not completed a valid registration" ;
                pnlIncompleteRegistration.Visible = true;
            }
    }
    protected void btnResendEmail_Click(object sender, EventArgs e)
    {
        UserBase user = new UserBase();
        user.UserID = new Guid(Session["UserID"].ToString());
        user.Load();
        user = user.LoadedItem;

        //Create Unique Nonce for security when landing back from email box
        Nonce nonce = new Nonce();
        nonce.UserID = user.UserID;
        nonce.NonceID = Guid.NewGuid();
        nonce.IsUsed = false;
        nonce.Add();

        //Send URL Link to the prospective user
        EmailHelper helper = new EmailHelper();
        helper.From = "registration@theqoffice.com";
        helper.To = user.Email;
        helper.Subject = "TheQOffice.com Registration Completion";
        helper.MessageBody = "Hello " + user.FirstName + ",<br />" +
                             "You are almost there, please click on the link below to complete your registration<br />" +
                             TQO_Classes.Utility.DomainList.ClientSiteURL() + "/Secured/CompleteRegistration.aspx?UID=" + user.UserID.ToString() + "&VerID=" + nonce.NonceID.ToString() +
                             "<br /><br />Thank you for your patronage, we look forward to working with you all the way." +
                             "<br />Your Friends,<br />TheQOffice Team";
        string response = helper.Send();

        if (response.Equals("Sent"))
        {
            Session["Announce"] = "You are almost done........Just a few more steps!!";
            Session["RegStatus"] = "Email sent: Login to your email box, to complete your registration.";
            Response.Redirect("~/Finally.aspx");
        }
        else
        {
            Session["Announce"] = "We are sorry.......an unexpected just occurred.";
            Session["RegStatus"] = "Email sending failed, please contact our technical team for assistance.";
            Response.Redirect("~/Finally.aspx");
        }
    }
    protected void btnEmailSub_Click(object sender, EventArgs e)
    {
        UserBase user = new UserBase();
        user.UserID = new Guid(Session["UserID"].ToString());
        user.Load();
        user = user.LoadedItem;
        user.Email = txtEmailSub.Text;
        user.Update2();

        //Get the user's unused nonce
        Nonce nonce = new Nonce();
        nonce.UserID = user.UserID;
        nonce.GetApplicantsNonce();
        nonce = nonce.LoadedItem;

        //Send URL Link to the prospective user
        EmailHelper helper = new EmailHelper();
        helper.From = "registration@theqoffice.com";
        helper.To = user.Email;
        helper.Subject = "TheQOffice.com Registration Completion";
        helper.MessageBody = "Hello " + user.FirstName + ",<br />" +
                             "You are almost there, please click on the link below to complete your registration<br />" +
                             TQO_Classes.Utility.DomainList.ClientSiteURL() + "/Secured/CompleteRegistration.aspx?UID=" + user.UserID.ToString() + "&VerID=" + nonce.NonceID.ToString() +
                             "<br /><br />Thank you for your patronage, we look forward to working with you all the way." +
                             "<br />Your Friends,<br />TheQOffice Team";
        string response = helper.Send();

        if (response.Equals("Sent"))
        {
            Session["Announce"] = "You are almost done........Just a few more steps!!";
            Session["RegStatus"] = "Email sent: Login to the new email you just specified, to complete your registration.";
            Response.Redirect("~/Finally.aspx");
        }
        else
        {
            Session["Announce"] = "We are sorry.......an unexpected just occurred.";
            Session["RegStatus"] = "Email sending failed, please contact our technical team for assistance.";
            Response.Redirect("~/Finally.aspx");
        }
    }
}
