/*
 * FoxyFabricConstructionReportsPage.java
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
public class FoxyFabricConstructionReportsPage extends Page implements Serializable{
    private static String MENU_CODE = new String("FOXY");
    
    private DataModel dataListModel;
    private String country = null;
    private String orderId = null;
    private String styleCode = null;
    
    private SimpleDateFormat fmt1 =  new SimpleDateFormat("yyyy-MM-dd");
    private SimpleDateFormat fmt2 =  new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    
    
    public class ReportDataBean {
        private String orderId = null;
        private String styleCode = null;
        private Double horiz = null;
        private Double vert = null;
        
        public String getOrderId() {
            return orderId;
        }
        
        public void setOrderId(String orderId) {
            this.orderId = orderId;
        }
        
        public String getStyleCode() {
            return styleCode;
        }
        
        public void setStyleCode(String styleCode) {
            this.styleCode = styleCode;
        }
        
        public Double getHoriz() {
            return horiz;
        }
        
        public void setHoriz(Double horiz) {
            this.horiz = horiz;
        }
        
        public Double getVert() {
            return vert;
        }
        
        public void setVert(Double vert) {
            this.vert = vert;
        }
        
    }; //Inner class end
    
    
    public FoxyFabricConstructionReportsPage() {
        super(new String("FabricConstructionListingForm"));
        
        try {
            this.isAuthorize(MENU_CODE);
            //System.out.println(ctx.getApplication().getViewHandler().toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    
    public String getTitle(){
        String str = " ";
        if ( this.orderId != null ) {
            str +=  "Ref No (" + this.orderId + ") ";
        }
        
        if ( this.styleCode != null ){
            str += "Style Code (" + this.styleCode + ") ";
        }
        
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
    
    public String getOrderId() {
        return orderId;
    }
    
    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }
    
    public String getStyleCode() {
        return styleCode;
    }
    
    public void setStyleCode(String styleCode) {
        this.styleCode = styleCode;
    }
    
    public String search() {
        this.foxySessionData.setAction(LST);
        if ( this.orderId != null ){
            this.orderId.replace('*', '%');
        }
        
        if ( this.styleCode != null ){
            this.styleCode.replace('*', '%');
        }
        
        return (null);
    }
    
    public DataModel getFabricConstructionList(){
        List<ReportDataBean>  recordList = null;
        if ( this.styleCode != null || this.orderId != null){
            try {
                //System.err.println("Search for records " +  this.country + "  " + this.quota + " " + this.getFromDate + " " + this.getToDate);
                Session session = (Session) HibernateUtil.currentSession();
                Transaction tx= session.beginTransaction();
                
                String qstr = "SELECT ord.orderid as orderid, ";
                qstr += " ord.stylecode as style, ord.horizontal as horiz, ord.vertical as vert ";
                qstr += " from orders as ord ";
                qstr += " WHERE ord.status = :pstatus ";
                
                if ( this.styleCode != null ) {
                    qstr += " AND ord.stylecode LIKE :pstylecode ";
                }
                
                if ( this.orderId != null) {
                    qstr += " AND ord.orderid LIKE :porderid ";
                }
                
                qstr += " ORDER BY orderid, style";
                
                //System.err.println("Test 1111111122222");
                SQLQuery q = session.createSQLQuery(qstr);
                //System.err.println("Test 1111111122222333333");
                q.setString("pstatus", "A");
                
                if ( this.styleCode != null ) {
                    q.setString("pstylecode", this.styleCode.replace('*', '%'));
                }
                if ( this.orderId != null) {
                    q.setString("porderid",this.orderId.replace('*', '%'));
                }
                
                
                q.addScalar("orderid", Hibernate.STRING);
                q.addScalar("style", Hibernate.STRING);
                q.addScalar("horiz", Hibernate.DOUBLE);
                q.addScalar("vert", Hibernate.DOUBLE);
                
                //System.err.println("Test 111111112222233333344444444");
                Iterator it = q.list().iterator();
                
                //System.err.println("Total records = " + q.list().size());
                
                if ( recordList == null){
                    recordList = new ArrayList();
                }
                
                //System.err.println("Test 11111");
                try {
                    while (it.hasNext()){
                        int idx = 0;
                        Object[] tmpRow = (Object[])it.next();
                        ReportDataBean obj = new  ReportDataBean();
                        obj.setOrderId((String)tmpRow[idx++]);
                        obj.setStyleCode((String)tmpRow[idx++]);
                        obj.setHoriz((Double)tmpRow[idx++]);
                        obj.setVert((Double)tmpRow[idx++]);
                        recordList.add(obj);
                    }
                } catch ( Exception e){
                    e.printStackTrace();
                }
                
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
            }finally {
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
