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
public class OrderSummary implements Auditable,Serializable {
    private int id = 0;
    private String orderId = null;
    private String month = null;
    private String location = null;
    private String mainFactory = null;
    private Long catId = null;
    private String importTax = null;
    private String quota = null;
    private Double multiplier = null;
    private String orderMethod = null;
    private Double qtyDzn = null;
    private Double qtyPcs = null;
    private String unit = null;
    private String unitc = null;
    private Date delivery = null;
    private Date fabricDeliveryDate = null;
    private String ship = null;
    private String destination = null;
    private String remark = null;
    private String status = null;
    private String delUsrId   = null;
    private Date   delTime   = null;
    private String updUsrId = null;
    private Date   updTime = null;
    private String insUsrId  = null;
    private Date   insTime   = null;
    
    /** Creates a new instance of Order */
    public OrderSummary() {
    }
    //PROPERTY: id
    public int getId(){
        return this.id;
    }
    public void setId(int newValue) {
        this.id = newValue;
    }
    //PROPERTY: orderId
    public String getOrderId(){
        return this.orderId;
    }
    public void setOrderId(String newValue) {
        this.orderId = newValue;
    }
    //PROPERTY: month
    public String getMonth(){
        return this.month;
    }
    public void setMonth(String newValue) {
        this.month = newValue;
    }
    //PROPERTY: mainFactory
    public String getMainFactory(){
        return this.mainFactory;
    }
    public void setMainFactory(String newValue) {
        this.mainFactory = newValue;
    }
    //PROPERTY: location
    public String getLocation(){
        return this.location;
    }
    public void setLocation(String newValue) {
        this.location = newValue;
    }
    //PROPERTY: category
    public Long getCatId(){
        return this.catId;
    }
    public void setCatId(Long newValue) {
        this.catId = newValue;
    }
    //PROPERTY: orderMethod
    public String getOrderMethod(){
        return this.orderMethod;
    }
    public void setOrderMethod(String newValue) {
        this.orderMethod = newValue;
    }
    //PROPERTY: importText
    public String getImportTax(){
        return this.importTax;
    }
    public void setImportTax(String newValue) {
        this.importTax = newValue;
    }
    
    //PROPERTY: quota
    public String getQuota() {
        return quota;
    }
    
    public void setQuota(String quota) {
        this.quota = quota;
    }
    
    //PROPERTY: multiplier
    public Double getMultiplier() {
        return multiplier;
    }
    
    public void setMultiplier(Double multiplier) {
        this.multiplier = multiplier;
    }
    
    
    //PROPERTY: qtyDzn
    public Double getQtyDzn(){
        return this.qtyDzn;
    }
    public void setQtyDzn(Double newValue) {
        this.qtyDzn = newValue;
    }
    
    //Additional handy method to do rounding
    public long getQtyDznRounded(){
        return Math.round(this.qtyDzn);
    }
    
    //PROPERTY: qtyPcs
    public Double getQtyPcs(){
        return this.qtyPcs;
    }
    public void setQtyPcs(Double newValue) {
        this.qtyPcs = newValue;
    }
    
    //Additional handy method to do rounding
    public long getQtyPcsRounded(){
        return Math.round(this.qtyPcs);
    }
    
    //PROPERTY: unit
    public String getUnit(){
        return this.unit;
    }
    public void setUnit(String newValue) {
        this.unit = newValue;
    }
    //PROPERTY: unitc
    public String getUnitc(){
        return this.unitc;
    }
    public void setUnitc(String newValue) {
        this.unitc = newValue;
    }
    //PROPERTY: delivery
    public Date getDelivery(){
        return this.delivery;
    }
    public void setDelivery(Date newValue) {
        this.delivery = newValue;
    }
    
    public Date getFabricDeliveryDate() {
        return fabricDeliveryDate;
    }
    
    public void setFabricDeliveryDate(Date fabricdeliverydate) {
        this.fabricDeliveryDate = fabricdeliverydate;
    }
    
    //PROPERTY: ship
    public String getShip(){
        return this.ship;
    }
    public void setShip(String newValue) {
        this.ship = newValue;
    }
    //PROPERTY: destination
    public String getDestination(){
        return this.destination;
    }
    public void setDestination(String newValue) {
        this.destination = newValue;
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
