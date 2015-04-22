using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using TQO_Classes;
using QOffice.Utility;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        RequestHandler handler = new RequestHandler();
        handler.Request = Request;

        Guid UserID = new Guid("9a7e6083-ce8a-449a-b239-c63d3311022a");//22107bb6-7533-43f3-a484-1906c5b56be7

        string PageName = "Hally";//handler.GetCustomPageName();

        Page.Title += PageName;

        PageMaker page = new PageMaker();
        page.UserID = UserID;
        page.PageName = PageName;
        page.LoadCustom();
        page = page.LoadedItem;

        if (page != null)
        {
            page.LoadCustomPageByUserID(UserID, this.Page);

            lblTitle.Text = page.Title;
            ltlDetails.Text = page.Details;
        }
        else
        {
            Response.Redirect(Request.Url.Host);
        }
    }
}
