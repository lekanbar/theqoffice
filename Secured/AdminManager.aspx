<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="AdminManager.aspx.cs" Inherits="Secured_AdminManager" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:LinkButton ID="lnkRegister" runat="server" onclick="lnkRegister_Click">Jobs</asp:LinkButton>&nbsp;|&nbsp;
    <asp:LinkButton ID="lnkViewClients" runat="server" onclick="lnkViewClients_Click">View Clients</asp:LinkButton>&nbsp;|&nbsp;
    <asp:LinkButton ID="lnkChangePass" runat="server" onclick="lnkChangePass_Click">Change Password</asp:LinkButton>&nbsp;|&nbsp;
    <asp:LinkButton ID="lnkClientEmail" runat="server" onclick="lnkClientEmail_Click">Client Emails</asp:LinkButton>&nbsp;|&nbsp;
    <asp:LinkButton ID="lnkClientSMS" runat="server" onclick="lnkClientSMS_Click">Bulk SMS</asp:LinkButton>&nbsp;|&nbsp;
    <asp:LinkButton ID="lnkTransactions" runat="server" onclick="lnkTransactions_Click">Transactions</asp:LinkButton>
    <br />
    <asp:MultiView ID="mvwAdmin" runat="server" ActiveViewIndex="0">        
        <asp:View ID="vwRegister" runat="server">
            <asp:Panel ID="Panel1" runat="server" BackColor="#CCCCCC">
                    <br />
                    <br />
                    <asp:Label ID="Label2" runat="server" Text="Jobs Done/Undone" Font-Bold="True" Font-Size="X-Large"></asp:Label>
                    <br />
                    <asp:GridView ID="grdVwJobs" runat="server" DataSourceID="SDSUsers"  
                        AllowPaging="True" AutoGenerateColumns="False" Width="569px" DataKeyNames="ID" PageSize="20" 
                        onselectedindexchanged="grdVwJobs_SelectedIndexChanged" OnPageIndexChanging="grdVwJobs_PageIndexChanging">
                        <Columns>
                            <asp:CommandField SelectText="Done/Undone" ShowSelectButton="True" />
                            <asp:BoundField DataField="Status" HeaderText="Job Done" 
                                SortExpression="Status" />
                            <asp:BoundField DataField="Category" HeaderText="Category" 
                                SortExpression="Category" />
                            <asp:BoundField DataField="Description" HeaderText="Description" 
                                SortExpression="Description" />
                            <asp:BoundField DataField="SiteURL" HeaderText="SiteURL" 
                                SortExpression="SiteURL" />
                            <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                            <asp:BoundField DataField="LastName" HeaderText="LastName" 
                                SortExpression="LastName" />
                            <asp:BoundField DataField="FirstName" HeaderText="FirstName" 
                                SortExpression="FirstName" />
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="SDSUsers" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:QOfficeDBConnectionString %>" 
                        
                        SelectCommand="SELECT TQO_AdminJobs.ID, TQO_AdminJobs.Status, TQO_AdminJobsCategory.Category, TQO_Tenant.SiteURL, TQO_User.Email, TQO_User.LastName, TQO_User.FirstName, TQO_AdminJobs.AdminID, TQO_AdminJobs.ClientID, TQO_AdminJobs.Description FROM TQO_AdminJobs INNER JOIN TQO_AdminJobsCategory ON TQO_AdminJobs.Category = TQO_AdminJobsCategory.ID INNER JOIN TQO_User ON TQO_AdminJobs.AdminID = @AdminID AND TQO_AdminJobs.ClientID = TQO_User.UserID INNER JOIN TQO_Tenant ON TQO_User.UserID = TQO_Tenant.UserID AND TQO_User.UserID = TQO_Tenant.UserID ORDER BY TQO_AdminJobs.Status">
                        <SelectParameters>
                            <asp:SessionParameter Name="AdminID" SessionField="UserID" />
                        </SelectParameters>
                    </asp:SqlDataSource>
            </asp:Panel>
        </asp:View>
        
        <asp:View ID="vwUsers" runat="server">
            <asp:Panel ID="Panel2" runat="server" BackColor="#666666">
                <br />
                <br />
                <asp:Label ID="Label1" runat="server" Text="All Clients" Font-Bold="True" Font-Size="X-Large"></asp:Label>
                <br />
                <asp:Label ID="Label9" runat="server" Text="Enter Client Email or Name:" 
                    style="font-weight: 700"></asp:Label><br />
                <asp:TextBox ID="txtQuery3" runat="server" Height="32px" Width="299px"></asp:TextBox>
                &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" 
                    ControlToValidate="txtQuery3" ErrorMessage="*" ValidationGroup="ser"></asp:RequiredFieldValidator>
                &nbsp;&nbsp;
                <asp:Button ID="btnSearch2" runat="server" Text="Search" ValidationGroup="ser" 
                    onclick="btnSearch2_Click" />
                &nbsp;&nbsp;&nbsp;&nbsp;<asp:Button ID="btnRefresh2" runat="server" onclick="btnRefresh2_Click" 
                    Text="Refresh" />
                    <br />
                    <br />
                    <asp:LinkButton ID="lnkGenerateAccess" runat="server" 
                    onclick="lnkGenerateAccess_Click">Generate Access Code</asp:LinkButton>
                &nbsp;&nbsp;
                <asp:LinkButton ID="lnkLockUser" runat="server" onclick="lnkLockUser_Click">Lock User</asp:LinkButton>
                    &nbsp;
                <asp:LinkButton ID="lnkUnlockUser" runat="server" onclick="lnkUnlockUser_Click">Unlock User</asp:LinkButton>
                <br />
                    <br />
                <asp:GridView ID="grdVwClients" runat="server" AllowPaging="True" 
                    AutoGenerateColumns="False" DataKeyNames="UserID" DataSourceID="SDSClients" 
                    Width="561px" onselectedindexchanged="grdVwClients_SelectedIndexChanged">
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" />
                        <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                        <asp:BoundField DataField="LastName" HeaderText="LastName" 
                            SortExpression="LastName" />
                        <asp:BoundField DataField="FirstName" HeaderText="FirstName" 
                            SortExpression="FirstName" />
                        <asp:BoundField DataField="UserID" HeaderText="UserID" ReadOnly="True" 
                            SortExpression="UserID" />
                        <asp:CheckBoxField DataField="IsLockedOut" HeaderText="IsLockedOut" 
                            SortExpression="IsLockedOut" />
                    </Columns>
                </asp:GridView>
                <br />
                <asp:SqlDataSource ID="SDSTenantDetails" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:QOfficeDBConnectionString %>" 
                    SelectCommand="SELECT CompanyName, SiteURL, PhoneNumber, SetupDate, ExpiryDate, Address, City, State, Country, TemplatePageID FROM TQO_Tenant
                                                                                                         Where UserID = @UserID">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="grdVwClients" Name="UserID" 
                            PropertyName="SelectedValue" Type="Object" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="SDSTesterDetails" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:QOfficeDBConnectionString %>" 
                    SelectCommand="SELECT CompanyName, PageURL, PhoneNumber, SetupDate, Address, City, State, Country, TemplatePageID FROM TQO_Tester WHERE (UserID = @UserID)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="grdVwClients" Name="UserID" 
                            PropertyName="SelectedValue" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="SDSClients" runat="server" 
                ConnectionString="<%$ ConnectionStrings:QOfficeDBConnectionString %>" 
                SelectCommand="SELECT Email, LastName, FirstName, UserID, IsLockedOut FROM TQO_User WHERE RoleTypeID = 2 or RoleTypeID = 5">
            </asp:SqlDataSource>
                <asp:SqlDataSource ID="SDSSearch0" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:QOfficeDBConnectionString %>" 
                    SelectCommand="SELECT Email, LastName, FirstName, UserID, IsLockedOut FROM TQO_User WHERE (Email LIKE '%' + @Query + '%') OR (FirstName LIKE '%' + @Query + '%') OR (LastName LIKE '%' + @Query + '%')">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="txtQuery3" Name="Query" PropertyName="Text" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </asp:Panel>
        </asp:View>
        
        <asp:View ID="vwBulkSMS" runat="server">
            <asp:Panel ID="Panel3" runat="server" BackColor="#CCCCCC">
                <br />
                <br />
                <asp:Label ID="Label3" runat="server" Text="Credit Client Bulk SMS" 
                    Font-Bold="True" Font-Size="X-Large"></asp:Label>
                <br />
                <br />
                <asp:Label ID="Label4" runat="server" Text="Enter Client Email or Name:" 
                    style="font-weight: 700"></asp:Label><br />
                <asp:TextBox ID="txtQuery" runat="server" Height="32px" Width="299px"></asp:TextBox>
                &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                    ControlToValidate="txtQuery" ErrorMessage="*" ValidationGroup="ser"></asp:RequiredFieldValidator>
                &nbsp;&nbsp;
                <asp:Button ID="btnSearch" runat="server" Text="Search" ValidationGroup="ser" 
                    onclick="btnSearch_Click" />
                &nbsp;&nbsp;&nbsp;&nbsp;<asp:Button ID="btnRefresh" runat="server" onclick="btnRefresh_Click" 
                    Text="Refresh" />
                <br />
                <br />
                <asp:GridView ID="grdVwUser" runat="server" AutoGenerateColumns="False" 
                    DataSourceID="SDSBulkSMS" DataKeyNames="UserID" 
                    onselectedindexchanged="grdVwUser_SelectedIndexChanged" Width="567px">
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" />
                        <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                        <asp:BoundField DataField="FirstName" HeaderText="First Name" 
                            SortExpression="FirstName" />
                        <asp:BoundField DataField="LastName" HeaderText="Last Name" 
                            SortExpression="LastName" />
                        <asp:BoundField DataField="CompanyName" HeaderText="Company Name" 
                            SortExpression="CompanyName" />
                        <asp:BoundField DataField="SMSBalance" HeaderText="Balance" 
                            SortExpression="SMSBalance" />
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="SDSBulkSMS" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:QOfficeDBConnectionString %>" 
                    SelectCommand="SELECT  TQO_User.UserID, TQO_User.Email, TQO_User.FirstName, TQO_User.LastName, TQO_Tenant.CompanyName, TQO_Tenant.SMSBalance

FROM    TQO_User INNER JOIN
               TQO_Tenant ON TQO_User.UserID = TQO_Tenant.UserID AND TQO_User.UserID = TQO_Tenant.UserID

Where (([Email] LIKE '%' + @Query + '%') OR ([FirstName] LIKE '%' + @Query + '%') OR ([LastName] LIKE '%' + @Query + '%') OR ([CompanyName] LIKE '%' + @Query + '%'))">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="txtEmail" Name="Query" PropertyName="Text" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="SDSSearch" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:QOfficeDBConnectionString %>" 
                    SelectCommand="SELECT TQO_User.UserID, TQO_User.Email, TQO_User.FirstName, TQO_User.LastName, TQO_Tenant.CompanyName, TQO_Tenant.SMSBalance FROM TQO_User INNER JOIN TQO_Tenant ON TQO_User.UserID = TQO_Tenant.UserID AND TQO_User.UserID = TQO_Tenant.UserID WHERE (TQO_User.Email LIKE '%' + @Query + '%') OR (TQO_User.FirstName LIKE '%' + @Query + '%') OR (TQO_User.LastName LIKE '%' + @Query + '%')">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="txtQuery" Name="Query" PropertyName="Text" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <br />
                <asp:Label ID="lblAmount" runat="server" ForeColor="Red" Text="Enter Amount:" 
                    Visible="False"></asp:Label>
                &nbsp;<asp:TextBox ID="txtAmount" runat="server" Height="32px" Visible="False" 
                    Width="205px"></asp:TextBox>
&nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                    ControlToValidate="txtAmount" ErrorMessage="*" ValidationGroup="amt"></asp:RequiredFieldValidator>
                &nbsp;&nbsp;
                <asp:Button ID="btnCredit" runat="server" onclick="btnCredit_Click" 
                    Text="Credit" ValidationGroup="amt" Visible="False" />
            </asp:Panel>
        </asp:View>
        
        <asp:View ID="vwChangePassword" runat="server">
            <asp:Panel ID="Panel4" runat="server" BackColor="#CCCCCC">
                <br />
                <br />
                <asp:Label ID="Label8" runat="server" Text="Change Password" 
                        Font-Bold="True" Font-Size="X-Large"></asp:Label>
                <br />
                <br />
                <asp:Label ID="Label5" runat="server" Text="Old Password"></asp:Label>
                :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:TextBox ID="txtOldPassword" runat="server" TextMode="Password"></asp:TextBox>&nbsp;<asp:RequiredFieldValidator 
                    ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtOldPassword" 
                    ErrorMessage="*" ValidationGroup="cpass"></asp:RequiredFieldValidator>
                <br />
                <br />
                <asp:Label ID="Label6" runat="server" Text="New Password"></asp:Label>
                :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:TextBox ID="txtNewPassword" runat="server" TextMode="Password"></asp:TextBox>&nbsp;<asp:RequiredFieldValidator 
                    ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtNewPassword" 
                    ErrorMessage="*" ValidationGroup="cpass"></asp:RequiredFieldValidator>
                <br />
                <br />
                <asp:Label ID="Label7" runat="server" Text="Confirm Password"></asp:Label>
                :
                <asp:TextBox ID="txtConfirm" runat="server" TextMode="Password"></asp:TextBox>&nbsp;<asp:RequiredFieldValidator 
                    ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtConfirm" 
                    ErrorMessage="*" ValidationGroup="cpass"></asp:RequiredFieldValidator>
                &nbsp;<asp:CompareValidator ID="CompareValidator1" runat="server" 
                    ControlToCompare="txtNewPassword" ControlToValidate="txtConfirm" 
                    ErrorMessage="Password does not match" ValidationGroup="cpass"></asp:CompareValidator>
                <br />
                <br />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Button ID="btnOk" runat="server" Text="Submit" ValidationGroup="cpass" OnClick="btnOk_Click" />
            </asp:Panel>
        </asp:View>
        
        <asp:View ID="vwClientEmails" runat="server">
            <asp:Panel ID="Panel5" runat="server" BackColor="#CCCCCC">
                <asp:Label ID="Label10" runat="server" Text="Client Emails" 
                        Font-Bold="True" Font-Size="X-Large"></asp:Label>
                <br />
                <br />
                <asp:Label ID="lblUpStatus" Font-Bold="true" runat="server" Text="Update Client Email Status"></asp:Label>
                &nbsp;<br />
                <asp:TextBox ID="txtOpEmail" runat="server" CssClass="texts1" Width="194px"></asp:TextBox>
                &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" 
                    ControlToValidate="txtOpEmail" ErrorMessage="*" ValidationGroup="opemail"></asp:RequiredFieldValidator>
                &nbsp;<asp:Button ID="btnSetStatus" runat="server" Text="Set Active" 
                    ValidationGroup="opemail" onclick="btnSetStatus_Click" />
                <br />
                <br />
                <asp:Label ID="Label11" runat="server" Font-Bold="true" 
                    Text="Delete Client Email"></asp:Label>
                &nbsp;<br />
                <asp:TextBox ID="txtOpEmail2" runat="server" CssClass="texts1" Width="183px"></asp:TextBox>
                &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" 
                    ErrorMessage="*" ControlToValidate="txtOpEmail2" 
                    ValidationGroup="opemail2"></asp:RequiredFieldValidator>
&nbsp;<asp:Button ID="btnDeleteEmail" runat="server" Text="Delete" 
                    onclick="btnDeleteEmail_Click" Width="99px" ValidationGroup="opemail2" />
            </asp:Panel>
        </asp:View>
        
        <asp:View ID="vwTransactions" runat="server">
            <asp:Panel ID="Panel6" runat="server" BackColor="#CCCCCC">
            <br />
                    <br />
                <asp:Label ID="Label12" runat="server" Text="Client Transactions" 
                        Font-Bold="True" Font-Size="X-Large"></asp:Label>
                <br />
                <br />
                <asp:GridView ID="GVTranx" runat="server" Width="700px" BackColor="White" PageSize="10"
            BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" CellPadding="4" 
            ForeColor="Black" GridLines="Vertical" AutoGenerateColumns="false"  onrowcommand="GVTranx_RowCommand"
            AllowPaging="True" onpageindexchanging="GVTranx_PageIndexChanging">
            <Columns>
                <asp:TemplateField>
                      <ItemTemplate>
                        <asp:Button ID="btnSelectDomain" runat="server" Text="Query Status" CommandName="Select" 
                           CommandArgument='<%# Eval("TransactionID").ToString() %>'
                           Visible='<%# (Eval("Status").ToString().StartsWith("Pending"))? true : false %>' />
                      </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField ShowHeader="False">
                  <ItemTemplate>
                    <i> Transaction ID:</i> <%# Eval("TransactionID").ToString()%>
                       <br />
                       <i> Name:</i> <%# Eval("Name").ToString()%>
                       <br />
                       <i> Email:</i> <%# Eval("Email").ToString()%>
                       <br />
                       <i> Item:</i> <%# Eval("ItemDescription").ToString()%>
                       <br />
                       <i> Amount:</i> <%# Eval("Amount").ToString()%>
                       <br /><br />
                       <i> Response Code:</i> <%# Eval("ResponseCode").ToString()%>
                       <br />
                       <i style="color:Green;"> Status:</i> <%# Eval("Status").ToString()%>
                       <br />
                       <div style="font-size:12px; color:Maroon;">                       
                            <span class="right">
                            <i>date:</i> <%# Eval("Date").ToString() %>
                            </span>
                        </div>
                  </ItemTemplate>
                  </asp:TemplateField>
          </Columns>
            <EmptyDataTemplate>
            <center>
            NO ITEMS HAVE BEEN CREATED YET!
            </center>
            
            </EmptyDataTemplate>
        <RowStyle BackColor="#F7F7DE" />
        <FooterStyle BackColor="#CCCC99" />
        <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
        <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
        <AlternatingRowStyle BackColor="White" />
    </asp:GridView>    <br />
    <asp:LinkButton ID="lnkSuccess" runat="server" OnClick="lnkSuccess_Click">Successful Transactions</asp:LinkButton>&nbsp;|&nbsp;
            <asp:LinkButton ID="lnkUnSuccess" runat="server" OnClick="lnkUnSuccess_Click">UnSuccessful Transactions</asp:LinkButton>&nbsp;|&nbsp;
            <asp:LinkButton ID="lnkPending" runat="server" OnClick="lnkPending_Click">Pending Transactions</asp:LinkButton>
            </asp:Panel>
        </asp:View>
    </asp:MultiView>
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
    <TQO:ResultNotification ID="Notification" runat="server" />
    </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

