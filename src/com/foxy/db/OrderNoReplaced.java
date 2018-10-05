/*
 * OrderNoReplaced.java
 *
 * Created on June 21, 2006, 3:59 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */
package com.foxy.db;

import java.io.Serializable;
import java.util.Date;

/**
 *
 * @author Darren Ting
 */
public class OrderNoReplaced implements Auditable, Serializable {

    private Long ordReplaceId = null;
    private String oldOrderId = null;
    private String newOrderId = null;
    private String status = null;
    private String delUsrId = null;
    private Date delTime = null;
    private String updUsrId = null;
    private Date updTime = null;
    private String insUsrId = null;
    private Date insTime = null;

    /**
     * Creates a new instance of Menu
     */
    public OrderNoReplaced() {
    }

    public Long getOrdReplaceId() {
        return ordReplaceId;
    }

    public void setOrdReplaceId(Long ordReplaceId) {
        this.ordReplaceId = ordReplaceId;
    }

    public String getOldOrderId() {
        return oldOrderId;
    }

    public void setOldOrderId(String orderId) {
        this.oldOrderId = orderId;
    }

    public String getNewOrderId() {
        return newOrderId;
    }

    public void setNewOrderId(String newOrderId) {
        this.newOrderId = newOrderId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public Date getDelTime() {
        return delTime;
    }

    @Override
    public void setDelTime(Date delTime) {
        this.delTime = delTime;
    }

    @Override
    public String getDelUsrId() {
        return delUsrId;
    }

    @Override
    public void setDelUsrId(String delUsrId) {
        this.delUsrId = delUsrId;
    }

    @Override
    public Date getInsTime() {
        return insTime;
    }

    @Override
    public void setInsTime(Date insTime) {
        this.insTime = insTime;
    }

    @Override
    public Date getUpdTime() {
        return updTime;
    }

    @Override
    public void setUpdTime(Date updTime) {
        this.updTime = updTime;
    }

    @Override
    public String getInsUsrId() {
        return insUsrId;
    }

    @Override
    public void setInsUsrId(String insUsrId) {
        this.insUsrId = insUsrId;
    }

    @Override
    public String getUpdUsrId() {
        return updUsrId;
    }

    @Override
    public void setUpdUsrId(String updUsrId) {
        this.updUsrId = updUsrId;
    }
}
