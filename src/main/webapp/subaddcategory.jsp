<%@page import="java.util.List"%>
<%@page import="com.kerberos.kopitiam.Products"%>
<%@page import="com.kerberos.kopitiam.SessionManager"%>
<%@page import="com.kerberos.kopitiam.DatabaseManager"%>
<%@page import="java.sql.ResultSet"%>
<%
    DatabaseManager db = new DatabaseManager();
    List<Products> productsExpired = db.getExpiredProducts();
    List<Products> fewProducts = db.getFewProducts();
    if (request.getMethod().equalsIgnoreCase("post")){
        String name = request.getParameter("category");
        String description = request.getParameter("description");
        String addedBy = (String) new SessionManager().getSessionAttribute(request,"email");
        String query = "INSERT INTO `sub_category`(`name`, `description`, `added_by`) "
            + "VALUES ('"+name+"','"+description+"','"+addedBy+"')";
        
        
        db.executeNonQuery(query);
        response.sendRedirect("subcategorylist.jsp");
    }
    
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
<meta name="keywords" content="admin, estimates, bootstrap, business, corporate, creative, invoice, html5, responsive, Projects">
<meta name="author" content="Kerberos">
<meta name="robots" content="noindex, nofollow">
<title>Add Sub Category</title>

<link rel="shortcut icon" type="image/x-icon" href="assets/img/favicon.png">

<link rel="stylesheet" href="assets/css/bootstrap.min.css">

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
<a class="dropdown-item" href="profile.jsp">My Profile</a>
<a class="dropdown-item" href="signin.jsp">Logout</a>
</div>
</div>

</div>


<div class="sidebar" id="sidebar">
<div class="sidebar-inner slimscroll">
<div id="sidebar-menu" class="sidebar-menu">
<ul>
<li>
<a  href="index.jsp"><img src="assets/img/icons/dashboard.svg" alt="img"><span> Dashboard</span> </a>
</li>
<li class="submenu">
<a href="javascript:void(0);"><img src="assets/img/icons/product.svg" alt="img"><span> Inventory</span> <span class="menu-arrow"></span></a>
<ul>
<li><a href="productlist.jsp">Inventory List</a></li>
<li><a href="addproduct.jsp">Add Product</a></li>
<li><a href="categorylist.jsp">Category List</a></li>
<li><a href="addcategory.jsp">Add Category</a></li>
<li><a href="subcategorylist.jsp">Sub Category List</a></li>
<li><a class="active" href="subaddcategory.jsp">Add Sub Category</a></li>
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
<li><a href="addpurchase.jsp">Make Sale</a></li>
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
<div class="content">
<div class="page-header">
<div class="page-title">
<h4>Product Add sub Category</h4>
<h6>Create new product Category</h6>
</div>
</div>
<form method="post">
<div class="card">
<div class="card-body">
<div class="row">
<div class="col-lg-4 col-sm-6 col-12">
<div class="form-group">
<label>Sub Category Name</label>
<input name="category" required type="text">
</div>
</div>
<div class="col-lg-12">
<div class="form-group">
<label>Description</label>
<textarea name="description" required class="form-control"></textarea>
</div>
</div>
<div class="col-lg-12">
<input type="submit" name="submit" class="btn btn-submit me-2">
<a href="subcategorylist.jsp" class="btn btn-cancel">Cancel</a>
</div>
</div>
</div>
</div>
</form>
</div>
</div>
</div>


<script src="assets/js/jquery-3.6.0.min.js"></script>

<script src="assets/js/feather.min.js"></script>

<script src="assets/js/jquery.slimscroll.min.js"></script>

<script src="assets/js/jquery.dataTables.min.js"></script>
<script src="assets/js/dataTables.bootstrap4.min.js"></script>

<script src="assets/js/bootstrap.bundle.min.js"></script>

<script src="assets/plugins/select2/js/select2.min.js"></script>

<script src="assets/plugins/sweetalert/sweetalert2.all.min.js"></script>
<script src="assets/plugins/sweetalert/sweetalerts.min.js"></script>

<script src="assets/js/script.js"></script>
</body>
</html>