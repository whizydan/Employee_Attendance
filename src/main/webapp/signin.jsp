<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.kerberos.kopitiam.DatabaseManager" %>
<%@ page import="com.kerberos.kopitiam.Logging" %>
<%@ page import="com.kerberos.kopitiam.SessionManager" %>
<%
    String message = "";
    DatabaseManager dbManager = new DatabaseManager();
    SessionManager sessionManager = new SessionManager();
    //if logged in redirect to dashboard
    if(sessionManager.getSessionAttribute(request,"email") != null){
        response.sendRedirect("index.jsp");
    }
    
    if (request.getMethod().equalsIgnoreCase("post")) {
            String password = request.getParameter("password");
            String email = request.getParameter("email");
            
            String sql = "select * from admin where password='" + password + "' and email='" + email + "' and status = 0";
            DatabaseManager db = new DatabaseManager();
            ResultSet result = db.executeQuery(sql);
            if(!result.next()){
                message = "<div class="+"alert alert-danger bg bg-danger"+" role="+"alert"+">Wrong credentials.</div>";
            }else{
                String role = result.getString("role");
                sessionManager.createSession(request,"email",email);
                sessionManager.createSession(request,"role",role);
                response.sendRedirect("index.jsp");
                db.closeConnection();
            }
    }
    dbManager.closeConnection();
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
<meta name="description" content="POS - Bootstrap Admin Template">
<meta name="keywords" content="admin, estimates, bootstrap, business, corporate, creative, invoice, html5, responsive, Projects">
<meta name="author" content="Dreamguys - Bootstrap Admin Template">
<meta name="robots" content="noindex, nofollow">
<title>Login</title>

<link rel="shortcut icon" type="image/x-icon" href="assets/img/favicon.png">

<link rel="stylesheet" href="assets/css/bootstrap.min.css">

<link rel="stylesheet" href="assets/plugins/fontawesome/css/fontawesome.min.css">
<link rel="stylesheet" href="assets/plugins/fontawesome/css/all.min.css">

<link rel="stylesheet" href="assets/css/style.css">
</head>
<body class="account-page">

<div class="main-wrapper">
<div class="account-content">
<div class="login-wrapper">
<div class="login-content">
<div class="login-userset">
<div class="login-logo">
<img src="assets/img/logo.png" alt="img">
</div>
<div class="login-userheading">
    <h3>Sign In</h3>
<h4>Please login to your account</h4>
</div>
<form method="post">
<div class="form-login">
<label>Email</label>
<div class="form-addons">
<input name="email" type="email" required placeholder="Enter your email address">
<img src="assets/img/icons/mail.svg" alt="img">
</div>
</div>
<div class="form-login">
<label>Password</label>
<div class="pass-group">
<input type="password" required name="password" class="pass-input" placeholder="Enter your password">
<span class="fas toggle-password fa-eye-slash"></span>
</div>
</div>
<div class="form-login">
<div class="alreadyuser">
<h4><a href="forgetpassword.jsp" class="hover-a"></a></h4>
</div>
</div>
<div class="form-login text-center" >
    <input style="background-color: #00FFFF;color: #ffffff" type="submit" value="Sign In" class="btn " />
</div>
 <div class="form-login">
<%=message %>
</div>   
</form>
</div>
</div>
<div class="login-img">
<img src="assets/img/login.jpg" alt="img">
</div>
</div>
</div>
</div>


<script src="assets/js/jquery-3.6.0.min.js"></script>

<script src="assets/js/feather.min.js"></script>

<script src="assets/js/bootstrap.bundle.min.js"></script>

<script src="assets/js/script.js"></script>
</body>
</html>