/*
 * FoxyFinishRptEditPage.java
 *
 * Created on July 9, 2006, 6:53 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package com.foxy.checklist.page;


import javax.faces.application.FacesMessage;
import com.foxy.db.HibernateUtil;
import com.foxy.db.ChkLstFinishRpt;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.Transaction;
import com.foxy.page.Page;



/**
 *
 * @author hcting
 */
public class FoxyFinishRptEditPage extends Page {
    private static String MENU_CODE = new String("FOXY");
    private List fRptList = null;
    private ChkLstFinishRpt frptBean = null;
    private long id = -1;
    
    
    /** Creates a new instance of FoxyFinishRptEditPage */
    public FoxyFinishRptEditPage() {
        super(new String("FinishRptEditForm"));
        try {
            this.isAuthorize(MENU_CODE);
            this.id = foxySessionData.getPageParameterLong();
            //System.out.println(ctx.getApplication().getViewHandler().toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public boolean isRecSelected(){
        
        if ( this.id <= 0){
            return false;
        } else {
            return true;
        }
    }
    
    
    public ChkLstFinishRpt getFrptBean(){
        
        if ( frptBean == null){
            frptBean = new ChkLstFinishRpt();
        }
        
        if ( fRptList == null ) {
            //System.err.println("Query record ChkLstFinishRpt id=[" + this.id + "] for edit");
            try {
                Session session = (Session) HibernateUtil.currentSession();
                Transaction tx= session.beginTransaction();
                fRptList = session.createQuery("from ChkLstFinishRpt frpt WHERE frpt.id = :myid").setLong("myid",this.id).list();
                tx.commit();
            } catch (Exception e) {
                e.printStackTrace();
                FacesMessage fmsg  = new FacesMessage(FacesMessage.SEVERITY_ERROR, e.getCause().toString(), e.getMessage());
                ctx.addMessage(null, fmsg);
                return null;
            } finally {
                HibernateUtil.closeSession();
            }
            
            
            if ( fRptList.size() != 0){
                frptBean = (ChkLstFinishRpt)fRptList.get(0);
            }
        }
        
        return  frptBean;
    }
    
    
    public String save(){
        try {
            Session session = (Session) HibernateUtil.currentSession();
            Transaction tx= session.beginTransaction();
            session.update(frptBean);
            tx.commit();
            
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Failed coz excveption!!!!");
            FacesMessage fmsg  = new FacesMessage(FacesMessage.SEVERITY_ERROR, e.getCause().toString(), e.getMessage());
            ctx.addMessage(null, fmsg);
            return (null);
        } finally {
            HibernateUtil.closeSession();
            //return ("success");
        }
        
        foxySessionData.setPageParameterLong(null); //Reset to default if successfully save
        return ("success");
    }
    
    
}
