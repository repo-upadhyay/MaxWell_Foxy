/*
 * ProdScheduleLots.java
 *
 * Created on June 30, 2006, 6:52 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package com.foxy.db;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import com.foxy.util.FoxyTimeZone;
import java.util.Date;


/**
 *
 * @author hcting
 */
public class ProdScheduleLots implements Auditable,Serializable {
    private Long lotId = null;
    private Long prodSchId = null;
    private String lot = null;
    private Date vesselDate = null;
    private String status  = null;
    private String delUsrId   = null;
    private Date   delTime   = null;
    private String updUsrId = null;
    private Date   updTime = null;
    private String insUsrId  = null;
    private Date   insTime   = null;
    
    
    /** Creates a new instance of Farameter */
    public ProdScheduleLots() {
    }
    
    public ProdScheduleLots(String lot, Date vesselDt) {
        this.lot = lot;
        this.vesselDate = vesselDt;
    }
    
    
    public Long getProdSchId() {
        return prodSchId;
    }
    
    public void setProdSchId(Long Id) {
        this.prodSchId = Id;
    }
    
    public Long getLotId() {
        return lotId;
    }
    
    public void setLotId(Long lotId) {
        this.lotId = lotId;
    }
    
    public String getLot() {
        return lot;
    }
    
    public void setLot(String lot) {
        this.lot = lot;
    }
    
    public Date getVesselDate() {
        return vesselDate;
    }
    
    public void setVesselDate(Date vesselDate) {
        this.vesselDate = vesselDate;
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
    
    public String getListDisplayFormat(){
        FoxyTimeZone ftz = new FoxyTimeZone();
        String str = null;
        
        // Format the current time.
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        return ( "[" + (this.vesselDate == null?"NULL":sdf.format(this.vesselDate)) + "]==>" + (this.lot == null?"NULL":this.lot) );
    }
    
    public String toString(){
        if ( this.vesselDate == null){
            return ("Lot id = " + this.lot + "=>NULL");
        } else {
            return ("Lot id = " + this.lot + "=>" + this.vesselDate.toString());
        }
    }
}
