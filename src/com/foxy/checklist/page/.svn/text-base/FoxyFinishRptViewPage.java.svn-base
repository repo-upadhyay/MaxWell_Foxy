/*
 * FoxyFinishRptViewPage.java
 *
 * Created on July 9, 2006, 4:53 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package com.foxy.checklist.page;



import javax.faces.application.FacesMessage;
import com.foxy.db.HibernateUtil;
import java.util.List;
import java.util.Date;
import javax.faces.model.DataModel;
import javax.faces.model.ListDataModel;
import org.hibernate.Session;
import org.hibernate.Transaction;
import java.text.SimpleDateFormat;
import com.foxy.page.Page;


/**
 *
 * @author hcting
 */
public class FoxyFinishRptViewPage extends Page {
    private static String MENU_CODE = new String("FOXY");
    private SimpleDateFormat fmt2 =  new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    private List objList = null;
    private DataModel objModel = null;
    private String refNo = null;
    private boolean searchdone = false;
    private String rptTitle = null;
    
    
    /** Creates a new instance of FoxyFinishRptViewPage */
    public FoxyFinishRptViewPage() {
        super(new String("FinishRptViewForm"));
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
    
    
    
    
    public String searchRec(){
        this.refNo = foxySessionData.getOrderId();
        //System.err.println("Search rec now...for [" + this.refNo + "]");
        this.searchdone = true;
        rptTitle = "Finish Report Listing ";
        
        if ( objModel == null){
            objModel = new ListDataModel();
        }
        
        
        try {
            
            rptTitle +=  " As At [" +  fmt2.format(new Date()) + "] ";
            
            Session session = (Session) HibernateUtil.currentSession();
            Transaction tx= session.beginTransaction();
            if ( this.refNo.length() == 0) {
                objList = session.createQuery("from ChkLstFinishRpt as fRpt ORDER BY fRpt.refNo, fRpt.ccode").list();
            } else {
                objList = session.createQuery("from ChkLstFinishRpt as fRpt WHERE fRpt.refNo LIKE '%" +
                        this.refNo + "%' ORDER BY fRpt.refNo, fRpt.ccode").list();
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
    
    
    
    public String editCurRec() {
        return ("editRec");
    }
    
    
    public String delRec() {
        
        try {
            //System.out.println("Inside delete records for id = [" + foxySessionData.getId() + "]");
            Session session = (Session) HibernateUtil.currentSession();
            Transaction tx= session.beginTransaction();
            session.createQuery("delete from ChkLstFinishRpt as fRpt WHERE fRpt.id = " + foxySessionData.getPageParameterLong()).executeUpdate();
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



