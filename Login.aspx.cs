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
using TQO_Classes;

public partial class Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["Error"] != null)
        {
            Notification.Message = "Access denied! please login for access.";
            Notification.Show();
        }
    }
    protected void recBtn_Click(object sender, EventArgs e)
    {
        //captcha time
        Random ran = new Random();
        imgCaptcha.ImageUrl = "customcontrols/captchagenerator.aspx?Id=" + ran.Next(1, 9).ToString();
        txtCaptcha.Text = "...repeat text";
        pnlCaptcha.Visible = true;   

    }
    protected void btnCaptcha_Click(object sender, EventArgs e)
    {
        if (Session["CaptchaKey"] != null)
        {
            if (Session["CaptchaKey"].ToString().ToLower() == txtCaptcha.Text.ToLower())
            {
                UserBase user = new UserBase();
                string result = user.RecoverPassword(txtRecoveryEmail.Text);
                Notification.Message = result;
                Notification.Show();
                pnlCaptcha.Visible = false;
                txtRecoveryEmail.Text = "";
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


