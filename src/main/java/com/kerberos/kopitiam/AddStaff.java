/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.kerberos.kopitiam;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 *
 * @author Kerberos
 */
@MultipartConfig
@WebServlet(name = "AddStaff", urlPatterns = {"/AddStaff"})
public class AddStaff extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Part filePart = request.getPart("file");
        String fileName = getSubmittedFileName(filePart);
        Logging log = new Logging();
        DatabaseManager db = new DatabaseManager();
        SessionManager sessionManager = new SessionManager();
        InputStream fileContent = filePart.getInputStream();
        String uploadDirectory = "assets\\img\\product"; // Update this path
        ServletContext context = getServletContext();
        String rootPath = context.getRealPath("/")+uploadDirectory;
        Path filePath = Paths.get(rootPath, fileName);
        Files.copy(fileContent, filePath, StandardCopyOption.REPLACE_EXISTING);
        
        String query = "";
        int role = 1;
        String id = request.getParameter("id");
        int status = Integer.parseInt(request.getParameter("status"));
        String name = request.getParameter("name");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String date = request.getParameter("date");
        String position = request.getParameter("pos");
        
        if(id.equals("")){
        log.log("position",position);
        query = "INSERT INTO `users`(`name`, `password`, `email`, `role`, `status`, `created_on`, `photo`, `position`) "
        + "VALUES ('"+name+"','"+password+"','"+email+"','"+role+"','"+status+"','"+date+"','"+fileName+"','"+position+"')";
    }
    else{
        log.log("data",id+"|"+status+"|"+name+"|"+password+"|"+email+"|"+date+"|"+position);
        query = "UPDATE `users` SET `name`='"+name+"',`password`='"+password+"',"
        + "`email`='"+email+"',`role`='"+role+"',`status`='"+status+"',"
        + "`created_on`='"+date+"',photo='"+fileName+"',position='"+position+"' WHERE id='"+id+"'";
        
    } 
        
        
        try {
            db.executeNonQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(UploadServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        // Optionally, you can do more processing or redirect to a different page.
        response.sendRedirect("expenselist.jsp");
        
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
