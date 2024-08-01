<%-- 
    Document   : calculate
    Created on : Nov 6, 2023, 5:04:34 AM
    Author     : tours
--%>
<%@page import="java.nio.file.Paths" %>
<%@page import="com.kerberos.kopitiam.Logging" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    
    Part imagePart = request.getPart("image");
    if(imagePart == null){
        new Logging().log("image","null image");
    }
    //String imageName = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();;
    String savePath = "D:\\uploads\\" + "file.png";
    imagePart.write(savePath);
%>