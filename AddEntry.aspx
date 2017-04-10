<%@ Page Title="" Language="C#" MasterPageFile="~/MyMaster.Master" AutoEventWireup="true" CodeBehind="AddEntry.aspx.cs" Inherits="WebPoultryFarmManager.AddEntry" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:UpdatePanel ID="upnlAddEntry" runat="server">
        <ContentTemplate>
            <table class="tblAddEntry" cellpadding="4" cellspacing="4">
                <tr>
                    <td></td>
                    <td>
                        <asp:Label ID="lblMainTitle" runat="server" CssClass="maintitle" Text="Add Entry In Book" style="padding-top:5px; padding-bottom:10px;"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblEntryDate" runat="server" Text="Date"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtEntryDate" runat="server" ReadOnly="true" class="txtReadOnly"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblUserType" runat="server" Text="User Type"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlUserType" runat="server" CssClass="ddl" AutoPostBack="true" OnSelectedIndexChanged="ddlUserType_SelectedIndexChanged">
                            <asp:ListItem Text="--Select--" Value="-1"></asp:ListItem>
                            <asp:ListItem Text="Farmer" Value="1"></asp:ListItem>
                            <asp:ListItem Text="Customer" Value="2"></asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="rfvUserType" runat="server" ErrorMessage="*" ControlToValidate="ddlUserType" InitialValue="-1"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblUser" runat="server" Text="User"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlUsers" runat="server" CssClass="ddl" Enabled="false" AutoPostBack="true" OnSelectedIndexChanged="ddlUsers_SelectedIndexChanged">
                            <asp:ListItem Text="--Select--" Value="-1"></asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="rfvUser" runat="server" Enabled="false" ErrorMessage="*" ControlToValidate="ddlUsers" InitialValue="-1"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblTotalWeight" runat="server" Text="Total Weight"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtTotalWeight" runat="server" Enabled="false" onkeypress="return ValidateInput(event)"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvTotalWeight" runat="server" ErrorMessage="*" Enabled="false" ControlToValidate="txtTotalWeight"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblpieces" runat="server" Text="Pieces"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtPieces" runat="server" Enabled="false" onkeypress="return ValidateInput(event)"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvPieces" runat="server" Enabled="false" ErrorMessage="*" ControlToValidate="txtPieces"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblPrice" runat="server" Text="Price (per kg)"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtPrice" runat="server" Enabled="false" onkeypress="return ValidateInput(event)"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvPrice" runat="server" Enabled="false" ErrorMessage="*" ControlToValidate="txtPrice"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblTotalPrice" runat="server" Text="Total Price"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtTotalPrice" runat="server" ReadOnly="true" class="txtReadOnly" onkeypress="return ValidateInput(event)" Text="0.00"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvTotalPrice" runat="server" Enabled="false" ErrorMessage="*" ControlToValidate="txtTotalPrice"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblPreviousBalance" runat="server" Text="Previous Balance"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtPreviousBalance" runat="server" ReadOnly="true" Text="0.00" class="txtReadOnly"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblAmountPaid" runat="server" Text="Amount Paid"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtAmountPaid" runat="server" Enabled="false" onkeypress="return ValidateInput(event)" Text="0.00"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvAmountPaid" runat="server" Enabled="false" ErrorMessage="*" ControlToValidate="txtAmountPaid"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblTotalBalance" runat="server" Text="Total Balance"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtTotalBalance" runat="server" ReadOnly="true" Text="0.00" class="txtReadOnly"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblDescription" runat="server" Text="Description"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Enabled="false" style="width: 230px; height: 100px;"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <asp:Button ID="btnSaveRecord" runat="server" Text="Save Record" OnClick="btnSaveRecord_Click" />
                    </td>
                </tr>
            </table>
            <asp:HiddenField ID="hdnIsSaved" runat="server" />
        </ContentTemplate>
    </asp:UpdatePanel>

    <script type="text/javascript">
        $(document).ready(function () {
            $('#<%=txtPrice.ClientID%>').keyup(function () {
                CalculateFields();
            });
        });

        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(on_post_backcall);

        function on_post_backcall() {
            $('#<%=txtTotalWeight.ClientID%>').keyup(function () {
                CalculateFields();
            });

            $('#<%=txtPrice.ClientID%>').keyup(function () {
                CalculateFields();
            });

            $('#<%=txtAmountPaid.ClientID%>').keyup(function () {
                CalculateFields();
            });

            //CalculateFields();

            var isSaved = $('input[id$=<%=hdnIsSaved.ClientID%>]').val();
            if (isSaved != "" && isSaved == "true")
                alert("Entry saved successfully.");
            else if (isSaved != "" && isSaved == "false")
                alert("There is an invalid input, please correct it first then try again.");
        }

        function CalculateFields() {
            var totalWeight = $('#<%=txtTotalWeight.ClientID%>').val();
            var price = $('#<%=txtPrice.ClientID%>').val();
            var totalPrice = $('#<%=txtTotalPrice.ClientID%>').val();
            var prevBalance = $('#<%=txtPreviousBalance.ClientID%>').val();
            var amountpaid = $('#<%=txtAmountPaid.ClientID%>').val();
            var totalBalance = $('#<%=txtTotalBalance.ClientID%>').val();

            totalWeight = (totalWeight == "" ? 0 : Number(totalWeight));
            price = (price == "" ? 0 : Number(price));
            totalPrice = (totalPrice == "" ? 0 : Number(totalPrice));
            prevBalance = (prevBalance == "" ? 0 : Number(prevBalance));
            amountpaid = (amountpaid == "" ? 0 : Number(amountpaid));
            totalBalance = (totalBalance == "" ? 0 : Number(totalBalance));

            $('#<%=txtTotalPrice.ClientID%>').val(Number(totalWeight * price).toFixed(2));

            $('#<%=txtTotalBalance.ClientID%>').val(Number(((totalWeight * price) + prevBalance) - amountpaid).toFixed(2));
        }

        function ValidateInput(evt) {
            evt = (evt) ? evt : window.event;
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            
            //Allow period
            if (charCode == 46)
                return true;

            if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                return false;
            }
            return true;
        }
    </script>
</asp:Content>
