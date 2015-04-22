using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TQO_Classes;
using QOffice.Utility;

public partial class PaymentLanding : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        System.Text.StringBuilder displayValues = new System.Text.StringBuilder();
        System.Collections.Specialized.NameValueCollection postedValues = Request.Form;
        String nextKey;

        Guid UserID = Guid.Empty;
        string TransactionID = "", TransactionStatus = "", AmountPaid = "", StatusCode = "";

        for (int i = 0; i < postedValues.AllKeys.Length; i++)
        {
            nextKey = postedValues.AllKeys[i];
            if (nextKey == "gtpay_tranx_id")
            {
                TransactionID = postedValues[i];
            }
            else if (nextKey == "gtpay_tranx_status_code")
            {
                StatusCode = postedValues[i];
            }
            else if (nextKey == "gtpay_tranx_status_msg")
            {
                TransactionStatus = postedValues[i];
            }
            else if (nextKey == "gtpay_tranx_amt")
            {
                AmountPaid = postedValues[i];
            }
            else if (nextKey == "gtpay_cust_id")
            {
                UserID = new Guid(postedValues[i]);
            }
        }

        //Update the Status of the transaction in our DB
        SwitchTransaction transaction = new SwitchTransaction();
        transaction.TransactionID = TransactionID;
        transaction.Load();
        transaction = transaction.LoadedItem;

        if (transaction != null)
        {
            Session["CustID"] = transaction.UserID;
            Session["AmountDue"] = transaction.Amount;
            Session["TranxDesc"] = transaction.ItemDescription;
            Session["TranxID"] = transaction.TransactionID;
            Session["AmountDue"] = AmountPaid;

            SwitchResponseCodes responseCodes = new SwitchResponseCodes();
            responseCodes.Code = StatusCode;
            responseCodes.Load();
            responseCodes = responseCodes.LoadedItem;

            transaction.ResponseCode = StatusCode;
            
            //Check if the amount is consistent with what we have in the DB
            string AmountInDB = transaction.Amount.Substring(0, transaction.Amount.IndexOf('.')) +
                                AmountPaid.Substring(AmountPaid.IndexOf('.'));
            if (!AmountInDB.Equals(AmountPaid))
            {
                Label1.Text = "Your transaction was not successful";
                Label2.Text = "Reason: The amount paid at the gateway is not consistent with what you are supposed to pay." +
                              "<br /><br />Transaction ID: " + transaction.TransactionID +
                              "<br />Amount Due: " + transaction.Amount +
                              "<br /><br />Please try again or contact our technical team for help and support on support@theqoffice.com <br />";
                Label2.ForeColor = System.Drawing.Color.Red;

                transaction.Status = "Pending: The amount paid at the gateway is not consistent with what you are supposed to pay.";
                transaction.StatusType = 0;
                transaction.Amount = transaction.Amount;
                transaction.Update();

                Session["TheTransaction"] = transaction;
                lnkTryAgain.Visible = true;
                return;
            }

            //Do this only when the transaction is successful
            if (StatusCode.Equals("00") || StatusCode.Equals("000"))
            {
                UserBase user = new UserBase();
                user.UserID = UserID;
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

                Label1.Text = "Congratulations, your payment was successful!!";
                Label2.Text = "Next: Please Login to your Email box for further instructions.";
                Label2.ForeColor = System.Drawing.Color.Blue;

                //Set Status Type
                transaction.Status = responseCodes.Description;
                transaction.StatusType = 1;

                Session.Clear();
                Session.Abandon();
            }
            else
            {
                Label1.Text = "Your transaction was not successful";
                if (responseCodes != null)
                {
                    Label2.Text = "Reason: " + responseCodes.Description +
                                  "<br /><br />Transaction ID: " + transaction.TransactionID +
                                  "<br />Amount Due: " + transaction.Amount +
                                  "<br /><br />Please try again or contact our technical team for help and support on support@theqoffice.com <br />";
                    //Set Status
                    transaction.Status = "Pending: " + responseCodes.Description;
                }
                else
                {
                    Label2.Text = "Reason: An Unknown Errror just occurred" +
                                  "<br /><br />Transaction ID: " + transaction.TransactionID +
                                  "<br />Amount Due: " + transaction.Amount +
                                  "<br /><br />Please try again or contact our technical team for help and support on support@theqoffice.com <br />";
                }
                Label2.ForeColor = System.Drawing.Color.Red;

                //Set Status Type
                transaction.StatusType = 2;

                Session["TheTransaction"] = transaction;
                lnkTryAgain.Visible = true;
            }

            transaction.Amount = AmountPaid;
            transaction.Update();
        }
        else
        {
            Label1.Text = "We are sorry, your transaction was not successful";
            Label2.Text = "Reason: Your transaction does not exist in our Database" +
                          "<br /><br />Transaction ID: " + TransactionID +
                          "<br />Amount Due: " + AmountPaid +
                          "<br /><br />Please contact our technical team for help and support on support@theqoffice.com <br />" + 
                          "Please keep the Transaction ID, because it will be required of you by the Support Team.";
            Label2.ForeColor = System.Drawing.Color.Red;

            lnkTryAgain.Visible = false;
        }
    }

    protected void lnkTryAgain_Click(object sender, EventArgs e)
    {
        //Re Generate the transaction
        SwitchTransaction transaction = Session["TheTransaction"] as SwitchTransaction;
        Session["CustID"] = transaction.UserID;
        string amountDue = transaction.Amount;
        Session["TranxDesc"] = "The Q-Office Website [Custom]";
        Session["TranxID"] = RandomDigits.Get();

        transaction.TransactionID = Session["TranxID"].ToString();
        transaction.Status = "Pending: Transaction is pending.";
        transaction.Date = DateTime.Now;
        transaction.StatusType = 0;
        transaction.Add();

        Response.Redirect("~/Payment.aspx", false);
    }
}
