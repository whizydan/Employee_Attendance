/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.kerberos.kopitiam;

/**
 *
 * @author tours
 */
public class Users {
    private String name, password, email,created_on,position;
    private int id, role, status;
    double confidence_score;
    
    public void setPosition(String position){
        this.position = position;
    }
    public String getPosition(){
        return this.position;
    }
    
    public double getConfidence(){
        return this.confidence_score;
    }
    public void setConfidence(double confidence){
        this.confidence_score = confidence;
    }

    public void setId(int id){
        this.id = id;
    }
    public int getId(){
        return this.id;
    }
    
    public int getRole() {
        return role;
    }

    public void setRole(int role) {
        this.role = role;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getEmail() {
        return email;
    }

    public String getCreated_on() {
        return created_on;
    }

    public void setCreated_on(String created_on) {
        this.created_on = created_on;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getStatus() {
        return status;
    }
}
