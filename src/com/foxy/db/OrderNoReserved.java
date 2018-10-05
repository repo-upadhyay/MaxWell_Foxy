/*
 * Menu.java
 *
 * Created on June 21, 2006, 3:59 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */
package com.foxy.db;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;
import java.util.concurrent.TimeUnit;

/**
 *
 * @author Darren Ting
 */
public class OrderNoReserved implements Serializable {

    private Long resvNoId = null;
    private Integer year = null;
    private Integer mainFactory = null;
    private String reservedNo = null;
    private String forUserId = null;
    private Date reservedOn = null;
    private Date expiredOn = null;
    private String status = null;
    SimpleDateFormat fmt2 = new SimpleDateFormat("dd-MM-yyyy");

    /**
     * Creates a new instance of Menu
     */
    public OrderNoReserved() {
    }

    public Long getResvNoId() {
        return resvNoId;
    }

    public void setResvNoId(Long resvNoId) {
        this.resvNoId = resvNoId;
    }

    public Integer getYear() {
        return year;
    }

    public void setYear(Integer year) {
        this.year = year;
    }

    public Integer getMainFactory() {
        return mainFactory;
    }

    public void setMainFactory(Integer mainFactory) {
        this.mainFactory = mainFactory;
    }

    public String getReservedNo() {
        return reservedNo;
    }

    public void setReservedNo(String reservedNo) {
        this.reservedNo = reservedNo;
    }

    public String getForUserId() {
        return forUserId;
    }

    public void setForUserId(String forUserId) {
        this.forUserId = forUserId;
    }

    public Date getReservedOn() {
        return reservedOn;
    }

    public void setReservedOn(Date reservedOn) {
        this.reservedOn = reservedOn;
    }

    public Date getExpiredOn() {
        return expiredOn;
    }

    public String getExpiredOnFmted() {
        return fmt2.format(expiredOn);
    }

    public boolean isExpired() {
        long msecDiff = 0;
        Calendar c = Calendar.getInstance(Locale.US);
        //c.set(Calendar.HOUR_OF_DAY, 0);
        //c.set(Calendar.MINUTE, 0);
        //c.set(Calendar.SECOND, 0);
        msecDiff = c.getTime().getTime() - this.expiredOn.getTime();

        //If current date greater than expired date, it has passed expiry date
        if (msecDiff > 0) {
            return true;
        } else {
            return false;
        }
    }

    public Long getDaysToExpiry() {
        long msecDiff = 0;
        Calendar c = Calendar.getInstance(Locale.US);
        c.set(Calendar.HOUR_OF_DAY, 0);
        c.set(Calendar.MINUTE, 0);
        c.set(Calendar.SECOND, 0);
        msecDiff = this.expiredOn.getTime() - c.getTime().getTime();

        msecDiff = TimeUnit.MILLISECONDS.toDays(msecDiff);
        if (msecDiff < 0) {
            msecDiff = 0;
        }
        return msecDiff;
    }

    public void setExpiredOn(Date expiredOn) {
        this.expiredOn = expiredOn;
    }

    public void setExpiredAfterDays(Integer DaysToExpiry) {
        Calendar c = Calendar.getInstance(Locale.US);
        if (this.reservedOn != null) {
            c.setTime(this.reservedOn);
            c.add(Calendar.DATE, DaysToExpiry + 1);
            c.set(Calendar.HOUR_OF_DAY, 0);
            c.set(Calendar.MINUTE, 0);
            c.set(Calendar.SECOND, 0);
            this.expiredOn = c.getTime();
        }
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
