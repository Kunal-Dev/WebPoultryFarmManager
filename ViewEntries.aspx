﻿<%@ Page Title="View Entries" Language="C#" MasterPageFile="~/MyMaster.Master" AutoEventWireup="true" CodeBehind="ViewEntries.aspx.cs" Inherits="WebPoultryFarmManager.ViewEntries" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:UpdatePanel ID="upnlViewEntry" runat="server">
        <ContentTemplate>
            <div class="mainHeading">View Entries</div>
            <div style="width: 100%; text-align: center;">
                <table style="display: inline;">
                    <tr>
                        <td style="vertical-align:top; text-align:left">
                            <asp:Label ID="lblUserType" runat="server" Text="User Type" Style="font-weight: bold;"></asp:Label>
                        </td>
                        <td style="text-align:left;">
                            <asp:DropDownList ID="ddlUserType" runat="server" CssClass="ddl" AutoPostBack="true" OnSelectedIndexChanged="ddlUserType_SelectedIndexChanged">
                                <asp:ListItem Text="--Select--" Value="-1"></asp:ListItem>
                                <asp:ListItem Text="Farmer" Value="1"></asp:ListItem>
                                <asp:ListItem Text="Customer" Value="2"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td style="vertical-align:top; text-align:left">
                            <asp:Label ID="lblUser" runat="server" Text="User" Style="font-weight: bold;"></asp:Label>
                        </td>
                        <td style="text-align:left;">
                            <asp:DropDownList ID="ddlUsers" runat="server" CssClass="ddl" Enabled="false" AutoPostBack="false">
                                <asp:ListItem Text="--Select--" Value="-1"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td style="vertical-align:top; text-align:left">
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
                            <asp:Button ID="btnShowRecord" runat="server" Text="Show Entires" OnClick="btnShowRecord_Click" />
                            <asp:Button ID="btnReset" runat="server" Text="Reset" OnClick="btnReset_Click" style="padding-left:15px;" />
                        </td>
                    </tr>
                </table>
                <div style="width: 100%; padding-top: 15px; padding-bottom: 15px;">
                    <div style="width: 100%; text-align: left; padding-bottom: 15px;">
                        <asp:Label ID="lblSelectedUser" runat="server" Style="text-align: left; font-weight: bold; font-size: 18px;"></asp:Label><br />
                        <asp:Label ID="lblTotalBalance" runat="server" Style="text-align: left; font-weight: bold; font-size: 18px;"></asp:Label>
                    </div>
                    <asp:GridView ID="gvUserEntries" runat="server" Width="100%" DataKeyNames="Id" AutoGenerateColumns="False" CellPadding="4" EnableModelValidation="True" ForeColor="#333333" GridLines="None" EmptyDataText="No record found :-(">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:TemplateField>
                                <HeaderStyle Font-Bold="true" />
                                <HeaderTemplate>
                                    User
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <span><%#DataBinder.Eval(Container.DataItem, "UserIdSource.FirstName")%> <%#DataBinder.Eval(Container.DataItem, "UserIdSource.LastName")%></span>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <HeaderStyle Font-Bold="true" />
                                <HeaderTemplate>
                                    User Type
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <span><%#DataBinder.Eval(Container.DataItem, "UserIdSource.UserTypeSource.Name")%></span>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Date" HeaderText="Date" />
                            <asp:BoundField DataField="TotalWeight" HeaderText="Total Weight" />
                            <asp:BoundField DataField="Pieces" HeaderText="Pieces" />
                            <asp:BoundField DataField="Price" HeaderText="Price" />
                            <asp:BoundField DataField="TotalPrice" HeaderText="Total Price" />
                            <asp:BoundField DataField="PreviousBalance" HeaderText="Previous Balance" />
                            <asp:BoundField DataField="Paid" HeaderText="Amount Paid" />
                            <asp:BoundField DataField="TotalBalance" HeaderText="Total Balance" />
                            <asp:BoundField DataField="Description" HeaderText="Description" />
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:Button ID="btnDeleteEntry" runat="server" OnClick="btnDeleteEntry_Click" OnClientClick="return ConfirmDelete();" Text="Delete" />
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
        }


        function showhidecalendar(type) {
            if (type == "start") {
                $('#<%=calStartDate.ClientID%>').show();
            }
        }
    </script>
</asp:Content>
