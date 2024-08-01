<%-- 
    Document   : logout
    Created on : Nov 10, 2023, 3:55:45 PM
    Author     : tours
--%>

<%@page import="com.kerberos.kopitiam.SessionManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    new SessionManager().invalidateSession(request);
    response.sendRedirect("index.jsp");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Logging out...</title>
    </head>
    <body>
        <h1>Logging out...</h1>
    </body>
</html>
