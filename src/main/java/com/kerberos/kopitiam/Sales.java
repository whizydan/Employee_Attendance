/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.kerberos.kopitiam;

/**
 *
 * @author tours
 */
public class Sales {
    private String id,date,ref_code,status,biller,product,payment_type,description;
    private int total_price,qty;
    
    public void setTotalPrice(int price){
        this.total_price = price;
    }
    public void setQty(int qty){
        this.qty = qty;
    }
    public int getQty(){
        return this.qty;
    }
    public int getTotalPrice(){
        return this.total_price;
    }

    public void setId(String id){
        this.id = id;
    }
    public String getId(){
        return this.id;
    }
    public void setDate(String date){
        this.date = date;
    }
    public String getDate(){
        return this.date;
    }

    public String getRef_code() {
        return ref_code;
    }

    public void setRef_code(String ref_code) {
        this.ref_code = ref_code;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getStatus() {
        return status;
    }

    public String getBiller() {
        return biller;
    }

    public void setBiller(String biller) {
        this.biller = biller;
    }

    public String getProduct() {
        return product;
    }

    public void setProduct(String product) {
        this.product = product;
    }

    public String getPayment_type() {
        return payment_type;
    }

    public void setPayment_type(String payment_type) {
        this.payment_type = payment_type;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getDescription() {
        return description;
    }
}

