<%@ Page Title="Edit User" Language="C#" MasterPageFile="~/MyMaster.Master" AutoEventWireup="true" CodeBehind="EditUser.aspx.cs" Inherits="WebPoultryFarmManager.EditUser" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table class="tblAddUser" cellpadding="4" cellspacing="4">
        <tr>
            <td></td>
            <td>
                <asp:Label ID="lblMainTitle" runat="server" CssClass="maintitle" Text="Edit User" style="padding-top:5px; padding-bottom:10px;"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblFirstName" runat="server" Text="First Name"></asp:Label>
                
            </td>
            <td>
                <asp:TextBox ID="txtFirstName" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvFirstName" runat="server" ErrorMessage="*" ControlToValidate="txtFirstName"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td><asp:Label ID="lblMiddleName" runat="server" Text="Middle Name"></asp:Label></td>
            <td><asp:TextBox ID="txtMiddleName" runat="server"></asp:TextBox></td>
        </tr>
        <tr>
            <td><asp:Label ID="lblLastName" runat="server" Text="Last Name"></asp:Label></td>
            <td>
                <asp:TextBox ID="txtLastName" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvLastName" runat="server" ErrorMessage="*" ControlToValidate="txtLastName"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td><asp:Label ID="lblLandlineNo" runat="server" Text="Landline No."></asp:Label></td>
            <td><asp:TextBox ID="txtLandlineNo" runat="server"></asp:TextBox></td>
        </tr>
        <tr>
            <td><asp:Label ID="lblMobileNo" runat="server" Text="Mobile No."></asp:Label></td>
            <td><asp:TextBox ID="txtMobileNo" runat="server"></asp:TextBox></td>
        </tr>
        <tr>
            <td><asp:Label ID="lblAddress" runat="server" Text="Address"></asp:Label></td>
            <td><asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine"></asp:TextBox></td>
        </tr>
        <tr>
            <td><asp:Label ID="lblUserType" runat="server" Text="User Type"></asp:Label></td>
            <td>
                <asp:DropDownList ID="ddlUserType" runat="server">
                    <asp:ListItem Text="--Select--" Value="-1"></asp:ListItem>
                    <asp:ListItem Text="Farmer" Value="1"></asp:ListItem>
                    <asp:ListItem Text="Customer" Value="2"></asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvUserType" runat="server" ErrorMessage="*" InitialValue="-1" ControlToValidate="ddlUserType"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td></td>
            <td>
                <asp:Button ID="btnUpdateUser" runat="server" Text="Update User" OnClick="btnUpdateUser_Click" />
            </td>
        </tr>
    </table>
</asp:Content>
