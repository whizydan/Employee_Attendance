/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.kerberos.kopitiam;

/**
 *
 * @author tours
 */
import java.io.File;
import java.io.IOException;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.nio.file.Files;
import java.util.Locale;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.nio.file.StandardOpenOption;
import java.nio.file.Paths;
import javax.servlet.http.Part;

public class Logging {
    //a variable to hold our loggs for this system
    //String filePath = "C:\\Users\\Kris Teo\\Downloads\\KopitiamSystem\\logs.txt";
    String filePath = "D:\\logs.txt";
    
    public void log(String process,String message){
        File file = new File(filePath);
        // Check if the file exists
        if (!file.exists()) {
            try {
                // Create the file
                Files.createFile(Paths.get(filePath));
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        
        String finalMessage = "[" + getDate() + "]-" + "[" + process + "]: " + message;

        try {
             //Append the message to the file
            Files.write(Paths.get(filePath), finalMessage.getBytes(StandardCharsets.UTF_8), StandardOpenOption.APPEND);
            Files.write(Paths.get(filePath), System.lineSeparator().getBytes(StandardCharsets.UTF_8), StandardOpenOption.APPEND);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    
    public String getDate(){
        // Get the current date and time
        Date currentDate = new Date();
        // Define the desired date and time format
        SimpleDateFormat dateFormat = new SimpleDateFormat("E dd MMM yyyy, HH:mm:ss", Locale.ENGLISH);
        String formattedDate = dateFormat.format(currentDate);
        // return date
        return formattedDate;
    }
    
    
}
