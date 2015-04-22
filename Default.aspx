<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" 
Inherits="_Default" Title="The Q-Office ->" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    
	<script type="text/javascript" 
	src='<%= TQO_Classes.Utility.DomainList.ImageServer() + "/fancybox/jquery.fancybox-1.3.1.js" %>'></script>
	<script type="text/javascript" 
	src='<%= TQO_Classes.Utility.DomainList.ImageServer() + "/Scripts/callZoom.js" %>'></script>
	<link rel="stylesheet" type="text/css" 
	href='<%= TQO_Classes.Utility.DomainList.ImageServer() + "/fancybox/jquery.fancybox-1.3.1.css" %>' media="screen" />
   	
   	<style type="text/css">
   	    .tRowTitle
   	    {
   	        color:Black;
   	        background-color:#cccccc;
   	    }
   	</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div style="clear:left; float:left; width:100%;">

    <div class="ColumnFront">
<asp:Image ID="img1" runat="server" ImageUrl="images/btnGetStarted.jpg" CssClass="right"
 AlternateText="Get Started" style="margin-right:20px" />

<div style="background-image:url(images/banner.png); width:100%; height:201px; float:right; margin-top:5px; "></div>


<div class="leftColumnFront">
  <div  class="leftColumnFrontWhite">

<span style=" font-size:24px">
ABOUT Q-OFFICE
</span>
<br /><br />

<div style="color:#000000;  "> 
For only N37,000/year, a Q-Office website offers an impressive array of business tools such as:
 <br />-  Personalized Email Accounts,
 <br />- News Gallery, 
 <br />- Project Gallery,
 <br />- Media Room,
 <br />- Bulk SMS integration,
 <br />- Search Engine Optimization
 <br />- Free Business Directory Listing
 <br />   and so much more, you can be sure of a world-class business representation.
   <br /><br />
   We're constantly building newer tools for small businesses so that our customers are constantly competitive.
   With our consistent drive for discovering innovative approaches to solving
   problems for small businesses, you're in the best hands!
   
   
</div>
<br /><br />
<center>
<asp:HyperLink ID="lnkAbout" runat="server" NavigateUrl="~/About.aspx" ForeColor="Yellow">
CLICK HERE FOR <br />
*MORE INFORMATION*
</asp:HyperLink>
</center>
<br />
</div>
</div>


<div class="rightColumnFront">

<div class="leftColumnFrontBlack" style="background-color:white; border:solid 1px #ff6600">
<span style="font-size:24px; text-align:right;color:#ff6600;">
IT'S YOUR CHOICE!
<sup style="color:black; font-size:18px;">
 ( custom design vs templates )
</sup>
</span>
<hr />
<div style=" width:100%; overflow:auto;">
You have the option to build a free website from our pre-designed templates and banners OR
we can create a unique design for your website using the pictures you provide for a stronger branding
advantage.
<br />
<br />

<table width="100%"  rules="rows" cellpadding="3" style=" border:solid 1px #cccccc">
<tr>
    <td></td>
    <td style="color:Green" align="center">FREE</td>
    <td style="color:#ff6600" align="center">CUSTOM</td>
</tr>
<tr>
    <td class="tRowTitle">SETUP TIME</td>
    <td align="center"> 24 hours </td>
    <td align="center"> 7 working days </td>
</tr>
<tr>
    <td  class="tRowTitle">GALLERIES</td>
    <td align="center"> any 2 </td>
    <td align="center"> on demand </td>
</tr>
<tr>
    <td  class="tRowTitle">EMAIL ACCOUNTS</td>
    <td align="center"> none </td>
    <td align="center"> 5 </td>
</tr>
<tr>
    <td  class="tRowTitle">MOBILE WEBSITE</td>
    <td align="center"> available </td>
    <td align="center"> available </td>
</tr>
<tr>
    <td  class="tRowTitle">BULK SMS INTEGRATION</td>
    <td align="center"> available </td>
    <td align="center"> available </td>
</tr>
<tr>
    <td class="tRowTitle">SETUP FEE</td>
    <td align="center"> - </td>
    <td align="center"> 20,000 </td>
</tr>
<tr>
    <td class="tRowTitle">YEARLY FEE</td>
    <td align="center"> - </td>
    <td align="center"> 37,000 </td>
</tr>
</table>
** read more about our packages <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="about.aspx#Comparisons" 
 ForeColor="blue"> here</asp:HyperLink>
<br /><br />
<span  class="right">
        <asp:HyperLink ID="linkCustom" runat="server" NavigateUrl="customregistration.aspx"  ForeColor="green" 
         Font-Size="24px">
           GET A CUSTOM WEBSITE TODAY!
        </asp:HyperLink>
</span>
</div>
</div>
        
<div class="xleftColumnFrontBlack" >
<span style="font-size:24px; text-align:right;color:#ff6600;">
GET A FREE WEBSITE!
<sup style="color:#cccccc; font-size:18px;">
 ( customizable )
</sup>
</span>
<hr />
<div style=" width:100%; overflow:auto;">
    <asp:UpdatePanel ID="UpdatePanelLayout" runat="server">
    <ContentTemplate>            
          <asp:ListView ID="LVTemplates" runat="server" ItemPlaceholderID="ItemContent" GroupPlaceholderID="GroupContent"
           GroupItemCount="3" DataKeyNames="SiteID" OnItemCommand="SelectTemplate" EnableViewState="true" >
            <LayoutTemplate>
                <asp:PlaceHolder ID="GroupContent" runat="server" ></asp:PlaceHolder>   
                <asp:DataPager ID="Pager" runat="server"  PagedControlID="LVTemplates" PageSize="3" EnableViewState="true" >                       
            <Fields>
            </Fields>
            </asp:DataPager>
            </LayoutTemplate>
            
            <GroupTemplate>
                <asp:PlaceHolder ID="ItemContent" runat="server" ></asp:PlaceHolder>
            </GroupTemplate>
            
            <ItemTemplate>
            <div class="SampleSiteBg"  >
                    <asp:Image ID="imgTemplate" runat="server"  ImageUrl='<%#  TQO_Classes.Utility.DomainList.ClientSiteURL()+ "/Templates/" +  Eval("SiteName").ToString() +
                "/images/thumbnail.jpg" %>' CssClass="SampleSite"  ToolTip='<%# Eval("SiteDescription").ToString() %>' />
                
                <center  style="margin-top:5px;">
                <asp:ImageButton ID="btnSelectTemplate" runat="server"  ImageUrl="images/btnSelectTemplate.png"
                CommandArgument='<%# Eval("SiteID").ToString() +"**" +Eval("SiteName").ToString() %>' 
                CommandName="SelectTemplate" />
                            
                <a id = "btnZoom" href='<%# TQO_Classes.Utility.DomainList.ClientSiteURL()+ "/Templates/" +  Eval("SiteName").ToString() +
                "/images/screenshot.jpg" %>'> 
                    <asp:Image ID="imgZoom" runat="server"  ImageUrl="images/btnZoomTemplate.png" /> 
                </a>
                 </center>
             </div>    
            </ItemTemplate>
          </asp:ListView>
    </ContentTemplate>
    </asp:UpdatePanel>
</div>
<hr />
<a style="font-size:24px; float:right; color:#ffffff; " href="TemplateSearch.aspx">
CHOOSE A TEMPLATE
</a>

</div>


<div class="miniSearch">
SEARCH OUR BUSINESS DIRECTORY
<br />
    <asp:TextBox ID="txtMiniSearch" runat="server"  Height="33px" Width="465px"  ForeColor="#999999"
                    Font-Size="X-Large"></asp:TextBox>
    <asp:Button ID="btnMiniSearch"   runat="server" Font-Size="24px"
                    Text=" GO! " Height="40px" Width="100px" onclick="btnMiniSearch_Click" />
</div>

</div>
</div>


</div>
</asp:Content>

