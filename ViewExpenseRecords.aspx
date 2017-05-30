<%@ Page Title="" Language="C#" MasterPageFile="~/MyMaster.Master" AutoEventWireup="true" CodeBehind="ViewExpenseRecords.aspx.cs" Inherits="WebPoultryFarmManager.ViewExpenseRecords" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:UpdatePanel ID="upnlViewEntry" runat="server">
        <ContentTemplate>
            <div class="mainHeading">View Expense Entries</div>
            <div style="width: 100%; text-align: center;">
                <table style="width: 50%; display: table;" cellpadding="2" cellspacing="2">
                    <tr>
                        <td style="text-align:left; width:40%;">
                            <asp:Label ID="lblExpenseCategoryType" runat="server" Text="Expense Category Type" Style="font-weight: bold;"></asp:Label>
                        </td>
                        <td style="text-align:left">
                            <asp:DropDownList ID="ddlExpCat" runat="server" CssClass="ddl">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td style="vertical-align:top;text-align:left">
                            <asp:Label ID="lblDateRange" runat="server" Text="" style="font-weight:bold;">Select Date</asp:Label>
                        </td>
                        <td style="vertical-align:top;text-align:left">
                            <div style="vertical-align:top; display:inline-block;">
                                <asp:TextBox ID="txtStartDate" runat="server" ReadOnly="true" onclick="showhidecalendar('start');"></asp:TextBox>
                                <asp:Calendar ID="calStartDate" runat="server" BackColor="White" style="display:none;" BorderColor="#3366CC" BorderWidth="1px" CellPadding="1" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="#003399" Height="200px" OnSelectionChanged="calStartDate_SelectionChanged"  SelectionMode="DayWeekMonth" Width="220px">
                                    <DayHeaderStyle BackColor="#99CCCC" ForeColor="#336666" Height="1px" />
                                    <NextPrevStyle Font-Size="8pt" ForeColor="#CCCCFF" />
                                    <OtherMonthDayStyle ForeColor="#999999" />
                                    <SelectedDayStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                                    <SelectorStyle BackColor="#99CCCC" ForeColor="#336666" />
                                    <TitleStyle BackColor="#003399" BorderColor="#3366CC" BorderWidth="1px" Font-Bold="True" Font-Size="10pt" ForeColor="#CCCCFF" Height="25px" />
                                    <TodayDayStyle BackColor="#99CCCC" ForeColor="White" />
                                    <WeekendDayStyle BackColor="#CCCCFF" />
                                </asp:Calendar>
                            </div>
                            <asp:HiddenField ID="hdnDateError" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td style="text-align:left;">
                            <asp:Button ID="btnShowByDate" runat="server" Text="Show Entires" OnClick="btnShowByDate_Click" />
                            <asp:Button ID="btnReset" runat="server" Text="Reset" OnClick="btnReset_Click" style="padding-left:15px;" />
                        </td>
                    </tr>
                </table>
                <div style="width: 100%; padding-top: 15px; padding-bottom: 15px;">
                    <asp:GridView ID="gvExpenseEntries" runat="server" Width="100%" DataKeyNames="Id" AutoGenerateColumns="False" CellPadding="4" EnableModelValidation="True" ForeColor="#333333" GridLines="None" EmptyDataText="No record found :-(">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:TemplateField>
                                <HeaderStyle Font-Bold="true" />
                                <HeaderTemplate>
                                    Expense
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <p><%#DataBinder.Eval(Container.DataItem, "ExpenseCatIdSource.Name")%></p>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Date" HeaderText="Date" />
                            <asp:BoundField DataField="Cost" HeaderText="Cost" />
                            <asp:BoundField DataField="Description" HeaderText="Description" />
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <a style="text-decoration:none;" href="AddEditExpenseRecord.aspx?id=<%#DataBinder.Eval(Container.DataItem, "Id")%>" ><input type="button" name="edit" value="Edit" /></a>
                                    <asp:Button ID="btnDeleteEntry" runat="server" OnClientClick="return ConfirmDelete();" Text="Delete" OnClick="btnDeleteEntry_Click" style="padding-left:5px;" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <EditRowStyle BackColor="#2461BF" />
                        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                        <RowStyle BackColor="#EFF3FB" />
                        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                    </asp:GridView>
                    <asp:HiddenField ID="hdnIsDeleted" runat="server" />
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>

    <script type="text/javascript">
        function ConfirmDelete() {
            if (confirm("Are you sure you want to delete this entry?"))
                return true;
            else
                return false;
        }

        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(on_post_backcall);

        function on_post_backcall() {
            var isSaved = $('input[id$=<%=hdnIsDeleted.ClientID%>]').val();
            if (isSaved != "" && isSaved == "true")
                alert("Entry deleted successfully.");
            else if (isSaved != "" && isSaved == "false")
                alert("Problem deleting entry.");

            var dateError = $('input[id$=<%=hdnDateError.ClientID%>]').val();

            if (dateError != "")
                alert(dateError);

            //if (dateError != "" && dateError == "StartDateExceedNow")
            //    alert("Start date cannot be greater than today date");
            //else if (dateError != "" && dateError == "EndDateExceedNow")
            //    alert("End date cannot be greater than today date");
            //else if (dateError != "" && dateError == "InvalidStartDate")
            //    alert("Invalid Start date");
            //else if (dateError != "" && dateError == "InvalidEndDate")
            //    alert("Invalid End date");
            //else if (dateError != "" && dateError == "StartDateCannotBeGreater")
            //    alert("Start date cannot be greater then end date");
        }

        function showhidecalendar(type) {
            if (type == "start") {
                $('#<%=calStartDate.ClientID%>').show();
            }
            
        }
    </script>
</asp:Content>
