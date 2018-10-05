/*
 * OrderNo.java
 *
 * Created on August 6, 2006, 11:13 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package com.foxy.db;

import java.io.Serializable;

/**
 *
 * @author eric
 */
public class OrderNo implements Serializable {
    
    private Integer ordNoId = null;
    private Integer year = null;
    private Integer mainFactory = null;
    private Integer sequence = null;
    
    /** Creates a new instance of Category */
    public OrderNo() {
    }
    
    //PROPERTY: ordNoId
    public Integer getOrdNoId(){
        return this.ordNoId;
    }
    public void setOrdNoId(Integer newValue) {
        this.ordNoId = newValue;
    }
    //PROPERTY: year
    public Integer getYear(){
        return this.year;
    }
    public void setYear(Integer newValue) {
        this.year = newValue;
    }
    //PROPERTY: mainFactory
    public Integer getMainFactory(){
        return this.mainFactory;
    }
    public void setMainFactory(Integer newValue) {
        this.mainFactory = newValue;
    }
    //PROPERTY: sequence
    public Integer getSequence(){
        return this.sequence;
    }
    public void setSequence(Integer newValue) {
        this.sequence = newValue;
    }
}
