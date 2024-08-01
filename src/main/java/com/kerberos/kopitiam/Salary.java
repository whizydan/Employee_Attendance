/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.kerberos.kopitiam;

/**
 *
 * @author Kerberos
 */
public class Salary {
    String staffId, salaryId, name, phone, email, created_on;
    int salary;
    double factor;
    
    public void setCreatedOn(String created_on){
        this.created_on = created_on;
    }
    public String getCreatedOn(){
        return this.created_on;
    }
    public String getStaffId(){
     return this.staffId;
    }
    public void setStaffId(String staffId){
        this.staffId = staffId;
    }
    public void setSalaryId(String salaryId){
        this.salaryId = salaryId;
    }
    public String getSalaryId(){
        return this.salaryId;
    }
    public void setName(String name){
        this.name = name;
    }
    public String getName(){
        return this.name;
    }
    public void setPhone(String phone){
        this.phone = phone;
    }
    public String getPhone(){
        return this.phone;
    }
    public void setEmail(String email){
        this.email = email;
    }
    public String getEmail(){
        return this.email;
    }
    public void setFactor(double factor){
        this.factor = factor;
    }
    public double getFactor(){
        return this.factor;
    }
    public void setSalary(int salary){
        this.salary = salary;
    }
    public int getSalary(){
        return this.salary;
    }
}
