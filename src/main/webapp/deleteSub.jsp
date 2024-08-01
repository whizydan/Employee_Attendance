<%-- 
    Document   : deleteSub
    Created on : Nov 9, 2023, 1:04:23 PM
    Author     : tours
--%>

<%@page import="com.kerberos.kopitiam.DatabaseManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String id = request.getParameter("id");
    String query = "delete from sub_category where id='"+id+"'";
    DatabaseManager db = new DatabaseManager();
    db.executeNonQuery(query);
    response.sendRedirect("subcategorylist.jsp");
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
