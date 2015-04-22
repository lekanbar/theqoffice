using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Payment : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        lblAmount.Text = Session["AmountDue"].ToString();
        lblDescription.Text = Session["TranxDesc"].ToString();
        lblTID.Text = Session["TranxID"].ToString();

        //Fill the payment form with the necessary details
        gtpay_mert_id.Value = "223";
        gtpay_item_name_1.Value = Session["TranxDesc"].ToString();
        gtpay_item_price_1.Value = Session["AmountDue"].ToString();
        gtpay_cust_id.Value = Session["CustID"].ToString();
        gtpay_tranx_noti_url.Value = "http://www.theqoffice.com/PaymentLanding.aspx";
        gtpay_tranx_amt.Value = Session["AmountDue"].ToString();
        gtpay_tranx_id.Value = Session["TranxID"].ToString();
    }
}
