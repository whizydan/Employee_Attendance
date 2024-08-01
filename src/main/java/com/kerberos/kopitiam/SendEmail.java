/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.kerberos.kopitiam;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;

public class SendEmail {
    public void sendEmail(String vendorEmail, String subject, String msg) {
        // Recipient's email address
        String recipientEmail = vendorEmail;

        // Set up mail properties
        Properties properties = new Properties();
        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.port", "587");
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");

        // Create a javax.mail.Session
        Session mailSession = Session.getInstance(properties, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication("your.email@gmail.com", "yourPassword");
            }
        });

        try {
            // Create a MimeMessage object using javax.mail.Session
            Message message = new MimeMessage(mailSession);

            // Set the sender's and recipient's email addresses
            message.setFrom(new InternetAddress("your.email@gmail.com"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));

            // Set the email subject and content
            message.setSubject(subject);
            message.setText(msg);

            // Send the email
            Transport.send(message);

            

        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
}

