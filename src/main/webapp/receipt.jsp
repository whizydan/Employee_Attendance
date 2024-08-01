<%@page import="java.sql.ResultSet"%>
<%@page import="com.kerberos.kopitiam.DatabaseManager"%>
<%
    DatabaseManager db = new DatabaseManager();
    String id = request.getParameter("id");
    String desc = request.getParameter("desc");
    String ref = request.getParameter("ref");
    String totalPrice = request.getParameter("t");
    String quantity = request.getParameter("q");
    String name="";
    ResultSet resNew = db.executeQuery("select * from products where id='"+id+"'");
    while(resNew.next()){
        name = resNew.getString("name");
    }
    db.closeConnection();
%>

<html>
    <head>
        <link rel="shortcut icon" type="image/x-icon" href="assets/img/favicon.png">

<link rel="stylesheet" href="assets/css/bootstrap.min.css">

<link rel="stylesheet" href="assets/css/animate.css">

<link rel="stylesheet" href="assets/css/dataTables.bootstrap4.min.css">

<link rel="stylesheet" href="assets/plugins/fontawesome/css/fontawesome.min.css">
<link rel="stylesheet" href="assets/plugins/fontawesome/css/all.min.css">
<script>
    function windowPrint(){
        window.print();
    }
</script>

<link rel="stylesheet" href="assets/css/style.css">
        
    </head>
    <body>
        <div class="container text-center">
    <div class="row">
        <div class="col-xs-12">
            <div class="text-center">
                <i class="fa fa-search-plus pull-left icon"></i>
                <h2>Receipt</h2>
            </div>
            <div class="panel-heading">
                <h3 class="text-end"><button onClick="windowPrint()" id="print" class="btn btn-lg btn-primary">Print</button></h3>
                </div>
            <hr>
            <div class="row">
                <div class="col-xs-12 col-md-3 col-lg-3 pull-left">
                    <div class="panel panel-default height">
                        <div class="panel-heading">Reference Code</div>
                        <div class="panel-body">
                            <strong><%=ref%></strong>
                        </div>
                    </div>
                </div>
                <div class="col-xs-12 col-md-3 col-lg-3">
                    <div class="panel panel-default height">
                        <div class="panel-heading">Payment Type</div>
                        <div class="panel-body">
                            <strong>Cash</strong><br>
                        </div>
                    </div>
                </div>
                <div class="col-xs-12 col-md-3 col-lg-3">
                    <div class="panel panel-default height">
                        <div class="panel-heading">Description</div>
                        <div class="panel-body">
                            <p><%=desc%></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="text-center"><strong>Sale details</strong></h3>
                </div>
                <div class="panel-body">
                    <div class="table-responsive">
                        <table class="table table-condensed">
                            <thead>
                                <tr>
                                    <td><strong>Item Name</strong></td>
                                    <td class="text-center"><strong>Item Quantity</strong></td>
                                    <td class="text-right"><strong>Total</strong></td>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td><%=name%></td>
                                    <td class="text-center"><%=quantity%></td>
                                    <td class="text-right"><%=totalPrice%></td>
                                </tr>
                                <tr>
                                    <td class="emptyrow"><i class="fa fa-barcode iconbig"></i></td>
                                    <td class="emptyrow text-center"><strong>Total</strong></td>
                                    <td class="emptyrow text-right"><%=totalPrice%></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
.height {
    min-height: 200px;
}

.icon {
    font-size: 47px;
    color: #5CB85C;
}

.iconbig {
    font-size: 77px;
    color: #5CB85C;
}

.table > tbody > tr > .emptyrow {
    border-top: none;
}

.table > thead > tr > .emptyrow {
    border-bottom: none;
}

.table > tbody > tr > .highrow {
    border-top: 3px solid;
}
</style>
    </body>
</html>



