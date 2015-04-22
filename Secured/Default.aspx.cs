using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using TQO_Classes;
using QOffice.Utility;

public partial class Secured_Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Misc.AuthenticateUser())
            Response.Redirect("~/Default.aspx");

        //resetting captcha validation
        if (!Page.IsPostBack)
        {
            Session["CaptchaKey"] = null;
        }
    }
    protected void recBtn_Click(object sender, EventArgs e)
    {
        //captcha time
        Random ran = new Random();
        imgCaptcha.ImageUrl = "customcontrols/captchagenerator.aspx?Id=" + ran.Next(1, 9).ToString();
        txtCaptcha.Text = "...repeat text";
        pnlCaptcha.Visible = true;
        btnCaptcha.CommandName = "Recovery";
    }

    protected void btnLogin_Click(object sender, EventArgs e)
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

                if (user.RoleTypeID == 3)
                {
                    Response.Redirect("~/Secured/AdminManager.aspx", false);
                }
                else if (user.RoleTypeID == 4)
                {
                    Response.Redirect("~/Secured/SuperAdminManager.aspx", false);
                }
                else
                {
                    Response.Redirect("~/Login.aspx?Error=Login+failed", false);
                }
            }
        }
        catch (Exception ex)
        {
            if (ex.Message == "Login attempts exceeded.")
            {
                //captcha time
                Random ran = new Random();
                imgCaptcha.ImageUrl = "customcontrols/captchagenerator.aspx?Id=" + ran.Next(1, 9).ToString();
                txtCaptcha.Text = "...repeat text";
                pnlCaptcha.Visible = true;
                btnCaptcha.CommandName = "Login";
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
    protected void btnCaptcha_Click(object sender, EventArgs e)
    {
        if (Session["CaptchaKey"] != null)
        {
            if (Session["CaptchaKey"].ToString().ToLower() == txtCaptcha.Text.ToLower())
            {
                if (btnCaptcha.CommandName == "Login")
                {
                    Session["LoginAttempts"] = 2;
                    pnlCaptcha.Visible = false;
                    Notification.Message = "Having login problems? try password recovery";
                    Notification.Show();
                }
                else if (btnCaptcha.CommandName == "Recovery")
                {
                    UserBase user = new UserBase();
                    string result = user.RecoverPassword(txtRecoveryEmail.Text);
                    Notification.Message = result;
                    Notification.Show();
                    pnlCaptcha.Visible = false;
                }
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
