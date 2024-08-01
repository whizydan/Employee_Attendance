/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.kerberos.kopitiam;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import javax.servlet.annotation.MultipartConfig;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletContext;

/**
 *
 * @author tours
 */
@MultipartConfig
@WebServlet(name = "UploadServlet", urlPatterns = {"/UploadServlet"})
public class UploadServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        Part filePart = request.getPart("file");
        String fileName = getSubmittedFileName(filePart);
        
        DatabaseManager db = new DatabaseManager();
        SessionManager sessionManager = new SessionManager();
        InputStream fileContent = filePart.getInputStream();
        String code = request.getParameter("code");
        String description = request.getParameter("description");
        String addedBy =(String) sessionManager.getSessionAttribute(request,"email");
        String name = request.getParameter("name");
        // Define the directory where you want to save the uploaded images
        String uploadDirectory = "assets\\img\\product"; // Update this path
        ServletContext context = getServletContext();
        String rootPath = context.getRealPath("/")+uploadDirectory;
        int role = 1;
        Path filePath = Paths.get(rootPath, fileName);
        Files.copy(fileContent, filePath, StandardCopyOption.REPLACE_EXISTING);
        String query = "INSERT INTO `category`(`code`, `description`, `added_by`, `name`, `photo`)"
            + " VALUES ('"+code+"','"+description+"','"+addedBy+"','"+name+"','"+fileName +"')";
        try {
            db.executeNonQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(UploadServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        // Optionally, you can do more processing or redirect to a different page.
        response.sendRedirect("categorylist.jsp");
    }

    private String getSubmittedFileName(Part part) {
        for (String content : part.getHeader("content-disposition").split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }
}

