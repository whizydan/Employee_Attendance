 <%@page import="com.kerberos.kopitiam.Products"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.kerberos.kopitiam.Sales"%>
<%@page import="com.kerberos.kopitiam.Sales"%>
<%@page import="com.kerberos.kopitiam.DatabaseManager"%>
<%@page import="com.kerberos.kopitiam.SessionManager"%>
<%
     DatabaseManager db = new DatabaseManager();
     String biller = (String) new SessionManager().getSessionAttribute(request,"email");
     List<Products> productsExpired = db.getExpiredProducts();
    List<Products> fewProducts = db.getFewProducts();
     List<Sales> sales = new ArrayList<>();
     ResultSet result = db.executeQuery("select * from sales");
     while(result.next()){
        Sales sale = new Sales();
        sale.setId(result.getString("id"));
        sale.setBiller(result.getString("biller"));
        sale.setDate(result.getString("date"));
        sale.setPayment_type(result.getString("payment_type"));
        sale.setRef_code(result.getString("ref_code"));
        sale.setStatus(result.getString("status"));
        sale.setTotalPrice(result.getInt("total_price"));
        sale.setProduct(result.getString("products"));
        sale.setQty(result.getInt("qty"));
        sale.setDescription(result.getString("description"));
        
        
        sales.add(sale);
    }
    db.closeConnection();
 %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
<meta name="keywords" content="admin, estimates, bootstrap, business, corporate, creative, invoice, html5, responsive, Projects">
<meta name="author" content="kerberos">
<meta name="robots" content="noindex, nofollow">
<title>Sales</title>

<link rel="shortcut icon" type="image/x-icon" href="assets/img/favicon.png">

<link rel="stylesheet" href="assets/css/bootstrap.min.css">

<link rel="stylesheet" href="assets/css/bootstrap-datetimepicker.min.css">

<link rel="stylesheet" href="assets/css/animate.css">

<link rel="stylesheet" href="assets/plugins/select2/css/select2.min.css">

<link rel="stylesheet" href="assets/css/dataTables.bootstrap4.min.css">

<link rel="stylesheet" href="assets/plugins/fontawesome/css/fontawesome.min.css">
<link rel="stylesheet" href="assets/plugins/fontawesome/css/all.min.css">

<link rel="stylesheet" href="assets/css/style.css">
<script>
    function handleClick(){
        window.print();
    }
</script>
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
<a class="dropdown-item" href="profile.jsp">My Profile</a>
<a class="dropdown-item" href="logout.jsp">Logout</a>
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
<li><a class="active" href="purchaselist.jsp">Sales List</a></li>
<li><a href="addpurchase.jsp">Make Sale</a></li>
</ul>
</li>
<li class="submenu">
<a href="javascript:void(0);"><img src="assets/img/icons/sales1.svg" alt="img"><span> Salaries</span> <span class="menu-arrow"></span></a>
<ul>
<li><a  href="saleslist.jsp">Salaries List</a></li>
<li><a href="add-sales.jsp"> Set Salaries</a></li>
</ul>
</li>
</ul>
</div>
</div>
</div>

<div class="page-wrapper">
<div class="content">
<div class="page-header">
<div class="page-title">
<h4>Sales</h4>
<h6>Sales List</h6>
</div>
<div class="page-btn">
<a href="addpurchase.jsp" class="btn btn-added">
<img src="assets/img/icons/plus.svg" alt="img">Add New Sale
</a>
</div>
</div>

<div  class="card">
<div  class="card-body">
<div  class="table-top">
<div  class="search-set">
<div hidden class="search-path">
<a class="btn btn-filter" id="filter_search">
<img src="assets/img/icons/filter.svg" alt="img">
<span><img src="assets/img/icons/closes.svg" alt="img"></span>
</a>
</div>
<div class="search-input">
<a class="btn btn-searchset"><img src="assets/img/icons/search-white.svg" alt="img"></a>
</div>
</div>
<div class="wordset">
<ul>
<li>
    <a data-bs-toggle="tooltip" onclick="handleClick();" data-bs-placement="top" title="print"><img src="assets/img/icons/printer.svg" alt="img"></a>
</li>
</ul>
</div>
</div>

<div hidden class="card" id="filter_inputs">
<div class="card-body pb-0">
<div class="row">
<div class="col-lg col-sm-6 col-12">
<div class="form-group">
<input type="text" class="datetimepicker cal-icon" placeholder="Choose Date">
</div>
</div>
<div class="col-lg col-sm-6 col-12">
<div class="form-group">
<input type="text" placeholder="Enter Reference">
</div>
</div>
<div class="col-lg col-sm-6 col-12">
<div class="form-group">
<select class="select">
<option>Choose Supplier</option>
<option>Supplier</option>
</select>
</div>
</div>
<div class="col-lg col-sm-6 col-12">
<div class="form-group">
<select class="select">
<option>Choose Status</option>
<option>Inprogress</option>
</select>
</div>
</div>
<div class="col-lg col-sm-6 col-12">
<div class="form-group">
<select class="select">
<option>Choose Payment Status</option>
<option>Payment Status</option>
</select>
</div>
</div>
<div class="col-lg-1 col-sm-6 col-12">
<div class="form-group">
<a class="btn btn-filters ms-auto"><img src="assets/img/icons/search-whites.svg" alt="img"></a>
</div>
</div>
</div>
</div>
</div>

<div class="table-responsive">
<table class="table datanew">
<thead>
<tr>
<th>
<label class="checkboxs">
<input type="checkbox" id="select-all">
<span class="checkmarks"></span>
</label>
</th>
<th>Product Name</th>
<th>Biller</th>
<th>Ref Code</th>
<th>Payment Type</th>
<th>Total Price</th>
<th>Quantity</th>
<th>Description</th>
<th>Date</th>
<th>Action</th>
</tr>
</thead>
<tbody>
            <% 
        if (sales != null && !sales.isEmpty()) {
            for (Sales item : sales) {
        %>
<tr>
<td>
<label class="checkboxs">
<input type="checkbox">
<span class="checkmarks"></span>
</label>
</td>
<td class="text-bolds"><%=item.getProduct()%></td>
<td><%=item.getBiller()%></td>
<td><%=item.getRef_code()%></td>
<td>
    <%
        if(item.getPayment_type().equals("Cash")){
    %>
    <span class="badges bg-lightred"><%=item.getPayment_type()%>
    <%
        }else{
    %>
    <span class="badges bg-secondary"><%=item.getPayment_type()%>
    <%
        }
    %></span></td>
<td><%=item.getTotalPrice()%></td>
<td><%=item.getQty()%></td>
<td><%=item.getDescription()%></td>
<td><span class="badges bg-secondary"><%=item.getDate()%></span>
</td>
<td>
<a class="me-3" href="addpurchase.jsp?op=edit&id=<%=item.getId()%>">
<img src="assets/img/icons/edit.svg" alt="img">
</a>
<a class="me-3" href="deletesale.jsp?=<%=item.getId()%>">
<img src="assets/img/icons/delete.svg" alt="img">
</a>
</td>
</tr>
        <%
            }
        } else {
        %>
        <%
        }
%>
</tbody>
</table>
</div>
</div>
</div>

</div>
</div>
</div>


<script src="assets/js/jquery-3.6.0.min.js"></script>

<script src="assets/js/feather.min.js"></script>

<script src="assets/js/jquery.slimscroll.min.js"></script>

<script src="assets/js/jquery.dataTables.min.js"></script>
<script src="assets/js/dataTables.bootstrap4.min.js"></script>

<script src="assets/js/bootstrap.bundle.min.js"></script>

<script src="assets/js/moment.min.js"></script>
<script src="assets/js/bootstrap-datetimepicker.min.js"></script>

<script src="assets/plugins/select2/js/select2.min.js"></script>

<script src="assets/plugins/sweetalert/sweetalert2.all.min.js"></script>
<script src="assets/plugins/sweetalert/sweetalerts.min.js"></script>

<script src="assets/js/script.js"></script>
</body>
</html>