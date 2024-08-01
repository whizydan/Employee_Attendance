<%@page import="com.kerberos.kopitiam.vendors"%>
<%@page import="com.kerberos.kopitiam.Categories"%>
<%@ page import="com.kerberos.kopitiam.DatabaseManager" %>
<%@ page import="com.kerberos.kopitiam.Logging" %>
<%@page import="com.kerberos.kopitiam.SessionManager" %>
<%@page import="java.util.ArrayList"%>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="com.kerberos.kopitiam.Products" %>
<%
    String id = request.getParameter("id");
    List<Products> products = new ArrayList<>();
    String operand = request.getParameter("op");
    if(operand == null){
    operand = "add";
    }
    DatabaseManager dbManager = new DatabaseManager();
    List<Products> productsExpired = dbManager.getExpiredProducts();
    List<Products> fewProducts = dbManager.getFewProducts();
    String name="",category="",subCategory="",brand="",unit="",code="",minimum="1",description="",discount="",status="",date="",photo="",vendor="",expiry="",addedBy="";
    int quantity = 0,price = 0;
    if(operand != null){
        ResultSet results = dbManager.executeQuery("select * from products where id='" + id + "'");
        while(results.next()){
            name = results.getString("name");
            category = results.getString("category");
            subCategory = results.getString("sub_category");
            brand = results.getString("brand");
            unit = results.getString("unit");
            code = results.getString("code");
            discount = results.getString("discount");
            description = results.getString("description");
            status = results.getString("status");
            date = results.getString("date");
            photo = results.getString("photo");
            vendor = results.getString("vendor");
            expiry = results.getString("expiry");
            addedBy = results.getString("added_by");
            quantity = results.getInt("quantity");
            price = results.getInt("price");
        }
    }
    
    List<Categories> categories = new ArrayList<>();
    String query = "select * from category";
    ResultSet result = dbManager.executeQuery(query);
    while(result.next()){
    Categories cat = new Categories();
    cat.setId(result.getInt("id"));
    cat.setName(result.getString("name"));
    categories.add(cat);
    }
    List<vendors> vendors = new ArrayList<>();
    String queryVendors = "select * from vendors";
    ResultSet resultVendors = dbManager.executeQuery(queryVendors);
    while(resultVendors.next()){
    vendors vend = new vendors();
    vend.setId(resultVendors.getInt("id"));
    vend.setName(resultVendors.getString("name"));
    vendors.add(vend);
    }
    List<Categories> subs = new ArrayList<>();
    String querySubs = "select * from sub_category";
    ResultSet resultSubs = dbManager.executeQuery(querySubs);
    while(resultSubs.next()){
    Categories cate = new Categories();
    cate.setId(resultSubs.getInt("id"));
    cate.setName(resultSubs.getString("name"));
    subs.add(cate);
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
<title>Add Products</title>

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
<li><a class="active" href="addproduct.jsp">Add Product</a></li>
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
<form method="post" action="AddProductServlet" enctype="multipart/form-data">
<div class="page-wrapper">
<div class="content">
<div class="page-header">
<div class="page-title">
<h4>Product Add</h4>
<h6>Create new product</h6>
</div>
</div>

<div class="card">
<div class="card-body">
<div class="row">
<div class="col-lg-3 col-sm-6 col-12">
<div class="form-group">
<label>Product Name</label>
<input value="<%=name%>" type="text" required name="name">
</div>
</div>

<div class="col-lg-3 col-sm-6 col-12">
<div class="form-group">
<label>Category</label>
<select name="category" class="select" required>
<% 
        if (categories != null && !categories.isEmpty()) {
            for (Categories item : categories) {
        %>
        <option><%=item.getName()%></option>
        <%
            }
        } else {
        %>
        <option>N/A</option>
        <%
        }
%>
</select>
</div>
</div>
<div class="col-lg-3 col-sm-6 col-12">
<div class="form-group">
<label>Sub Category</label>
<select name="subCategory" class="select" required>
<% 
        if (subs != null && !subs.isEmpty()) {
            for (Categories item : subs) {
        %>
        <option><%=item.getName()%></option>
        <%
            }
        } else {
        %>
        <option>N/A</option>
        <%
        }
%>
</select>
</div>
</div>
<div class="col-lg-3 col-sm-6 col-12">
<div class="form-group">
<label>Variety</label>
<input value="<%=brand%>" type="text" required name="brand">
</div>
</div>
<div class="col-lg-3 col-sm-6 col-12">
<div class="form-group">
<label>Unit</label>
<select name="unit" class="select">
<option>Choose Unit</option>
<option>1</option>
<option>litre</option>
<option>sack</option>
<option>kg</option>
</select>
</div>
</div>
<div class="col-lg-3 col-sm-6 col-12">
<div class="form-group">
<label>SKU</label>
<input value="<%=code%>" type="text" required name="code">
</div>
</div>
<div class="col-lg-3 col-sm-6 col-12">
<div class="form-group">
<label>Vendor</label>
<select name="vendor" class="select" required>
<% 
        if (vendors != null && !vendors.isEmpty()) {
            for (vendors item : vendors) {
        %>
        <option><%=item.getName()%></option>
        <%
            }
        } else {
        %>
        <option disabled>No vendor available</option>
        <%
        }
%>
</div>
</div>
<div class="col-lg-3 col-sm-6 col-12">
<div class="form-group">
<label>Quantity</label>
<input value="<%=quantity%>" placeholder="quantity" type="text" name="quantity" required>
</div>
</div>
<div class="col-lg-12">
<div class="form-group">
<label>Description</label>
<textarea  placeholder="Description" name="description" required class="form-control"><%=description%></textarea>
</div>
</div>
<div class="col-lg-3 col-sm-6 col-12">
<div class="form-group">
<label>Tax</label>
<select name="tax" class="select" required>
<option selected>2%</option>
<option>5%</option>
<option>7%</option>
<option>9%</option>
<option>14%</option>
</select>
</div>
</div>
<div class="col-lg-3 col-sm-6 col-12">
<div class="form-group">
<label>Discount Type</label>
<select name="discount" class="select">
<option selected>0%</option>
<option>10%</option>
<option>20%</option>
</select>
</div>
</div>
<div class="col-lg-3 col-sm-6 col-12">
<div class="form-group">
<label>Price</label>
<input value="<%=price%>" type="text" name="price" required>
</div>
</div>
<div class="col-lg-3 col-sm-6 col-12">
<div class="form-group">
<label>Expiry</label>
<input value="<%=date%>" type="date" name="date" required>
</div>
</div>
<div class="col-lg-3 col-sm-6 col-12">
<div class="form-group">
<label> Status</label>
<select name="status" class="select" required>
<option selected>Live</option>
<option>Draft</option>
</select>
</div>
</div>
<div class="col-lg-12">
<div class="form-group">
<label> Product Image</label>
<div class="image-upload">
<input type="file" name="file" required>
<div class="image-uploads">
<img src="assets/img/icons/upload.svg" alt="img">
<h4>Drag and drop a file to upload</h4>
</div>
</div>
</div>
</div>
<input name="id" hidden value="<%=request.getParameter("id")%>">
<input name="op" hidden value="<%=operand%>">
<div class="col-lg-12">
    <input type="submit" value="Submit" name="submit" class="btn btn-submit me-2">
<a href="productlist.jsp" class="btn btn-cancel">Cancel</a>
</div>
</div>
</div>
</div>

</div>
</div>
</div>
</form>


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