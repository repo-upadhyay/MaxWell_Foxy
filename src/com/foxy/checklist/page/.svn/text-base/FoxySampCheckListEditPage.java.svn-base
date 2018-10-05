/*
 * FoxySampCheckListAddPage.java
 *
 * Created on July 3, 2006, 8:54 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package com.foxy.checklist.page;

import javax.faces.application.FacesMessage;
import com.foxy.db.HibernateUtil;
import com.foxy.db.ChkLstSampCheckList;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.Transaction;
import com.foxy.page.Page;


/**
 *
 * @author hcting
 */
public class FoxySampCheckListEditPage extends Page {
    private static String MENU_CODE = new String("FOXY");
    private List sclList = null;
    private ChkLstSampCheckList sclBean = null;
    private long id = -1;
    
    
    
    /** Creates a new instance of FoxySampCheckListAddPage */
    public FoxySampCheckListEditPage() {
        super(new String("SampCheckistEditForm"));
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
    
    
    public ChkLstSampCheckList getSclBean(){
        
        if ( sclBean == null){
            sclBean = new ChkLstSampCheckList();
        }
        
        if ( sclList == null ) {
            
            //System.err.println("Query record ChkLstSampCheckList id=[" + this.id + "] for edit");
            try {
                Session session = (Session) HibernateUtil.currentSession();
                Transaction tx= session.beginTransaction();
                sclList = session.createQuery("from ChkLstSampCheckList scl WHERE scl.id = :myid").setLong("myid",this.id).list();
                tx.commit();
            } catch (Exception e) {
                e.printStackTrace();
                FacesMessage fmsg  = new FacesMessage(FacesMessage.SEVERITY_ERROR, e.getCause().toString(), e.getMessage());
                ctx.addMessage(null, fmsg);
                return null;
            } finally {
                HibernateUtil.closeSession();
            }
            
            
            if ( sclList.size() != 0){
                sclBean = (ChkLstSampCheckList)sclList.get(0);
            }
        }
        
        return  sclBean;
    }
    
    
    public String save(){
        
        //Make sure field clear off if not check
        if ( sclBean.getFabricDelReq() == false ) {
            sclBean.setFabricDel(null);
        }
        if ( sclBean.getFitSub1Req() == false ) {
            sclBean.setFitSub1(null);
        }
        if ( sclBean.getCommentsReq() == false ) {
            sclBean.setComments(null);
        }
        if ( sclBean.getFitSub2Req() == false ) {
            sclBean.setFitSub2(null);
        }
        if ( sclBean.getFinalApReq() == false ) {
            sclBean.setFinalAp(null);
        }
        if ( sclBean.getSoSub1Req() == false ) {
            sclBean.setSoSub1(null);
        }
        if ( sclBean.getSoComment1Req() == false ) {
            sclBean.setSoComment1(null);
        }
        if ( sclBean.getSoSub2Req() == false ) {
            sclBean.setSoSub2(null);
        }
        if ( sclBean.getSoAppReq() == false ) {
            sclBean.setSoApp(null);
        }
        if ( sclBean.getApSPLReq() == false ) {
            sclBean.setApSPL(null);
        }
        if ( sclBean.getPpSplReq() == false ) {
            sclBean.setPpSpl(null);
        }
        if ( sclBean.getAdSplReq() == false ) {
            sclBean.setAdSpl(null);
        }
        if ( sclBean.getTopSampReq() == false ) {
            sclBean.setTopSamp(null);
        }
        if ( sclBean.getTopSampCommentReq() == false ) {
            sclBean.setTopSampComment(null);
        }
        if ( sclBean.getTestSampReq() == false ) {
            sclBean.setTestSamp(null);
        }
        if ( sclBean.getTestRptReq() == false ) {
            sclBean.setTestRpt(null);
        }
        if ( sclBean.getFinalTestSampReq() == false ) {
            sclBean.setFinalTestSamp(null);
        }
        if ( sclBean.getFinalGmtTestRptReq() == false ) {
            sclBean.setFinalGmtTestRpt(null);
        }
        if ( sclBean.getShipSplReq() == false ) {
            sclBean.setShipSpl(null);
        }
        if ( sclBean.getRmk1Req() == false ) {
            sclBean.setRmk1Date(null);
        }
        if ( sclBean.getRmk2Req() == false ) {
            sclBean.setRmk2Date(null);
        }
        if ( sclBean.getRmk3Req() == false ) {
            sclBean.setRmk3Date(null);
        }
        if ( sclBean.getRmk4Req() == false ) {
            sclBean.setRmk4Date(null);
        }
        if ( sclBean.getRmk5Req() == false ) {
            sclBean.setRmk5Date(null);
        }
        
        
        
        try {
            Session session = (Session) HibernateUtil.currentSession();
            Transaction tx= session.beginTransaction();
            session.update(sclBean);
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
