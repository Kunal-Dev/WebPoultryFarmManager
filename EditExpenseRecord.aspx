<%@ Page Title="" Language="C#" MasterPageFile="~/MyMaster.Master" AutoEventWireup="true" CodeBehind="EditExpenseRecord.aspx.cs" Inherits="WebPoultryFarmManager.EditExpenseRecord" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:updatepanel id="upnlAddExpenseRecord" runat="server">
        <ContentTemplate>
            <table class="tblAddEntry" cellpadding="4" cellspacing="4">
                <tr>
                    <td></td>
                    <td>
                        <asp:Label ID="lblMainTitle" runat="server" CssClass="maintitle" Text="Edit Expense Record" style="padding-top:5px; padding-bottom:10px;"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblEntryDate" runat="server" Text="Date"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtEntryDate" runat="server" ReadOnly="true" class="txtReadOnly" style="width:160px;"></asp:TextBox>
                        <asp:Calendar ID="Calendar1" runat="server" BackColor="White" BorderColor="#3366CC" BorderWidth="1px" CellPadding="1" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="#003399" Height="200px" OnSelectionChanged="Calendar1_SelectionChanged" SelectionMode="DayWeekMonth" Width="220px">
                            <DayHeaderStyle BackColor="#99CCCC" ForeColor="#336666" Height="1px" />
                            <NextPrevStyle Font-Size="8pt" ForeColor="#CCCCFF" />
                            <OtherMonthDayStyle ForeColor="#999999" />
                            <SelectedDayStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                            <SelectorStyle BackColor="#99CCCC" ForeColor="#336666" />
                            <TitleStyle BackColor="#003399" BorderColor="#3366CC" BorderWidth="1px" Font-Bold="True" Font-Size="10pt" ForeColor="#CCCCFF" Height="25px" />
                            <TodayDayStyle BackColor="#99CCCC" ForeColor="White" />
                            <WeekendDayStyle BackColor="#CCCCFF" />
                        </asp:Calendar>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblExpenseCategoryType" runat="server" Text="Expense Category Type"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlExpCat" runat="server" CssClass="ddl" AutoPostBack="true">
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="rfvExpCatType" runat="server" ErrorMessage="*" ControlToValidate="ddlExpCat" InitialValue="-1"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblPrice" runat="server" Text="Cost"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtExepnseCost" runat="server" onkeypress="return ValidateInput(event)"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvExpCost" runat="server" ErrorMessage="*" ControlToValidate="txtExepnseCost"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblDescription" runat="server" Text="Description"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" style="width: 230px; height: 100px;"></asp:TextBox>
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
            <asp:HiddenField ID="hdnIsCorrectDate" runat="server" />
        </ContentTemplate>
    </asp:updatepanel>

    <script type="text/javascript">
        function ValidateInput(evt) {
            evt = (evt) ? evt : window.event;
            var charCode = (evt.which) ? evt.which : evt.keyCode;

            //Allow period
            if (charCode == 46 || charCode == 37 || charCode == 39)
                return true;

            if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                return false;
            }
            return true;
        }

        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(on_post_backcall);

        function on_post_backcall() {
            var isSaved = $('input[id$=<%=hdnIsSaved.ClientID%>]').val();
            if (isSaved != "" && isSaved == "true")
                alert("Entry update successfully.");
            else if (isSaved != "" && isSaved == "false")
                alert("There is an invalid input, please correct it first then try again.");

            var isSaved = $('input[id$=<%=hdnIsCorrectDate.ClientID%>]').val();
            if (isSaved != "" && isSaved == "false")
                alert("You can only add entry for current date or back date.");

            $('input[id$=<%=hdnIsSaved.ClientID%>]').val("");
            $('input[id$=<%=hdnIsCorrectDate.ClientID%>]').val("");
        }
    </script>
</asp:Content>
