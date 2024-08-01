<%-- 
    Document   : deletecategory
    Created on : Nov 7, 2023, 3:54:22 PM
    Author     : tours
--%>
<%@ page import="com.kerberos.kopitiam.DatabaseManager" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
String id = request.getParameter("id");
String query = "delete from category where id = '" + id + "'";
DatabaseManager manager = new DatabaseManager();
manager.executeNonQuery(query);
response.sendRedirect("categorylist.jsp");
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
