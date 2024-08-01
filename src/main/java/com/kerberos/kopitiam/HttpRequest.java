/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.kerberos.kopitiam;

/**
 *
 * @author tours
 */
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;
import org.json.JSONObject;

public class HttpRequest {
    public static double compare(String face1, String face2) throws IOException {
        // Creating URL connection
        int rand = 0;
        URL url = new URL("https://api.luxand.cloud/photo/similarity");
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setRequestMethod("POST");
        connection.setDoOutput(true);
        Logging log = new Logging();

        // Setting headers
        connection.setRequestProperty("token", "78a845f64c0448019043b32dfd44f9be");

        // Setting request parameters
        Map<String, String> parameters = new HashMap<>();
        parameters.put("threshold", "0.8");

        // Writing request parameters
        StringBuilder postData = new StringBuilder();
        for (Map.Entry<String, String> param : parameters.entrySet()) {
            if (postData.length() != 0) postData.append('&');
            postData.append(URLEncoder.encode(param.getKey(), "UTF-8"));
            postData.append('=');
            postData.append(URLEncoder.encode(param.getValue(), "UTF-8"));
        }

        // Writing files
        File file1 = new File(face1);
        File file2 = new File(face2);

        try (DataOutputStream wr = new DataOutputStream(connection.getOutputStream())) {
            wr.writeBytes(postData.toString());
            writeFileStream("face1", file1, wr);
            writeFileStream("face2", file2, wr);
        }

        // Executing the request
        int responseCode = connection.getResponseCode();
        System.out.println("Response Code: " + responseCode);

        // Handling the response
        try (BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()))) {
            String inputLine;
            StringBuilder response = new StringBuilder();
            while ((inputLine = in.readLine()) != null) {
                response.append(inputLine);
            }
            System.out.println("Response: " + response.toString());
            log.log("HttpRequestClass",response.toString());
            try{
                JSONObject jsonObject = new JSONObject(response.toString());
                rand = jsonObject.getInt("age");
                
            }catch(Exception e){
                e.printStackTrace();
            }
        }
        return rand;
    }

    private static void writeFileStream(String fieldName, File file, DataOutputStream wr) throws IOException {
        wr.writeBytes("--" + "boundary" + "\r\n");
        wr.writeBytes("Content-Disposition: form-data; name=\"" + fieldName + "\"; filename=\"" + file.getName() + "\"\r\n");
        wr.writeBytes("Content-Type: application/octet-stream\r\n\r\n");

        try (FileInputStream fileInputStream = new FileInputStream(file)) {
            byte[] buffer = new byte[4096];
            int bytesRead;
            while ((bytesRead = fileInputStream.read(buffer)) != -1) {
                wr.write(buffer, 0, bytesRead);
            }
        }

        wr.writeBytes("\r\n");
        wr.writeBytes("--" + "boundary" + "--\r\n");
    }
}

