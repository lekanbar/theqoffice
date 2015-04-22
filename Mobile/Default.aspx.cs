using System;
using System.Collections;
using System.Collections.Generic;
using System.Drawing;
using System.Web.UI.MobileControls;
using QOffice.Utility;
using TQO_Classes;

public partial class Mobile_TQOMobileDefault : System.Web.UI.MobileControls.MobilePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ActiveForm = Form1;
    }
    protected void btnCheck_Click(object sender, EventArgs e)
    {        
        ActiveForm = Form6;
    }
    protected void Form1_Activate(object sender, EventArgs e)
    {
        lblCopyRightYear.Text = DateTime.Now.Year.ToString();
    }
    protected void Form2_Activate(object sender, EventArgs e)
    {
        lblCopyRightYear2.Text = DateTime.Now.Year.ToString();
    }
    protected void Form3_Activate(object sender, EventArgs e)
    {
        UserTenant user = new UserTenant();
        user.GetAllBySetupDate();
        List<UserTenant> tenants = user.TenantCollection;
        int count = 11;

        foreach (UserTenant tenant in tenants)
        {
            System.Web.UI.MobileControls.Label lblTitle = new System.Web.UI.MobileControls.Label();
            lblTitle.Text = tenant.CompanyName;
            lblTitle.Font.Bold = BooleanOption.True;
            lblTitle.Font.Size = System.Web.UI.MobileControls.FontSize.Normal;
            Form3.Controls.AddAt(count + 1, lblTitle);

            System.Web.UI.MobileControls.Link lnkTenant = new System.Web.UI.MobileControls.Link();
            lnkTenant.Text = tenant.SiteURL;
            lnkTenant.NavigateUrl = "http://mobile." + tenant.SiteURL;
            Form3.Controls.AddAt(count + 2, lnkTenant);

            System.Web.UI.MobileControls.Label lblBreak = new System.Web.UI.MobileControls.Label();
            lblBreak.Text = "-----------";
            Form3.Controls.AddAt(count + 3, lblBreak);

            count += 3;
        }
        lblCopyRightYear3.Text = DateTime.Now.Year.ToString();
    }
    protected void Form5_Activate(object sender, EventArgs e)
    {
        lblCopyRightYear5.Text = DateTime.Now.Year.ToString();
    }
    protected void Form6_Activate(object sender, EventArgs e)
    {
        DomainSearchResult domain = new DomainSearchResult();
        domain.Domain = txtDomainName.Text;
        domain.GetResults();
        domain = domain.LoadedItem;

        int count = 8;

        System.Web.UI.MobileControls.Label lblTitle = new System.Web.UI.MobileControls.Label();
        lblTitle.Text = domain.Domain;
        lblTitle.Font.Bold = BooleanOption.True;
        lblTitle.Font.Size = System.Web.UI.MobileControls.FontSize.Normal;
        Form6.Controls.AddAt(count + 1, lblTitle);

        if (domain.Status.Equals("available"))
        {
            System.Web.UI.MobileControls.Label lblDetails = new System.Web.UI.MobileControls.Label();
            lblDetails.Text = "Congratulations the domain name is available!!";
            Form6.Controls.AddAt(count + 2, lblDetails);
        }
        else
        {
            System.Web.UI.MobileControls.Label lblDetails = new System.Web.UI.MobileControls.Label();
            lblDetails.Text = "Sorry, this domain name is already Taken";
            Form6.Controls.AddAt(count + 2, lblDetails);
        }

        lblCopyRightYear6.Text = DateTime.Now.Year.ToString();
    }
}
