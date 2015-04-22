<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="TemplateDesign.aspx.cs" 
Inherits="Login"  Title="The Q-Office -> Setup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
	<script type="text/javascript" 
	src='<%= TQO_Classes.Utility.DomainList.ImageServer() + "/Scripts/jquery-1.4.2.min.js" %>'></script>
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

<div style="color:#000000;  "> 
Building a website for your business can be as easy as checking your email! All you have to do is choose a 
 website design and let the world know about your business.
 <br /><br />
 A Q-Office website offers an impressive array of business tools such as
 Personalized Email Accounts, News Gallery, Project Gallery, Media Room,
  Press Room (with bulk SMS and email Notification capabilities),
 Search Engine Optimization Assistant
   and so much more, you can be sure of a world-class business representation.
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
  
  
  <div class="NormalContentRight"  >
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
    
     <asp:Label ID="lblWebsiteDesign" runat="server" ForeColor="Green" CssClass="right" ></asp:Label>
     
    <br />
    
    HOMEPAGE DESIGN THEME: 
    
    <asp:HyperLink ID="lnkDesignEdit" runat="server" CssClass="right"  Style="margin-left:5px" ToolTip="Change"
     NavigateUrl="~/HomeDesignSearch.aspx">
        <asp:Image ID="imgDesignEdit" runat="server"  ImageUrl="images/minibtnEdit.jpg" AlternateText="change"
         Height="20px" Width="20px"/>
     </asp:HyperLink>
    
     <asp:Label ID="lblHomeDesign" runat="server" ForeColor="Maroon" CssClass="right" ></asp:Label>
    <hr />
    </span>
</ContentTemplate>
</asp:UpdatePanel>
<hr />
<span class="right">
      <asp:Button ID="btnBack" runat="server" Text="GO BACK << CHANGE WEBSITE LAYOUT" 
            CssClass="greenSideBarButton" ValidationGroup="grpRecovery" 
            onclick="btnBack_Click" />
</span>
    </div>
    </div>
  
  <div class="NormalContentRight"  style="margin-top:10px;">
  <div style="font-size:24px;">
CHOOSE YOUR WEBSITE COLOURS
<hr />
<center>
    <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
    <ContentTemplate>
                  
            <table cellspacing="10px" >
            <tr>
                <td>
                     <asp:Panel ID="pnlColour1" runat="server"  CssClass="labelBorder" ></asp:Panel>
                </td>
                <td>
                    <asp:Button ID="btnColour1" runat="server" Text="Choose Colour 1" 
                        onclick="btnColour1_Click" />
                </td>
                <td>
                     <asp:Panel ID="pnlColour2" runat="server"  CssClass="labelBorder"></asp:Panel>
                </td>
                <td>
                    <asp:Button ID="btnColour2" runat="server" Text="Choose Colour 2" 
                        onclick="btnColour2_Click" />
                </td>
                <td>
                     <asp:Panel ID="pnlColour3" runat="server"  CssClass="labelBorder"></asp:Panel>
                </td>
                <td>
                    <asp:Button ID="btnColour3" runat="server" Text="Choose Colour 3" 
                        onclick="btnColour3_Click" />
                </td>
                
            </tr>
            <tr>
            <td colspan="2" align="center" class="tableRowSpacing">
            <asp:label ID="lblColour1" runat="server"  ></asp:label>
            </td>
            <td colspan="2" align="center" class="tableRowSpacing">
            <asp:label ID="lblColour2" runat="server"  ></asp:label>
            </td>
            <td colspan="2" align="center" class="tableRowSpacing">
            <asp:label ID="lblColour3" runat="server"  ></asp:label>
            </td>
            </tr>
            </table>

    </ContentTemplate>
    </asp:UpdatePanel>
</center>

<hr />
      <asp:UpdatePanel ID="UpdatePanelColours" runat="server">
      <ContentTemplate>
          
          <asp:Panel ID="pnlColours" runat="server" Visible="false" >
          <asp:ImageButton ID="btnCloseColourPanel" runat="server" ImageUrl="images/btnCloseColourPanel.jpg"
           ImageAlign="Right" AlternateText="Close" onclick="btnCloseColourPanel_Click" />
           <br />
          <asp:ListView ID="LVColours" runat="server" ItemPlaceholderID="ItemContent" GroupPlaceholderID="GroupContent"
           GroupItemCount="24" DataKeyNames="ColourID" OnItemCommand="SelectColour" 
              EnableViewState="true" 
              onpagepropertieschanged="LVColours_PagePropertiesChanged"  >
            <LayoutTemplate> 
                <asp:PlaceHolder ID="GroupContent" runat="server" ></asp:PlaceHolder> 
               
            </LayoutTemplate>
            
            <GroupTemplate> 
            <div style="width:100%; background-color:#cccccc; padding:1px; overflow:auto; margin:auto;">
                <asp:PlaceHolder ID="ItemContent" runat="server" ></asp:PlaceHolder>
            </div>
            </GroupTemplate>
            
            <ItemTemplate>
            <div >
            <div   style="border:solid 1px #cccccc; padding:3px; float:left;">
                    <asp:Button ID="btnColour" runat="server"
                     BackColor='<%# System.Drawing.ColorTranslator.FromHtml(Eval("ColourCode").ToString()) %>'
                     ToolTip='<%# Eval("ColourName").ToString() %>' Width="20px " Height="15px" CommandName="_SelectColour" 
                     CommandArgument='<%# Eval("ColourName").ToString() + "**" + Eval("ColourCode").ToString() %>' />
             </div>    
             </div>
            </ItemTemplate>
          </asp:ListView>
          </asp:Panel>
          
      </ContentTemplate>
      </asp:UpdatePanel>

      
</div>
  </div>
  
  
  
  <div class="NormalContentRight"  style="margin-top:10px;">
  <div style="font-size:24px;">
    <asp:UpdatePanel ID="UpdatePanelDDL" runat="server" UpdateMode="Conditional">
    <ContentTemplate>
<asp:DropDownList ID="DDLCategories" runat="server" CssClass="right"  AutoPostBack="true"
          DataSourceID="SDSCategories" DataTextField="CategoryTitle" 
          DataValueField="CategoryID" 
          onselectedindexchanged="DDLCategories_SelectedIndexChanged">
</asp:DropDownList>
      <asp:SqlDataSource ID="SDSCategories" runat="server" 
          ConnectionString="<%$ ConnectionStrings:QOfficeDBConnectionString %>" 
          SelectCommand="SELECT [CategoryID], [CategoryTitle] FROM [TQO_BusinessCategories]">
      </asp:SqlDataSource>
      </ContentTemplate>
      </asp:UpdatePanel>
CHOOSE YOUR WEBSITE BANNER
<hr style="clear:both;" />
<center>
    <asp:UpdatePanel ID="UpdatePanelBanners" runat="server" UpdateMode="Conditional">
    <ContentTemplate>
     
          <asp:ListView ID="LVBanners" runat="server" ItemPlaceholderID="ItemContent" GroupPlaceholderID="GroupContent"
           GroupItemCount="2" DataKeyNames="BannerID" OnItemCommand="SelectBanner" 
              EnableViewState="true" 
              onpagepropertieschanged="LVBanners_PagePropertiesChanged"  >
            <LayoutTemplate> 
                <asp:PlaceHolder ID="GroupContent" runat="server" ></asp:PlaceHolder>     
            <div style="float:right;  font-size:16px; color:green;">
                <asp:DataPager ID="Pager" runat="server"  PagedControlID="LVBanners" PageSize="6" EnableViewState="true" >                       
                <Fields>
                    <asp:numericpagerfield ButtonCount="10" NextPageText="..." 
                        PreviousPageText="..."  />
                </Fields>
                </asp:DataPager>
           </div> 
            </LayoutTemplate>
            
            <GroupTemplate> 
            <div style="width:100%; padding:1px; overflow:auto; margin:auto;">
                <asp:PlaceHolder ID="ItemContent" runat="server" ></asp:PlaceHolder>
            </div>
            </GroupTemplate>
            
            <ItemTemplate>
            <div>
            <div style="border:solid 1px #cccccc; padding:3px; float:left; margin-right:2px;">
                <table>
                    <tr>
                        <td align="right">
                            <asp:Label ID="lblBanner" runat="server" Font-Size="16px" ForeColor="#ff6600"
                             Text='<%# Eval("BannerName").ToString().ToUpper() %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Image ID="imgBanner" runat="server"  CssClass="MiniBanner"
                            ImageUrl='<%# TQO_Classes.Utility.DomainList.ImageServer() + "/banners/" + Eval("BannerName").ToString()
                            + "/" + "mini.jpg" %>' AlternateText="Banner" />                        
                        </td>
                    </tr>
                    <tr>
                        <td align="center">
                        <div  style="margin-top:5px;">
                            <asp:ImageButton ID="btnSelectBanner" runat="server"  ImageUrl="images/btnSelectTemplate.png"
                             CommandArgument='<%# Eval("BannerID").ToString() + "**" + Eval("BannerName").ToString() %>' 
                             CommandName="_SelectBanner" />
                            
                            <span id="magic">
                            <a id = "btnZoom" href='<%# TQO_Classes.Utility.DomainList.ImageServer() + "/banners/" +  Eval("BannerName").ToString() 
                            + "/" + "banner.jpg" %>' > 
                                <asp:Image ID="imgZoom" runat="server"  ImageUrl="images/btnZoomTemplate.png" /> </a>
                             </span>
                                
                        </div>
                        </td>
                    </tr>
                </table>
             </div>    
             </div>
            </ItemTemplate>
          </asp:ListView>
          
    </ContentTemplate>
    <Triggers>
        <asp:AsyncPostBackTrigger ControlID="DDLCategories" EventName="SelectedIndexChanged" />
    </Triggers>
    </asp:UpdatePanel>
</center>

      
  </div>
  </div>
  
  
  <div class="NormalContentRight" style="margin-top:30px; border:solid 1px #ff6600">
    
    <asp:UpdatePanel ID="UpdatePanelProgress" runat="server">
    <ContentTemplate>
    
    <div style="font-size:24px;">
    TEST RUN WEBSITE 
    <sup>(<asp:Label ID="lblBannerChoice" runat="server" Text="choose a banner first" ForeColor="Maroon"></asp:Label>)</sup>
    </div><hr />
    <div class="right greenSideBarButton" style="height:28px; line-height:28px">    
       
        <asp:Hyperlink ID="imgTestRun" runat="server"  ForeColor="White"
          Font-Size="14px"
          Text="PROCEED >> TESTRUN DESIGN CHOICES"
          
          Target="_blank" />         
          
    </div>
    
    </ContentTemplate>
    </asp:UpdatePanel> 
<br />
 </div>
 
 
  
  <div class="NormalContentRight" style="margin-top:30px; border:solid 1px #ff6600">
    <div style="font-size:24px;">
    CONTINUE
    </div><hr />
    <div class="right">    
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
      <asp:Button ID="Button1" runat="server" Text="PROCEED >> FINISH DESIGN PROCESS" 
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

