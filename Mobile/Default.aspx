<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Mobile_TQOMobileDefault" %>
<%@ Register TagPrefix="mobile" Namespace="System.Web.UI.MobileControls" Assembly="System.Web.Mobile" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<body>
    <mobile:Form id="Form1" runat="server" OnActivate="Form1_Activate" BackColor="White" ForeColor="Black" Title="Home">
    <mobile:Panel ID="HomePanel" Runat="server">
        <mobile:Image ID="imgHome" Runat="server" ImageUrl="~/Images/mobileLogo.jpg"></mobile:Image>
    </mobile:Panel>
     <br />
        <mobile:Link ID="lnkAboutUs" Runat="server" NavigateUrl="#Form2">About Us</mobile:Link>
        <mobile:Link ID="lnkProducts" Runat="server" NavigateUrl="#Form3">Customers</mobile:Link>
        <mobile:Link ID="lnkContactUs" Runat="server" NavigateUrl="#Form5">Contact Us</mobile:Link>
        <br />
        <p>
           <b>Welcome to The Q-Office Mobile site!!</b>
           <br />
           Building a website for your business is now as easy as using Microsoft Word! All you have to do is choose a website design and let 
           the world know about your business.
             <br /><br />
             Check if your business name is available e.g. business.com<br />
             Check here: <mobile:TextBox ID="txtDomainName" Runat="server"></mobile:TextBox>
             <mobile:Command ID="btnCheck" Runat="server" OnClick="btnCheck_Click">Go</mobile:Command><br /><br />
             <mobile:Label ID="Label3" Runat="server" Font-Bold="True" Font-Size="Large">Also.....</mobile:Label>
             A Q-Office website offers an impressive array of business tools such as:
                     <br />    
                 &nbsp;&nbsp;Personalized Email Accounts<br />
                 &nbsp;&nbsp;News Gallery<br />
                 &nbsp;&nbsp;Product/Service Gallery<br />
                 &nbsp;&nbsp;Project Gallery<br />
                 &nbsp;&nbsp;Media Room<br />
                 &nbsp;&nbsp;Press Room (with bulk SMS and email Notification capabilities)<br />
                 &nbsp;&nbsp;Search Engine Optimization Assistant
             <br />
             &nbsp;&nbsp;and so much more, you can be sure of a world-class business representation. 
        </p>
        <br />
        &nbsp;Copyright&nbsp;&copy;&nbsp;<mobile:Label ID="lblCopyRightYear" Runat="server"></mobile:Label>
        &nbsp;TheQOffice.com
        <br />
        &nbsp;powered&nbsp;by&nbsp;<mobile:Link ID="lnkTQO" Runat="server" NavigateUrl="http://www.theqoffice.com">TheQOffice.com</mobile:Link>
    </mobile:Form>
    <mobile:Form id="Form2" runat="server" OnActivate="Form2_Activate" BackColor="White" ForeColor="Black" Title="About Us">
    <mobile:Panel ID="AboutPanel" Runat="server">
         <mobile:Image ID="imgAboutUs" Runat="server" ImageUrl="~/images/mobileLogo.jpg"></mobile:Image>
     </mobile:Panel>
     <br />
        <mobile:Link ID="lnkHome" Runat="server" NavigateUrl="#Form1">Home</mobile:Link>
        <mobile:Link ID="Link1" Runat="server" NavigateUrl="#Form3">Customers</mobile:Link>
        <mobile:Link ID="Link3" Runat="server" NavigateUrl="#Form5">Contact Us</mobile:Link>
        <br />
        <p>
        <mobile:Label ID="Label8" Runat="server" Font-Bold="True" Font-Size="Large">ABOUT THE Q-OFFICE</mobile:Label>
            Hello friend, we think we just found a more innovative way of doing business and we're sure you can't get this anywhere else!
            <br /><br />
            We talked to several small business owners from different industries to find out their peculiar needs and how a 
            simple concept such as a website can help them advertise more and communicate better and we came up with The Q-Office.
            <br /><br />
            Basically, The Q-Office project helps you create a dynamic website in 24 hours, but we aim to create a business
            revolution with that simple concept.
            We are building in more tools for customer relationship management, electronic commerce support and every other
            business aspect that can be supported adequately on the internet.
            <br /><br />
            We think you, the business owner, are the most important part of this service and we'd love to hear from you.
            Our doors are always open to everyone who has interesting 
            ideas on how we can do a better job. Such opinions are welcome at suggestions@theqoffice.com
        </p>
        <p>
        <br />
        <mobile:Label ID="Label6" Runat="server" Font-Bold="True" Font-Size="Large">Our Payment Information</mobile:Label>
        We're still setting up our internet payment gateway but pending it's release you can
        pay into our GTBank account. Here are the details you would need:
        <br />
        <br />
        <mobile:Label ID="Label5" Runat="server" Font-Bold="True">
        A/C NAME:
        </mobile:Label>
        Electronic Phase Information Systems
        <br />
        <mobile:Label ID="Label4" Runat="server" Font-Bold="True">
        A/C NUMBER:</mobile:Label>
        202 280123 110
        </p>
        <br />
        &nbsp;Copyright&nbsp;&copy;&nbsp;<mobile:Label ID="lblCopyRightYear2" Runat="server"></mobile:Label>
        &nbsp;TheQOffice.com
        <br />
        &nbsp;powered&nbsp;by&nbsp;<mobile:Link ID="Link4" Runat="server" NavigateUrl="http://www.theqoffice.com">TheQOffice</mobile:Link>
    </mobile:Form>
    <mobile:Form id="Form3" runat="server" OnActivate="Form3_Activate" BackColor="White" ForeColor="Black" Title="Latest Customers">
    <mobile:Panel ID="Panel1" Runat="server">
     <mobile:Image ID="imgCustomers" Runat="server" ImageUrl="~/images/mobileLogo.jpg"></mobile:Image>
     </mobile:Panel>
     <br />
        <mobile:Link ID="lnkHome2" Runat="server" NavigateUrl="#Form1">Home</mobile:Link>
        <mobile:Link ID="lnkAboutUs3" Runat="server" NavigateUrl="#Form2">About Us</mobile:Link>
        <mobile:Link ID="Link10" Runat="server" NavigateUrl="#Form5">Contact Us</mobile:Link>
        <br />
        <mobile:Label ID="Label9" Runat="server" Font-Bold="True" Font-Size="Large">Here are our latest customers</mobile:Label>
        <br />
        
        <br />
        <br />
        &nbsp;Copyright&nbsp;&copy;&nbsp;<mobile:Label ID="lblCopyRightYear3" Runat="server"></mobile:Label>
        &nbsp;TheQOffice.com
        <br />
        &nbsp;powered&nbsp;by&nbsp;<mobile:Link ID="Link6" Runat="server" NavigateUrl="http://www.theqoffice.com">TheQOffice</mobile:Link>
    </mobile:Form>
    <mobile:Form ID="Form4" Runat="server">
    </mobile:Form>
    <mobile:Form id="Form5" runat="server" OnActivate="Form5_Activate" Title="Contact Us" BackColor="White" ForeColor="Black">
     <mobile:Image ID="imgContactUs" Runat="server" ImageUrl="~/images/mobileLogo.jpg"></mobile:Image>
     <br />
        <mobile:Link ID="lnkHome5" Runat="server" NavigateUrl="#Form1">Home</mobile:Link>
        <mobile:Link ID="lnkAboutUs5" Runat="server" NavigateUrl="#Form2">About Us</mobile:Link>
        <mobile:Link ID="Link11" Runat="server" NavigateUrl="#Form3">Customers</mobile:Link>
        <br />
        Customer Care
        We'd love to hear what you think. Please feel free to send us an email at any of the following addresses:
        <br />
        <mobile:Label ID="Label7" Runat="server" Font-Bold="True" Font-Size="Large">
        General Customer Support
        </mobile:Label>
        <br />
        support@theqoffice.com
        <br />
        <mobile:Label ID="Label2" Runat="server" Font-Bold="True" Font-Size="Large">
        Product Suggestions
        </mobile:Label>
        <br />
        suggestions@theqoffice.com
        <br />
        <mobile:Label ID="Label1" Runat="server" Font-Bold="True" Font-Size="Large">
        Product Complaints
        </mobile:Label>
        <br />
        complaints@theqoffice.com
        <br />
        <mobile:Label ID="lblCustCare" Runat="server" Font-Bold="True" Font-Size="Large">
        Executive Business contact</mobile:Label>
        <br />
        yourfriends@theqoffice.com
        <br />
        &nbsp;Copyright&nbsp;&copy;&nbsp;<mobile:Label ID="lblCopyRightYear5" Runat="server"></mobile:Label>
        &nbsp;TheQOffice.com
        <br />
        &nbsp;powered&nbsp;by&nbsp;<mobile:Link ID="Link8" Runat="server" NavigateUrl="http://www.theqoffice.com">TheQOffice</mobile:Link>
    </mobile:Form>
    <mobile:Form id="Form6" runat="server" OnActivate="Form6_Activate" BackColor="White" ForeColor="Black" Title="Domain Search Result">
    <mobile:Panel ID="Panel2" Runat="server">
     <mobile:Image ID="Image1" Runat="server" ImageUrl="~/images/mobileLogo.jpg"></mobile:Image>
     </mobile:Panel>
     <br />
        <mobile:Link ID="Link14" Runat="server" NavigateUrl="#Form1">Home</mobile:Link>
        <mobile:Link ID="Link15" Runat="server" NavigateUrl="#Form2">About Us</mobile:Link>
        <mobile:Link ID="Link19" Runat="server" NavigateUrl="#Form3">Customers</mobile:Link>
        <mobile:Link ID="Link17" Runat="server" NavigateUrl="#Form5">Contact Us</mobile:Link>
        <br />
        
        <br />
        <br />
        &nbsp;Copyright&nbsp;&copy;&nbsp;<mobile:Label ID="lblCopyRightYear6" Runat="server"></mobile:Label>
        &nbsp;TheQOffice.com
        <br />
        &nbsp;powered&nbsp;by&nbsp;<mobile:Link ID="Link18" Runat="server" NavigateUrl="http://www.theqoffice.com">TheQOffice</mobile:Link>
    </mobile:Form>   
</body>
</html>
