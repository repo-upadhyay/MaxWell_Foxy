/*
 * FoxyAccsCheckListAddPage.java
 *
 * Created on July 2, 2006, 8:13 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package com.foxy.checklist.page;

import javax.faces.application.FacesMessage;
import com.foxy.db.HibernateUtil;
import com.foxy.db.ChkLstAccsCheckList;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.Transaction;
import com.foxy.page.Page;


/**
 *
 * @author hcting
 */
public class FoxyAccsCheckListEditPage extends Page {
    private static String MENU_CODE = new String("FOXY");
    private List aclList = null;
    private ChkLstAccsCheckList aclBean = null;
    private long id = -1;
    
    
    /** Creates a new instance of FoxyAccsCheckListAddPage */
    public FoxyAccsCheckListEditPage() {
        super(new String("AccsCheckistEditForm"));
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
    
    
    public ChkLstAccsCheckList getAclBean(){
        
        if ( aclBean == null){
            aclBean = new ChkLstAccsCheckList();
        }
        
        if ( aclList == null ) {
            
            //System.err.println("Query record ChkLstAccsCheckList id=[" + this.id + "] for edit");
            try {
                Session session = (Session) HibernateUtil.currentSession();
                Transaction tx= session.beginTransaction();
                aclList = session.createQuery("from ChkLstAccsCheckList as acl WHERE acl.id = :myid").setLong("myid",this.id).list();
                tx.commit();
            } catch (Exception e) {
                e.printStackTrace();
                FacesMessage fmsg  = new FacesMessage(FacesMessage.SEVERITY_ERROR, e.getCause().toString(), e.getMessage());
                ctx.addMessage(null, fmsg);
                return null;
            } finally {
                HibernateUtil.closeSession();
            }
            
            
            if ( aclList.size() != 0){
                aclBean = (ChkLstAccsCheckList)aclList.get(0);
            }
        }
        
        return  aclBean;
    }
    
    
    
    public String save(){
        
        if ( aclBean.getFinalMarkerReq() == false ) {
            aclBean.setFinalMarker(null);
        }
        if ( aclBean.getProdSheetReq() == false ) {
            aclBean.setProdSheet(null);
        }
        if ( aclBean.getMainLblReq() == false ) {
            aclBean.setMainLbl(null);
        }
        if ( aclBean.getCareLblReq() == false ) {
            aclBean.setCareLbl(null);
        }
        if ( aclBean.getJokerLblReq() == false ) {
            aclBean.setJokerLbl(null);
        }
        if ( aclBean.getGpuLblReq() == false ) {
            aclBean.setGpuLbl(null);
        }
        if ( aclBean.getJpnLblReq() == false ) {
            aclBean.setJpnLbl(null);
        }
        if ( aclBean.getUkLblReq() == false ) {
            aclBean.setUkLbl(null);
        }
        if ( aclBean.getFireLblReq() == false ) {
            aclBean.setFireLbl(null);
        }
        if ( aclBean.getSideLblReq() == false ) {
            aclBean.setSideLbl(null);
        }
        if ( aclBean.getSizeLblReq() == false ) {
            aclBean.setSizeLbl(null);
        }
        if ( aclBean.getCtnLblReq() == false ) {
            aclBean.setCtnLbl(null);
        }
        if ( aclBean.getElasticBandReq() == false ) {
            aclBean.setElasticBand(null);
        }
        if ( aclBean.getPriceTktReq() == false ) {
            aclBean.setPriceTkt(null);
        }
        if ( aclBean.getSizeStickerReq() == false ) {
            aclBean.setSizeSticker(null);
        }
        if ( aclBean.getThreadReq() == false ) {
            aclBean.setThread(null);
        }
        if ( aclBean.getSkubarCodeReq() == false ) {
            aclBean.setSkubarCode(null);
        }
        if ( aclBean.getOnlPlyBagReq() == false ) {
            aclBean.setOnlPlyBag(null);
        }
        if ( aclBean.getPpackStickerReq() == false ) {
            aclBean.setPpackSticker(null);
        }
        if ( aclBean.getRibbonReq() == false ) {
            aclBean.setRibbon(null);
        }
        if ( aclBean.getInterLiningReq() == false ) {
            aclBean.setInterLining(null);
        }
        if ( aclBean.getBowReq() == false ) {
            aclBean.setBow(null);
        }
        if ( aclBean.getTwillTapeReq() == false ) {
            aclBean.setTwillTape(null);
        }
        if ( aclBean.getGrossGainReq() == false ) {
            aclBean.setGrossGain(null);
        }
        if ( aclBean.getDrawCordReq() == false ) {
            aclBean.setDrawCord(null);
        }
        if ( aclBean.getZipperReq() == false ) {
            aclBean.setZipper(null);
        }
        if ( aclBean.getButtonReq() == false ) {
            aclBean.setButton(null);
        }
        if ( aclBean.getSnapButtonReq() == false ) {
            aclBean.setSnapButton(null);
        }
        if ( aclBean.getEyeLetReq() == false ) {
            aclBean.setEyeLet(null);
        }
        if ( aclBean.getMagicTapeReq() == false ) {
            aclBean.setMagicTape(null);
        }
        if ( aclBean.getLaceReq() == false ) {
            aclBean.setLace(null);
        }
        if ( aclBean.getHangerReq() == false ) {
            aclBean.setHanger(null);
        }
        if ( aclBean.getSizerReq() == false ) {
            aclBean.setSizer(null);
        }
        if ( aclBean.getCpyrLblReq() == false ) {
            aclBean.setCpyrLbl(null);
        }
        if ( aclBean.getRmk1Req() == false ) {
            aclBean.setRmk1Date(null);
        }
        if ( aclBean.getRmk2Req() == false ) {
            aclBean.setRmk2Date(null);
        }
        if ( aclBean.getRmk3Req() == false ) {
            aclBean.setRmk3Date(null);
        }
        if ( aclBean.getRmk4Req() == false ) {
            aclBean.setRmk4Date(null);
        }
        if ( aclBean.getRmk5Req() == false ) {
            aclBean.setRmk5Date(null);
        }
        
        
        
        try {
            Session session = (Session) HibernateUtil.currentSession();
            Transaction tx= session.beginTransaction();
            session.update(aclBean);
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
