<%-- 
    Document   : deleteProduct
    Created on : Nov 7, 2023, 6:39:26 AM
    Author     : tours
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="com.kerberos.kopitiam.DatabaseManager" %>
<%@ page import="com.kerberos.kopitiam.Logging" %>
<%
    String id = request.getParameter("id");
    Logging log = new Logging();
    DatabaseManager dbManager = new DatabaseManager();
    String query = "delete from products where id='"+id+"'";
    dbManager.executeNonQuery(query);
    log.log("db", "Deleting product with id "+id);
    response.sendRedirect("productlist.jsp");
    log.log("Response", "Deleted Redirecting to product list");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
    </body>
</html>
