<%@ Page Title="" Language="C#" MasterPageFile="~/MyMaster.Master" AutoEventWireup="true" CodeBehind="ViewExpenseCategories.aspx.cs" Inherits="WebPoultryFarmManager.ViewExpenseCategories" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:UpdatePanel ID="upnlViewEntry" runat="server">
        <ContentTemplate>
            <div class="mainHeading">Manage Expense Category</div>
            <div style="width: 100%; text-align: center;">
                <asp:GridView ID="gvExpenseCategory" runat="server" Width="100%" AutoGenerateColumns="False" DataKeyNames="Id" CellPadding="4" EnableModelValidation="True" ForeColor="#333333" GridLines="None" EmptyDataText="No record found :-(">
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:BoundField DataField="Name" HeaderText="Expense Category Name" />
                        <asp:TemplateField>
                            <ItemTemplate>
                                <a href='EditExpenseCategory.aspx?eId=<%#DataBinder.Eval(Container.DataItem, "Id")%>'>Edit</a>
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
                <asp:HiddenField ID="hdnDeleteMsg" runat="server" />
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>

    <script type="text/javascript">
        function ConfirmDelete() {
            if (confirm("Are you sure you want to delete this category?"))
                return true;
            else
                return false;
        }

        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(on_post_backcall);

        function on_post_backcall() {
            var msg = $('input[id$=<%=hdnDeleteMsg.ClientID%>]').val();
            if (msg != "") {
                alert(msg);
                $('input[id$=<%=hdnDeleteMsg.ClientID%>]').val("");
            }
        }
    </script>

</asp:Content>
