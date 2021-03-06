/*
 * Order.java
 *
 * Created on June 21, 2006, 3:29 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package com.foxy.db;

import java.io.Serializable;
import java.util.Date;

/**
 *
 * @author eric
 */
public class OrderConfirm implements Auditable,Serializable {
    private Integer id = null;
    private String orderId = null;
    private Integer sRefId = null;
    private String month = null;
    private String location = null;
    private String subLocation = null;
    
    private String make = null;
    private String poNumber = null;
    private Date poDate = null;
    private Double qtyDzn = null;
    private Double qtyPcs = null;
    private String unitc = null;
    private Date fabricDate = null;
    private Date vesselDate = null;
    private String ship = null;
    private String emb = null;
    private String lmerchandiser = null;
    private String mrForCust = null;
    private Date closeDate = null;
    private String remark = null;
    private String status = null;
    private String delUsrId   = null;
    private Date   delTime   = null;
    private String updUsrId = null;
    private Date   updTime = null;
    private String insUsrId  = null;
    private Date   insTime   = null;
    
    /** Creates a new instance of Order */
    public OrderConfirm() {
    }
    //PROPERTY: id
    public Integer getId(){
        return this.id;
    }
    public void setId(Integer newValue) {
        this.id = newValue;
    }
    //PROPERTY: orderId
    public String getOrderId(){
        return this.orderId;
    }
    public void setOrderId(String newValue) {
        this.orderId = newValue;
    }
    //PROPERTY: sRefId
    public Integer getSsRefId(){
        return this.sRefId;
    }
    public void setSsRefId(Integer newValue) {
        this.sRefId = newValue;
    }
    //PROPERTY: month
    public String getMonth(){
        return this.month;
    }
    public void setMonth(String newValue) {
        this.month = newValue;
    }
    //PROPERTY: location
    public String getLocation(){
        return this.location;
    }
    public void setLocation(String newValue) {
        this.location = newValue;
    }
    //PROPERTY: subLocation
    public String getSubLocation(){
        return this.subLocation;
    }
    public void setSubLocation(String newValue) {
        this.subLocation = newValue;
    }
    //PROPERTY: make
    public String getMake(){
        return this.make;
    }
    public void setMake(String newValue) {
        this.make = newValue;
    }
    //PROPERTY: poNumber
    public String getPoNumber(){
        return this.poNumber;
    }
    public void setPoNumber(String newValue) {
        this.poNumber = newValue;
    }
    //PROPERTY: poDate
    public Date getPoDate(){
        return this.poDate;
    }
    public void setPoDate(Date newValue) {
        this.poDate = newValue;
    }
    //PROPERTY: qtyDzn
    public Double getQtyDzn(){
        return this.qtyDzn;
    }
    public void setQtyDzn(Double newValue) {
        this.qtyDzn = newValue;
    }
    //PROPERTY: qtyPcs
    public Double getQtyPcs(){
        return this.qtyPcs;
    }
    public void setQtyPcs(Double newValue) {
        this.qtyPcs = newValue;
    }
    //PROPERTY: unit
    public String getUnitc(){
        return this.unitc;
    }
    public void setUnitc(String newValue) {
        this.unitc = newValue;
    }
    //PROPERTY: fabricDate
    public Date getFabricDate(){
        return this.fabricDate;
    }
    public void setFabricDate(Date newValue) {
        this.fabricDate = newValue;
    }
    //PROPERTY: vesselDate
    public Date getVesselDate(){
        return this.vesselDate;
    }
    public void setVesselDate(Date newValue) {
        this.vesselDate = newValue;
    }
    
    public String getShip(){
        return this.ship;
    }
    public void setShip(String newValue) {
        this.ship = newValue;
    }
    
    public String getEmb() {
        return emb;
    }
    
    public void setEmb(String emb) {
        this.emb = emb;
    }
    
    public String getLmerchandiser() {
        return lmerchandiser;
    }
    
    public void setLmerchandiser(String lmerchandiser) {
        this.lmerchandiser = lmerchandiser;
    }
    
    public String getMrForCust() {
        return mrForCust;
    }
    
    public void setMrForCust(String mrForCust) {
        this.mrForCust = mrForCust;
    }
    
    
    //PROPERTY: closeDate
    public Date getCloseDate(){
        return this.closeDate;
    }
    public void setCloseDate(Date newValue) {
        this.closeDate = newValue;
    }
    //PROPERTY: remark
    public String getRemark(){
        return this.remark;
    }
    public void setRemark(String newValue) {
        this.remark = newValue;
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
