<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="HomeDesignSearch.aspx.cs" 
Inherits="Login"  Title="The Q-Office -> Setup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
	<script type="text/javascript" 
	src='<%= TQO_Classes.Utility.DomainList.ImageServer() + "/fancybox/jquery.fancybox-1.3.1.js" %>'></script>
	<script type="text/javascript" 
	src='<%= TQO_Classes.Utility.DomainList.ImageServer() + "/Scripts/callZoom.js" %>'></script>
	<link rel="stylesheet" type="text/css" 
	href='<%= TQO_Classes.Utility.DomainList.ImageServer() + "/fancybox/jquery.fancybox-1.3.1.css" %>' media="screen" />
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
 
 <div class="NormalContentTitle">
 CREATE YOUR WEBSITE
 </div>
  
 <div  id="NormalContent">
  <div  class="NormalContentLeft">
ABOUT Q-OFFICE
<br /><br />

<div style="color:#000000; "> 
Building a website for your business can be as easy as checking your email! All you have to do is choose a 
 website design and let the world know about your business.
 <br /><br />
 A Q-Office website offers an impressive array of business tools such as
 Personalized Email Accounts, News Gallery, Project Gallery, Media Room,
  Press Room (with bulk SMS and email Notification capabilities),
 Search Engine Optimization Assistant
   and so much more, you can be sure of a world-class business representation.
<br /><br />
<center>
<asp:HyperLink ID="lnkAbout" runat="server" NavigateUrl="~/About.aspx" ForeColor="Yellow">
CLICK HERE FOR <br />
*MORE INFORMATION*
</asp:HyperLink>
</center>
</div>
<br />
  </div>
  
  
  <div class="NormalContentRight" >
  <div style="font-size:24px;">
PROGRESS DETAILS
<hr />

<asp:UpdatePanel ID="UpdatePanelDetails" runat="server">
<ContentTemplate>
    <span  style="color:#666666;">
    WEBSITE ADDRESS: 
        
    <asp:HyperLink ID="lnkDomainEdit" runat="server" CssClass="right"  Style="margin-left:5px" ToolTip="Change"
     NavigateUrl="~/DomainSearch.aspx">
        <asp:Image ID="imgDomainEdit" runat="server"  ImageUrl="images/minibtnEdit.jpg" AlternateText="change"
         Height="20px" Width="20px"/>
     </asp:HyperLink>
    
    <asp:Label ID="lblWebsiteAddress" runat="server" ForeColor="Blue" CssClass="right" 
    Text="None selected yet" ></asp:Label>
    
    <br />
    
    WEBSITE DESIGN THEME:  

    <asp:HyperLink ID="lnkTemplateEdit" runat="server" CssClass="right"  Style="margin-left:5px" ToolTip="Change"
     NavigateUrl="~/TemplateSearch.aspx">
        <asp:Image ID="imgTemplateEdit" runat="server"  ImageUrl="images/minibtnEdit.jpg" AlternateText="change"
         Height="20px" Width="20px"/>
     </asp:HyperLink>
    
    <asp:Label ID="lblWebsiteDesign" runat="server" ForeColor="Green" CssClass="right"
    Text="None selected yet"  ></asp:Label>
    <br />

    WEBSITE BANNER:      

    <asp:HyperLink ID="lnkWebsiteBanner" runat="server" CssClass="right"  Style="margin-left:5px" ToolTip="Change"
     NavigateUrl="~/TemplateDesign.aspx">
        <asp:Image ID="imgBannerEdit" runat="server"  ImageUrl="images/minibtnEdit.jpg" AlternateText="change"
         Height="20px" Width="20px"/>
     </asp:HyperLink>
     
    <asp:Label ID="lblWebsiteBanner" runat="server" ForeColor="Maroon" CssClass="right"
    Text="None selected yet"  ></asp:Label>
    
    <br />    
    
    HOMEPAGE DESIGN THEME:  
    <asp:Label ID="lblHomeDesign" runat="server" ForeColor="Maroon" CssClass="right"
    Text="None selected yet"  ></asp:Label>
    </span>
</ContentTemplate>
</asp:UpdatePanel>
    </div>
    </div>
  
  <div class="NormalContentRight"  style="margin-top:10px">
  <div style="font-size:24px;">
CHOOSE YOUR HOMEPAGE DESIGN
<hr />

<asp:UpdatePanel ID="UpdatePanel1" runat="server">
<ContentTemplate>

      <asp:ListView ID="LVTemplates" runat="server" ItemPlaceholderID="ItemContent" GroupPlaceholderID="GroupContent"
       GroupItemCount="3" DataKeyNames="DesignID" OnItemCommand="SelectTemplate" 
          EnableViewState="true" 
          onpagepropertieschanged="LVTemplates_PagePropertiesChanged"  >
        <LayoutTemplate> 
            <asp:PlaceHolder ID="GroupContent" runat="server" ></asp:PlaceHolder>           
            <hr />
             <div style="float:right;  font-size:16px; color:green;">
        <asp:DataPager ID="Pager" runat="server"  PagedControlID="LVTemplates" PageSize="9" EnableViewState="true" >                       
        <Fields>
            <asp:numericpagerfield ButtonCount="10" NextPageText="..." 
                PreviousPageText="..."  />
        </Fields>
        </asp:DataPager>
           </div>
        </LayoutTemplate>
        
        <GroupTemplate> 
        <p>
        <div style="width:605px; background-color:#cccccc; padding:5px; overflow:hidden; margin:auto;">
            <asp:PlaceHolder ID="ItemContent" runat="server" ></asp:PlaceHolder>
        </div>
        </p>
        </GroupTemplate>
        
        <ItemTemplate>
        <div >
        <div class="SampleSiteBg"  style="border:solid 1px #ffffff; padding:3px;">
            
            <center  style="margin-top:5px;">
                <asp:Image ID="imgTemplate" runat="server"  ImageUrl='<%# TQO_Classes.Utility.DomainList.ImageServer() + "/HomeDesign/" +  Eval("Title").ToString() +
            "/thumbnail.jpg" %>'  CssClass="HomeDesign"  />
            
            <asp:ImageButton ID="btnSelectTemplate" runat="server"  ImageUrl="images/btnSelectTemplate.png"
             CommandArgument='<%# Eval("DesignID").ToString() + "**" + Eval("Title").ToString() %>' 
             CommandName="SelectDesign" />
            
            <a id = "btnZoom" href='<%# TQO_Classes.Utility.DomainList.ImageServer() + "/HomeDesign/" +  Eval("Title").ToString() +
            "/screenshot.jpg" %>' target="_blank" > 
                <asp:Image ID="imgZoom" runat="server"  ImageUrl="images/btnZoomTemplate.png" /> </a>
             </center>
         </div>    
         </div>
        </ItemTemplate>
      </asp:ListView>

      
</ContentTemplate>
</asp:UpdatePanel>
</div>
  </div>
  
  
  <div class="NormalContentRight" style="margin-top:30px; border:solid 1px #ff6600">
    <div style="font-size:24px;">
    CONTINUE
    </div><hr />
    <div class="right">
    
        <asp:UpdatePanel ID="UpdatePanelProgress" runat="server">
        <ContentTemplate>
      <asp:Button ID="btnProgress" runat="server" Text="PROCEED >> CONTINUE DESIGN PROCESS" 
            CssClass="greenSideBarButton" ValidationGroup="grpRecovery" 
            onclick="btnProgress_Click" />
            </ContentTemplate>
            </asp:UpdatePanel>
    </div>
<br />
 </div>
</div>

        <asp:UpdatePanel ID="UpdatePanelNotification" runat="server">
        <ContentTemplate>
<TQO:ResultNotification ID="Result" runat="server" />
            </ContentTemplate>
            </asp:UpdatePanel>

</asp:Content>

