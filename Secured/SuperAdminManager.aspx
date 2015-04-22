<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="SuperAdminManager.aspx.cs" Inherits="Secured_SuperAdminManager" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<br />
<br />
                    WHAT WOULD YOU LIKE TO DO?
                    <br />
                    <asp:DropDownList ID="DDLToDo" runat="server" AutoPostBack="true"
                     OnSelectedIndexChanged="DDLToDo_SelectedIndexChanged" 
        Height="16px" Width="265px">
                        <asp:ListItem Text="-- please select --"></asp:ListItem>
                        <asp:ListItem Text="View Marketers" Value="SuperAdminManager.aspx?vw=5" ></asp:ListItem>
                        <asp:ListItem Text="Add Marketer" Value="SuperAdminManager.aspx?vw=6" ></asp:ListItem>
                        <asp:ListItem Text="View Sales" Value="SuperAdminManager.aspx?vw=7"></asp:ListItem>
                        <asp:ListItem Text="View Logs" Value="SuperAdminManager.aspx?vw=3"></asp:ListItem>
                        <asp:ListItem Text="View Clients" Value="SuperAdminManager.aspx?vw=2"></asp:ListItem>
                        <asp:ListItem Text="Create Admin User" Value="SuperAdminManager.aspx?vw=0"></asp:ListItem>
                        <asp:ListItem Text="View Admin Users" Value="SuperAdminManager.aspx?vw=1"></asp:ListItem>
                    </asp:DropDownList>
    <br />
    <asp:MultiView ID="mvwAdmin" runat="server" ActiveViewIndex="0">
        <asp:View ID="vwAddAdmin" runat="server">
            <asp:Panel ID="Panel1" runat="server" BackColor="#CCCCCC">
                <asp:Label ID="Label1" runat="server" Text="Create Admin User" Font-Bold="True" Font-Size="X-Large"></asp:Label>
                <br />
                <br />
                <asp:Label ID="Label2" runat="server" Text="First Name:"></asp:Label>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:TextBox ID="txtFirstName" runat="server"></asp:TextBox>&nbsp;<asp:RequiredFieldValidator 
                    ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtFirstName" 
                    ErrorMessage="*" ValidationGroup="grpAdmin"></asp:RequiredFieldValidator>
                <br />
                <br />
                <asp:Label ID="Label3" runat="server" Text="Last Name:"></asp:Label>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:TextBox ID="txtLastName" runat="server"></asp:TextBox>&nbsp;<asp:RequiredFieldValidator 
                    ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtLastName" 
                    ErrorMessage="*" ValidationGroup="grpAdmin"></asp:RequiredFieldValidator>
                <br />
                <br />
                <asp:Label ID="Label5" runat="server" Text="Email:"></asp:Label>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:TextBox ID="txtEmail" runat="server"></asp:TextBox>&nbsp;<asp:RequiredFieldValidator 
                    ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtEmail" 
                    ErrorMessage="*" ValidationGroup="grpAdmin"></asp:RequiredFieldValidator>
                <br />
                <br />
                <asp:Label ID="Label4" runat="server" Text="Default Password:"></asp:Label>
                &nbsp;&nbsp;
                <asp:TextBox ID="txtPassword" runat="server"></asp:TextBox>
                &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                    ControlToValidate="txtPassword" ErrorMessage="*" ValidationGroup="grpAdmin"></asp:RequiredFieldValidator>
                <br />
                <br />
                <asp:Label ID="Label6" runat="server" Text="User Category:"></asp:Label>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:DropDownList ID="drpUsers" runat="server" Width="128px">
                    <asp:ListItem Text="Admin" Value="3" Selected="True"></asp:ListItem>
                    <asp:ListItem Text="Super Admin" Value="4"></asp:ListItem>
                </asp:DropDownList>
                <br />
                <br />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Button ID="btnClear" runat="server" Text="Clear" 
                    onclick="btnClear_Click" ValidationGroup="grpAdmin" />
                &nbsp;&nbsp;&nbsp;
                <asp:Button ID="btnSubmit" runat="server" Text="Submit" 
                    onclick="btnSubmit_Click" ValidationGroup="grpAdmin" />
            </asp:Panel>
        </asp:View>
        <asp:View ID="vwChangeRole" runat="server">
            <asp:Panel ID="Panel4" runat="server" BackColor="#CCCCCC">
                <asp:Label ID="Label9" runat="server" Text="Admin Users" Font-Bold="True" 
                    Font-Size="X-Large"></asp:Label>
                <br />
                <br />
                <asp:GridView ID="grdVwAdminUsers" runat="server" AllowPaging="True" 
                    AutoGenerateColumns="False" DataKeyNames="UserID" 
                    DataSourceID="SDSGetAdminUsers" Width="570px" AllowSorting="True">
                    <Columns>
                        <asp:CommandField ShowEditButton="True" />
                        <asp:BoundField DataField="RoleTypeID" HeaderText="Role Type" 
                            SortExpression="RoleTypeID" />
                        <asp:BoundField DataField="FirstName" HeaderText="First Name" 
                            SortExpression="FirstName" />
                        <asp:BoundField DataField="LastName" HeaderText="Last Name" 
                            SortExpression="LastName" />
                        <asp:BoundField DataField="LastLoginDate" HeaderText="Last Login" 
                            SortExpression="LastLoginDate" />
                        <asp:CheckBoxField DataField="IsLockedOut" HeaderText="Locked Out" 
                            SortExpression="IsLockedOut" />
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="SDSGetAdminUsers" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:QOfficeDBConnectionString %>" 
                    SelectCommand="SELECT * FROM [TQO_User] WHERE ([RoleTypeID] = 3)">
                </asp:SqlDataSource>
                <br />
            </asp:Panel>
        </asp:View>
        <asp:View ID="vwAllUsers" runat="server">
            <asp:Panel ID="Panel2" runat="server" BackColor="#CCCCCC">
                <asp:Label ID="Label7" runat="server" Text="All Clients" Font-Bold="True" Font-Size="X-Large"></asp:Label>
                <br />
                <br />
                    <asp:GridView ID="grdVwClients" runat="server" AllowPaging="True" 
                        AutoGenerateColumns="False" DataKeyNames="UserID" DataSourceID="SDSClients" 
                        Width="571px" AllowSorting="True">
                        <Columns>
                            <asp:CommandField ShowSelectButton="True" />
                            <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                            <asp:BoundField DataField="LastName" HeaderText="Last Name" 
                                SortExpression="LastName" />
                            <asp:BoundField DataField="FirstName" HeaderText="First Name" 
                                SortExpression="FirstName" />
                            <asp:CheckBoxField DataField="IsLockedOut" HeaderText="Locked Out" 
                                ReadOnly="True" SortExpression="IsLockedOut" />
                        </Columns>
                    </asp:GridView><br />
                    <asp:DetailsView ID="dvwDetails" runat="server" Height="50px" Width="561px" 
                    DataSourceID="SDSTenantDetails">
                    </asp:DetailsView>
                    <asp:SqlDataSource ID="SDSTenantDetails" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:QOfficeDBConnectionString %>" 
                        SelectCommand="SELECT CompanyName, SiteURL, PhoneNumber, SetupDate, ExpiryDate, Address, City, State, Country, TemplatePageID FROM TQO_Tenant
                                                                                                             Where UserID = @UserID">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="grdVwClients" Name="UserID" 
                                PropertyName="SelectedValue" Type="Object" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:SqlDataSource ID="SDSClients" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:QOfficeDBConnectionString %>" 
                        SelectCommand="SELECT Email, LastName, FirstName, UserID, IsLockedOut FROM TQO_User WHERE RoleTypeID = 2 or RoleTypeID = 5">
                    </asp:SqlDataSource>
            </asp:Panel>
        </asp:View> 
        <asp:View ID="vwLogs" runat="server">
        <asp:Panel ID="Panel3" runat="server" BackColor="#666666">
            <asp:Label ID="Label8" runat="server" Text="View Logs" Font-Bold="True" Font-Size="X-Large"></asp:Label>
            <br />
            <br />
            &nbsp;<asp:Label ID="Label10" runat="server" Text="Enter Email or Name:"></asp:Label>
            &nbsp;<asp:TextBox ID="txtQuery" runat="server" Width="256px" ValidationGroup="grpLogs"></asp:TextBox>
            &nbsp;
            <asp:Button ID="btnSearch" runat="server" onclick="cmdSearch_Click" 
                Text="Search" ValidationGroup="grpLogs" />
            &nbsp;
            <asp:Button ID="btnRefresh" runat="server" onclick="btnRefresh_Click" 
                Text="Refresh" ValidationGroup="grpLogs" />
            <br />
            <br />
            <asp:GridView ID="grdVwLogs" runat="server" AutoGenerateColumns="False" 
                DataSourceID="SDSLogs" Width="569px">
                <Columns>
                    <asp:BoundField DataField="LogID" HeaderText="Log ID" ReadOnly="True" 
                        SortExpression="LogID" />
                    <asp:BoundField DataField="UserID" HeaderText="User ID" 
                        SortExpression="UserID" />
                    <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title" />
                    <asp:BoundField DataField="Details" HeaderText="Details" 
                        SortExpression="Details" />
                    <asp:BoundField DataField="DateCreated" HeaderText="Date Created" 
                        SortExpression="DateCreated" />
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="SDSLogs" runat="server" 
                ConnectionString="<%$ ConnectionStrings:QOfficeDBConnectionString %>" 
                SelectCommand="SELECT * FROM [TQO_Logs]"></asp:SqlDataSource>
            <asp:SqlDataSource ID="SDSLogSearch" runat="server" 
                ConnectionString="<%$ ConnectionStrings:QOfficeDBConnectionString %>" 
                
                SelectCommand="SELECT TQO_Logs.LogID, TQO_Logs.UserID, TQO_Logs.Title, TQO_Logs.Details, TQO_Logs.DateCreated FROM TQO_Logs INNER JOIN TQO_User ON TQO_Logs.UserID = TQO_User.UserID WHERE (TQO_Logs.UserID = (SELECT UserID FROM TQO_User AS TQO_User_1 WHERE (Email LIKE '%' + @Query + '%') OR (FirstName LIKE '%' + @Query + '%') OR (LastName LIKE '%' + @Query + '%')))">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtQuery" Name="Query" PropertyName="Text" />
                </SelectParameters>
            </asp:SqlDataSource>
            <br />
        </asp:Panel>
    </asp:View>
        <asp:View ID="vwSitePrices" runat="server">
            <asp:Panel ID="Panel5" runat="server" BackColor="#CCCCCC">
                <asp:Label ID="Label11" runat="server" Text="Site Prices" Font-Bold="True" Font-Size="X-Large"></asp:Label>
                <br />
                <br />
                <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" 
                    DataSourceID="SDSSitePrices" Width="474px">
                    <Columns>
                        <asp:BoundField DataField="Price" HeaderText="Price" SortExpression="Price" />
                        <asp:BoundField DataField="Category" HeaderText="Category" 
                            SortExpression="Category" />
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="SDSSitePrices" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:QOfficeDBConnectionString %>" 
                    SelectCommand="SELECT [Price], [Category] FROM [TQO_SitePrices]">
                </asp:SqlDataSource>
                <br />
                
            </asp:Panel>
    </asp:View>
        <asp:View ID="vwMarketers" runat="server">
            <asp:Panel ID="Panel6" runat="server" BackColor="#CCCCCC">
                <asp:Label ID="Label12" runat="server" Text="Marketers" Font-Bold="True" 
                    Font-Size="X-Large"></asp:Label>
                <br />
                <br />
                Enter Marketer&#39;s Code, Name or Email<br />
                <asp:TextBox ID="txtQuery2" runat="server" Width="229px"></asp:TextBox>
&nbsp;
                <asp:Button ID="btnSearch2" runat="server" Text="Search" 
                    onclick="btnSearch2_Click" />
                &nbsp;
                <asp:Button ID="btnRefresh2" runat="server" Text="Refresh" 
                    onclick="btnRefresh2_Click" />
                <br />
                <br />
                <asp:GridView ID="grdVwMarketers" runat="server" AutoGenerateColumns="False" 
                    DataKeyNames="ID" DataSourceID="SDSMarketers">
                    <Columns>
                        <asp:BoundField DataField="Code" HeaderText="Code" SortExpression="Code" />
                        <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                        <asp:BoundField DataField="Address" HeaderText="Address" 
                            SortExpression="Address" />
                        <asp:BoundField DataField="PhoneNumber" HeaderText="Phone Number" 
                            SortExpression="PhoneNumber" />
                        <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                        <asp:BoundField DataField="NoOfCustomers" HeaderText="Customers" 
                            SortExpression="NoOfCustomers" />
                        <asp:CheckBoxField DataField="IsLocked" HeaderText="IsLocked" 
                            SortExpression="IsLocked" />
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="SDSMarketers" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:QOfficeDBConnectionString %>" 
                    SelectCommand="SELECT * FROM [TQO_Marketer] ORDER BY [NoOfCustomers] DESC">
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="SDSMarketerSearch" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:QOfficeDBConnectionString %>" 
                    SelectCommand="Select * from TQO_Marketer
     WHERE ((Code LIKE '%' + @Query + '%') OR (Name LIKE '%' + @Query + '%') OR (Email LIKE '%' + @Query + '%')) ">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="txtQuery2" Name="Query" PropertyName="Text" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </asp:Panel>
        </asp:View>
        <asp:View ID="vwAddMarketer" runat="server">
            <asp:Panel ID="Panel7" runat="server" BackColor="#CCCCCC">
                <asp:Label ID="Label13" runat="server" Text="Add Marketer" Font-Bold="True" Font-Size="X-Large"></asp:Label>
                <br />
                <br />
                <table>
                <tr>
                    <td>
                        Code:&nbsp;<asp:TextBox ID="txtCode" runat="server" MaxLength="50"></asp:TextBox>
                    </td>
                    <td>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" 
                            ErrorMessage="enter a value" Display="Dynamic"
                         ValidationGroup="grpMar" ControlToValidate="txtCode" 
                            style="text-align: left"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>
                        Name:&nbsp;<asp:TextBox ID="txtName" runat="server" MaxLength="70"></asp:TextBox>
                    </td>
                    <td>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" 
                            ErrorMessage="enter a value" Display="Dynamic"
                         ValidationGroup="grpMar" ControlToValidate="txtName" 
                            style="text-align: left"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>
                        Phone Number:&nbsp;<asp:TextBox ID="txtPhoneNumber" runat="server" MaxLength="50"></asp:TextBox>
                    </td>
                    <td>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" 
                            ErrorMessage="enter a value" Display="Dynamic"
                         ValidationGroup="grpMar" ControlToValidate="txtPhoneNumber" 
                            style="text-align: left"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>
                        Email:&nbsp;<asp:TextBox ID="txtEmail2" runat="server" MaxLength="80"></asp:TextBox>
                    </td>
                    <td>
                        <asp:RequiredFieldValidator ID="reqDetails" runat="server" 
                            ErrorMessage="enter a value" Display="Dynamic"
                         ValidationGroup="grpMar" ControlToValidate="txtEmail2" 
                            style="text-align: left"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>
                        Address:&nbsp;<asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine"></asp:TextBox>
                    </td>
                    <td>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" 
                            ErrorMessage="enter a value" Display="Dynamic"
                         ValidationGroup="grpMar" ControlToValidate="txtAddress" 
                            style="text-align: left"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Button ID="btnCreate" runat="server" Text="Create" 
                            ValidationGroup="grpMar" onclick="btnCreate_Click" />
                    </td>
                </tr>
                </table>
            </asp:Panel>
        </asp:View>
        <asp:View ID="vwMarketing" runat="server">
            <asp:Panel ID="Panel8" runat="server" BackColor="#CCCCCC">
                <asp:Label ID="Label14" runat="server" Text="Marketing and Sales" Font-Bold="True" Font-Size="X-Large"></asp:Label>
                <br />
                <br />
                Enter Marketer&#39;s Code, Name or Email<br />
                <asp:TextBox ID="txtQuery3" runat="server" Width="229px"></asp:TextBox>
&nbsp;
                <asp:Button ID="btnSearch3" runat="server" Text="Search" 
                    onclick="btnSearch3_Click" />
                <br />
                <br />
                <asp:GridView ID="grdVwMarketerUser" runat="server" AutoGenerateColumns="False" 
                    DataKeyNames="ID" DataSourceID="SDSMarketerUser">
                    <Columns>
                        <asp:BoundField DataField="Code" HeaderText="Code" SortExpression="Code" />
                        <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                        <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                        <asp:BoundField DataField="NoOfCustomers" HeaderText="Customers" 
                            SortExpression="NoOfCustomers" />
                        <asp:BoundField DataField="UserID" HeaderText="UserID" 
                            SortExpression="UserID" />
                        <asp:BoundField DataField="DateRegistered" HeaderText="DateRegistered" 
                            SortExpression="DateRegistered" />
                        <asp:BoundField DataField="Amount" HeaderText="Amount" 
                            SortExpression="Amount" />
                        <asp:CheckBoxField DataField="CommissionPaid" HeaderText="CommissionPaid" 
                            SortExpression="CommissionPaid" />
                        <asp:BoundField DataField="TransactionType" HeaderText="TransactionType" 
                            SortExpression="TransactionType" />
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="SDSMarketerUser" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:QOfficeDBConnectionString %>" 
                    SelectCommand="Select m.*, mu.* from TQO_Marketer m Inner join TQO_MarketerUser mu
     on m.ID = mu.MarketerID
     WHERE ((m.Code LIKE '%' + @Query + '%') OR (m.Name LIKE '%' + @Query + '%') OR (m.Email LIKE '%' + @Query + '%'))">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="txtQuery3" Name="Query" PropertyName="Text" 
                            Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <br />
                
            </asp:Panel>
        </asp:View>
    </asp:MultiView>
    
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
    <TQO:ResultNotification ID="Notification" runat="server" />
    </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

