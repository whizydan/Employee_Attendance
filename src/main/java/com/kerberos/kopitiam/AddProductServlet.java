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
@WebServlet(name = "AddProductServlet", urlPatterns = {"/AddProductServlet"})
public class AddProductServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        Part filePart = request.getPart("file");
        String fileName = getSubmittedFileName(filePart);
        
        String operation = request.getParameter("op");
        String id = request.getParameter("id");
        
        DatabaseManager db = new DatabaseManager();
        SessionManager sessionManager = new SessionManager();
        InputStream fileContent = filePart.getInputStream();
        // Define the directory where you want to save the uploaded images
        String uploadDirectory = "assets\\img\\product"; // Update this path
        ServletContext context = getServletContext();
        String rootPath = context.getRealPath("/")+uploadDirectory;
        String query = "";
        Path filePath = Paths.get(rootPath, fileName);
        Files.copy(fileContent, filePath, StandardCopyOption.REPLACE_EXISTING);
        
        int quantity = 0,price = 0;
        String name="",category="",subCategory="",brand="",unit="",code="",minimum="1",description="",discount="",status="",date="",photo="",vendor="",expiry="",addedBy="";
        name = request.getParameter("name");
        category = request.getParameter("category");
        subCategory = request.getParameter("subcategory");
        brand = request.getParameter("brand");
        unit = request.getParameter("unit");
        code = request.getParameter("code");
        minimum = request.getParameter("minimum");
        quantity = Integer.parseInt(request.getParameter("quantity"));
        description = request.getParameter("description");
        int tax = Integer.parseInt(request.getParameter("tax").replace("%",""));
        discount = request.getParameter("discount");
        price = Integer.parseInt(request.getParameter("price"));
        status = request.getParameter("status");
        date = new Logging().getDate();
        vendor = request.getParameter("vendor");
        expiry = request.getParameter("date");
        addedBy = (String) SessionManager.getSessionAttribute(request, "email");
        
        if(operation.equals("add")){
            query = "INSERT INTO `products`(`name`, `code`, `brand`, `category`, `expiry`, `photo`, `price`, "
                    + "`vendor`, `unit`, `quantity`, `added_by`, `sub_category`, `tax`, `status`, `description`, "
                    + "`date`, `discount`) "
                    + "VALUES ('"+name+"','"+code+"','"+brand+"','"+category+"','"+expiry+"','"+fileName+"',"
                    + "'"+price+"','"+vendor+"','"+unit+"','"+quantity+"','"+addedBy+"','"+subCategory+"','"+tax+"','"+status+"','"+description+"',"
                    + "'"+date+"','"+discount+"')";
        }else if(operation.equals("edit")){
            query = "UPDATE `products` SET `name`='"+name+"',`code`='"+code+"',`brand`='"+brand+"',`category`='"+category+"',"
                    + "`expiry`='"+expiry+"',`photo`='"+fileName+"',`price`='"+price+"',`vendor`='"+vendor+"',`unit`='"+unit+"',"
                    + "`quantity`='"+quantity+"',`added_by`='"+addedBy+"',`sub_category`='"+subCategory+"',`tax`='"+tax+"',"
                    + "`status`='"+status+"',`description`='"+description+"',`date`='"+date+"',`discount`='"+discount+"' "
                    + "WHERE id='"+id+"'";
        }
        
        try {
            db.executeNonQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(AddProductServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        // Optionally, you can do more processing or redirect to a different page.
        response.sendRedirect("productlist.jsp");
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

