<%-- 
    Document   : deletesale
    Created on : Nov 10, 2023, 12:40:34 PM
    Author     : tours
--%>

<%@page import="com.kerberos.kopitiam.DatabaseManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String id  = request.getParameter("id");
    DatabaseManager db = new DatabaseManager();
    db.executeNonQuery("delete from sales where id= '"+id+"'");
    response.sendRedirect("purchaselist.jsp");
%>
