﻿using System;
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

public partial class Secured_Finally : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null && Session["RegStatus"] == null)
        {
            Response.Redirect("~/Default.aspx");
        }
        else
        {
            Label1.Text = Session["Announce"].ToString();
            Label2.Text = Session["RegStatus"].ToString();

            Session.Clear();
            Session.Abandon();
        }
    }
}
