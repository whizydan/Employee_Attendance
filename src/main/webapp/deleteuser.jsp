<%-- 
    Document   : deleteuser
    Created on : Nov 10, 2023, 4:48:54 PM
    Author     : tours
--%>

<%@page import="com.kerberos.kopitiam.DatabaseManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
String id = request.getParameter("id");
DatabaseManager db = new DatabaseManager();
db.executeNonQuery("delete from users where id = '"+id+"'");
response.sendRedirect("expenselist.jsp");
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
