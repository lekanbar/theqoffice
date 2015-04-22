using System;
using System.Web.UI.WebControls;
using TQO_Classes;
using QOffice.Utility;

public partial class Secured_SuperAdminManager : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Misc.AuthenticateUser())
            Response.Redirect("~/Default.aspx");
        //Session["UserID"] = new Guid("2c614191-cb88-46cb-863e-968981e661c2");

        if (Request.QueryString["vw"] != null)
        {
            if (int.Parse(Request.QueryString["vw"]) == 0)
            {
                mvwAdmin.ActiveViewIndex = 0;
            }
            else if (int.Parse(Request.QueryString["vw"]) == 1)
            {
                grdVwAdminUsers.DataSourceID = SDSGetAdminUsers.ID;
                grdVwAdminUsers.DataBind();
                mvwAdmin.ActiveViewIndex = 1;
            }
            else if (int.Parse(Request.QueryString["vw"]) == 2)
            {
                grdVwClients.DataSourceID = SDSClients.ID;
                grdVwClients.DataBind();
                mvwAdmin.ActiveViewIndex = 2;
            }
            else if (int.Parse(Request.QueryString["vw"]) == 3)
            {
                mvwAdmin.ActiveViewIndex = 3;
            }
            else if (int.Parse(Request.QueryString["vw"]) == 5)
            {
                grdVwMarketers.DataSourceID = SDSMarketers.ID;
                grdVwMarketers.DataBind();
                mvwAdmin.ActiveViewIndex = 5;
            }
            else if (int.Parse(Request.QueryString["vw"]) == 6)
            {
                mvwAdmin.ActiveViewIndex = 6;
            }
            else if (int.Parse(Request.QueryString["vw"]) == 7)
            {
                grdVwMarketerUser.DataSourceID = SDSMarketerUser.ID;
                grdVwMarketerUser.DataBind();
                mvwAdmin.ActiveViewIndex = 7;
            }
            else
            {
                mvwAdmin.ActiveViewIndex = 6;
            }
        }
        else
        {
            mvwAdmin.ActiveViewIndex = 6;
        }
    }
    protected void lnkSitePrice_Click(object sender, EventArgs e)
    {
        mvwAdmin.ActiveViewIndex = 4;
    }
    protected void DDLToDo_SelectedIndexChanged(object sender, EventArgs e)
    {
        Response.Redirect(DDLToDo.SelectedValue);
    }
    protected void btnClear_Click(object sender, EventArgs e)
    {
        txtEmail.Text = "";
        txtFirstName.Text = "";
        txtLastName.Text = "";
        drpUsers.SelectedIndex = 0;
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            UserBase user = new UserBase();
            user.UserID = Guid.NewGuid();
            user.Email = txtEmail.Text;
            user.FirstName = txtFirstName.Text;
            user.LastName = txtLastName.Text;
            user.RoleTypeID = int.Parse(drpUsers.SelectedValue);
            user.IsLockedOut = false;
            user.Password = "welcome";
            user.LastLoginDate = DateTime.Now;

            user.Add();//Create the Admin User

            //Send URL Link to the prospective user
            EmailHelper helper = new EmailHelper();
            helper.From = "yourfriends@theqoffice.com";
            helper.Password = "YourfriendsOlobe";
            helper.To = user.Email;
            helper.Subject = "The Q-Office Registration";
            helper.MessageBody = "Hello " + user.FirstName + ",<br />" +
                                 "<br />Congratulations your account has been created, you can now login with the following details:" +
                                 "<br />Email -- " + user.Email +
                                 "<br />Password -- " + user.Password +
                                 "<br />Please make sure you change your password once you login." +
                                 "<br /><br />Please feel free share your thoughts about The Q-Office by sending an email to yourfriends@theqoffice.com" +
                                 "we would be glad to hear from you." +
                                 "<br /><br />TheQOffice Team";
            helper.Send();

            Notification.Message = "Admin User Created!!";
            Notification.Show();
        }
        catch(Exception ex)
        {
            Notification.Message = ex.Message;
            Notification.Show();
        }
    }
    //protected void grdVwClients_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    UserBase user = new UserBase();
    //    try
    //    {            
    //        user.UserID = new Guid(grdVwClients.DataKeys[0].Value.ToString());
    //        user.Load();
    //        user = user.LoadedItem;
    //    }
    //    catch(Exception ex)
    //    {
    //    }

    //    if (user.RoleTypeID == 1)
    //    {
    //        dvwDetails.DataSourceID = SDSTesterDetails.ID;
    //        dvwDetails.DataBind();
    //    }
    //    else
    //    {
    //        dvwDetails.DataSourceID = SDSTenantDetails.ID;
    //        dvwDetails.DataBind();
    //    }
    //}
    protected void cmdSearch_Click(object sender, EventArgs e)
    {
        grdVwLogs.DataSourceID = SDSLogSearch.ID;
        grdVwLogs.DataBind();
    }
    protected void btnRefresh_Click(object sender, EventArgs e)
    {
        grdVwLogs.DataSourceID = SDSLogs.ID;
        grdVwLogs.DataBind();
    }
    protected void btnSearch2_Click(object sender, EventArgs e)
    {
        grdVwMarketers.DataSourceID = SDSMarketerSearch.ID;
        grdVwMarketers.DataBind();
    }
    protected void btnRefresh2_Click(object sender, EventArgs e)
    {
        grdVwMarketers.DataSourceID = SDSMarketers.ID;
        grdVwMarketers.DataBind();
    }
    protected void btnCreate_Click(object sender, EventArgs e)
    {
        Marketer marketer = new Marketer();
        marketer.MarketerID = Guid.NewGuid();
        marketer.Code = txtCode.Text;
        marketer.Name = txtName.Text;
        marketer.Address = txtAddress.Text;
        marketer.PhoneNumber = txtPhoneNumber.Text;
        marketer.Email = txtEmail2.Text;
        marketer.Add();

        //Send URL Link to the prospective user
        EmailHelper helper = new EmailHelper();
        helper.From = "yourfriends@theqoffice.com";
        helper.Password = "YourfriendsOlobe";
        helper.To = marketer.Email;
        helper.Subject = "The Q-Office Registration";
        helper.MessageBody = "Hello " + marketer.Name + ",<br />" +
                             "Congratulations your account has been created, below is your code" +
                             "<br />Marketer Code: " + marketer.Code +
                             "<br />Please make sure you give your customers this code, so that you can be paid accordingly when they sign up with it." +
                             "<br />Thank you for partnering with us, we look forward to doing great business together." +
                             "<br /><br />Please feel free share your thoughts about The Q-Office by sending an email to yourfriends@theqoffice.com" +
                             "we would be glad to hear from you." +
                             "<br /><br />TheQOffice Team";
        helper.Send();

        Notification.Message = "Marketer created";
        Notification.Show();
    }
    protected void btnSearch3_Click(object sender, EventArgs e)
    {
        grdVwMarketerUser.DataSourceID = SDSMarketerUser.ID;
        grdVwMarketerUser.DataBind();
    }
}
