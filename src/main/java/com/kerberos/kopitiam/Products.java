/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.kerberos.kopitiam;

/**
 *
 * @author tours
 */
public class Products {
    private int id, price, quantity, tax;
    private String name, code, category, expiry, unit, added_by, photo, vendor, sub_category, status, description, brand;

    public void setBrand(String brand){
        this.brand = brand;
    }
    public String getBrand(){
        return this.brand;
    }
    public String getSub_category() {
        return sub_category;
    }

    public void setSub_category(String sub_category) {
        this.sub_category = sub_category;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getExpiry() {
        return expiry;
    }

    public void setExpiry(String expiry) {
        this.expiry = expiry;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public String getAdded_by() {
        return added_by;
    }

    public void setAdded_by(String added_by) {
        this.added_by = added_by;
    }

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }

    public String getVendor() {
        return vendor;
    }

    public void setVendor(String vendor) {
        this.vendor = vendor;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getStatus() {
        return status;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getDescription() {
        return description;
    }

    public void setId(int id){
        this.id = id;
    }
    public int getId(){
        return this.id;
    }
    public int getPrice(){
        return this.price;
    }
    public void setPrice(int price){
        this.price = price;
    }
    public void setQuantity(int qty){
        this.quantity = qty;
    }
    public int getQuantity(){
        return this.quantity;
    }
    public void setTax(int tax){
        this.tax = tax;
    }
    public int getTax(){
        return this.tax;
    }
    public void setName(String name){
        this.name = name;
    }
    public String getName(){
        return this.name;
    }
    public void setCode(String code){
        this.code = code;
    }
    public String getCode(){
        return this.code;
    }
}
