using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using TQO_Classes;

public partial class MasterPage : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //resetting captcha validation
        if (!Page.IsPostBack)
        {
            Session["CaptchaKey"] = null;
        }
        if (Session["UserID"] == null)
            MultiView1.ActiveViewIndex = 0;
        else
            MultiView1.ActiveViewIndex = 1;

        if (Session["UserName"] != null)
        {
            lblUsername.Text = Session["UserName"].ToString();
        }
    }
    protected void btnLogin_Click(object sender, ImageClickEventArgs e)
    { 
        int LoginAttempts = 0;

        if (Session["LoginAttempts"] == null)
        {
            LoginAttempts = 1;
            Session["LoginAttempts"] = LoginAttempts;
        }
        else
        {
            //Increment the Login attempts
            LoginAttempts = int.Parse(Session["LoginAttempts"].ToString()) + 1;
            Session["LoginAttempts"] = LoginAttempts;
        }

        try
        {
            UserBase userBase = new UserBase();
            userBase.Email = txtEmail.Text;
            userBase.Password = txtPassword.Text;

            IUser user = userBase.Login(LoginAttempts);

            if (user != null)
            {
                Session["UserID"] = user.UserID;
                Session["UserName"] = user.FirstName;
                Session["LoginAttempts"] = null;

                if (user.RoleTypeID == 2)
                {
                    //Create Unique Nonce for security when landing back from email box
                    Nonce nonce = new Nonce();
                    nonce.UserID = user.UserID;
                    nonce.NonceID = Guid.NewGuid();
                    nonce.IsUsed = false;
                    nonce.Add();

                    Session.Clear();
                    Session.Abandon();

                    Response.Redirect(TQO_Classes.Utility.DomainList.ClientSiteURL() + 
                                      "/Secured/Default.aspx?UID=" + nonce.UserID.ToString() + "&NID=" + nonce.NonceID.ToString(), false);
                }
                else if (user.RoleTypeID == 3)
                {
                    Response.Redirect("~/Secured/AdminManager.aspx", false);
                }
                else if (user.RoleTypeID == 4)
                {
                    Response.Redirect("~/Secured/SuperAdminManager.aspx", false);
                }
                else if (user.RoleTypeID == 5)
                {
                    Response.Redirect("~/GenericPages/AccessDenied.aspx?ErrorType=IncompleteRegistration", false);
                }
                else
                {
                    Response.Redirect("~/Login.aspx?Error=Login+failed", false);
                }
            }
            else
            {
                Response.Redirect("~/Login.aspx?Error=Login+failed", false);
            }
        }        
        catch(Exception ex)
        {
            if (ex.Message == "Login attempts exceeded.")
            {
                //captcha time
                Random ran = new Random();
                imgCaptcha.ImageUrl = "customcontrols/captchagenerator.aspx?Id=" + ran.Next(1, 9).ToString();
                txtCaptcha.Text = "...repeat text";
                pnlCaptcha.Visible = true;               
            }
            else if (ex.Message == "Applicant cannot Login at this time")
            {
                //account verification incomplete
                Notification.Message = "Login Failed, please Login to your email box and click on the TheQOffice Link";
                Notification.Show();
            }
            else
            {
                Notification.Message = "Could not log you in, please try again!";
                Notification.Show();
            }
        }
    }
    protected void btnLogout_Click(object sender, EventArgs e)
    {
        Session.Clear();
        Session.Abandon();
        Response.Redirect("~/Default.aspx");
    }
    protected void btnAccount_Click(object sender, EventArgs e)
    {
        if(Session["UserID"] != null)
        {
            UserBase user = new UserBase();
            user.UserID = new Guid(Session["UserID"].ToString());
            user.Load();
            user = user.LoadedItem;

            if (user.RoleTypeID == 2)
            {
                //Create Unique Nonce for security when landing back from email box
                Nonce nonce = new Nonce();
                nonce.UserID = user.UserID;
                nonce.NonceID = Guid.NewGuid();
                nonce.IsUsed = false;
                nonce.Add();

                Session.Clear();
                Session.Abandon();

                Response.Redirect(TQO_Classes.Utility.DomainList.ClientSiteURL() +
                                  "/Secured/Default.aspx?UID=" + nonce.UserID.ToString() + "&NID=" + nonce.NonceID.ToString(), false);
            }
            else if (user.RoleTypeID == 3)
            {
                Response.Redirect("~/Secured/AdminManager.aspx", false);
            }
            else if (user.RoleTypeID == 4)
            {
                Response.Redirect("~/Secured/SuperAdminManager.aspx", false);
            }
            else if (user.RoleTypeID == 5)
            {
                Response.Redirect("~/GenericPages/AccessDenied.aspx?ErrorType=IncompleteRegistration&UID=" + user.UserID.ToString(), false);
            }
            else if (user.RoleTypeID == 6)
            {
                Response.Redirect("~/Secured/AdminManager.aspx", false);
            }
            else if (user.RoleTypeID == 7)
            {
                Response.Redirect("~/Secured/AdminManager.aspx", false);
            }
            else
            {
                Response.Redirect("~/Login.aspx?Error=Login+failed", false);
            }
        }
    }
    protected void btnCaptcha_Click(object sender, EventArgs e)
    {
        if (Session["CaptchaKey"] != null)
        {
            if (Session["CaptchaKey"].ToString().ToLower() == txtCaptcha.Text.ToLower())
            {
                Session["LoginAttempts"] = 2;
                pnlCaptcha.Visible = false;
                Notification.Message = "Having login problems? try password recovery";
                Notification.Show();
            }
            else
            {
                lblCaptcha.Text = "VERIFICATION FAILED, PLEASE TRY AGAIN!";
                txtCaptcha.Text = "...repeat text";
                Random ran = new Random();
                imgCaptcha.ImageUrl = "customcontrols/captchagenerator.aspx?Id=" + ran.Next(1, 9).ToString();
            }
        }
    }
}
