/*
 * Customer.java
 *
 * Created on June 21, 2006, 3:59 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package com.foxy.db;

import com.foxy.util.ListData;
import java.io.Serializable;
import java.util.Date;

/**
 *
 * @author hcting
 */
public class FactoryMast implements Auditable,Serializable {
    private Long id = null;
    private String factoryCode = null;
    private String countryCode = null;
    //currently not in used, reserve for merger
    private String parentCompanyId = "";
    private String factoryName = null;
    private String factoryNameLong = null;
    private Integer seqNo = null;
    private String status = null;
    private String delUsrId   = null;
    private Date   delTime   = null;
    private String updUsrId = null;
    private Date   updTime = null;
    private String insUsrId  = null;
    private Date   insTime   = null;
    
    
    /** Creates a new instance of Customer */
    public FactoryMast() {
    }
    
    
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getFactoryCode() {
        return factoryCode;
    }

    public void setFactoryCode(String factoryCode) {
        this.factoryCode = factoryCode;
    }

    public String getCountryCode() {
        return countryCode;
    }

    public void setCountryCode(String countryCode) {
        this.countryCode = countryCode;
    }

    public String getParentCompanyId() {
        return parentCompanyId;
    }

    public void setParentCompanyId(String parentCompanyId) {
        this.parentCompanyId = parentCompanyId;
    }

    public String getFactoryName() {
        return factoryName;
    }

    public void setFactoryName(String factoryName) {
        this.factoryName = factoryName;
    }

    public String getFactoryNameLong() {
        return factoryNameLong;
    }

    public void setFactoryNameLong(String factoryNameLong) {
        this.factoryNameLong = factoryNameLong;
    }

    public Integer getSeqNo() {
        return seqNo;
    }

    public void setSeqNo(Integer seqNo) {
        this.seqNo = seqNo;
    }
    
    //PROPERTY: status
    public String getStatus(){
        return this.status;
    }
    public void setStatus(String newValue) {
        this.status = newValue;
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
