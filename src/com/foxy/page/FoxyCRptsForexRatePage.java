/*
 * FoxyCRptsForexRatePage.java
 *
 * Created on June 20, 2006, 6:18 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package com.foxy.page;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import javax.faces.application.FacesMessage;
import com.foxy.db.HibernateUtil;
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
public class FoxyCRptsForexRatePage extends Page implements Serializable{
    private static String MENU_CODE = new String("FOXY");
    
    private DataModel dataListModel;
    
    private Date Jan01 = null;
    private SimpleDateFormat fmt1 =  new SimpleDateFormat("yyyy-MM-dd");
    private SimpleDateFormat fmt2 =  new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    
    
    public class ReportDataBean {
        private Date dateRate = null;
        private Double HkdRate = null;
        private Double SgdRate = null;
        private Double UsdRate = null;
        
        public Date getDateRate() {
            return dateRate;
        }
        
        public void setDateRate(Date dateRate) {
            this.dateRate = dateRate;
        }
        
        public Double getHkdRate() {
            return HkdRate;
        }
        
        public void setHkdRate(Double HkdRate) {
            this.HkdRate = HkdRate;
        }
        
        public Double getSgdRate() {
            return SgdRate;
        }
        
        public void setSgdRate(Double SgdRate) {
            this.SgdRate = SgdRate;
        }
        
        public Double getUsdRate() {
            return UsdRate;
        }
        
        public void setUsdRate(Double UsdRate) {
            this.UsdRate = UsdRate;
        }
        
    }; //Inner class end
    
    
    
    public FoxyCRptsForexRatePage() {
        super(new String("ForexRateReportsForm"));
        
        try {
            this.isAuthorize(MENU_CODE);
            //System.out.println(ctx.getApplication().getViewHandler().toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    
    public String getTitle(){
        String str = " ";
        
        if ( this.searchKey != null){
            str = " [" + this.searchKey + "] As At ["  +  fmt2.format(new Date()) + "] ";
        }else{
            str +=  " From [" +  fmt1.format(this.getFromDate()) + "] ";
            if ( this.getToDate() != null) {
                str +=  " To [" +  fmt1.format(this.getToDate()) + "] ";
            }
            str +=  " As At [" +  fmt2.format(new Date()) + "] ";
        }
        return str;
    }
    
    
    public void setJan01(Date Jan01) {
        this.Jan01 = Jan01;
    }
    
    public Date getJan01() {
        return Jan01;
    }
    
    
    
    public String search() {
        this.foxySessionData.setAction(LST);
        
        if ( this.getFromDate() != null ){
            Calendar cal = Calendar.getInstance();
            // This is the right way to set the month
            cal.setTime(this.getFromDate());
            cal.set(Calendar.MONTH, Calendar.JANUARY);
            cal.set(Calendar.DAY_OF_MONTH, cal.getActualMinimum(Calendar.DAY_OF_MONTH));
            
            this.Jan01 = cal.getTime();
        }
        
        return (null);
    }
    
    
    
    public DataModel getReportData(){
        List<ReportDataBean>  dataList = null;
        if ( this.getFromDate() != null){
            try {
                //System.err.println("Search for records " +  this.country + " " + this.getFromDate() + " " + this.getToDate());
                Session session = (Session) HibernateUtil.currentSession();
                Transaction tx= session.beginTransaction();
                
                String qstr = "SELECT a.ratedate as ratedate, a.perusdrate as sgdrate, b.perusdrate as hkdrate, 1 as usdrate  ";
                qstr += " FROM  forexrate a  ";
                qstr += " LEFT JOIN forexrate b ON a.ratedate = b.ratedate AND b.curcode = 'HKD' ";
                qstr += " WHERE a.curcode = 'SGD' AND a.ratedate >= :pfromdate AND a.ratedate <= :ptodate ";
                qstr += " ORDER BY a.ratedate ";
                
                
                //System.err.println(qstr);
                //System.err.println("from date " + this.getFromDate() + " To date " + this.getToDate() );
                SQLQuery q = session.createSQLQuery(qstr);
                //System.err.println("Test 1111111122222333333");
                
                q.setDate("pfromdate", this.getFromDate());
                q.setDate("ptodate", this.getToDate());
                
                q.addScalar("ratedate", Hibernate.DATE);
                q.addScalar("sgdrate", Hibernate.DOUBLE);
                q.addScalar("hkdrate", Hibernate.DOUBLE);
                q.addScalar("usdrate", Hibernate.DOUBLE);
                
                
                //System.err.println("Test 111111112222233333344444444");
                
                Iterator it = q.list().iterator();
                //System.err.println("Total records = " + q.list().size());
                tx.commit();
                
                if ( dataList == null){
                    dataList = new ArrayList();
                }
                
                String tmporderid = null;
                try { //loop of all applicable order id
                    while (it.hasNext()){
                        Object[] tmpRow = (Object[])it.next();
                        int i = 0;
                        
                        ReportDataBean obj = new  ReportDataBean();
                        obj.setDateRate((Date)tmpRow[i++]);
                        obj.setSgdRate((Double)tmpRow[i++]);
                        obj.setHkdRate((Double)tmpRow[i++]);
                        obj.setUsdRate((Double)tmpRow[i++]);
                        
                        //obj.set(String)tmpRow[idx++]);
                        dataList.add(obj);
                    }
                } catch ( Exception e){
                    e.printStackTrace();
                }
                
                
                
                if (dataListModel == null) {
                    //System.err.println("Search for records 333");
                    dataListModel = new ListDataModel();
                }
                
                dataListModel.setWrappedData(dataList);
                
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
