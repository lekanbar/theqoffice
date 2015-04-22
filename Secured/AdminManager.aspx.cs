using System;
using System.Web.UI.WebControls;
using TQO_Classes;
using QOffice.Utility;

public partial class Secured_AdminManager : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //Guid UserID = new Guid("9edc562d-1c5a-45d1-8ddc-6c5ae0dde7bf");//handler.GetUserIDFromDomainName();//
        //Session["UserID"] = UserID;
        if (!Misc.AuthenticateUser())
            Response.Redirect("~/Default.aspx");

        grdVwClients.DataBind();
        mvwAdmin.ActiveViewIndex = 1;
    }
    protected void grdVwClients_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session["TenantID2"] = new Guid(grdVwClients.SelectedDataKey[0].ToString());

        Notification.Message = "User selected!!";
        Notification.Show();
    }
    protected void lnkSuccess_Click(object sender, EventArgs e)
    {
        SwitchTransaction tranx = new SwitchTransaction();
        tranx.StatusType = 1;
        tranx.GetAllTransactionsByStatus();

        GVTranx.DataSource = tranx.TransactionCollection;
        GVTranx.DataBind();

        mvwAdmin.ActiveViewIndex = 5;
    }
    protected void lnkUnSuccess_Click(object sender, EventArgs e)
    {
        SwitchTransaction tranx = new SwitchTransaction();
        tranx.StatusType = 2;
        tranx.GetAllTransactionsByStatus();

        GVTranx.DataSource = tranx.TransactionCollection;
        GVTranx.DataBind();

        mvwAdmin.ActiveViewIndex = 5;
    }
    protected void lnkPending_Click(object sender, EventArgs e)
    {
        SwitchTransaction tranx = new SwitchTransaction();
        tranx.StatusType = 0;
        tranx.GetAllTransactionsByStatus();

        GVTranx.DataSource = tranx.TransactionCollection;
        GVTranx.DataBind();

        mvwAdmin.ActiveViewIndex = 5;
    }
    protected void lnkViewClients_Click(object sender, EventArgs e)
    {
        grdVwClients.DataBind();
        mvwAdmin.ActiveViewIndex = 1;
    }
    protected void lnkChangePass_Click(object sender, EventArgs e)
    {
        mvwAdmin.ActiveViewIndex = 3;
    }
    protected void lnkRegister_Click(object sender, EventArgs e)
    {
        grdVwJobs.DataBind();
        mvwAdmin.ActiveViewIndex = 0;
    }
    protected void lnkTransactions_Click(object sender, EventArgs e)
    {
        SwitchTransaction tranxs = new SwitchTransaction();
        tranxs.GetAll();

        GVTranx.DataSource = tranxs.TransactionCollection;
        GVTranx.DataBind();

        mvwAdmin.ActiveViewIndex = 5;
    }
    protected void lnkClientSMS_Click(object sender, EventArgs e)
    {
        txtAmount.Text = "";
        txtQuery.Text = "";
        mvwAdmin.ActiveViewIndex = 2;
    }
    protected void lnkClientEmail_Click(object sender, EventArgs e)
    {
        mvwAdmin.ActiveViewIndex = 4;
    }
    protected void btnCredit_Click(object sender, EventArgs e)
    {
        if (Session["TenantID"] != null)
        {
            UserTenant tenant = new UserTenant();
            tenant.UserID = new Guid(Session["TenantID"].ToString());
            tenant.Load();
            tenant = tenant.LoadedItem;

            //Credit User with Amount specified
            tenant.SMSBalance = int.Parse(txtAmount.Text) + tenant.SMSBalance;
            tenant.Update();

            //Send URL Link to the prospective user
            EmailHelper helper = new EmailHelper();
            helper.From = "support@theqoffice.com";
            helper.Password = "SupportOlobe";
            helper.To = tenant.Email;
            helper.Subject = "The Q-Office Bulk SMS ";
            helper.MessageBody = "Hello " + tenant.FirstName + ",<br />" +
                                 "Your account has just been credited with " + txtAmount.Text + " units of SMS.<br />You can begin to send your SMS messages." +
                                 "<br /><br />Thank you for your patronage, we look forward to working with you all the way." +
                                 "<br /><br /> Please feel free share your thoughts about The Q-Office by sending an email to yourfriends@theqoffice.com" +
                                 " we would be glad to hear from you." +
                                 "<br /><br />TheQOffice Team";
            string response = helper.Send();

            grdVwUser.DataBind();
            txtAmount.Text = "";

            if (response.Equals("Sent"))
            {
                Session["TenantID"] = null;

                Notification.Message = "User credited and notification sent.";
                Notification.Show();
            }
            else
            {
                Session["TenantID"] = null;

                Notification.Message = "User credited and notification not sent.";
                Notification.Show();
            }
        }
        else
        {
            Notification.Message = "No user selected.";
            Notification.Show();
        }
    }
    protected void grdVwUser_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session["TenantID"] = new Guid(grdVwUser.SelectedDataKey[0].ToString());
        lblAmount.Visible = true;
        txtAmount.Visible = true;
        btnCredit.Visible = true;
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        grdVwUser.DataSourceID = SDSSearch.ID;
        grdVwUser.DataBind();
    }
    protected void btnRefresh_Click(object sender, EventArgs e)
    {
        grdVwUser.DataSourceID = SDSBulkSMS.ID;
        grdVwUser.DataBind();
    }
    protected void btnSearch2_Click(object sender, EventArgs e)
    {
        grdVwClients.DataSourceID = SDSSearch0.ID;
        grdVwClients.DataBind();
    }
    protected void btnRefresh2_Click(object sender, EventArgs e)
    {
        grdVwClients.DataSourceID = SDSClients.ID;
        grdVwClients.DataBind();
    }
    protected void btnOk_Click(object sender, EventArgs e)
    {
        UserBase user = new UserBase();
        user.UserID = new Guid(Session["UserID"].ToString());
        user.Load();
        user = user.LoadedItem;

        user.Password = txtNewPassword.Text;
        user.Update();

        Notification.Message = "Password changed successfully!!";
        Notification.Show();       
    }
    protected void lnkGenerateAccess_Click(object sender, EventArgs e)
    {
        if (Session["TenantID2"] != null)
        {
            UserBase user = new UserBase();
            user.UserID = new Guid(Session["TenantID2"].ToString());
            user.Load();
            user = user.LoadedItem;

            AccessCode access = new AccessCode();
            access.UserID = user.UserID;
            try
            {                
                access.Code = Guid.NewGuid().ToString().Substring(0, 8);
                access.IsUsed = false;
                access.Add();
            }
            catch
            {
                access.GetApplicantsAccessCode();
                access = access.LoadedItem;
            }

            //Create Unique Nonce for security when landing back from email box
            Nonce nonce = new Nonce();
            nonce.UserID = user.UserID;
            nonce.NonceID = Guid.NewGuid();
            nonce.IsUsed = false;
            nonce.Add();

            //Send URL Link to the prospective user
            EmailHelper helper = new EmailHelper();
            helper.From = "support@theqoffice.com";
            helper.Password = "SupportOlobe";
            helper.To = user.Email;
            helper.Subject = "The Q-Office.com Registration Completion";
            helper.MessageBody = "Hello " + user.FirstName + ",<br />" +
                                 "You are almost there, your access key is " + access.Code + "<br /><br />Please click on the link below to complete your registration." +
                                 "<br />" + TQO_Classes.Utility.DomainList.ClientSiteURL() + "/Secured/CompleteRegistration.aspx?UID=" + user.UserID.ToString() + "&VerID=" + nonce.NonceID.ToString() +
                                 "<br /><br />Thank you for your patronage, we look forward to working with you all the way." +
                                 "<br /><br /> Please feel free share your thoughts about The Q-Office by sending an email to yourfriends@theqoffice.com" +
                                 " we would be glad to hear from you." +
                                 "<br /><br />The Q-Office Team";
            helper.Send();

            Session["TenantID2"] = null;

            Notification.Message = "Access code generated and sent to the user.";
            Notification.Show();
        }
        else
        {
            Notification.Message = "No  user selected. Select a user first";
            Notification.Show();
        }
    }
    protected void btnDeleteEmail_Click(object sender, EventArgs e)
    {
        try
        {
            Emails email = new Emails();
            email.Email = txtOpEmail2.Text;
            email.LoadByEmail();
            email = email.LoadedItem;
            email.AdminDelete();

            Notification.Message = "Client email deleted";
            Notification.Show();
        }
        catch
        {
            Notification.Message = "Client email already deleted";
            Notification.Show();
        }
    }
    protected void btnSetStatus_Click(object sender, EventArgs e)
    {
        Emails email = new Emails();
        email.Email = txtOpEmail.Text;
        email.LoadByEmail();
        email = email.LoadedItem;

        email.Status = "Active";
        email.Update();

        UserTenant user = new UserTenant();
        user.UserID = email.UserID;
        user.Load();
        user = user.LoadedItem;

        //Notify the prospective user
        EmailHelper helper = new EmailHelper();
        helper.From = "support@theqoffice.com";
        helper.Password = "SupportOlobe";
        helper.To = user.Email;
        helper.Subject = "The Q-Office Email Created";
        helper.MessageBody = "Hello " + user.FirstName + ", the email you created is now active and ready, the following are the credentials." +
                             "<br />Email: " + email.Email +
                             "<br />Password: " + email.Password + 
                             "<br />You can now login at http://email.secureserver.net" + 
                             "<br /><br />N.B. Please make sure you change your password as soon as you login." + 
                             "<br /><br />Thank you,<br />The Q-Office Team";
        helper.Send();

        Notification.Message = "Client email activated";
        Notification.Show();
    }
    protected void grdVwJobs_SelectedIndexChanged(object sender, EventArgs e)
    {
        int ID = int.Parse(grdVwJobs.SelectedDataKey["ID"].ToString());

        AdminJobs job = new AdminJobs();
        job.ID = ID;
        job.LoadByID();
        job = job.LoadedItem;

        job.Status = (job.Status ? false : true);
        job.Update();

        grdVwJobs.DataBind();

        Notification.Message = "Job has been marked as " + (job.Status ? "done" : "undone");
        Notification.Show();
    }
    protected void GVTranx_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Select")
        {
            string TransactionID = e.CommandArgument.ToString();

            Response.Redirect("QueryTransaction.aspx?TranxID=" + TransactionID);
        }

    }
    protected void lnkLockUser_Click(object sender, EventArgs e)
    {
        if (Session["TenantID2"] != null)
        {
            UserBase user = new UserBase();
            user.UserID = new Guid(Session["TenantID2"].ToString());
            user.LockUser();

            Session["TenantID2"] = null;

            grdVwClients.DataBind();

            Notification.Message = "User Successfully Locked!!";
            Notification.Show();
        }
        else
        {
            Notification.Message = "No  user selected. Select a user first";
            Notification.Show();
        }
    }
    protected void lnkUnlockUser_Click(object sender, EventArgs e)
    {
        if (Session["TenantID2"] != null)
        {
            UserBase user = new UserBase();
            user.UserID = new Guid(Session["TenantID2"].ToString());
            user.UnlockUser();

            Session["TenantID2"] = null;

            grdVwClients.DataBind();

            Notification.Message = "User Successfully Unlocked!!";
            Notification.Show();
        }
        else
        {
            Notification.Message = "No  user selected. Select a user first";
            Notification.Show();
        }
    }
    protected void GVTranx_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GVTranx.PageIndex = e.NewPageIndex;
        SwitchTransaction tranxs = new SwitchTransaction();
        tranxs.GetAll();

        GVTranx.DataSource = tranxs.TransactionCollection;
        GVTranx.DataBind();

        mvwAdmin.ActiveViewIndex = 5;
    }
    protected void grdVwJobs_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grdVwJobs.PageIndex = e.NewPageIndex;
        grdVwJobs.DataBind();
        mvwAdmin.ActiveViewIndex = 0;
    }
}
