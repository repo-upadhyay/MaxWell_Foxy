/*
 * FoxySessionData.java
 *
 * Created on July 25, 2006, 7:32 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */
package com.foxy.bean;

import java.util.Date;
import javax.faces.context.FacesContext;

/**
 *
 * @author hcting
 */
public class FoxySessionData {

    private String orderId = null;
    private String searchKey = null;       /* Search key for search page */

    private String searchType = null;       /* Search Type for search page */

    private int tableFirstRow = 0;
    private int tableRows = 0;
    private boolean backToList = false;
    private String action = null;          /* Action */

    private String pageParameter = null;          /* pageParameter */

    private Long pageParameterLong = null;
    private Long pageParameterLong2 = null;
    private Object sessObject1 = null;
    private Date fromDate = null;
    private Date toDate = null;

    /**
     * Creates a new instance of FoxySessionData
     */
    public FoxySessionData() {
    }

    /**
     * Reset all variable
     */
    public void resetAll() {
        this.action = null;
        this.pageParameter = null;
    }

    public void resetSearchKey() {
        this.searchKey = null;
    }

    public void resetOrderId() {
        this.orderId = null;
    }

    public void setSearchKey(String newValue) {
        this.searchKey = newValue;
    }

    public String getSearchKey() {
        return this.searchKey;
    }

    public int getTableFirstRow() {
        return tableFirstRow;
    }

    public void setTableFirstRow(int tableFirstRow) {
        this.tableFirstRow = tableFirstRow;
    }

    public int getTableRows() {
        return tableRows;
    }

    public void setTableRows(int tableRows) {
        this.tableRows = tableRows;
    }

    public boolean isBackToList() {
        return backToList;
    }

    public void setBackToList(boolean backToList) {
        this.backToList = backToList;
    }
    //PROPERTY: searchType

    public String getSearchType() {
        return this.searchType;
    }

    public void setSearchType(String newValue) {
        this.searchType = newValue;
    }

    public void setOrderId(String newValue) {
        this.orderId = newValue;
    }

    public String getOrderId() {
        return this.orderId;
    }

    public void setAction(String newValue) {
        this.action = newValue;
    }

    public String getAction() {
        return this.action;
    }

    public void resetAction() {
        this.action = null;
    }

    public void setPageParameterLong(Long newValue) {
        this.pageParameterLong = newValue;
    }

    public Long getPageParameterLong() {
        return this.pageParameterLong;
    }

    public Long getPageParameterLong2() {
        return pageParameterLong2;
    }

    public void setPageParameterLong2(Long pageParameterLong2) {
        this.pageParameterLong2 = pageParameterLong2;
    }

    public void setPageParameter(String newValue) {
        this.pageParameter = newValue;
    }

    public String getPageParameter() {
        return this.pageParameter;
    }

    public void resetPageParameter() {
        this.pageParameter = null;
    }

    public Object getSessObject1() {
        return sessObject1;
    }

    public void setSessObject1(Object sessObject1) {
        this.sessObject1 = sessObject1;
    }

    public Date getFromDate() {
        return fromDate;
    }

    public void setFromDate(Date fromDate) {
        this.fromDate = fromDate;
    }

    public Date getToDate() {
        return toDate;
    }

    public void setToDate(Date toDate) {
        this.toDate = toDate;
    }

    public boolean isShortCut() {
        if (this.orderId != null
                && !FacesContext.getCurrentInstance().getExternalContext().isUserInRole("3002")) {
            return true;
        } else {
            return false;
        }
    }

    public boolean isInvShortCut() {
        if (FacesContext.getCurrentInstance().getExternalContext().isUserInRole("3002")
                || FacesContext.getCurrentInstance().getExternalContext().isUserInRole("9000")) {
            return true;
        } else {
            return false;
        }
    }

    public boolean isDisplayOrderId() {
        if (this.orderId != null
                && !FacesContext.getCurrentInstance().getExternalContext().isUserInRole("3002")) {
            return true;
        } else {
            return false;
        }
    }

    public boolean isDisplayInvId() {
        if (this.orderId != null
                && FacesContext.getCurrentInstance().getExternalContext().isUserInRole("3002")) {
            return true;
        } else {
            return false;
        }
    }

    public boolean isList() {
        if (this.searchKey != null) {
            return true;
        } else {
            return false;
        }
    }
}
