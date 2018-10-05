/*
 * Category.java
 *
 * Created on August 6, 2006, 11:13 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package com.foxy.db;

import java.io.Serializable;
import java.util.Date;

/**
 *
 * @author hcting
 */
public class Category implements Auditable,Serializable {
    
    private Long catId = null;
    private String category = null;
    private String country = null;
    private String fabric = null;
    private String desc   = null;
    private String unit   = null;
    private String status = null;
    private String delUsrId  = null;
    private Date   delTime   = null;
    private String updUsrId = null;
    private Date   updTime = null;
    private String insUsrId  = null;
    private Date   insTime   = null;
    
    
    
    /** Creates a new instance of Category */
    public Category() {
    }
    
    
    //Setter method
    public void setCategory(String category) {
        this.category = category;
    }
    
    public void setCatId(Long catid) {
        this.catId = catid;
    }
    
    public void setCountry(String country) {
        this.country = country;
    }
    
    public void setDesc(String desc) {
        this.desc = desc;
    }
    
    public void setFabric(String fabric) {
        this.fabric = fabric;
    }
    
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public void setUnit(String unit) {
        this.unit = unit;
    }
    
    
    
    //getter method
    public String getCategory() {
        return category;
    }
    
    public Long getCatId() {
        return catId;
    }
    
    public String getCountry() {
        return country;
    }
    
    public String getDesc() {
        return desc;
    }
    
    public String getFabric() {
        return fabric;
    }
    
    
    public String getStatus() {
        return status;
    }
    
    public String getUnit() {
        return unit;
    }
    
    public Date getDelTime() {
        return delTime;
    }
    
    public void setDelTime(Date delTime) {
        this.delTime = delTime;
    }
    
    public Date getInsTime() {
        return insTime;
    }
    
    public void setInsTime(Date insTime) {
        this.insTime = insTime;
    }
    
    public Date getUpdTime() {
        return updTime;
    }
    
    public void setUpdTime(Date updTime) {
        this.updTime = updTime;
    }
    
    public String getDelUsrId() {
        return delUsrId;
    }
    
    public void setDelUsrId(String delUsrId) {
        this.delUsrId = delUsrId;
    }
    
    public String getInsUsrId() {
        return insUsrId;
    }
    
    public void setInsUsrId(String insUsrId) {
        this.insUsrId = insUsrId;
    }
    
    public String getUpdUsrId() {
        return updUsrId;
    }
    
    public void setUpdUsrId(String updUsrId) {
        this.updUsrId = updUsrId;
    }
}
