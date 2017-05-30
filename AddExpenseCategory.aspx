<%@ Page Title="" Language="C#" MasterPageFile="~/MyMaster.Master" AutoEventWireup="true" CodeBehind="AddExpenseCategory.aspx.cs" Inherits="WebPoultryFarmManager.AddExpenseCategory" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table class="tblExpenseCategory" cellpadding="4" cellspacing="4">
        <tr>
            <td></td>
            <td>
                <asp:Label ID="lblMainTitle" runat="server" CssClass="maintitle" Text="Add Expense Category" style="padding-top:5px; padding-bottom:10px;"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblExpenseCategory" runat="server" Text="Expense Category Name"></asp:Label>
                
            </td>
            <td>
                <asp:TextBox ID="txtExpenseCategory" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvExpenseCategory" runat="server" ErrorMessage="*" ControlToValidate="txtExpenseCategory"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td></td>
            <td>
                <asp:Button ID="btnAddExpenseCategory" runat="server" Text="Add Expense Category" OnClick="btnAddExpenseCategory_Click" />
            </td>
        </tr>
    </table>
</asp:Content>
