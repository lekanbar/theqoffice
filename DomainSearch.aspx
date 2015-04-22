<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="DomainSearch.aspx.cs" 
Inherits="Login" Title="The Q-Office -> Setup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
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
  
  <div class="NormalContentRight" >
  <div style="font-size:24px;">
PROGRESS DETAILS
<hr />

<asp:UpdatePanel ID="UpdatePanelDetails" runat="server">
<ContentTemplate>
    <span  style="color:#666666;">
        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
        <ContentTemplate>
        
    WEBSITE ADDRESS: 
    
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

    <asp:HyperLink ID="lnkDesignEdit" runat="server" CssClass="right"  Style="margin-left:5px" ToolTip="Change"
     NavigateUrl="~/HomeDesignSearch.aspx">
        <asp:Image ID="imgDesignEdit" runat="server"  ImageUrl="images/minibtnEdit.jpg" AlternateText="change"
         Height="20px" Width="20px"/>
     </asp:HyperLink>
     
    <asp:Label ID="lblHomeDesign" runat="server" ForeColor="Maroon" CssClass="right"
    Text="None selected yet"  ></asp:Label>
    
    
        </ContentTemplate>
        </asp:UpdatePanel>
    </span>
</ContentTemplate>
</asp:UpdatePanel>
    </div>
    </div>
    
  <div class="NormalContentRight" style="margin-top:10px">
  <div style="font-size:24px;">
      <asp:UpdatePanel ID="UpdatePanel2" runat="server">
      <ContentTemplate>
CHOOSE YOUR WEBSITE ADDRESS
<br />
<table>
<tr>
<td>
HTTP://
</td>
<td>
<asp:TextBox ID="txtDomainName" runat="server" Width="140px" MaxLength="20"></asp:TextBox>     
</td>
<td>

    .THEQOFFICE.COM
</td>
<td>
    <asp:Button ID="btnSearch" runat="server" ForeColor="White" BackColor="Black"  ValidationGroup="grpAdd"
          Text="START SEARCH" onclick="btnSearch_Click" /> 

</td>
</tr>
<tr> 
<td></td>
<td>
    <asp:RequiredFieldValidator ID="reqxx"  Display="Dynamic" Font-Size="12px"
    runat="server" ErrorMessage="enter a value"  ControlToValidate="txtDomainName" 
       ValidationGroup="grpAdd" ></asp:RequiredFieldValidator>
    <asp:RegularExpressionValidator ID="req1" runat="server"  ValidationGroup="grpAdd" Font-Size="12px"
    ErrorMessage="only numbers and alphabets allowed" ControlToValidate="txtDomainName" Display="Dynamic"
     ValidationExpression="^[\d\w]+">
    </asp:RegularExpressionValidator>
    </td>
<td></td>
<td></td>
</tr>
<tr> 
<td colspan="4">
   <span style="color:Red; font-size:12px ">e.g. mybusiness.theqoffice.com, beautyshop.theqoffice.com</span>
    </td>
</tr>
</table>
          
          </ContentTemplate>
          </asp:UpdatePanel>
</div>
  </div>
  
  
  <div class="NormalContentRight" style="margin-top:30px; border:solid 1px #ff6600">
    <div style="font-size:24px;">
    SEARCH RESULTS
    </div><hr /><br />
      <asp:UpdatePanel ID="UpdatePanel1" runat="server">
      <ContentTemplate>
      <div style="font-size:24px;">
          <asp:Label ID="lblDomainResult" runat="server" ForeColor="Green"></asp:Label>
    </div>
      <asp:GridView ID="GVDomains" runat="server" Width="100%" BackColor="White"  Visible="false"
          BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" CellPadding="4" 
          ForeColor="Black" GridLines="Vertical" onrowcommand="GVDomains_RowCommand" 
              onrowcreated="GVDomains_RowCreated">
          <RowStyle BackColor="#F7F7DE" />
          <Columns>
              <asp:TemplateField ShowHeader="False" ItemStyle-Width="200px">
                  <ItemTemplate>
                  <center>
                      <asp:ImageButton ID="btnSelectDomain" runat="server" CausesValidation="false"  AlternateText="Select Domain"
                          CommandName="Select" CommandArgument='<%# Eval("Domain").ToString() %>' ToolTip="Select"
                           Enabled='<%# (Eval("Status").ToString() == "available")? true : false %>'
                           ImageUrl='<%# (Eval("Status").ToString() == "available")? "images/btnSelectDomain.png" :
                            "images/btnSelectDomain2.png" %>'/>
                  </center>
                  </ItemTemplate>
                  </asp:TemplateField>
                  
          </Columns>
          <EmptyDataTemplate>
          <center>
          No results available
          </center>
          </EmptyDataTemplate>
          <FooterStyle BackColor="#CCCC99" />
          <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
          <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
          <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
          <AlternatingRowStyle BackColor="White" />
      </asp:GridView>
      </ContentTemplate>
      </asp:UpdatePanel>
      
    <br />
    <div class="right">
        <asp:UpdatePanel ID="UpdatePanelProgress" runat="server">
        <ContentTemplate>
          <asp:Button ID="btnProgress" runat="server" Text="PROCEED >> CHOOSE TEMPLATE" 
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

