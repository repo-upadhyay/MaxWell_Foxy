/*
 * MyPageListDataModel.java
 *
 * Created on July 21, 2006, 5:08 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */


package com.foxy.util;



/***************************************************************************
 *Inside Page Bean, add in following code
 *
 *class page_1 extend page {
 *
 private UIData myTable;
 
    //getter for dataTable JSF component
    public UIData getMyTable(){
        return myTable;
    }
 
    //setter for dataTable JSF component
    public void setMyTable(UIData mtbl) {
        this.myTable = mtbl;
    }
 *}
 *
 *
 *
 *Inside JSP add following binding NOTE: binding, value, preserveDataModel="true" and rows is MANDATORY to set
 *ie: page_1.jsp
 *<t:dataTable  id="mydatatable" 
 * binding="#{page_1.myTable}"
 * value="#{page_1.myPagedListDataModel}" var="var1"
 * preserveDataModel="true"
 * styleClass="dataTable"
 * rows="10">
 *
 *****************************************************************************/



import java.util.List;
import javax.faces.model.DataModel;

public class FoxyPagedDataModel extends DataModel{
    
    private int rowIndex = -1;
    
    private int totalNumRows;
    
    private int pageSize;
    
    private List list;
    
    public FoxyPagedDataModel() {
        super();
    }
    
    public FoxyPagedDataModel(List list, int totalNumRows, int pageSize) {
        super();
        setWrappedData(list);
        this.totalNumRows = totalNumRows;
        this.pageSize = pageSize;
    }
    
    public boolean isRowAvailable() {
        if(list == null)
            return false;
        
        int rowIndex_l = getRowIndex();
        if(rowIndex_l >=0 && rowIndex_l < list.size())
            return true;
        else
            return false;
    }
    
    public int getRowCount() {
        return totalNumRows;
    }
    
    public Object getRowData() {
        if(list == null)
            return null;
        else if(!isRowAvailable())
            throw new IllegalArgumentException();
        else {
            int dataIndex = getRowIndex();
            return list.get(dataIndex);
        }
    }
    
    public int getRowIndex() {
        return (rowIndex % pageSize);
    }
    
    public void setRowIndex(int rowIndex) {
        this.rowIndex = rowIndex;
    }
    
    public Object getWrappedData() {
        return list;
    }
    
    public void setWrappedData(Object list) {
        this.list = (List) list;
    }
    
}