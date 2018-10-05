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

/**
 *
 * @author hcting
 */
public class UserRole implements Auditable,Serializable {
    private Long roleId = null;
    private String userId = null;
    private String role = null;
    private String status = null;
    private String delUsrId   = null;
    private Date   delTime   = null;
    private String updUsrId = null;
    private Date   updTime = null;
    private String insUsrId  = null;
    private Date   insTime   = null;
    
    /** Creates a new instance of User */
    public UserRole() {
    }
    
    public UserRole(String userid, String role) {
        this.userId = userid;
        this.role = role;
    }
    
    
    //Getter methods
    public String getRole() {
        return role;
    }
    
    public Long getRoleId() {
        return roleId;
    }
    
    public String getUserId() {
        return userId;
    }
    
    
    //Setter method
    public void setRole(String role) {
        this.role = role;
    }
    
    public void setRoleId(Long roleId) {
        this.roleId = roleId;
    }
    
    public void setUserId(String userId) {
        this.userId = userId;
    }
    
    //PROPERTY: status
    public String getStatus() {
        return this.status;
    }
    
    public void setStatus(String newValue) {
        this.status = newValue;
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
    
    public Date getDelTime() {
        return delTime;
    }
    
    public void setDelTime(Date delTime) {
        this.delTime = delTime;
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
