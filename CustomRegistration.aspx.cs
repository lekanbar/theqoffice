using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Text;
using System.Net.Sockets;
using TQO_Classes;
using QOffice.Utility;

public partial class CustomRegistration : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //Session["SelectedDomain"] = "testing.com";
    }
    protected void btnComplete_Click(object sender, EventArgs e)
    {
        if (Session["SelectedDomain"] == null)
        {
            Notification.Message = "Please search for your domain name first, before you proceed.";
            Notification.Show();
        }
        else
        {
            UserBase uzer = new UserBase();
            uzer.Email = txtEmail.Text;
            uzer.CheckEmail();
            if (uzer.LoadedItem == null)
            {
                if (rbtnAgree.Checked)
                {
                    if (txtDiscountCode.Text.ToLower().Equals("tqoswitch"))
                    {
                        Session["CustID"] = "51202a35-679e-4522-92c5-41ef3470e2d8";
                        Session["AmountDue"] = "55000.00";
                        Session["TranxDesc"] = "The Q-Office Website [Custom]";
                        Session["TranxID"] = RandomDigits.Get();

                        SwitchTransaction transaction = new SwitchTransaction();
                        transaction.TransactionID = Session["TranxID"].ToString();
                        transaction.Name = "Vanessa O";
                        transaction.Amount = Session["AmountDue"].ToString();
                        transaction.Date = DateTime.Now;
                        transaction.Email = "VOkwuegbunam@interswitchng.com";//txtEmail.Text;//"ephasemail@gmail.com";//
                        transaction.ItemDescription = Session["TranxDesc"].ToString();
                        transaction.Status = "Pending: Transaction is pending.";
                        transaction.UserID = new Guid(Session["CustID"].ToString());
                        transaction.StatusType = 0;
                        transaction.ResponseCode = "--";
                        transaction.Add();

                        Response.Redirect("~/Payment.aspx", false);
                    }
                    else
                    {
                        //Create and Store User information in DB
                        UserBase user = new UserBase();
                        user.UserID = Guid.NewGuid();
                        user.RoleTypeID = 5;
                        user.FirstName = txtFName.Text;
                        user.LastName = txtLName.Text;
                        user.Email = txtEmail.Text;
                        user.Password = txtPassword1.Text;
                        user.LastLoginDate = DateTime.Now;
                        user.IsLockedOut = true;
                        user.Add();

                        //Add Custom Template to DB
                        TemplateSite template = new TemplateSite();
                        template.SiteID = Guid.NewGuid();
                        template.SiteName = Session["SelectedDomain"].ToString();
                        template.SiteDescription = "Custom Business template";
                        template.IsPrivate = true;
                        template.Add();

                        //Add Cutom Banner to DB
                        Banner banner = new Banner();
                        banner.BannerID = Guid.NewGuid();
                        banner.BannerName = Session["SelectedDomain"].ToString();
                        banner.BannerURL = "banner.jpg";
                        banner.CategoryID = 23;
                        banner.IsPrivate = true;
                        banner.Add();

                        //Add Custom Home Design
                        HomeDesign homie = new HomeDesign();
                        homie.DesignID = Guid.NewGuid();
                        homie.Title = Session["SelectedDomain"].ToString();
                        homie.IsPrivate = true;
                        homie.Add();

                        //Create User as a Tenant
                        UserTenant tenant = new UserTenant();
                        tenant.TenantID = Guid.NewGuid();
                        tenant.UserID = user.UserID;
                        tenant.SiteURL = Session["SelectedDomain"].ToString();
                        tenant.PhoneNumber = txtPhoneNumber.Text;
                        tenant.TemplateSiteID = template.SiteID;
                        tenant.BannerID = banner.BannerID;
                        tenant.HomeDesignID = homie.DesignID;
                        tenant.SetupDate = DateTime.Now;
                        tenant.EmailAccounts = 5;
                        tenant.CompanyName = txtCompanyName.Text;
                        tenant.CompanyEmail = txtCompanyEmail.Text + lblDomain.Text;
                        tenant.SMSBalance = 400;

                        if (DDLDuration.SelectedValue == "1")
                            tenant.ExpiryDate = DateTime.Now.AddYears(1);
                        else
                            tenant.ExpiryDate = DateTime.Now.AddYears(2);

                        tenant.Add();
                        tenant.Load();

                        //Create a record of the Custom Template
                        CustomTemplates custom = new CustomTemplates();
                        custom.SiteID = template.SiteID;
                        custom.BannerID = banner.BannerID;
                        custom.UserID = tenant.UserID;
                        custom.Add();

                        //Renumerate Marketer, if User is using the Discount code
                        if (!string.IsNullOrEmpty(txtDiscountCode.Text))
                        {
                            Marketer marketer = new Marketer();
                            marketer.Code = txtDiscountCode.Text;
                            marketer.Load();
                            marketer = marketer.LoadedItem;
                            marketer.UserID = tenant.UserID;
                            marketer.DateRegistered = DateTime.Now;
                            marketer.Amount = lblAmount.Text;
                            marketer.CommissionPaid = false;
                            marketer.TransactionType = "Website and Domain Registration";
                            marketer.AddUserToMarketer();

                            //Update the Number of customers the marketer has sold to.
                            marketer.NoOfCustomers = marketer.NoOfCustomers + 1;
                            marketer.Update();
                        }

                        //Create User's Default Apps
                        AppRegister defApps = new AppRegister();
                        defApps.UserID = tenant.UserID;
                        defApps.AddDefaultApps();

                        //Register chosen Applications for user
                        string AppsAppliedFor = "";
                        foreach (ListItem Item in ChkLstAppGallery.Items)
                        {
                            if (Item.Selected)
                            {
                                if (Item.Value.Equals("10"))
                                {
                                    Testimonials testimonial = new Testimonials();
                                    testimonial.UserID = tenant.UserID;
                                    testimonial.CustomerName = "Sample";
                                    testimonial.Details = "Ut lectus porttitor ultrices mattis mattis";
                                    testimonial.DateModified = DateTime.Now;
                                    testimonial.IsApproved = true;
                                    testimonial.Add();
                                }
                                else
                                {
                                    AppRegister register = new AppRegister();
                                    register.AppID = int.Parse(Item.Value);
                                    register.UserID = tenant.UserID;
                                    register.Add();
                                }

                                AppsAppliedFor += Item.Text + ", ";
                            }
                        }

                        //Notify the appropiate admin user to carry out domain registration
                        AdminJobs job = new AdminJobs();
                        job.AdminID = AdminRoles.GetRegistrar();
                        job.ClientID = tenant.UserID;
                        job.Category = 1;
                        job.Status = false;
                        job.Description = "Register Domain: " + tenant.SiteURL + "//" + DDLDuration.SelectedValue + " Year(s)";
                        job.Add();

                        //Create the email and set the status
                        Emails email = new Emails();
                        email.UserID = tenant.UserID;
                        email.Email = txtCompanyEmail.Text + lblDomain.Text;
                        email.Password = Guid.NewGuid().ToString().Substring(0, 8);
                        email.Add();

                        //Notify the appropiate admin user to generate the user's access code
                        AdminJobs job3 = new AdminJobs();
                        job3.ClientID = tenant.UserID;
                        job3.AdminID = job.AdminID;
                        job3.Category = 1;
                        job3.Status = false;
                        job3.Description = "Generate Access code for " + txtEmail.Text;
                        job3.Add();

                        //Send URL Link to the prospective user
                        EmailHelper helper = new EmailHelper();
                        helper.From = "yourfriends@theqoffice.com";
                        helper.Password = "YourfriendsOlobe";
                        helper.To = txtEmail.Text;
                        helper.Subject = "TheQOffice.com Registration Completion";
                        helper.MessageBody = "Hello " + user.FirstName + ",<br />" +
                                             "Thanks for completing the first stage of registration, we have started the custom account process." +
                                             "<br /><br />Here's how it works:" +
                                             "<br />- Payment confirmation." +
                                             "<br />- You will be contacted by a member of our development team to setup an appointment " +
                                             "to discuss the design, functionality and personality of your website." +
                                             " Appointments are usually by online chat or phone call." +
                                             "<br />- You would be required to send us an email containing your logo, company profile and" +
                                             " other relevant pictures." +
                                             "<br />- We would usually invest seven working days designing your custom website from your" +
                                             " specifications and resources you provide on the Q-Office engine." +
                                             " This stage is usually executed with your cooperation via email." +
                                             "<br />- On completion, you would be sent an email containing an access key and a website link" +
                                             " for the final stage of registration and first-time access to the admin panel." +
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
                            helper2.Subject = "Domain Registration [Custom]";
                            helper2.MessageBody = "Create Domain Name: " + tenant.SiteURL +
                                                 "<br />Create Sub-Domain: mobile." + tenant.SiteURL +
                                                 "<br />Tenant Name: " + user.FirstName + " " + user.LastName +
                                                 "<br />Tenant Email: " + user.Email +
                                                 "<br />Tenant Phone Number: " + tenant.PhoneNumber +
                                                 "<br />Date Submitted: " + tenant.SetupDate.ToString() +
                                                 "<br />Contract Duration: " + DDLDuration.SelectedValue + " Year(s)" +
                                                 "<br /><br />Website Description: " + txtWebDesc.Text +
                                                 "<br /><br />Apps Applied For: " + AppsAppliedFor +
                                                 "<br /><br />Regards,<br />The team is counting on you!!";
                            helper2.Send();

                            //Get the admin user that will handle access code generation for this user
                            EmailHelper helper3 = new EmailHelper();
                            helper3.From = "mail@theqoffice.com";
                            helper3.To = admin.Email;
                            helper3.Password = "MailOlobe";
                            helper3.Subject = "Generate Access Code [Custom]";
                            helper3.MessageBody = "Generate the Access code for this user once and ONLY when the payment is confirmed." +
                                                  "<br /><br />Tenant Name: " + user.FirstName + " " + user.LastName +
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
                }
                else
                {
                    Notification.Message = "You have to agree to the Terms and Conditions before you can proceed.";
                    Notification.Show();
                }
            }
            else
            {
                Notification.Message = "Your Email address has been already been used!" +
                 " \n Please register with another email address";
                Notification.Show();
            }
        }
    }
    protected void lnkMarketerCode_Click(object sender, EventArgs e)
    {
        if (txtDiscountCode.Text != "")
        {
            Marketer marketer = new Marketer();
            marketer.Code = txtDiscountCode.Text;
            marketer.Load();
            marketer = marketer.LoadedItem;

            if (marketer != null)
            {
                if (DDLDuration.SelectedIndex == 0)
                {
                    SitePrice price = new SitePrice();
                    price.Category = "Discounted";
                    price.Load();
                    price = price.LoadedItem;
                    lblAmount.Text = (double.Parse(price.Price) + 20000).ToString();
                    Notification.Message = "Discount code applied!";
                    Notification.Show();
                    return;
                }
                else if (DDLDuration.SelectedIndex == 1)
                {
                    SitePrice price = new SitePrice();
                    price.Category = "Discounted";
                    price.Load();
                    price = price.LoadedItem;
                    lblAmount.Text = ((double.Parse(price.Price) * 2) + 20000).ToString();
                    Notification.Message = "Discount code applied!";
                    Notification.Show();
                    return;
                }
            }
            else
            {
                if (DDLDuration.SelectedIndex == 0)
                {
                    SitePrice price = new SitePrice();
                    price.Category = "Regular";
                    price.Load();
                    price = price.LoadedItem;
                    lblAmount.Text = (double.Parse(price.Price) + 20000).ToString();
                    Notification.Message = "Invalid discount code!";
                    Notification.Show();
                    return;
                }
                else if (DDLDuration.SelectedIndex == 1)
                {
                    SitePrice price = new SitePrice();
                    price.Category = "Regular";
                    price.Load();
                    price = price.LoadedItem;
                    lblAmount.Text = ((double.Parse(price.Price) * 2) + 20000).ToString();
                    Notification.Message = "Invalid discount code!";
                    Notification.Show();
                    return;
                }
            }
        }
        else
        {
            if (DDLDuration.SelectedIndex == 0)
            {
                SitePrice price = new SitePrice();
                price.Category = "Regular";
                price.Load();
                price = price.LoadedItem;
                lblAmount.Text = (double.Parse(price.Price) + 20000).ToString();
                Notification.Message = "No dicounts available!";
                Notification.Show();
                return;
            }
            else if (DDLDuration.SelectedIndex == 1)
            {
                SitePrice price = new SitePrice();
                price.Category = "Regular";
                price.Load();
                price = price.LoadedItem;
                lblAmount.Text = ((double.Parse(price.Price) * 2) + 20000).ToString();
                Notification.Message = "No disounts available!";
                Notification.Show();
                return;
            }

        }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        //DomainSearchResult result = new DomainSearchResult();
        string domain = txtDomainName.Text + DDLDomain.SelectedValue;
        //result.Domain = domain;
        //result.GetResults();
        bool b = isAvailable(domain, "");

        if (b)
        {
            lblDomainResult.Text = "Sorry, This domain name is already taken";
            Session["SelectedDomain"] = null;
        }
        else
        {
            lblDomainResult.Text = "Congratulations! " + domain.ToUpper() + " is available";
            Session["SelectedDomain"] = domain;
            lblDomain.Text = "@" + domain;
        }
    }
    protected void GVDomains_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Select")
        {
            string domainName = e.CommandArgument.ToString();
            Notification.Message = domainName + " will be registered after registration is completed, \n please scroll down to continue registration";
            Notification.Show();
            Session["SelectedDomain"] = domainName;
            lblDomain.Text = "@" + domainName;
        }
    }

    /// <summary>
    /// Check whether a given domain name is available or not
    /// </summary>
    /// <param name="domainname">daomain name to be verified</param>
    /// <param name="whois_server_address">use null value (that is "") or "whois.internic.net" if you dont know any whois servers</param>
    /// <returns></returns>
    private bool isAvailable(string domainname, string whois_server_address)
    {
        List<string> ws = lookup(domainname, whois_server_address);
        return ws[0].Contains("No match for domain \"" + domainname.ToUpper() + "\".");
    }

    private List<string> lookup(string domainname, string whois_server_address)
    {
        //if (whois_server_address == "")
        //    whois_server_address = "whois.internic.net";
        //TcpClient tcp = new TcpClient();
        //tcp.Connect(whois_server_address, 43);
        //string strDomain = "domain " + domainname + "\r\n";
        //byte[] bytDomain = Encoding.ASCII.GetBytes(strDomain.ToCharArray());
        //Stream s = tcp.GetStream();
        //s.Write(bytDomain, 0, strDomain.Length);
        //StreamReader sr = new StreamReader(tcp.GetStream(), Encoding.ASCII);
        //string strLine = "";
        List<string> result = new List<string>();
        result.Add("Success");
        //while (null != (strLine = sr.ReadLine()))
        //{
        //    result.Add(strLine);
        //}
        //tcp.Close();
        return result;
    }
}
