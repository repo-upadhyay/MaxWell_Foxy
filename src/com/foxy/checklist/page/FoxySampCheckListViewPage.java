/*
 * FoxySampCheckListViewPage.java
 *
 * Created on July 5, 2006, 12:39 AM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package com.foxy.checklist.page;

import javax.faces.application.FacesMessage;
import java.text.SimpleDateFormat;
import java.text.DateFormat;
import com.foxy.db.HibernateUtil;
import com.foxy.db.ChkLstSampCheckList;
import java.util.List;
import java.util.Date;
import javax.faces.model.DataModel;
import javax.faces.model.ListDataModel;
import org.hibernate.Session;
import org.hibernate.Criteria;
import org.hibernate.criterion.Expression;
import org.hibernate.Transaction;
import org.hibernate.criterion.Order;
import com.foxy.page.Page;
import com.foxy.util.ListData;


/**
 *
 * @author hcting
 */
public class FoxySampCheckListViewPage extends Page {
    private static String MENU_CODE = new String("FOXY");
    private SimpleDateFormat fmt2 =  new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    private List objList = null;
    private DataModel objModel = null;
    private String refNo = null;
    private boolean searchdone = false;
    private boolean isrptTitle = false;
    private String rptTitle = null;
    private String country = null;
    private boolean showRmkByRefSrch = false;
    private boolean showRmkByDate = false;
    
    
    
    
    /**
     * Creates a new instance of FoxySampCheckListViewPage
     */
    public FoxySampCheckListViewPage() {
        super(new String("SampCheckListViewForm"));
        try {
            this.isAuthorize(MENU_CODE);
            this.refNo = foxySessionData.getOrderId();
            //System.out.println(ctx.getApplication().getViewHandler().toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
        
    }
    
    
    
//PROPERTY: refNo
    public String getRefNo() {
        return (String)refNo;
    }
    
    
//PROPERTY: refNo
    public void setRefNo(String newvalString) {
        this.refNo = newvalString;
    }
    
    
//PROPERTY: rptTitle
    public String getRptTitleStr() {
        return (String)rptTitle;
    }
    
    
    public boolean isRptTitle(){
        return isrptTitle;
    }
    
    
    
    
    public boolean isObjFound(){
        
        if ( objModel != null) {
            if(objList == null){
                return false;
            } else {
                return true;
            }
        } else {
            return false;
        }
        
        
    }
    
    
    public boolean isSearchNotFound(){
        
        if ( searchdone == true) {
            if(objList == null){
                return true;
            } else {
                return false;
            }
            
        } else {
            return false;
        }
    }
    
    
    public DataModel getObjModel(){
        return  this.objModel;
    }
    
    public boolean getShowRmkByRefSrch(){
        return showRmkByRefSrch;
    }
    
    public void setShowRmkByRefSrch(boolean bol1){
        showRmkByRefSrch = bol1;
    }
    
    public boolean getShowRmkByDate(){
        return showRmkByDate;
    }
    
    public void setShowRmkByDate(boolean bol1){
        showRmkByDate = bol1;
    }
    
    
    public String searchRec(){
        this.isrptTitle = false;
        this.rptTitle = null;
        this.refNo = foxySessionData.getOrderId();
        //System.err.println("Search rec now...for [" + this.refNo + "]");
        this.searchdone = true;
        
        
        if ( this.refNo.length() == 0){
            objList = null;
            return null;
        }
        
        
        
        if ( objModel == null){
            objModel = new ListDataModel();
        }
        
        
        
        try {
            Session session = (Session) HibernateUtil.currentSession();
            Transaction tx= session.beginTransaction();
            if ( this.refNo.length() == 0){
                objList = session.createQuery("from ChkLstSampCheckList as samp ORDER BY samp.refNo, samp.ccode").list();
            }else {
                objList = session.createQuery("from ChkLstSampCheckList as samp WHERE samp.refNo LIKE '%" +
                        this.refNo + "%' ORDER BY samp.refNo, samp.ccode").list();
            }
            
            tx.commit();
            
        } catch (Exception e) {
            e.printStackTrace();
            FacesMessage fmsg  = new FacesMessage(FacesMessage.SEVERITY_ERROR, e.getCause().toString(), e.getMessage());
            ctx.addMessage(null, fmsg);
            return null;
        } finally {
            HibernateUtil.closeSession();
        }
        
        if ( objList.size() != 0){
            objModel.setWrappedData(objList);
        } else {
            objList = null;
        }
        return null;
    }
    
    
    public String getCountryName(){
        ListData ld = (ListData)getBean("listData");
        String cstr = foxySessionData.getPageParameter();
        return(ld.getCountryDesc(cstr, 0));
    }
    
    
    public String searchRecByDate(){
        
        DateFormat format1 = new SimpleDateFormat( "yyyyMMdd" );
        
        this.isrptTitle = true;
        this.searchdone = true;
        rptTitle = new String("Sample Check List Report For ");
        
        rptTitle += getCountryName();
        
        if ( objModel == null){
            objModel = new ListDataModel();
        }
        
        try {
            Date tmpdate1 = null;
            Date tmpdate2 = null;
            Session session = (Session) HibernateUtil.currentSession();
            Transaction tx= session.beginTransaction();
            
            Criteria criteria = session.createCriteria(ChkLstSampCheckList.class);
            
            //Filter for date start from
            tmpdate1 = foxySessionData.getFromDate();
            tmpdate2 = foxySessionData.getToDate();
            
            if ( tmpdate1 != null || tmpdate2 != null) {
                rptTitle += " Delivery Date ";
            }
            
            if (tmpdate1 != null) {
                criteria.add(Expression.ge("del", tmpdate1));
                rptTitle += "After " + format1.format(tmpdate1);
            }
            
            
            if (tmpdate2 != null) {
                criteria.add(Expression.le("del", tmpdate2));
                if ( tmpdate1 == null){
                    rptTitle += " Before " + format1.format(tmpdate2);
                } else {
                    rptTitle += " And Before " + format1.format(tmpdate2);
                }
            }
            
            rptTitle +=  " As At [" +  fmt2.format(new Date()) + "] ";
            
            String cstr = foxySessionData.getPageParameter();
            criteria.add(Expression.eq("ccode", Integer.parseInt(cstr)));
            criteria.addOrder(Order.asc("refNo"));
            criteria.addOrder(Order.asc("ccode"));
            
            
            objList = criteria.list();
            tx.commit();
            
        } catch (Exception e) {
            e.printStackTrace();
            FacesMessage fmsg  = new FacesMessage(FacesMessage.SEVERITY_ERROR, e.getCause().toString(), e.getMessage());
            ctx.addMessage(null, fmsg);
            return null;
        } finally {
            HibernateUtil.closeSession();
        }
        
        if ( objList.size() != 0){
            objModel.setWrappedData(objList);
        } else {
            objList = null;
        }
        return null;
    }
    
    
    
    public String editCurRec() {
        return ("editRec");
    }
    
    
    public String delRec() {
        
        try {
            //System.out.println("Inside delete records for id = [" + foxySessionData.getId() + "]");
            Session session = (Session) HibernateUtil.currentSession();
            Transaction tx= session.beginTransaction();
            session.createQuery("delete from ChkLstSampCheckList as samp WHERE samp.id = " + foxySessionData.getPageParameterLong()).executeUpdate();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
            FacesMessage fmsg  = new FacesMessage(FacesMessage.SEVERITY_ERROR, e.getCause().toString(), e.getMessage());
            ctx.addMessage(null, fmsg);
            return (null);
        } finally {
            HibernateUtil.closeSession();
            foxySessionData.setPageParameterLong(null);
        }
        
        //System.err.println("Calling del rec");
        searchRec();
        return null;
    }
    
    
}
