/*
 * User.java
 *
 * Created on June 15, 2006, 6:38 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package com.foxy.db;

import java.io.Serializable;
import java.util.Date;
import javax.faces.context.FacesContext;
import com.foxy.util.ListData;
/**
 *
 * @author eric
 */
public class User implements Auditable,Serializable {
    private String userId = null;
    private String password = null;
    private String fullName = null;
    private String location = null;
    private String userGroup = null;
    private String status = null;
    private String delUsrId   = null;
    private Date   delTime   = null;
    private String updUsrId = null;
    private Date   updTime = null;
    private String insUsrId  = null;
    private Date   insTime   = null;
    
    /** Creates a new instance of User */
    public User() {
    	System.out.println("============================ User constructor=====================");
    }
    
    //PROPERTY: userId
    public String getUserId(){
        return this.userId;
    }
    public void setUserId(String newValue) {
        this.userId = newValue;
    }
    //PROPERTY: password
    public String getPassword(){
        return this.password;
    }
    public void setPassword(String newValue) {
        this.password = newValue;
    }
    
    //PROPERTY: fullName
    public String getFullName() {
        return this.fullName;
    }
    
    public void setFullName(String newValue) {
        this.fullName = newValue;
    }
    
    //PROPERTY: location
    public String getLocation() {
        return this.location;
    }
    
    public void setLocation(String newValue) {
        this.location = newValue;
    }
    
    public String getCountryDesc(){
        FacesContext ctx = FacesContext.getCurrentInstance();
        ListData ld = (ListData)ctx.getApplication().getVariableResolver().resolveVariable(ctx, "listData");
        return ld.getCountryDesc(this.location, 1);
    }
    
    //PROPERTY: userGroup
    public String getUserGroup() {
        return this.userGroup;
    }
    
    public void setUserGroup(String newValue) {
        this.userGroup = newValue;
    }
    
    //PROPERTY: status
    public String getStatus() {
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
