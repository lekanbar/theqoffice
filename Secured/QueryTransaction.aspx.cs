using System;
using System.Net;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Drawing;
using System.Collections.Specialized;
using com.interswitchng.testwebpay;
using TQO_Classes;
using QOffice.Utility;

public partial class Secured_QueryTransaction : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            string TransactionID = Request.QueryString["TranxID"];

            //Load Transaction from DB
            SwitchTransaction transaction = new SwitchTransaction();
            transaction.TransactionID = TransactionID;
            transaction.Load();
            transaction = transaction.LoadedItem;

            //Set Values from DB
            lblTranxID.Text = TransactionID;
            lblName.Text = transaction.Name;
            lblEmail.Text = transaction.Email;
            lblItem.Text = transaction.ItemDescription;
            lblPrevStatus.Text = transaction.Status;
            lblAmount.Text = transaction.Amount;
            lblDate.Text = transaction.Date.ToString();

            //Declare variables...
            string resp;
            string respDesc = "";
            string respCode = "";
            string respAmt = "";
            NameValueCollection webPayFeedback = new NameValueCollection();

            //WebPAY Service Call...
            webpay wp = new webpay();

            //This section works for those that use proxy. 
            //I get mine from the config file.
            //System.Net.WebProxy proxy = new System.Net.WebProxy(((System.Collections.Specialized.NameValueCollection)ConfigurationManager.GetSection("appSettings"))["proxy"]);
            //wp.Proxy = proxy;

            //Pass values to the getStatus. getStatus expects....
            //CADPID, MerchantID and Transaction ref. no(used to send the transaction)
            resp = wp.getStatus("CADP627787", "GTB202280123110", TransactionID);

            //Split the response from WEBPAY
            String[] tmp = resp.Split('&');
            for (int i = 0; i < tmp.Length; i++)
            {
                string[] tmp2 = tmp[i].Split('=');
                webPayFeedback.Add(tmp2[0], tmp2[1]);
                respCode = webPayFeedback["rspcode"];
                respAmt = webPayFeedback["appamt"];
            }

            //Get the Response Description from the DB;
            SwitchResponseCodes code = new SwitchResponseCodes();
            code.Code = respCode;
            code.Load();
            code = code.LoadedItem;
            respDesc = code.Description;

            //Set label Color
            lblCurrStatus.ForeColor = Color.Blue;
            lblAppAmount.ForeColor = Color.Blue;
            lblResponseCode.ForeColor = Color.Blue;

            //Displays user friendly messages
            lblCurrStatus.Text = respDesc;
            lblAppAmount.Text = respAmt;
            lblResponseCode.Text = respCode;

            transaction.ResponseCode = respCode;

            if (respCode.Equals("00") || respCode.Equals("000"))
            {
                transaction.StatusType = 1;
                transaction.Status = code.Description;

                UserBase user = new UserBase();
                user.UserID = transaction.UserID;
                user.Load();
                user = user.LoadedItem;

                EmailHelper helper = new EmailHelper();
                helper.From = "support@theqoffice.com";
                helper.Password = "SupportOlobe";
                helper.To = transaction.Email;//user.Email user.FirstName;
                helper.Subject = "TheQOffice.com Payment Confirmed";
                helper.MessageBody = "Hello " + transaction.Name + ",<br />" +
                                     "<br />Congratulations, your payment was successful.<br />" +
                                     "<br />Payment Details:" +
                                     "<br />Transation ID: " + transaction.TransactionID +
                                     "<br />Amount Paid: N" + transaction.Amount +
                                     "<br />Product Purchased: " + transaction.ItemDescription +
                                     "<br /><br />N.B. Please do not delete this email, you transaction ID might be required of you in future circumstances." +
                                     "<br />Thank you for your patronage, we look forward to working with you all the way." +
                                     "<br /><br />Please feel free share your thoughts about The Q-Office by sending an email to yourfriends@theqoffice.com" +
                                     " we would be glad to hear from you." +
                                     "<br /><br />The Q-Office Support Team";
                helper.Send();

                //Get the admin user that will handle access code generation for this user
                EmailHelper helper2 = new EmailHelper();
                helper2.From = "mail@theqoffice.com";
                helper2.To = "admin@theqoffice.com";
                helper2.Password = "MailOlobe";
                helper2.Subject = "Tenant Payment Confirmed";
                helper2.MessageBody = "Generate the Access code for this user." +
                                      "<br /><br />Tenant Details" +
                                      "<br />Tenant Name: " + user.FirstName + " " + user.LastName +
                                      "<br />Tenant Email: " + user.Email +
                                      "<br />Tenant ID: " + user.UserID.ToString() +
                                      "<br />Date Submitted: " + DateTime.Now.ToString() +
                                      "<br /><br />Payment Details" +
                                      "<br />Transation ID: " + transaction.TransactionID +
                                      "<br />Amount Paid: N" + transaction.Amount +
                                      "<br />Product Purchased: " + transaction.ItemDescription +
                                      "<br /><br />Regards,<br />The team is counting on you!!";
                helper2.Send();
            }
            else
            {
                transaction.StatusType = 2;
                transaction.Status = "Pending: " + code.Description;
            }
            transaction.Update();
        }
        catch (Exception ex)
        {
            lblCurrStatus.Visible = true;
            lblCurrStatus.ForeColor = Color.Red;

            // If this is displayed, then it means your proxy is wrong.
            lblCurrStatus.Text = "OOPS!! UNABLE TO CONNECT TO WEBPAY SERVER.";
        }
    }
    protected void btnOk_Click(object sender, EventArgs e)
    {
        Response.Redirect("AdminManager.aspx?todo=rettranx");
    }
}
