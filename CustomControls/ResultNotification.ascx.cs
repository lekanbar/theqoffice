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

public partial class CustomControls_ResultNotification : System.Web.UI.UserControl
{
    private string _Message;
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    public string Message
    {
        get { return _Message; }
        set { _Message = value; }
    }
    
    public void Show()
    {
        if (Message != null && Message != string.Empty)
        {
            lblNotification.Text = Message;
            pnlNotification.Visible = true;
        }
        else throw new NullReferenceException("Please set the message property");
    }
    
    protected void btnNotificationCancel_Click(object sender, ImageClickEventArgs e)
    {
        pnlNotification.Visible = false;
    }
}
