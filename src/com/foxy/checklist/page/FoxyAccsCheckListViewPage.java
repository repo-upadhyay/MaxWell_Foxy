/*
 * FoxyAccsCheckListViewPage.java
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
import com.foxy.db.ChkLstAccsCheckList;
import java.util.List;
import java.util.Date;
import javax.faces.model.DataModel;
import javax.faces.model.ListDataModel;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.Criteria;
import org.hibernate.criterion.Expression;
import org.hibernate.criterion.Order;
import com.foxy.page.Page;
import com.foxy.util.ListData;
import java.io.Serializable;


/**
 *
 * @author hcting
 */
public class FoxyAccsCheckListViewPage extends Page implements Serializable {
    
    private static String MENU_CODE = new String("FOXY");
    //private Long id = null;
    private SimpleDateFormat fmt2 =  new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    private ChkLstAccsCheckList  selectedRec = null;
    private List acllist = null;
    private DataModel aclModel = null;
    private String refNo = null;
    private boolean searchdone = false;
    private boolean isrptTitle = false;
    private String rptTitle = null;
    private String country = null;
    private boolean showRmkByRefSrch = false;
    private boolean showRmkByDate = false;
    
    
    
    /**
     * Creates a new instance of FoxyAccsCheckListViewPage
     */
    public FoxyAccsCheckListViewPage() {
        super(new String("AccsCheckistViewForm"));
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
        
        if ( aclModel != null) {
            if(acllist == null){
                return false;
            } else {
                return true;
            }
        } else {
            return false;
        }
        
        
    }
    
    
    public boolean isSearchNotFound(){
        try{
            if ( searchdone == true) {
                if(acllist == null){
                    return true;
                } else {
                    return false;
                }
                
            } else {
                return false;
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return true;
    }
    
    public DataModel getAclModel(){
        return  this.aclModel;
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
        
        
        try {
            if ( this.refNo.length() == 0){
                acllist = null;
                return null;
            }
            
            
            if ( aclModel == null){
                aclModel = new ListDataModel();
            }
            
            
            try {
                Session session = (Session) HibernateUtil.currentSession();
                Transaction tx= session.beginTransaction();
                //System.err.println("Now searching for = [" + this.refNo + "]");
                if ( this.refNo.length() == 0){
                    acllist = session.createQuery("from ChkLstAccsCheckList as acl ORDER BY acl.refNo, acl.ccode").list();
                } else {
                    acllist = session.createQuery("from ChkLstAccsCheckList as acl WHERE acl.refNo LIKE '%" +
                            this.refNo + "%'  ORDER BY acl.refNo, acl.ccode").list();
                }
                //System.err.println("Now searching for = [" + this.refNo + "] Resut size = [" + acllist.size() + "]");
                tx.commit();
                
            } catch (Exception e) {
                e.printStackTrace();
                FacesMessage fmsg  = new FacesMessage(FacesMessage.SEVERITY_ERROR, e.getCause().toString(), e.getMessage());
                ctx.addMessage(null, fmsg);
                return null;
            } finally {
                HibernateUtil.closeSession();
            }
            
            if ( acllist.size() != 0){
                aclModel.setWrappedData(acllist);
            } else {
                acllist = null;
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            FacesMessage fmsg  = new FacesMessage(FacesMessage.SEVERITY_ERROR, e.getCause().toString(), e.getMessage());
            ctx.addMessage(null, fmsg);
            return null;
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
        String cstr = foxySessionData.getPageParameter();
        
        this.isrptTitle = true;
        this.searchdone = true;
        acllist = null;
        rptTitle = new String("Accesories Check List Report For ");
        
        rptTitle += getCountryName();
        
        if ( aclModel == null){
            aclModel = new ListDataModel();
        }
        
        try {
            Date tmpdate1 = null;
            Date tmpdate2 = null;
            Session session = (Session) HibernateUtil.currentSession();
            Transaction tx= session.beginTransaction();
            
            Criteria criteria = session.createCriteria(ChkLstAccsCheckList.class);
            
            //Filter for date start from
            tmpdate1 = this.getFromDate();
            tmpdate2 = this.getToDate();
            
            
            if ( tmpdate1 != null || tmpdate2 != null) {
                rptTitle += " Delivery Date ";
            }
            
            //Filter for date start from
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
            
            
            criteria.add(Expression.eq("ccode", Integer.parseInt(cstr)));
            criteria.addOrder(Order.asc("refNo"));
            criteria.addOrder(Order.asc("ccode"));
            
            //System.err.println("List size = [" + criteria + "]");
            acllist = criteria.list();
            tx.commit();
            
        } catch (Exception e) {
            e.printStackTrace();
            FacesMessage fmsg  = new FacesMessage(FacesMessage.SEVERITY_ERROR, e.getCause().toString(), e.getMessage());
            ctx.addMessage(null, fmsg);
            return null;
        } finally {
            HibernateUtil.closeSession();
        }
        
        if ( acllist.size() != 0){
            aclModel.setWrappedData(acllist);
        } else {
            acllist = null;
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
            session.createQuery("delete from ChkLstAccsCheckList as acl WHERE acl.id = " + foxySessionData.getPageParameterLong()).executeUpdate();
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
