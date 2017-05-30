<%@ Page Title="Payment Received" Language="C#" MasterPageFile="~/MyMaster.Master" AutoEventWireup="true" CodeBehind="PaymentReceived.aspx.cs" Inherits="WebPoultryFarmManager.PaymentReceived" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:UpdatePanel ID="upnlPaymentReceived" runat="server">
        <ContentTemplate>
            <div class="mainHeading">Cash In Hand</div>
            <div style="width: 100%; text-align: center;">
                <table style="display: table; width:100%" cellpadding="2" cellspacing="2">
                    <tr>
                        <td style="text-align: right; width: 50%;">
                            <asp:Label ID="lblViewDate" runat="server" Text="Select Date" Style="font-weight: bold;"></asp:Label>
                        </td>
                        <td style="text-align: left; width:50%;">
                            <asp:TextBox ID="txtViewDate" runat="server" onclick="showhidecalendar();" ReadOnly="true"></asp:TextBox>
                            <asp:Calendar ID="calViewDate" runat="server" BackColor="White" Style="display: none;" BorderColor="#3366CC" BorderWidth="1px" CellPadding="1" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="#003399" Height="200px" OnSelectionChanged="calViewDate_SelectionChanged" SelectionMode="DayWeekMonth" Width="220px">
                                <DayHeaderStyle BackColor="#99CCCC" ForeColor="#336666" Height="1px" />
                                <NextPrevStyle Font-Size="8pt" ForeColor="#CCCCFF" />
                                <OtherMonthDayStyle ForeColor="#999999" />
                                <SelectedDayStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                                <SelectorStyle BackColor="#99CCCC" ForeColor="#336666" />
                                <TitleStyle BackColor="#003399" BorderColor="#3366CC" BorderWidth="1px" Font-Bold="True" Font-Size="10pt" ForeColor="#CCCCFF" Height="25px" />
                                <TodayDayStyle BackColor="#99CCCC" ForeColor="White" />
                                <WeekendDayStyle BackColor="#CCCCFF" />
                            </asp:Calendar>
                            <asp:HiddenField ID="hdnDateError" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td style="text-align:left;">
                            <asp:Button ID="btnShowRecord" runat="server" OnClick="btnShowRecord_Click" Text="Show Record" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="text-align:left;">
                            <div>
                                <asp:Label ID="lblRecordDate" runat="server"></asp:Label>
                            </div>
                            <br />
                            <div>
                                <table id="tblPaymentReceived" runat="server" style="width:70%;">

                                </table>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>

    <script type="text/javascript">
        function showhidecalendar() {
            $('#<%=calViewDate.ClientID%>').show();
        }
    </script>

</asp:Content>
