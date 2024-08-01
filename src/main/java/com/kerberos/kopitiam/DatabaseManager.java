/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.kerberos.kopitiam;

/**
 *
 * @author tours
 */
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import com.mysql.jdbc.Driver;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

public class DatabaseManager {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/kopitiam?zeroDateTimeBehavior=CONVERT_TO_NULL";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "";
    Connection connection;
    
    public DatabaseManager(){
        Properties prop = new Properties();
        prop.setProperty("user", JDBC_USER);
        prop.setProperty("password", JDBC_PASSWORD);
        try{
             connection = new Driver().connect(JDBC_URL,prop);
        }catch(Exception e){
            e.printStackTrace();
        }
       
    }
    
    public ResultSet executeQuery(String query) throws SQLException {
        PreparedStatement statement =  connection.prepareStatement(query);
        ResultSet resultSet = statement.executeQuery();
        return resultSet;
    }
    public List<Products> getExpiredProducts() throws SQLException {
        PreparedStatement statement =  connection.prepareStatement("select * from products");
        LocalDate currentDate = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String formattedCurrentDate = currentDate.format(formatter);
        
        List<Products> products = new ArrayList<>();
        //Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
        ResultSet resultSet = statement.executeQuery();
        while(resultSet.next()){
            LocalDate givenDate = LocalDate.parse(resultSet.getString("expiry"), formatter);
            if(givenDate.isBefore(currentDate)){
                Products expiredProduct = new Products();
                expiredProduct.setId(resultSet.getInt("id"));
                expiredProduct.setExpiry(resultSet.getString("expiry"));
                expiredProduct.setPrice(resultSet.getInt("price"));
                expiredProduct.setCode(resultSet.getString("code"));
                expiredProduct.setCategory(resultSet.getString("category"));
                expiredProduct.setName(resultSet.getString("name"));
                expiredProduct.setPhoto(resultSet.getString("photo"));
                
                products.add(expiredProduct);
            }
        }
        return products;
    }
    public List<Products> getFewProducts() throws SQLException {
        PreparedStatement statement =  connection.prepareStatement("select * from products where quantity < 20");
        
        List<Products> products = new ArrayList<>();
        ResultSet resultSet = statement.executeQuery();
        while(resultSet.next()){
                Products expiredProduct = new Products();
                expiredProduct.setId(resultSet.getInt("id"));
                expiredProduct.setExpiry(resultSet.getString("expiry"));
                expiredProduct.setPrice(resultSet.getInt("price"));
                expiredProduct.setCode(resultSet.getString("code"));
                expiredProduct.setCategory(resultSet.getString("category"));
                expiredProduct.setName(resultSet.getString("name"));
                expiredProduct.setPhoto(resultSet.getString("photo"));
                
                products.add(expiredProduct);
        }
        return products;
    }
    public void executeNonQuery(String query)throws SQLException{
        PreparedStatement statement =  connection.prepareStatement(query);
        Boolean resultSet = statement.execute();
    }

    public void closeResources(ResultSet resultSet, PreparedStatement preparedStatement, Connection connection) {
        try {
            if (resultSet != null) {
                resultSet.close();
            }
            if (preparedStatement != null) {
                preparedStatement.close();
            }
            if (connection != null) {
                connection.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public void closeConnection() throws SQLException{
        connection.close();
    }

    public static void getUsers(String[] args) {
        DatabaseManager dbManager = new DatabaseManager();

        // Replace this query with your own SQL query
        String query = "SELECT * FROM users";

        try {
            ResultSet resultSet = dbManager.executeQuery(query);

            while (resultSet.next()) {
                // Process the results here
                String columnName = resultSet.getString("id"); // Replace with your column name
                System.out.println("Result: " + columnName);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}


