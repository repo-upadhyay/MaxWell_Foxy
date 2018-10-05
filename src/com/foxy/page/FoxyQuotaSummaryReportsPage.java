/*
 * FoxyQuotaSummaryReportsPage.java
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
import com.foxy.db.QuotaMast;
import com.foxy.db.HibernateUtil;
import com.foxy.util.ListData;
import java.io.Serializable;
import java.util.Date;
import java.util.List;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Set;
import javax.faces.model.DataModel;
import javax.faces.model.ListDataModel;
import javax.faces.model.SelectItem;
import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.Criteria;
import org.hibernate.criterion.Expression;
import org.hibernate.criterion.Order;


/**
 *
 * @author hcting
 */
public class FoxyQuotaSummaryReportsPage extends Page implements Serializable{
    private static String MENU_CODE = new String("FOXY");
    
    private DataModel quotaOutstandingListModel;
    private List quotaForCountry = null;
    private String country = null;
    private Date Jan01 = null;
    private SimpleDateFormat fmt1 =  new SimpleDateFormat("yyyy-MM-dd");
    private SimpleDateFormat fmt2 =  new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    
    
    public class ReportDataBean {
        private String quota = null;
        private Double avlQty = null;
        private Double BIQty = null;
        private Double TIQty = null;
        private Double TOQty = null;
        private Double usedQty = null;
        private Double usedBalQty = null;
        private Double oustQty = null;
        private Double oustBalQty = null;
        
        public String getQuota() {
            return quota;
        }
        
        public void setQuota(String quota) {
            this.quota = quota;
        }
        
        public Double getBIQty() {
            return BIQty;
        }
        
        public void setBIQty(Double BIQty) {
            this.BIQty = BIQty;
        }
        
        public Double getTIQty() {
            return TIQty;
        }
        
        public void setTIQty(Double TIQty) {
            this.TIQty = TIQty;
        }
        
        public Double getTOQty() {
            return TOQty;
        }
        
        public void setTOQty(Double TOQty) {
            this.TOQty = TOQty;
        }
        
        public Double getAvlQty() {
            return avlQty;
        }
        
        public void setAvlQty(Double avlQty) {
            this.avlQty = avlQty;
        }
        
        public Double getOustBalQty() {
            if ( oustBalQty == null) {
                oustBalQty = new Double(0);
                if ( avlQty != null ){
                    oustBalQty += avlQty;
                }
                if ( TIQty != null ){
                    oustBalQty += TIQty;
                }
                if ( TOQty != null ){ //already come with -ve value
                    oustBalQty += TOQty;
                }
                if ( BIQty != null ){
                    oustBalQty += BIQty;
                }
                if ( oustQty != null ){
                    oustBalQty -= oustQty;
                }
            }
            return oustBalQty;
        }
        
        public Double getOustQty() {
            return oustQty;
        }
        
        public void setOustQty(Double oustQty) {
            this.oustQty = oustQty;
        }
        
        public Double getUsedBalQty() {
            if ( usedBalQty == null) {
                usedBalQty = new Double(0);
                if ( avlQty != null ){
                    usedBalQty += avlQty;
                }
                if ( TIQty != null ){
                    usedBalQty += TIQty;
                }
                if ( TOQty != null ){ //already come with -ve value
                    usedBalQty += TOQty;
                }
                if ( BIQty != null ){
                    usedBalQty += BIQty;
                }
                if ( usedQty != null ){
                    usedBalQty -= usedQty;
                }
            }
            //usedBalQty = new Double(avlQty + TIQty + TOQty + BIQty - usedQty);
            return usedBalQty;
        }
        
        public Double getUsedQty() {
            return usedQty;
        }
        
        public void setUsedQty(Double usedQty) {
            this.usedQty = usedQty;
        }
        
    }; //Inner class end
    
    
    public FoxyQuotaSummaryReportsPage() {
        super(new String("QuotaSummaryReportsForm"));
        
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
    
    public void setJan01(Date Jan01) {
        this.Jan01 = Jan01;
    }
    
    public Date getJan01() {
        return Jan01;
    }
    
    
    //Ajax used to get latest Quota list based on country submitted
    public List getQtaByCountryList(){
        System.out.println("Get quota list for country " + this.country);
        if (quotaForCountry == null )
            try {
                Session session = (Session) HibernateUtil.currentSession();
                Transaction tx= session.beginTransaction();
                Criteria criteria = session.createCriteria(QuotaMast.class);
                criteria.add(Expression.eq("country", this.country));
                criteria.addOrder(Order.asc("quota"));
                List resultlist = criteria.list();
                tx.commit();
                HibernateUtil.closeSession();
                
                //Use LinkedHashMap to supress duplicate entry, bcoz list can have duplicate if join table used!!!! and hibernate do return duplicate
                Map resultMap = new LinkedHashMap();
                QuotaMast qtam = null;
                for ( int i = 0; i < resultlist.size(); i++ ){
                    qtam = (QuotaMast)resultlist.get(i);
                    resultMap.put(qtam.getQtaId(), qtam);
                }
                //System.err.println("result size = " +  resultMap.size());
                
                quotaForCountry = new ArrayList();
                quotaForCountry.add(new SelectItem(new String(""),
                        new String((resultMap.size() == 0)?"No Quota Applicable":"Please Select One")));
                
                QuotaMast qm = null;
                Set st = resultMap.entrySet();
                Iterator it = st.iterator();
                while( it.hasNext()){
                    Map.Entry me = (Map.Entry)it.next();
                    qm = (QuotaMast)me.getValue();
                    quotaForCountry.add(new SelectItem(qm.getQuota(), qm.getListDisplayString()));
                    //System.err.println("=====>>>" + qm.getQtaId() + " - " + qm.getListDisplayString());
                }
            } catch (Exception e) {
                e.printStackTrace();
                FacesMessage fmsg  = new FacesMessage(FacesMessage.SEVERITY_ERROR, e.getCause().toString(), e.getMessage());
                ctx.addMessage(null, fmsg);
                return null;
            } finally {
                HibernateUtil.closeSession();
            }
            return (quotaForCountry);
    }
    
    
    public String search() {
        this.foxySessionData.setAction(LST);
        
        Calendar cal = Calendar.getInstance();
        // This is the right way to set the month
        cal.setTime(this.getFromDate());
        cal.set(Calendar.MONTH, Calendar.JANUARY);
        cal.set(Calendar.DAY_OF_MONTH, cal.getActualMinimum(Calendar.DAY_OF_MONTH));
        
        this.Jan01 = cal.getTime();
        
        return (null);
    }
    
    
    public DataModel getQuotaSummaryReport(){
        List<ReportDataBean>  quotaUsagesList = null;
        if ( this.country != null){
            try {
                System.err.println("Search for records " +  this.country + " " + this.getFromDate() + " " + this.getToDate());
                Session session = (Session) HibernateUtil.currentSession();
                Transaction tx= session.beginTransaction();
                
                String qstr = "SELECT a.quota as quota, b.type as type, sum(b.quotaqty) as qty ";
                qstr += " FROM quotamast as a ";
                qstr += " LEFT JOIN quotaentry as b on a.quota = b.quota AND a.country = b.country ";
                qstr += "       AND b.effdate >= :pfrom and b.effdate <= :pto ";
                qstr += " WHERE a.country = :porigin ";
                qstr += " And a.status = :pstatus ";
                qstr += " GROUP BY quota, type ";
                qstr += " ORDER BY quota, type ";
                
                //System.err.println(qstr);
                //System.err.println("from date " + this.getFromDate() + " To date " + this.getToDate() +  "origin = " + this.country);
                SQLQuery q = session.createSQLQuery(qstr);
                //System.err.println("Test 1111111122222333333");
                q.setString("porigin", this.country);
                q.setString("pstatus", "A");
                q.setDate("pfrom", this.getFromDate());
                q.setDate("pto",this.getToDate());
                
                q.addScalar("quota", Hibernate.STRING);
                q.addScalar("type", Hibernate.STRING);
                q.addScalar("qty", Hibernate.DOUBLE);
                
                
                //System.err.println("Test 111111112222233333344444444");
                
                Iterator it = q.list().iterator();
                //System.err.println("Total records = " + q.list().size());
                
                if ( quotaUsagesList == null){
                    quotaUsagesList = new ArrayList();
                }
                
                //System.err.println("Test 11111");
                String tmpstr = null;
                Double tmpval = null;
                String q1 = null;
                String q2 = null;
                ReportDataBean obj = new  ReportDataBean();
                try {
                    while (it.hasNext()){
                        int idx = 0;
                        Object[] tmpRow = (Object[])it.next();
                        
                        q1 = (String)tmpRow[idx++];
                        
                        if ( ! q1.equals(q2) && q2 != null){
                            obj.setQuota(q2);
                            quotaUsagesList.add(obj);
                            //System.err.println("add 1111");
                            obj = new  ReportDataBean();
                        }
                        
                        q2 = q1;
                        
                        tmpstr = (String)tmpRow[idx++];
                        tmpval = (Double)tmpRow[idx++];
                        //System.err.println("type = " +  tmpstr + "==" + tmpval);
                        if ( "BI".equals(tmpstr)){
                            obj.setBIQty(tmpval);
                        }else if ( "TI".equals(tmpstr)){
                            obj.setTIQty(tmpval);
                        }else if ( "TO".equals(tmpstr)){
                            obj.setTOQty(tmpval);
                        }
                    }
                } catch ( Exception e){
                    e.printStackTrace();
                }
                //System.err.println("add 111122222");
                obj.setQuota(q2);
                quotaUsagesList.add(obj);
                
                
                Iterator it2 = quotaUsagesList.iterator();
                Double dd = new Double(100);
                while ( it2.hasNext()){
                    ReportDataBean obj2 = (ReportDataBean)it2.next();
                    
                    //--------------------------------------------
                    //Query to get quota available
                    //--------------------------------------------
                    qstr =  " Select sum(quotaqty) as quotahas, 'dummy' From quotaentry  ";
                    qstr += " Where effdate >= :pfrom and effdate < :pto and country = :porigin ";
                    qstr += " And quota = :pquota ";
                    
                    q = session.createSQLQuery(qstr);
                    q.setString("porigin", this.country);
                    q.setString("pquota", obj2.getQuota());
                    q.setDate("pfrom", this.Jan01);
                    q.setDate("pto",this.getFromDate());
                    
                    q.addScalar("quotahas", Hibernate.DOUBLE);
                    q.addScalar("dummy", Hibernate.STRING);
                    
                    it = q.list().iterator();
                    try {
                        while (it.hasNext()){
                            int idx = 0;
                            Object[] tmpRow = (Object[])it.next();
                            obj2.setAvlQty((Double)tmpRow[idx++]);
                        }
                    } catch ( Exception e){
                        e.printStackTrace();
                    }
                    
                    //--------------------------------------------
                    //Query to get quota outstanding
                    //--------------------------------------------
                    qstr =  " Select sum(os.qtypcs/os.multiplier) as outstdqty, 'dummy' from ordsummary os ";
                    qstr += " LEFT JOIN factorymast fm ON fm.factorycode = os.mainfactory ";
                    qstr += " Where os.quota = :pquota And os.delivery >= :pfrom And os.delivery <= :pto ";
                    qstr += " And os.status = 'A' and  fm.countrycode = :porigin ";
                    q = session.createSQLQuery(qstr);
                    q.setString("porigin", this.country);
                    q.setString("pquota", obj2.getQuota());
                    q.setDate("pfrom", this.Jan01);
                    q.setDate("pto",this.getToDate());
                    
                    q.addScalar("outstdqty", Hibernate.DOUBLE);
                    q.addScalar("dummy", Hibernate.STRING);
                    it = q.list().iterator();
                    try {
                        while (it.hasNext()){
                            int idx = 0;
                            Object[] tmpRow = (Object[])it.next();
                            obj2.setOustQty((Double)tmpRow[idx++]);
                        }
                    } catch ( Exception e){
                        e.printStackTrace();
                    }
                    
                    
                    
                    //--------------------------------------------
                    //Query to get quota used
                    //--------------------------------------------
                    qstr  = " SELECT sum(sh.qtyPcs/os.multiplier) as usedqty, 'dummy' ";
                    qstr += " FROM shipping as sh ";
                    qstr += " LEFT JOIN ordconfirm as oc  on oc.crefid = sh.crefid ";
                    qstr += " LEFT JOIN ordsummary as os  on os.srefid = oc.srefid ";
                    qstr += " LEFT JOIN factorymast fm ON fm.factorycode = os.mainfactory ";
                    qstr += " WHERE fm.countrycode = :porigin AND os.quota = :pquota ";
                    qstr += " AND sh.etd >= :pDateStart AND  sh.etd <= :pDateEnd ";
                    qstr += " AND os.status = 'A' ";
                    
                    //System.err.println("Test 1111111122222");
                    q = session.createSQLQuery(qstr);
                    //System.err.println("Test 1111111122222333333");
                    q.setString("porigin", this.country);
                    q.setString("pquota", obj2.getQuota());
                    q.setDate("pDateStart", this.Jan01);
                    q.setDate("pDateEnd",this.getToDate());
                    
                    q.addScalar("usedqty", Hibernate.DOUBLE);
                    q.addScalar("dummy", Hibernate.STRING);
                    it = q.list().iterator();
                    try {
                        while (it.hasNext()){
                            int idx = 0;
                            Object[] tmpRow = (Object[])it.next();
                            obj2.setUsedQty((Double)tmpRow[idx++]);
                        }
                    } catch ( Exception e){
                        e.printStackTrace();
                    }
                    
                }//while loop
                
                //System.err.println("Quota range from "  + this.Jan01 + " to " + this.getToDate());
                
                if (quotaOutstandingListModel == null) {
                    //System.err.println("Search for records 333");
                    quotaOutstandingListModel = new ListDataModel();
                }
                
                quotaOutstandingListModel.setWrappedData(quotaUsagesList);
                
            } catch (HibernateException e) {
                //do something here with the exception
                e.printStackTrace();
                FacesMessage fmsg  = new FacesMessage(FacesMessage.SEVERITY_ERROR, e.getCause().toString(), e.getMessage());
                ctx.addMessage(null, fmsg);
            } catch (Exception e){
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
        if (quotaOutstandingListModel == null) {
            System.err.println("No records ....!!!");
            quotaOutstandingListModel = new ListDataModel();
        }
        
        return quotaOutstandingListModel;
    }
}
