using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.IO;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using TQO_Classes;
using QOffice.Utility;

public partial class Summary : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["SelectedTemplateName"] == null || Session["SelectedTemplate"] == null)
            Response.Redirect("TemplateSearch.aspx");
        else if (Session["SelectedDomain"] == null)
            Response.Redirect("DomainSearch.aspx");
        else if (Session["Email"] == null)
            Response.Redirect("Registration.aspx");
        else if (Session["SelectedDesign"] == null)
            Response.Redirect("HomeDesignSearch.aspx");
        else
        {
            lblFirstName.Text = Session["FirstName"].ToString();
            lblLastName.Text = Session["LastName"].ToString();
            lblCompanyName.Text = Session["CompanyName"].ToString();
            lblConDuration.Text = Session["ConDuration"].ToString();
            lblEmail.Text = Session["Email"].ToString();
            lblDomainName.Text = Session["SelectedDomain"].ToString();
            lblTemplateName.Text = Session["SelectedTemplateName"].ToString();
            lblAmount.Text = Session["AmountDue"].ToString();
            lblBanner.Text = Session["TemplateBannerName"].ToString();
            lblHomeDesign.Text = Session["SelectedDesignName"].ToString();
            lblGalleryApp.Text = Session["App1Name"].ToString();
            lblMediaApp.Text = Session["App2Name"].ToString();
            lblEmailAccounts.Text = "0";
            lblSMSBalance.Text = "0";
            Panel1.BackColor = System.Drawing.ColorTranslator.FromHtml(Session["TemplateColour1"].ToString());
            Panel2.BackColor = System.Drawing.ColorTranslator.FromHtml(Session["TemplateColour2"].ToString());
            Panel3.BackColor = System.Drawing.ColorTranslator.FromHtml(Session["TemplateColour3"].ToString());
        }
    }
    protected void btnConfirm_Click(object sender, EventArgs e)
    {
        try
        {
            if (rbtnAgree.Checked)
            {
                //Create and Store User information in DB
                UserBase user = new UserBase();
                user.UserID = Guid.NewGuid();
                user.RoleTypeID = 5;
                user.FirstName = Session["FirstName"].ToString();
                user.LastName = Session["LastName"].ToString();
                user.Email = Session["Email"].ToString();
                user.Password = Session["Password"].ToString();
                user.LastLoginDate = DateTime.Now;
                user.IsLockedOut = true;
                user.Add();

                //Create User as a Tenant
                UserTenant tenant = new UserTenant();
                tenant.TenantID = Guid.NewGuid();
                tenant.UserID = user.UserID;
                tenant.SiteURL = Session["SelectedDomain"].ToString();
                tenant.TemplateSiteID = new Guid(Session["SelectedTemplate"].ToString());
                tenant.SetupDate = DateTime.Now;
                tenant.EmailAccounts = 0;
                tenant.CompanyName = Session["CompanyName"].ToString();
                tenant.CompanyEmail = "";
                tenant.SMSBalance = 0;

                if (Session["ConDuration"].ToString() == "1")
                    tenant.ExpiryDate = DateTime.Now.AddYears(1);
                else
                    tenant.ExpiryDate = DateTime.Now.AddYears(2);

                tenant.BannerID = new Guid(Session["TemplateBanner"].ToString());
                tenant.HomeDesignID = new Guid(Session["SelectedDesign"].ToString());
                tenant.PrimaryColor = Session["TemplateColour1"].ToString();
                tenant.SecondaryColor = Session["TemplateColour2"].ToString();
                tenant.AuxiliaryColor = Session["TemplateColour3"].ToString();
                tenant.Add();
                tenant.Load();


                //Renumerate Marketer, if User is using the Discount code
                if (Session["MarketCode"].ToString() != "")
                {
                    Marketer marketer = new Marketer();
                    marketer.Code = Session["MarketCode"].ToString();
                    marketer.Load();
                    marketer = marketer.LoadedItem;
                    marketer.UserID = tenant.UserID;
                    marketer.DateRegistered = DateTime.Now;
                    marketer.Amount = Session["AmountDue"].ToString();
                    marketer.CommissionPaid = false;
                    marketer.TransactionType = "Website and Domain Registration";
                    marketer.AddUserToMarketer();

                    //Update the Number of customers the marketer has sold to.
                    marketer.NoOfCustomers = marketer.NoOfCustomers + 1;
                    marketer.Update();
                }

                //Register Applicant's 2 Apps
                //App1
                AppRegister register = new AppRegister();
                register.AppID = int.Parse(Session["App1"].ToString());
                register.UserID = tenant.UserID;
                register.Add();

                //App2
                register.AppID = int.Parse(Session["App2"].ToString());
                register.Add();

                //Notify the appropiate admin user to carry out domain registration
                AdminJobs job = new AdminJobs();
                job.AdminID = AdminRoles.GetRegistrar();
                job.ClientID = tenant.UserID;
                job.Category = 1;
                job.Status = false;
                job.Description = "Register Domain: " + tenant.SiteURL + "//" + Session["ConDuration"].ToString() + " Year(s)";
                job.Add();

                //Notify the appropiate admin user to generate the user's access code
                AdminJobs job3 = new AdminJobs();
                job3.ClientID = tenant.UserID;
                job3.AdminID = job.AdminID;
                job3.Category = 1;
                job3.Status = false;
                job3.Description = "Generate Access code for " + Session["Email"].ToString();
                job3.Add();

                //Send URL Link to the prospective user
                EmailHelper helper = new EmailHelper();
                helper.From = "yourfriends@theqoffice.com";
                helper.Password = "YourfriendsOlobe";
                helper.To = Session["Email"].ToString();
                helper.Subject = "TheQOffice.com Registration Completion";
                helper.MessageBody = "Hello " + user.FirstName + ",<br />" +
                                     "An Access Key will be sent to you once your payment is confirmed.<br />" +
                                     "<br /><br />Thank you for your patronage, we look forward to working with you all the way." +
                                     "<br /><br /> Please feel free share your thoughts about The Q-Office by sending an email to yourfriends@theqoffice.com" +
                                     " we would be glad to hear from you." +
                                     "<br /><br />Bankole and Lekan,<br /> The Q-Office Team Executives";
                string response = helper.Send();

                if (response.Equals("Sent"))
                {
                    //Get the admin user that will handle this domain registration
                    UserBase admin = new UserBase();
                    admin.UserID = job.AdminID;
                    admin.Load();
                    admin = admin.LoadedItem;

                    EmailHelper helper2 = new EmailHelper();
                    helper2.From = "mail@theqoffice.com";
                    helper2.To = admin.Email;
                    helper2.Password = "MailOlobe";
                    helper2.Subject = "Domain Registration";
                    helper2.MessageBody = "Create Domain Name: " + tenant.SiteURL +
                                         "<br />Create Sub-Domain: mobile." + tenant.SiteURL +
                                         "<br />Tenant Name: " + user.FirstName + " " + user.LastName +
                                         "<br />Tenant Email: " + user.Email +
                                         "<br />Date Submitted: " + tenant.SetupDate.ToString() +
                                         "<br />Contract Duration: " + Session["ConDuration"].ToString() + " Year(s)" +
                                         "<br /><br />Regards,<br />The team is counting on you!!";
                    helper2.Send();

                    //Get the admin user that will handle access code generation for this user
                    EmailHelper helper3 = new EmailHelper();
                    helper3.From = "mail@theqoffice.com";
                    helper3.To = admin.Email;
                    helper3.Password = "MailOlobe";
                    helper3.Subject = "Generate Access Code";
                    helper3.MessageBody = "Generate the Access code for this user once and ONLY when the payment is confirmed." +
                                         "<br />Tenant Name: " + user.FirstName + " " + user.LastName +
                                         "<br />Tenant Email: " + user.Email +
                                         "<br />Tenant ID: " + tenant.UserID.ToString() +
                                         "<br />Date Submitted: " + DateTime.Now.ToString() +
                                         "<br /><br />Regards,<br />The team is counting on you!!";
                    helper3.Send();

                    Session["Announce"] = "You are almost done........Just a few more steps!!";
                    Session["RegStatus"] = "Email sent: Login to your email box, to complete your registration.";
                    Response.Redirect("~/Finally.aspx", false);
                }
                else
                {
                    Session["Announce"] = response;
                    Session["RegStatus"] = "Email sending failed, please contact our technical team for assistance.";
                    Response.Redirect("~/Finally.aspx", false);
                }
            }
            else
            {
                Notification.Message = "You have to agree to the Terms and Conditions before you can proceed.";
                Notification.Show();
            }
        }
        catch (Exception ex)
        {
            Session["Announce"] = "An unexpected error just occurred";
            Session["RegStatus"] = "Email sending failed, please contact our technical team for assistance.";
            Response.Redirect("~/Finally.aspx", false);
        }
    }
    protected void lnkBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("Registration.aspx");
    }
}
