<%@ Page Title="View Entries" Language="C#" MasterPageFile="~/MyMaster.Master" AutoEventWireup="true" CodeBehind="ViewEntries.aspx.cs" Inherits="WebPoultryFarmManager.ViewEntries" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="mainHeading">View Entries</div>
    <div style="width: 100%; text-align: center;">
        <table style="display:inline;">
            <tr>
                <td>
                    <asp:Label ID="lblUserType" runat="server" Text="User Type" style="font-weight:bold;"></asp:Label>
                </td>
                <td>
                    <asp:DropDownList ID="ddlUserType" runat="server" CssClass="ddl" AutoPostBack="true" OnSelectedIndexChanged="ddlUserType_SelectedIndexChanged">
                        <asp:ListItem Text="--Select--" Value="-1"></asp:ListItem>
                        <asp:ListItem Text="Farmer" Value="1"></asp:ListItem>
                        <asp:ListItem Text="Customer" Value="2"></asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td>
                    <asp:Label ID="lblUser" runat="server" Text="User" style="font-weight:bold; padding-left:15px;"></asp:Label>
                </td>
                <td>
                    <asp:DropDownList ID="ddlUsers" runat="server" CssClass="ddl" Enabled="false" AutoPostBack="true" OnSelectedIndexChanged="ddlUsers_SelectedIndexChanged">
                        <asp:ListItem Text="--Select--" Value="-1"></asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
        <div style="width:100%; padding-top:15px; padding-bottom:15px;">
            <div style="width:100%; text-align:left;padding-bottom:15px;">
                <asp:Label ID="lblSelectedUser" runat="server" style="text-align:left; font-weight:bold; font-size:18px;"></asp:Label><br />
                <asp:Label ID="lblTotalBalance" runat="server" style="text-align:left; font-weight:bold; font-size:18px;"></asp:Label>
            </div>
            <asp:GridView ID="gvUserEntries" runat="server" Width="100%" AutoGenerateColumns="False" CellPadding="4" EnableModelValidation="True" ForeColor="#333333" GridLines="None" EmptyDataText="No record found :-(">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:BoundField DataField="Date" HeaderText="Date" />
                    <asp:BoundField DataField="TotalWeight" HeaderText="Total Weight" />
                    <asp:BoundField DataField="Pieces" HeaderText="Pieces" />
                    <asp:BoundField DataField="Price" HeaderText="Price" />
                    <asp:BoundField DataField="TotalPrice" HeaderText="Total Price" />
                    <asp:BoundField DataField="PreviousBalance" HeaderText="Previous Balance" />
                    <asp:BoundField DataField="Paid" HeaderText="Amount Paid" />
                    <asp:BoundField DataField="TotalBalance" HeaderText="Total Balance" />
                    <asp:BoundField DataField="Description" HeaderText="Description" />
                </Columns>
                <EditRowStyle BackColor="#2461BF" />
                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#EFF3FB" />
                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            </asp:GridView>
        </div>
    </div>
</asp:Content>
