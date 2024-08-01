<%@page import="java.util.ArrayList"%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.List" %>
<%@ page import="com.kerberos.kopitiam.DatabaseManager" %>
<%@ page import="com.kerberos.kopitiam.Logging" %>
<%@ page import="com.kerberos.kopitiam.Products" %>
<%@page import="com.kerberos.kopitiam.SessionManager" %>
<%
    int notificationCount = 0,totalSales=0,totalOrders=0,totalSalaries=0,netUsage=0,salesInvoice=0,totalExpenses=0;
    List<Products> products = new ArrayList<>();
    String userName = (String) SessionManager.getSessionAttribute(request, "email");
    if(userName == null){
        response.sendRedirect("signin.jsp");
    }
    DatabaseManager dbManager = new DatabaseManager();
    List<Products> productsExpired = dbManager.getExpiredProducts();
    //add values to the stat indicators
    String queryInvoices = "select * from sales where status='completed'";
    ResultSet invoices = dbManager.executeQuery(queryInvoices);
    while(invoices.next()){
        salesInvoice++;
        totalExpenses++;
    }
    //get all categories
    int totalCategories=0;
    String queryCategory = "select * from category";
    ResultSet cats = dbManager.executeQuery(queryCategory);
    while(cats.next()){
        totalCategories++;
    }
    //get all sales
    String querySales = "select * from sales";
    ResultSet sales = dbManager.executeQuery(querySales);
    while(sales.next()){
        totalSales += sales.getInt("total_price");
    }
    //get all the attendances for all users who have attende
    String queryAttendance = "select * from attendance";
    ResultSet allAttendances = dbManager.executeQuery(queryAttendance);
    //get all salaries
    String querySalaries = "select * from salary";
    ResultSet salaries = dbManager.executeQuery(querySalaries);
    while(salaries.next()){
        String factor = salaries.getString("factor");
        double fac = Double.parseDouble(factor);
        double newSalary = (fac*salaries.getInt("salary"));
        totalSalaries += newSalary;
        totalExpenses++;
    }
    //get total orders
    String queryOrders = "select * from orders";//expenses
    ResultSet orders = dbManager.executeQuery(queryOrders);
    while(orders.next()){
        totalOrders += orders.getInt("price");
        totalExpenses++;
    }
    //net usage
    netUsage = totalSales + totalSalaries + totalOrders;
    
    //populate the notifications view with items where it is less than 10
    SessionManager sessionManager = new SessionManager();
    String query = "select * from products where quantity < 10";
    ResultSet result = dbManager.executeQuery(query);
    while(result.next()){
        Products productItem = new Products();
        productItem.setId(result.getInt("id"));
        productItem.setName(result.getString("name"));
        products.add(productItem);
        notificationCount++;
    }
    //populate the expired products list
    int totalProducts=0;
    List<Products> expiredProducts = new ArrayList<>();
    ResultSet resultExpired = dbManager.executeQuery("select * from products");
    while(resultExpired.next()){
        Products expiredProduct = new Products();
        expiredProduct.setId(resultExpired.getInt("id"));
        expiredProduct.setExpiry(resultExpired.getString("expiry"));
        expiredProduct.setPrice(resultExpired.getInt("price"));
        expiredProduct.setCode(resultExpired.getString("code"));
        expiredProduct.setCategory(resultExpired.getString("category"));
        
        if(resultExpired.getString("expiry") == ""){
        //compare current time and past and check if it older than today
            expiredProducts.add(expiredProduct);
        }
        totalProducts++;
    }

    //get the total number of customers we have
    int totalCustomer = 0;
    ResultSet totalCustomers = dbManager.executeQuery("SELECT * FROM sales where payment_type='inhouse'");
    while(totalCustomers.next()){
        totalCustomer++;
    }
    
    //get the total number of suppliers we have
    int totalSuppliers = 0;
    ResultSet totalSupp = dbManager.executeQuery("select * from vendors");
    while(totalSupp.next()){
        totalSuppliers++;
    }
    
    //get the 4 newest supplies
    List<Products> newProducts = new ArrayList<>();
    ResultSet newSupplies = dbManager.executeQuery("select * from products order by id DESC LIMIT 4");
    while(newSupplies.next()){
        Products newProduct = new Products();
        newProduct.setId(newSupplies.getInt("id"));
        newProduct.setName(newSupplies.getString("name"));
        newProduct.setPrice(newSupplies.getInt("price"));
        newProduct.setPhoto(newSupplies.getString("photo"));
        newProduct.setSub_category(newSupplies.getString("sub_category"));
        newProducts.add(newProduct);
    }
    List<Products> fewProducts = dbManager.getFewProducts();
    dbManager.closeConnection();
    netUsage = totalOrders+totalSalaries;
    int netProfit = totalSales - netUsage;
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
<meta name="keywords" content="admin, estimates, bootstrap, business, corporate, creative, management, minimal, modern,  html5, responsive">
<meta name="author" content="kerberos">
<meta name="robots" content="noindex, nofollow">
<title>DashBoard</title>

<link rel="shortcut icon" type="image/x-icon" href="assets/img/favicon.png">

<link rel="stylesheet" href="assets/css/bootstrap.min.css">

<link rel="stylesheet" href="assets/css/animate.css">

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
<div class="topnav-dropdown-footer">
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
<a class="active" href="index.jsp"><img src="assets/img/icons/dashboard.svg" alt="img"><span> Dashboard</span> </a>
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
<div class="row">
<div class="col-lg-3 col-sm-6 col-12">
<div class="dash-widget">
<div class="dash-widgetimg">
<span><img src="assets/img/icons/dash1.svg" alt="img"></span>
</div>
<div class="dash-widgetcontent">
<h5>Rm <span class="counters" data-count="<%=totalOrders%>.00">RM<%=totalOrders%></span></h5>
<h6>Total Orders</h6>
</div>
</div>
</div>
<div class="col-lg-3 col-sm-6 col-12">
<div class="dash-widget dash1">
<div class="dash-widgetimg">
<span><img src="assets/img/icons/dash2.svg" alt="img"></span>
</div>
<div class="dash-widgetcontent">
<h5>Rm <span class="counters" data-count="<%=totalSales%>">RM<%=totalSales%>.00</span></h5>
<h6>Total sales</h6>
</div>
</div>
</div>
<div class="col-lg-3 col-sm-6 col-12">
<div class="dash-widget dash2">
<div class="dash-widgetimg">
<span><img src="assets/img/icons/dash3.svg" alt="img"></span>
</div>
<div class="dash-widgetcontent">
<h5>Rm <span class="counters" data-count="<%=totalSalaries%>"><%=totalSalaries%>.00</span></h5>
<h6>Total Salaries</h6>
</div>
</div>
</div>
<div class="col-lg-3 col-sm-6 col-12">
<div class="dash-widget dash3">
<div class="dash-widgetimg">
<span><img src="assets/img/icons/dash4.svg" alt="img"></span>
</div>
<div class="dash-widgetcontent">
<h5>Rm <span class="counters" data-count="<%=netProfit%>.00"><%=netProfit%>.00</span></h5>
<h6><%
    if(netProfit < 0){
    %>
    Total Loses
    <%
        }else{
    %>
    Total Profit
    <%
        }
    %>
</h6>
</div>
</div>
</div>
<div class="col-lg-3 col-sm-6 col-12 d-flex">
<div class="dash-count">
<div class="dash-counts">
<h4><%=totalCategories%></h4>
<h5>Categories</h5>
</div>
<div class="dash-imgs">
<i data-feather="user"></i>
</div>
</div>
</div>
<div class="col-lg-3 col-sm-6 col-12 d-flex">
<div class="dash-count das1">
<div class="dash-counts">
<h4><%=totalSuppliers%></h4>
<h5>Vendors</h5>
</div>
<div class="dash-imgs">
<i data-feather="user-check"></i>
</div>
</div>
</div>
<div class="col-lg-3 col-sm-6 col-12 d-flex">
<div class="dash-count das2">
<div class="dash-counts">
<h4><%=totalExpenses%></h4>
<h5>Expenses</h5>
</div>
<div class="dash-imgs">
<i data-feather="file-text"></i>
</div>
</div>
</div>
<div class="col-lg-3 col-sm-6 col-12 d-flex">
<div class="dash-count das3">
<div class="dash-counts">
<h4><%=totalProducts%></h4>
<h5>Total Products</h5>
</div>
<div class="dash-imgs">
<i data-feather="file"></i>
</div>
</div>
</div>
</div>

<div class="row">
<div class="col-lg-12 col-sm-12 col-12 d-flex">
<div class="card flex-fill">
<div class="card-header pb-0 d-flex justify-content-between align-items-center">
<h4 class="card-title mb-0">Recently Added Products</h4>
<div class="dropdown">
<a href="javascript:void(0);" data-bs-toggle="dropdown" aria-expanded="false" class="dropset">
<i class="fa fa-ellipsis-v"></i>
</a>
<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
<li>
<a href="productlist.jsp" class="dropdown-item">Product List</a>
</li>
<li>
<a href="addproduct.jsp" class="dropdown-item">Product Add</a>
</li>
</ul>
</div>
</div>
<div class="card-body">
<div class="table-responsive dataview">
<table class="table datatable ">
<thead>
<tr>
<th>S:NO</th>
<th>Products</th>
<th>Price</th>
</tr>
</thead>
<tbody>
    <% 
        if (newProducts != null && !newProducts.isEmpty()) {
            for (Products item : newProducts) {
        %>
        <tr>
<td>1</td>
<td class="productimgname">
<a href="product-details.jsp?id=<%=item.getId()%>" class="product-img">
<img src="assets/img/product/<%=item.getPhoto()%>" alt="product">
</a>
<a href="product-details.jsp?id=<%=item.getId()%>"><%=item.getName()%></a>
</td>
<td>$<%=item.getPrice()%></td>
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
<div class="card mb-0">
<div class="card-body">
<h4 class="card-title">Expired Products</h4>
<div class="table-responsive dataview">
<table class="table datatable ">
<thead>
<tr>
<th>S:NO</th>
<th>Product Code</th>
<th>Product Name</th>
<th>Price</th>
<th>Category</th>
<th>Expiry Date</th>
</tr>
</thead>
<tbody>
    <% 
        if (productsExpired != null && !productsExpired.isEmpty()) {
            for (Products item : productsExpired) {
        %>
        <tr>
        <td><%=item.getId()%></td>
        <td><a href="javascript:void(0);"><%=item.getCode()%></a></td>
        <td class="productimgname">
        <a class="product-img" href="product-details.jsp?id=<%=item.getId()%>">
        <img src="assets/img/product/<%=item.getPhoto()%>" alt="product">
        </a>
        <a href="product-details.jsp?id=<%=item.getId()%>"><%=item.getName()%></a>
        </td>
        <td><%=item.getPrice()%></td>
        <td><%=item.getCategory()%></td>
        <td><%=item.getExpiry()%></td>
        </tr>
        <%
            }
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

<script src="assets/plugins/apexchart/apexcharts.min.js"></script>
<script src="assets/plugins/apexchart/chart-data.js"></script>

<script src="assets/js/script.js"></script>
<script src="assets/js/notify.js"></script>
</body>
</html>