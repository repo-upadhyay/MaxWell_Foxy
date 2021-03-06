/*
 * FoxyQtyCheckListReportsPage.java
 *
 * Created on June 20, 2006, 6:18 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package com.foxy.page;

import java.text.SimpleDateFormat;
import javax.faces.application.FacesMessage;
import com.foxy.db.HibernateUtil;
import com.foxy.util.ListData;
import java.io.Serializable;
import java.util.Date;
import java.util.List;
import java.util.ArrayList;
import java.util.Iterator;
import javax.faces.model.DataModel;
import javax.faces.model.ListDataModel;
import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.Transaction;


/**
 *
 * @author hcting
 */
public class FoxyQtyCheckListReportsPage extends Page implements Serializable{
    private static String MENU_CODE = new String("FOXY");
    
    private DataModel dataListModel;
    private String country = null;
    private SimpleDateFormat fmt1 =  new SimpleDateFormat("yyyy-MM-dd");
    private SimpleDateFormat fmt2 =  new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    
    
    public class ReportDataBean {
        private final Double alertPercentThreshold = new Double(0.1);
        private String orderId = null;
        private String month = null;
        private String location = null;
        private Double ordQtyPcs = null;
        private Double confirmQtyPcs = null;
        private boolean alertConfirmQtyPcs = false;
        private Double shipQtyPcs = null;
        private boolean alertShipQtyPcs = false;
        private Date  delivery = null;
        private String merchandiser = null;
        private String createdBy = null;
        private String lastupdBy = null;
        
        
        public String getOrderId() {
            return orderId;
        }
        
        public void setOrderId(String orderId) {
            this.orderId = orderId;
        }
        
        public String getMonth() {
            return month;
        }
        
        public void setMonth(String month) {
            this.month = month;
        }
        
        public String getLocation() {
            return location;
        }
        
        public void setLocation(String location) {
            this.location = location;
        }
        
        public Double getOrdQtyPcs() {
            return ordQtyPcs;
        }
        
        public void setOrdQtyPcs(Double ordQtyPcs) {
            this.ordQtyPcs = ordQtyPcs;
        }
        
        public Double getConfirmQtyPcs() {
            return confirmQtyPcs;
        }
        
        public void setConfirmQtyPcs(Double confirmQtyPcs) {
            this.confirmQtyPcs = confirmQtyPcs;
        }
        
        public boolean isAlertConfirmQtyPcs() {
            if ( this.ordQtyPcs != null && this.confirmQtyPcs != null && this.ordQtyPcs > 0){
                Double tmp = (this.confirmQtyPcs - this.ordQtyPcs) / this.ordQtyPcs;
                tmp = Math.abs(tmp);
                if ( tmp > this.alertPercentThreshold ){
                    alertConfirmQtyPcs = true;
                } else {
                    alertConfirmQtyPcs = false;
                }
            }else {
                alertConfirmQtyPcs = true;
            }
            return alertConfirmQtyPcs;
        }
        
        public Double getShipQtyPcs() {
            return shipQtyPcs;
        }
        
        public void setShipQtyPcs(Double shipQtyPcs) {
            this.shipQtyPcs = shipQtyPcs;
        }
        
        public boolean isAlertShipQtyPcs() {
            if ( this.ordQtyPcs != null && this.shipQtyPcs != null && this.ordQtyPcs > 0){
                Double tmp = (this.shipQtyPcs - this.ordQtyPcs) / this.ordQtyPcs;
                tmp = Math.abs(tmp);
                if ( tmp > this.alertPercentThreshold ){
                    alertShipQtyPcs = true;
                } else {
                    alertShipQtyPcs = false;
                }
            }else{
                alertShipQtyPcs = true;
            }
            return alertShipQtyPcs;
        }
        
        public Date getDelivery() {
            return delivery;
        }
        
        public void setDelivery(Date delivery) {
            this.delivery = delivery;
        }
        
        public String getMerchandiser() {
            return merchandiser;
        }
        
        public void setMerchandiser(String merchandiser) {
            this.merchandiser = merchandiser;
        }
        
        public String getCreatedBy() {
            return createdBy;
        }
        
        public void setCreatedBy(String createdBy) {
            this.createdBy = createdBy;
        }
        
        public String getLastupdBy() {
            return lastupdBy;
        }
        
        public void setLastupdBy(String lastupdBy) {
            this.lastupdBy = lastupdBy;
        }
        
    }; //Inner class end
    
    
    public FoxyQtyCheckListReportsPage() {
        super(new String("QtyCheckListReportsForm"));
        
        try {
            this.isAuthorize(MENU_CODE);
            //System.out.println(ctx.getApplication().getViewHandler().toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    
    public String getTitle(){
        String str = " ";
        str +=  "(" + this.getCountryName() + ") ";
        str +=  "From [" +  fmt1.format(this.getFromDate()) + "] ";
        str +=  "To [" +  fmt1.format(this.getToDate()) + "] ";
        str +=  "As At [" +  fmt2.format(new Date()) + "] ";
        return str;
    }
    
    
    public String getCountry() {
        return country;
    }
    
    public void setCountry(String country) {
        this.country = country;
    }
    
    public String getCountryName(){
        ListData ld = (ListData)getBean("listData");
        return(ld.getCountryDesc(this.getCountry(), 0));
        //return this.country;
    }
    
    public String search() {
        this.foxySessionData.setAction(LST);
        return (null);
    }
    
    public DataModel getQuantityCheckList(){
        List<ReportDataBean>  recordList = null;
        if ( this.country != null){
            try {
                //System.err.println("Search for records " +  this.country + "  " + this.quota + " " + this.getFromDate + " " + this.getToDate);
                Session session = (Session) HibernateUtil.currentSession();
                Transaction tx= session.beginTransaction();
                
                String qstr = "SELECT os.srefid as srefid,  os.orderid as orderid, os.month as month, os.location as location, ";
                qstr += " os.delivery, os.qtypcs as oqtypcs, ";
                qstr += " sum(oc.qtypcs) as cqtypcs, sum(sh.qtypcs) as sqtypcs, od.merchandiser as merchandiser, ";
                qstr += " od.insusrid as insusrid, od.updusrid as updusrid ";
                qstr += " from ordsummary as os ";
                qstr += " LEFT JOIN orders as od ON od.orderid = os.orderid ";
                qstr += " LEFT JOIN ordconfirm as oc ON os.srefid = oc.srefid ";
                qstr += " LEFT JOIN shipping as sh ON oc.crefid = sh.crefid ";
                qstr += " LEFT JOIN factorymast fm ON fm.factorycode = os.mainfactory ";
                qstr += " WHERE fm.countrycode = :porigin AND ";
                qstr += " os.delivery >= :pdeliveryStart AND os.delivery <= :pdeliveryEnd ";
                qstr += " AND os.status = :pstatus ";
                qstr += " GROUP BY os.srefid ORDER BY orderid, month, location";
                
                
                //System.err.println("Test 1111111122222");
                SQLQuery q = session.createSQLQuery(qstr);
                //System.err.println("Test 1111111122222333333");
                q.setString("porigin", this.country);
                q.setString("pstatus", "A");
                q.setDate("pdeliveryStart", this.getFromDate());
                q.setDate("pdeliveryEnd",this.getToDate());
                
                q.addScalar("srefid", Hibernate.STRING);
                q.addScalar("orderid", Hibernate.STRING);
                q.addScalar("month", Hibernate.STRING);
                q.addScalar("location", Hibernate.STRING);
                q.addScalar("delivery", Hibernate.DATE);
                q.addScalar("oqtypcs", Hibernate.DOUBLE);
                q.addScalar("cqtypcs", Hibernate.DOUBLE);
                q.addScalar("sqtypcs", Hibernate.DOUBLE);
                q.addScalar("merchandiser", Hibernate.STRING);
                q.addScalar("insusrid", Hibernate.STRING);
                q.addScalar("updusrid", Hibernate.STRING);
                
                
                //recordList = q.list();
                //System.err.println("Test 111111112222233333344444444");
                Iterator it = q.list().iterator();
                
                //System.err.println("Total records = " + q.list().size());
                
                if ( recordList == null){
                    recordList = new ArrayList();
                }
                
                //System.err.println("Test 11111");
                ReportDataBean grandTotal = new  ReportDataBean();
                try {
                    grandTotal.setOrderId(new String("Grand Total:"));
                    grandTotal.setOrdQtyPcs(new Double(0));
                    grandTotal.setConfirmQtyPcs(new Double(0));
                    grandTotal.setShipQtyPcs(new Double(0));
                    Double tmp = null;
                    while (it.hasNext()){
                        int idx = 0;
                        Object[] tmpRow = (Object[])it.next();
                        ReportDataBean obj = new  ReportDataBean();
                        idx++; //skip srefid
                        obj.setOrderId((String)tmpRow[idx++]);
                        obj.setMonth((String)tmpRow[idx++]);
                        obj.setLocation((String)tmpRow[idx++]);
                        obj.setDelivery((Date)tmpRow[idx++]);
                        
                        tmp = (Double)tmpRow[idx++];
                        obj.setOrdQtyPcs(tmp);
                        grandTotal.setOrdQtyPcs(grandTotal.getOrdQtyPcs() + tmp);
                        
                        tmp = (Double)tmpRow[idx++];
                        obj.setConfirmQtyPcs(tmp);
                        if ( tmp == null ){
                            tmp = new Double(0);
                        }
                        grandTotal.setConfirmQtyPcs(grandTotal.getConfirmQtyPcs() + tmp);
                        
                        tmp = (Double)tmpRow[idx++];
                        obj.setShipQtyPcs(tmp);
                        if ( tmp == null ){
                            tmp = new Double(0);
                        }
                        obj.setMerchandiser((String)tmpRow[idx++]);
                        obj.setCreatedBy((String)tmpRow[idx++]);
                        obj.setLastupdBy((String)tmpRow[idx++]);
                        grandTotal.setShipQtyPcs(grandTotal.getShipQtyPcs() + tmp);
                        
                        recordList.add(obj);
                    }
                } catch ( Exception e){
                    e.printStackTrace();
                }
                
                //System.err.println("Test 11111333");
                recordList.add(grandTotal);
                //System.err.println("Test 1111144444");
                if (dataListModel == null) {
                    //System.err.println("Search for records 333");
                    dataListModel = new ListDataModel();
                }
                
                //System.err.println("Test 111115555");
                dataListModel.setWrappedData(recordList);
                //System.err.println("Test 11111666");
                tx.commit();
            } catch (HibernateException e) {
                //do something here with the exception
                e.printStackTrace();
                FacesMessage fmsg  = new FacesMessage(FacesMessage.SEVERITY_ERROR, e.getCause().toString(), e.getMessage());
                ctx.addMessage(null, fmsg);
            }catch (Exception e){
                e.printStackTrace();
                FacesMessage fmsg  = new FacesMessage(FacesMessage.SEVERITY_ERROR, e.getCause().toString(), e.getMessage());
                ctx.addMessage(null, fmsg);
            } finally {
                HibernateUtil.closeSession();
            }
        }else {
            System.err.println("No records ....!!! Search key is null");
        }
        //Avoid null pointer exception
        if (dataListModel == null) {
            System.err.println("No records ....!!!");
            dataListModel = new ListDataModel();
        }
        
        return dataListModel;
    }
    
    
}
