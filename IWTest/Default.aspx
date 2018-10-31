<%@ Page Title="Individuals" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="IWTest._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">


    <script src="//cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
    <asp:UpdatePanel ID="UpdatePanelGrid" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="false">
        <ContentTemplate>

            <div class="jumbotron">
                <h1>INDIVIDUALS</h1>
            </div>
            <asp:GridView ID="IndividualsGridView" runat="server" CssClass="table table-striped table-hover table-dark" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Horizontal" OnRowCommand="IndividualsGridView_RowCommand" DataKeyNames="id, firstname, lastname">
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkButton1" runat="server" CommandName="viewAddresses" CommandArgument="<%# Container.DataItemIndex %>">
                                <i class="fas fa-plus-circle"></i>
                            </asp:LinkButton>
                        </ItemTemplate>
                        <ItemStyle Width="10px" />
                    </asp:TemplateField>
                </Columns>
                <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
                <HeaderStyle BackColor="#333333" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
                <SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#F7F7F7" />
                <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
                <SortedDescendingCellStyle BackColor="#E5E5E5" />
                <SortedDescendingHeaderStyle BackColor="#242121" />
            </asp:GridView>


            <div class="row">

                <div class="col-md-2">
                    <asp:LinkButton Text="Merge Data" disabled="disabled" CssClass="btn btn-success" ID="btnMergePreview" runat="server" OnClick="btnMergePreview_Click" />
                    </span>
                </div>
                <div class="col-md-6">
                    <div class="alert alert-success">
                        Select two individuals by clicking a row holding the ctrl key or holding touch or click.
                    </div>
                </div>


                <div class="col-md-2">
                    <asp:HiddenField ID="IndividualId1" runat="server" />
                    <asp:HiddenField ID="IndividualId2" runat="server" />
                    <asp:HiddenField ID="IndividualName1" runat="server" />
                    <asp:HiddenField ID="IndividualName2" runat="server" />
                </div>
            </div>

        </ContentTemplate>
    </asp:UpdatePanel>



    <div class="modal modal-2 animated fadeInDown" tabindex="-1" role="dialog" style="overflow-y: auto;" id="modalDetail">
        <div class="modal-dialog modal-dialog-centered animated fadeInDown" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h2 class="modal-title text-center" style="margin: auto;">Individual Addresses</h2>
                    <button type="button" class="close btn-modal-close" aria-label="Close" onclick="$('#modalDetail').hide();">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <asp:UpdatePanel ID="UpdatePanelIndividualDetail" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="false">
                        <ContentTemplate>
                            <div class="row">
                                <div class="col-md-12">
                                    <h3>
                                        <asp:Label ID="lblName" runat="server" Text="Label"></asp:Label>
                                    </h3>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <asp:GridView ID="GridViewIndividualDetail" runat="server" CssClass="table table-striped table-hover table-dark" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Horizontal">
                                    </asp:GridView>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <div class="modal-footer">
                    <div class="col-md-12">
                        <a class="btn btn-default float-right" style="margin-left: 15px;" onclick="$('#modalDetail').hide();">Regresar
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <div class="modal modal-2 animated fadeInDown" tabindex="-1" role="dialog" style="overflow-y: auto;" id="modalMerge">
        <div class="modal-dialog modal-dialog-centered animated fadeInDown" role="document">
            <div class="modal-content">

                <asp:UpdatePanel ID="UpdatePanelMergePreview" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="false">
                    <ContentTemplate>

                        <div class="modal-header">
                            <h2 class="modal-title text-center" style="margin: auto;">Merge Preview</h2>
                            <button type="button" class="close btn-modal-close" aria-label="Close" onclick="$('#modalMerge').hide();">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">



                            <div class="row">
                                <div class="col-md-12">
                                    <h3>
                                        <asp:Label ID="LabelIndividualName1" runat="server" Text="Label"></asp:Label>
                                    </h3>
                                    <asp:GridView ID="individualAddressGrid1" runat="server" CssClass="table table-striped table-hover table-dark" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Horizontal">
                                    </asp:GridView>
                                </div>
                            </div>
                            <hr />
                            <div class="row">
                                <div class="col-md-12">
                                    <h3>
                                        <asp:Label ID="LabelIndividualName2" runat="server" Text="Label"></asp:Label>
                                    </h3>
                                    <asp:GridView ID="individualAddressGrid2" runat="server" CssClass="table table-striped table-hover table-dark" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Horizontal">
                                    </asp:GridView>

                                </div>
                            </div>



                        </div>
                        <div class="modal-footer">
                            <div class="col-md-12">
                                <asp:LinkButton Text="Merge" CssClass="btn btn-success" ID="btnMerge" runat="server" OnClick="btnMerge_Click" />
                                <a class="btn btn-default float-right" style="margin-left: 15px;" onclick="$('#modalMerge').hide();">Back
                                </a>
                            </div>
                        </div>

                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
    </div>
    <div class="alert alert-warning alert-dismissible fade" role="alert" id="buttonAlert">
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
        <strong>Holy guacamole!</strong> You should check in on some of those fields below.
    </div>



    <script>

        var array;
        var table;

        function initTable() {
            table = $('#<%=IndividualsGridView.ClientID%>').DataTable();
            array = [];
        }


        $(document).ready(function () {

            initPage();

        });

        function initPage() {

            $(".ui-loader").hide();


            $('#<%=IndividualsGridView.ClientID%> tbody').on('click', 'tr', function () {
                if (event.ctrlKey) {
                    toggleSelect(this);
                }
            });

            $('#<%=IndividualsGridView.ClientID%> tbody').on('taphold', 'tr', function () {
                toggleSelect(this);
            });
        }

        function toggleSelect(row) {
            if (table.rows('.selected').data().length < 2 || $(row).hasClass('selected')) {

                if ($(row).hasClass('selected')) {
                    var index = array.indexOf(table.row(row).data());
                    array.splice(index, 1);
                } else {
                    array.push(table.row(row).data())
                }
                $(row).toggleClass('selected');
            }

            if (table.rows('.selected').data().length == 2) {
                $('#<%=btnMergePreview.ClientID%>').removeAttr('disabled');
                selectRows(array);
            } else {
                $('#<%=btnMergePreview.ClientID%>').attr('disabled', 'disabled');
            }
        }


        function selectRows(data) {
            $('#<%=IndividualName1.ClientID%>').val(data[0][2] + ' ' + data[0][3]);
            $('#<%=IndividualName2.ClientID%>').val(data[1][2] + ' ' + data[1][3]);

            $('#<%=IndividualId1.ClientID%>').val(data[0][1]);
            $('#<%=IndividualId2.ClientID%>').val(data[1][1]);
        };


    </script>
</asp:Content>
