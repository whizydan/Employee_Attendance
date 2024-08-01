<%-- 
    Document   : deletevendor
    Created on : Nov 10, 2023, 5:19:31 PM
    Author     : tours
--%>

<%@page import="com.kerberos.kopitiam.DatabaseManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
String id = request.getParameter("id");
DatabaseManager db = new DatabaseManager();
db.executeNonQuery("delete from vendors where id = '"+id+"'");
response.sendRedirect("vendorlist.jsp");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Deleting vendor</title>
    </head>
    <body>
        <h1>Deleting vendors</h1>
    </body>
</html>
