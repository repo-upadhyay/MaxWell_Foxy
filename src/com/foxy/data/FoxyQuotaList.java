/*
 * FoxyQuotaList.java
 *
 * Created on June 20, 2006, 6:18 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */
package com.foxy.data;

import java.io.Serializable;
import java.util.Date;

/**
 *
 * @author eric
 */
public class FoxyQuotaList  implements Serializable {
    /**
     * serial id for serialisation versioning
     */
    private Integer id = null;
    private Date quotaDate = null;
    private String orgCountryName = null;
    private String orgCountry = null;
    private String destCountryName = null;
    private String destCountry = null;
    private String category = null;
    private String categoryD = null;
    private String quotaYear = null;
    private Double quantity = null;
    private String unit = null;
    private Double price = null;
    
    public FoxyQuotaList() {}

    //PROPERTY: id
    public Integer getId(){
        return this.id;
    }
    public void setId(Integer newValue) {
        this.id = newValue;
    }
    //PROPERTY: qtadate
    public Date getQuotaDate(){
        return this.quotaDate;
    }
    public void setQuotaDate(Date newValue) {
        this.quotaDate = newValue;
    }
    //PROPERTY: orgCountryName
    public String getOrgCountryName(){
        return this.orgCountryName;
    }
    public void setOrgCountryName(String newValue) {
        this.orgCountryName = newValue;
    }
    //PROPERTY: orgCountry
    public String getOrgCountry(){
        return this.orgCountry;
    }
    public void setOrgCountry(String newValue) {
        this.orgCountry = newValue;
    }
    //PROPERTY: destCountryName
    public String getDestCountryName(){
        return this.destCountryName;
    }
    public void setDestCountryName(String newValue) {
        this.destCountryName = newValue;
    }
    //PROPERTY: destCountry
    public String getDestCountry(){
        return this.destCountry;
    }
    public void setDestCountry(String newValue) {
        this.destCountry = newValue;
    }
    //PROPERTY: category
    public String getCategory(){
        return this.category;
    }
    public void setCategory(String newValue) {
        this.category = newValue;
    }
        //PROPERTY: category
    public String getCategoryD(){
        return this.categoryD;
    }
    public void setCategoryD(String newValue) {
        this.categoryD = newValue;
    }
    //PROPERTY: quotaYear
    public String getQuotaYear(){
        return this.quotaYear;
    }
    public void setQuotaYear(String newValue) {
        this.quotaYear = newValue;
    }
    //PROPERTY: quantity
    public Double getQuantity(){
        return this.quantity;
    }
    public void setQuantity(Double newValue) {
        this.quantity = newValue;
    }
    //PROPERTY: unit
    public String getUnit(){
        return this.unit;
    }
    public void setUnit(String newValue) {
        this.unit = newValue;
    }
    //PROPERTY: price
    public Double getPrice(){
        return this.price;
    }
    public void setPrice(Double newValue) {
        this.price = newValue;
    }
}
