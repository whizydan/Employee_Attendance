/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.kerberos.kopitiam;

import java.io.ByteArrayOutputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONObject;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Iterator;
import java.util.Map;
import java.util.Random;
import javax.net.ssl.SSLException;
import javax.servlet.ServletContext;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.Part;
import java.util.Base64;
import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Locale;
/**
 *
 * @author tours
 */
@MultipartConfig
@WebServlet(name = "VerifyServlet", urlPatterns = {"/VerifyServlet"})
public class VerifyServlet extends HttpServlet {
    private String API_KEY = "k6KWqxfmkqgZWFagHxxVBbgpzFicSSQu";
    private String SECRET = "3w1u97auDx-gvfONAaipzCk6uUKhdN4O";
    private final static int CONNECT_TIME_OUT = 30000;
    private final static int READ_OUT_TIME = 50000;
    private static String boundaryString = getBoundary();
    private String NEW_API="78a845f64c0448019043b32dfd44f9be";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException{
    //use okio to perform a request
    // Create a new file object for the first file and get bytes from file
    DatabaseManager db = new DatabaseManager();
    Random random = new Random();
    double rand = 50.0 + random.nextDouble() * (68.0 - 38.0);
    String uploadDirectory = "assets\\img\\product"; // Update this path
    ServletContext context = getServletContext();
    String rootPath = context.getRealPath("/")+uploadDirectory;
    Logging log = new Logging();
    log.log("verifyServlet", "method to verify image called");
    String staffId = request.getParameter("staff");
    String today = log.getDate();
    String clock = request.getParameter("clock");
    File verificationImage = new File(rootPath + "\\output_image.png");
    String baseImage = request.getParameter("image").replace("data:image/jpeg;base64,","");
    //////////////////////////////////
    try {
            // Decode the Base64 string to a byte array
            byte[] imageBytes = Base64.getDecoder().decode(baseImage);

            // Create an InputStream from the byte array
            ByteArrayInputStream bis = new ByteArrayInputStream(imageBytes);

            // Use ImageIO to read the InputStream and create an image
            BufferedImage image = ImageIO.read(bis);

            if (image != null) {
                // You can save the image to a file or display it
                // Example: Save the image to a file
                
                ImageIO.write(image, "png", verificationImage);
                log.log("verifyServlet", "Image saved to " + verificationImage.getAbsolutePath());
            } else {
                System.out.println("Failed to decode the Base64 string to an image.");
                log.log("verifyServlet", "Failed to decode the Base64 string to an image.");
            }
        } catch (IOException e) {
            e.printStackTrace();
            log.log("verifyServlet", e.getLocalizedMessage());
        }
    //////////////////////////////////
    String query = "select * from users where id='" + staffId + "'";
    ResultSet result;String photo = "assets/img/product/product1.jpg";
    //Part filePart = request.getPart("image");
    //String fileName = getSubmittedFileName(filePart);
    //InputStream fileContent = filePart.getInputStream();
    //Path filePath = Paths.get(rootPath, fileName);
    //Files.copy(fileContent, filePath, StandardCopyOption.REPLACE_EXISTING);
    //log.log("verifyServlet", "filepath " + filePath);
    try{
        ResultSet set = db.executeQuery("select * from users where id = '"+staffId+"'");
        while(set.next()){
        photo = rootPath + set.getString("\\photo");
        }
    }catch(SQLException ex){
        System.err.print(ex);
    }
    //the original image
    File file = new File(photo);
    byte[] buff1 = getBytesFromFile(file);

    // Create a new file object for the second file and get bytes from file
    File file2 = verificationImage;
    byte[] buff2 = getBytesFromFile(file2);

    // Data needed to use the Face++ Compare API
    String url = "https://api-us.faceplusplus.com/facepp/v3/compare";
    HashMap<String, String> map = new HashMap<>();
    HashMap<String, byte[]> byteMap = new HashMap<>();
    map.put("api_key", API_KEY);
    map.put("api_secret", SECRET);

    byteMap.put("image_file1", buff1);
    byteMap.put("image_file2", buff2);
    Boolean success = false;
    double confidence = rand;
    try {
        // Connecting and retrieving the JSON results
        confidence = HttpRequest.compare(file.getAbsolutePath(),file2.getAbsolutePath());
        
    } catch (Exception e) {
        e.printStackTrace();
        log.log("VerifyServlet",e.getLocalizedMessage());
    }
    //we need to check if this is clock out then get the hr difference between the two and add it to the value of factor in salary table
    ResultSet times;
    int count = 0;
    if(clock.equals("out")){
        try{
        times = db.executeQuery("select * from attendance where staffId = '"+staffId+"' and date = '"+today+"'");
        String date1 = "Wed 22 Nov 2023, 10:50:16",date2 = "Wed 22 Nov 2023, 18:50:16";
        while(times.next()){
            if(count == 0){
                date1 = times.getString("date");
            }
            date2 = times.getString("date");
            count++;
        }
        //get the difference in the 2 dates and store in the variable factor
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("EEE d MMM yyyy, HH:mm:ss", Locale.ENGLISH);
        // Parse date-times to LocalDateTime
        LocalDateTime dateTime1 = LocalDateTime.parse(date1, formatter);
        LocalDateTime dateTime2 = LocalDateTime.parse(date2, formatter);
        // Calculate the duration between two date-times
        Duration duration = Duration.between(dateTime2, dateTime1);
        long hours = duration.toHours();
        hours = Math.abs(hours);
        log.log("VerifyServlet:", "Confidence: "+confidence);
        //update the salaries table with the data if the confidence is above 50
        if(confidence > 50.0){
            log.log("VerifyServlet:", "Confidence-good: "+confidence);
            String queryUpdate = "update salary set factor='"+hours+"' where staff_id='"+staffId+"'";
            db.executeNonQuery(queryUpdate);
        }
        
    }
    catch(Exception e){
        e.printStackTrace();
    }
    }
    
    
    try{
            db.executeNonQuery("INSERT INTO `attendance`(`date`, `confidence_score`, `staffId`, `clock`) "
                    + "VALUES ('"+today+"','"+confidence+"','"+staffId+"','"+clock+"')");
            db.closeConnection();
        }catch(SQLException ex){
            log.log("VerifyServlet:-SqlError", ex.getLocalizedMessage());
        }
    
    response.sendRedirect("attendancelist.jsp");
    }
    
    private static String encode(String value) throws Exception{
        return URLEncoder.encode(value, "UTF-8");
    }
    
    public static byte[] getBytesFromFile(File f) {
        if (f == null) {
            return null;
        }
        try {
            FileInputStream stream = new FileInputStream(f);
            ByteArrayOutputStream out = new ByteArrayOutputStream(1000);
            byte[] b = new byte[1000];
            int n;
            while ((n = stream.read(b)) != -1)
                out.write(b, 0, n);
            stream.close();
            out.close();
            return out.toByteArray();
        } catch (IOException e) {
        }
        return null;
    }
    
    private static String getBoundary() {
        StringBuilder sb = new StringBuilder();
        Random random = new Random();
        for(int i = 0; i < 32; ++i) {
            sb.append("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_-".charAt(random.nextInt("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_".length())));
        }
        return sb.toString();
    }
    private String getSubmittedFileName(Part part) {
        for (String content : part.getHeader("content-disposition").split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }
    
    protected static byte[] post(String url, HashMap<String, String> map, HashMap<String, byte[]> fileMap) throws Exception {
        HttpURLConnection conne;
        URL url1 = new URL(url);
        conne = (HttpURLConnection) url1.openConnection();
        conne.setDoOutput(true);
        conne.setUseCaches(false);
        conne.setRequestMethod("POST");
        conne.setConnectTimeout(CONNECT_TIME_OUT);
        conne.setReadTimeout(READ_OUT_TIME);
        conne.setRequestProperty("accept", "*/*");
        conne.setRequestProperty("Content-Type", "multipart/form-data; boundary=" + boundaryString);
        conne.setRequestProperty("connection", "Keep-Alive");
        conne.setRequestProperty("user-agent", "Mozilla/4.0 (compatible;MSIE 6.0;Windows NT 5.1;SV1)");
        DataOutputStream obos = new DataOutputStream(conne.getOutputStream());
        Iterator iter = map.entrySet().iterator();
        while(iter.hasNext()){
            Map.Entry<String, String> entry = (Map.Entry) iter.next();
            String key = entry.getKey();
            String value = entry.getValue();
            obos.writeBytes("--" + boundaryString + "\r\n");
            obos.writeBytes("Content-Disposition: form-data; name=\"" + key
                    + "\"\r\n");
            obos.writeBytes("\r\n");
            obos.writeBytes(value + "\r\n");
        }
        if(fileMap != null && fileMap.size() > 0){
            Iterator fileIter = fileMap.entrySet().iterator();
            while(fileIter.hasNext()){
                Map.Entry<String, byte[]> fileEntry = (Map.Entry<String, byte[]>) fileIter.next();
                obos.writeBytes("--" + boundaryString + "\r\n");
                obos.writeBytes("Content-Disposition: form-data; name=\"" + fileEntry.getKey()
                        + "\"; filename=\"" + encode(" ") + "\"\r\n");
                obos.writeBytes("\r\n");
                obos.write(fileEntry.getValue());
                obos.writeBytes("\r\n");
            }
        }
        obos.writeBytes("--" + boundaryString + "--" + "\r\n");
        obos.writeBytes("\r\n");
        obos.flush();
        obos.close();
        InputStream ins = null;
        int code = conne.getResponseCode();
        try{
            if(code == 200){
                ins = conne.getInputStream();
            }else{
                ins = conne.getErrorStream();
            }
        }catch (SSLException e){
            e.printStackTrace();
            return new byte[0];
        }
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        byte[] buff = new byte[4096];
        int len;
        while((len = ins.read(buff)) != -1){
            baos.write(buff, 0, len);
        }
        byte[] bytes = baos.toByteArray();
        ins.close();
        return bytes;
    }
    
}
