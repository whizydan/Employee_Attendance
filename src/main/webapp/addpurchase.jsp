<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.kerberos.kopitiam.Products"%>
<%@page import="com.kerberos.kopitiam.Products"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.kerberos.kopitiam.Logging"%>
<%@page import="com.kerberos.kopitiam.SessionManager"%>
<%@page import="com.kerberos.kopitiam.DatabaseManager"%>
<%
    Logging log = new Logging();
    String date = log.getDate();
    DatabaseManager dbManager = new DatabaseManager();
    List<Products> productsExpired = dbManager.getExpiredProducts();
    List<Products> fewProducts = dbManager.getFewProducts();
    String biller = (String) new SessionManager().getSessionAttribute(request,"email");
    String op = request.getParameter("op");
    String id = request.getParameter("id");
    List<Products> products = new ArrayList<>();
    ResultSet result = dbManager.executeQuery("select * from products");
    while(result.next()){
        Products product = new Products();
        product.setName(result.getString("name"));
        product.setId(result.getInt("id"));
        
        products.add(product);
    }
    
     if (request.getMethod().equalsIgnoreCase("post")){
            String query = "";
            String refCode = request.getParameter("ref_code");
            String status = request.getParameter("status");
            String product = request.getParameter("product");
            String paymentType = request.getParameter("payment_type");
            String desc = request.getParameter("description");
            String qty = request.getParameter("qty");
            int price=0,totalPrice =0;
            ResultSet resultPrice = dbManager.executeQuery("select * from products where id='"+product+"'");
            int currentQty = 0;
            while(resultPrice.next()){
                price = resultPrice.getInt("price");
                totalPrice = Integer.parseInt(qty)*price;
                currentQty = resultPrice.getInt("quantity");
            }
            
        if(op != null){
        int quantity = Integer.parseInt(qty);
            //here we are editing so update statement
            query = "UPDATE `sales` SET `date`='"+date+"',`ref_code`='"+refCode+"',"
                + "`status`='"+status+"',`total_price`='"+totalPrice+"',`biller`='"+biller+"',"
                + "`products`='"+product+"',`payment_type`='"+paymentType+"',"
                + "`description`='"+desc+"',`qty`='"+quantity+"' WHERE id = '"+id+"'";
            
        }else{
        //no op therefore insertion
                query = "INSERT INTO `sales`(`date`, `ref_code`, `status`, `total_price`, "
                + "`biller`, `products`, `payment_type`, `description`, `qty`) "
                + "VALUES ('"+date+"','"+refCode+"','"+status+"','"+totalPrice+"','"+biller+"',"
                + "'"+product+"','"+paymentType+"','"+desc+"','"+currentQty+"')";
                
                //add code here to reduce the quantity of the product
                int deduction = Integer.parseInt(qty);
                String newQuery = "update products set quantity='"+(currentQty-deduction)+"' where id='"+product+"'";
                dbManager.executeNonQuery(newQuery);
        }
        dbManager.executeNonQuery(query);
        out.println("<script type=\"text/javascript\">");
        out.println("");
        out.println("  var resultUrl = 'receipt.jsp?id="+product+"&desc="+desc+"&ref="+refCode+"&t="+totalPrice+"&q="+qty+"';"); // Replace with the actual URL
        out.println("  window.open(resultUrl, '_blank');");
        out.println("");
        out.println("</script>");
        
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
<meta name="keywords" content="admin, estimates, bootstrap, business, corporate, creative, invoice, html5, responsive, Projects">
<meta name="author" content="kerberos">
<meta name="robots" content="noindex, nofollow">
<title>Make sale</title>

<link rel="shortcut icon" type="image/x-icon" href="assets/img/favicon.png">

<link rel="stylesheet" href="assets/css/bootstrap.min.css">

<link rel="stylesheet" href="assets/css/bootstrap-datetimepicker.min.css">

<link rel="stylesheet" href="assets/css/animate.css">

<link rel="stylesheet" href="assets/plugins/select2/css/select2.min.css">

<link rel="stylesheet" href="assets/css/dataTables.bootstrap4.min.css">

<link rel="stylesheet" href="assets/plugins/fontawesome/css/fontawesome.min.css">
<link rel="stylesheet" href="assets/plugins/fontawesome/css/all.min.css">

<link rel="stylesheet" href="assets/css/style.css">
</head>
<body>
<div id="global-loader">
<div class="whirly-loader"> </div>
</div>

<div class="main-wrapper">

<div class="header">

<div class="header-left active">
<a href="index.jsp" class="logo">
<img src="assets/img/logo.png" alt="">
</a>
<a href="index.jsp" class="logo-small">
<img src="assets/img/logo-small.png" alt="">
</a>
<a id="toggle_btn" href="javascript:void(0);">
</a>
</div>

<a id="mobile_btn" class="mobile_btn" href="#sidebar">
<span class="bar-icon">
<span></span>
<span></span>
<span></span>
</span>
</a>

<ul class="nav user-menu">



<li class="nav-item dropdown has-arrow flag-nav">
<a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="javascript:void(0);" role="button">
<img src="assets/img/flags/us1.png" alt="" height="20">
</a>
<div class="dropdown-menu dropdown-menu-right">
<a href="javascript:void(0);" class="dropdown-item">
<img src="assets/img/flags/us.png" alt="" height="16"> English
</a>
</div>
</li>


<li class="nav-item dropdown">
<a href="javascript:void(0);" class="dropdown-toggle nav-link" data-bs-toggle="dropdown">
<img src="assets/img/icons/notification-bing.svg" alt="img"> <span class="badge rounded-pill"><%=productsExpired.size()+fewProducts.size()%></span>
</a>
<div class="dropdown-menu notifications">
<div class="topnav-dropdown-header">
<span class="notification-title">Notifications</span>
</div>
<div class="noti-content">
<ul class="notification-list">

<% 
        
        if (productsExpired != null && !productsExpired.isEmpty()) {
            for (Products item : productsExpired) {
        %>
        <li class="notification-message">
        
        <div class="media d-flex">
        <span class="avatar flex-shrink-0">
            <img alt="" src="assets/img/product/<%=item.getPhoto()%>">
        </span>
        <div class="media-body flex-grow-1">
        <p class="noti-details"><span class="noti-title">Product</span> <%=item.getName()%><span class="noti-title"> has expired, please delete it!</span></p>
        <p class="noti-time"><span class="notification-time">Just now</span></p>
        </div>
        </div>
        </a>
        </li>
        <%
            }
        }
        %>
        <%
        if (fewProducts != null && !fewProducts.isEmpty()) {
            for (Products item : fewProducts) {
        %>
        <li class="notification-message">
        <a href="activities.jsp?id=<%= item.getId() %>">
        <div class="media d-flex">
        <span class="avatar flex-shrink-0">
            <img alt="" src="assets/img/product/<%=item.getPhoto()%>">
        </span>
        <div class="media-body flex-grow-1">
        <p class="noti-details"><span class="noti-title">Product</span> <%=item.getName()%><span class="noti-title"> is almost being completed</span></p>
        <p class="noti-time"><span class="notification-time">Just now</span></p>
        </div>
        </div>
        </a>
        </li>
        <%
            }
        }
        %>

</ul>
</div>
</div>
</li>

<li class="nav-item dropdown has-arrow main-drop">
<a href="javascript:void(0);" class="dropdown-toggle nav-link userset" data-bs-toggle="dropdown">
<span class="user-img"><img src="assets/img/profiles/avator1.jpg" alt="">
<span class="status online"></span></span>
</a>
<div class="dropdown-menu menu-drop-user">
<div class="profilename">
<div class="profileset">
<span class="user-img"><img src="assets/img/profiles/avator1.jpg" alt="">
<span class="status online"></span></span>
<div class="profilesets">
<h6><%=new SessionManager().getSessionAttribute(request,"email")%></h6>
<h5>Admin</h5>
</div>
</div>
<hr class="m-0">
<a class="dropdown-item" href="profile.jsp"> <i class="me-2" data-feather="user"></i> My Profile</a>
<hr class="m-0">
<a class="dropdown-item logout pb-0" href="logout.jsp"><img src="assets/img/icons/log-out.svg" class="me-2" alt="img">Logout</a>
</div>
</div>
</li>
</ul>


<div class="dropdown mobile-user-menu">
<a href="javascript:void(0);" class="nav-link dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false"><i class="fa fa-ellipsis-v"></i></a>
<div class="dropdown-menu dropdown-menu-right">
<a class="dropdown-item" href="profile.html">My Profile</a>
<a class="dropdown-item" href="signin.html">Logout</a>
</div>
</div>

</div>


<div class="sidebar" id="sidebar">
<div class="sidebar-inner slimscroll">
<div id="sidebar-menu" class="sidebar-menu">
<ul>
<li>
<a href="index.jsp"><img src="assets/img/icons/dashboard.svg" alt="img"><span> Dashboard</span> </a>
</li>
<li class="submenu">
<a href="javascript:void(0);"><img src="assets/img/icons/product.svg" alt="img"><span> Inventory</span> <span class="menu-arrow"></span></a>
<ul>
<li><a href="productlist.jsp">Inventory List</a></li>
<li><a href="addproduct.jsp">Add Product</a></li>
<li><a href="categorylist.jsp">Category List</a></li>
<li><a href="addcategory.jsp">Add Category</a></li>
<li><a href="subcategorylist.jsp">Sub Category List</a></li>
<li><a href="subaddcategory.jsp">Add Sub Category</a></li>
</ul>
</li>
<li class="submenu">
<a href="javascript:void(0);"><img src="assets/img/icons/users1.svg" alt="img"><span> Persons</span> <span class="menu-arrow"></span></a>
<ul>
<li><a  href="expenselist.jsp">Staff list</a></li>
<li><a href="vendorlist.jsp">Vendor list</a></li>
<li><a href="attendance.jsp">Attendance</a></li>
</ul>
</li>
<li class="submenu">
<a href="javascript:void(0);"><img src="assets/img/icons/purchase1.svg" alt="img"><span> Transaction</span> <span class="menu-arrow"></span></a>
<ul>
<li><a href="purchaselist.jsp">Sales List</a></li>
<li><a class="active" href="addpurchase.jsp">Make Sale</a></li>
</ul>
</li>
<li class="submenu">
<a href="javascript:void(0);"><img src="assets/img/icons/sales1.svg" alt="img"><span> Salaries</span> <span class="menu-arrow"></span></a>
<ul>
<li><a  href="saleslist.jsp">Salaries List</a></li>
<li><a href="add-sales.jsp"> Set hourly Rate</a></li>
</ul>
</li>
</ul>
</div>
</div>
</div>

<div class="page-wrapper">
<form method="post">  
<div class="content">
<div class="page-header">
<div class="page-title">
<h4>Sales</h4>
<h6>Make new sale</h6>
</div>
</div>
<div class="card">
<div class="card-body">
<div class="row">
<div class="col-lg-3 col-sm-6 col-12">
<div class="form-group">
<label>Description</label>
<div class="row">
<div class="col-lg-10 col-sm-10 col-10">
<input name="description" required type="text">
</div>
</div>
</div>
</div>
<div class="col-lg-3 col-sm-6 col-12">
<div class="form-group">
<label>Date </label>
<div class="input-groupicon">
<input name="date" required type="text" placeholder="DD-MM-YYYY" class="datetimepicker">
<div class="addonset">
<img src="assets/img/icons/calendars.svg" alt="img">
</div>
</div>
</div>
<div class="form-group">
<label>Quantity </label>
<div class="input-groupicon">
<input name="qty" required type="text" placeholder="203">
</div>
</div>
</div>
<div class="col-lg-3 col-sm-6 col-12">
<div class="form-group">
<label>Payment Type</label>
<select name="payment_type" required class="select">
<option>Cash</option>
<option>Visa or Debit</option>
</select>
</div>
<div class="form-group">
<label>Status</label>
<select name="status" required class="select">
<option>pending</option>
<option>completed</option>
</select>
</div>
</div>
<div class="col-lg-3 col-sm-6 col-12">
<div class="form-group">
<label>Reference No.</label>
<input name="ref_code" required type="text">
</div>
</div>
<div class="col-lg-12 col-sm-6 col-12">
<div class="form-group">
<label>Product Name</label>
<div class="input-groupicon">
<div class="row">
<div class="col-lg-10 col-sm-10 col-10">
<select required name="product" class="select">
<tbody>
            <% 
        if (products != null && !products.isEmpty()) {
            for (Products item : products) {
        %>
<option value="<%=item.getId()%>"><%=item.getId()+": "+item.getName()%></option>
        <%
            }
        } else {
        %>
        <%
        }
%>
</select>
</div>
</div>
</div>
</div>
</div>
</div>
<div class="row">
<div class="col-lg-12">
<input type="submit" href="javascript:void(0);" class="btn btn-submit me-2">
<a href="purchaselist.jsp" class="btn btn-cancel">Cancel</a>
</div>
</div>
</div>
</div>
</div>
</form>
</div>
</div>


<script src="assets/js/jquery-3.6.0.min.js"></script>

<script src="assets/js/feather.min.js"></script>

<script src="assets/js/jquery.slimscroll.min.js"></script>

<script src="assets/js/jquery.dataTables.min.js"></script>
<script src="assets/js/dataTables.bootstrap4.min.js"></script>

<script src="assets/js/bootstrap.bundle.min.js"></script>

<script src="assets/plugins/select2/js/select2.min.js"></script>

<script src="assets/js/moment.min.js"></script>
<script src="assets/js/bootstrap-datetimepicker.min.js"></script>

<script src="assets/plugins/sweetalert/sweetalert2.all.min.js"></script>
<script src="assets/plugins/sweetalert/sweetalerts.min.js"></script>

<script src="assets/js/script.js"></script>
</body>
</html>