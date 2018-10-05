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
import java.util.Date;
import org.hibernate.Session;
import org.hibernate.Transaction;
import com.foxy.page.Page;


/**
 *
 * @author hcting
 */
public class FoxySampCheckListAddPage extends Page {
    private static String MENU_CODE = new String("FOXY");
    private Integer ccode = null;
    private String refNo = null;
    private String style = null;
    private String buyer = null;
    private String poNo = null;
    private String merchant = null;
    private Integer qty = null;
    private Date del = null;
    private Date fabricDel = null;
    private String color = null;
    private Date fitSub1 = null;
    private Date comments = null;
    private Date fitSub2 = null;
    private Date finalAp = null;
    private Date soSub1 = null;
    private Date soComment1 = null;
    private Date soSub2 = null;
    private Date soApp = null;
    private Date apSPL = null;
    private Date ppSpl = null;
    private Date adSpl = null;
    private Date topSamp = null;
    private Date topSampComment = null;
    private Date testSamp = null;
    private Date testRpt = null;
    private Date finalTestSamp = null;
    private Date finalGmtTestRpt = null;
    private Date shipSpl = null;
    private String srmk1 = null;
    private String rmk1 = null;
    private String rmk2 = null;
    private String rmk3 = null;
    private String rmk4 = null;
    private String rmk5 = null;
    private Date   rmk1Date = null;
    private Date   rmk2Date = null;
    private Date   rmk3Date = null;
    private Date   rmk4Date = null;
    private Date   rmk5Date = null;
    private boolean delReq = false;
    private boolean fabricDelReq = false;
    private boolean fitSub1Req = false;
    private boolean commentsReq = false;
    private boolean fitSub2Req = false;
    private boolean finalApReq = false;
    private boolean soSub1Req = false;
    private boolean soComment1Req = false;
    private boolean soSub2Req = false;
    private boolean soAppReq = false;
    private boolean apSPLReq = false;
    private boolean ppSplReq = false;
    private boolean adSplReq = false;
    private boolean topSampReq = false;
    private boolean topSampCommentReq = false;
    private boolean testSampReq = false;
    private boolean testRptReq = false;
    private boolean finalTestSampReq = false;
    private boolean finalGmtTestRptReq = false;
    private boolean shipSplReq = false;
    private boolean srmk1Req = false;
    private boolean rmk1Req = false;
    private boolean rmk2Req = false;
    private boolean rmk3Req = false;
    private boolean rmk4Req = false;
    private boolean rmk5Req = false;
    
    
    
    /** Creates a new instance of FoxySampCheckListAddPage */
    public FoxySampCheckListAddPage() {
        super(new String("SampCheckListAddForm"));
        try {
            this.isAuthorize(MENU_CODE);
            //System.out.println(ctx.getApplication().getViewHandler().toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    
    
//PROPERTY: ccode
    public Integer getCcode() {
        return (Integer)this.ccode;
    }
    
    
    public void  setCcode(Integer newvalInteger) {
        this.ccode = newvalInteger;
    }
    
    
//PROPERTY: refNo
    public String getRefNo() {
        return (String)this.refNo;
    }
    
    
    public void  setRefNo(String newvalString) {
        this.refNo = newvalString;
    }
    
    
//PROPERTY: style
    public String getStyle() {
        return (String)this.style;
    }
    
    
    public void  setStyle(String newvalString) {
        this.style = newvalString;
    }
    
    
//PROPERTY: buyer
    public String getBuyer() {
        return (String)this.buyer;
    }
    
    
    public void  setBuyer(String newvalString) {
        this.buyer = newvalString;
    }
    
    
//PROPERTY: poNo
    public String getPoNo() {
        return (String)this.poNo;
    }
    
    
    public void  setPoNo(String newvalString) {
        this.poNo = newvalString;
    }
    
    
//PROPERTY: merchant
    public String getMerchant() {
        return (String)this.merchant;
    }
    
    
    public void  setMerchant(String newvalString) {
        this.merchant = newvalString;
    }
    
    
//PROPERTY: qty
    public Integer getQty() {
        return (Integer)this.qty;
    }
    
    
    public void  setQty(Integer newvalInteger) {
        this.qty = newvalInteger;
    }
    
    
//PROPERTY: del
    public Date getDel() {
        return (Date)this.del;
    }
    
    
    public void  setDel(Date newvalDate) {
        this.del = newvalDate;
    }
    
    
//PROPERTY: fabricDel
    public Date getFabricDel() {
        return (Date)this.fabricDel;
    }
    
    
    public void  setFabricDel(Date newvalDate) {
        this.fabricDel = newvalDate;
    }
    
    
//PROPERTY: color
    public String getColor() {
        return (String)this.color;
    }
    
    
    public void  setColor(String newvalString) {
        this.color = newvalString;
    }
    
    
//PROPERTY: fitSub1
    public Date getFitSub1() {
        return (Date)this.fitSub1;
    }
    
    
    public void  setFitSub1(Date newvalDate) {
        this.fitSub1 = newvalDate;
    }
    
    
//PROPERTY: comments
    public Date getComments() {
        return (Date)this.comments;
    }
    
    
    public void  setComments(Date newvalDate) {
        this.comments = newvalDate;
    }
    
    
//PROPERTY: fitSub2
    public Date getFitSub2() {
        return (Date)this.fitSub2;
    }
    
    
    public void  setFitSub2(Date newvalDate) {
        this.fitSub2 = newvalDate;
    }
    
    
//PROPERTY: finalAp
    public Date getFinalAp() {
        return (Date)this.finalAp;
    }
    
    
    public void  setFinalAp(Date newvalDate) {
        this.finalAp = newvalDate;
    }
    
    
//PROPERTY: soSub1
    public Date getSoSub1() {
        return (Date)this.soSub1;
    }
    
    
    public void  setSoSub1(Date newvalDate) {
        this.soSub1 = newvalDate;
    }
    
    
//PROPERTY: soComment1
    public Date getSoComment1() {
        return (Date)this.soComment1;
    }
    
    
    public void  setSoComment1(Date newvalDate) {
        this.soComment1 = newvalDate;
    }
    
    
//PROPERTY: soSub2
    public Date getSoSub2() {
        return (Date)this.soSub2;
    }
    
    
    public void  setSoSub2(Date newvalDate) {
        this.soSub2 = newvalDate;
    }
    
    
//PROPERTY: soApp
    public Date getSoApp() {
        return (Date)this.soApp;
    }
    
    
    public void  setSoApp(Date newvalDate) {
        this.soApp = newvalDate;
    }
    
    
//PROPERTY: apSPL
    public Date getApSPL() {
        return (Date)this.apSPL;
    }
    
    
    public void  setApSPL(Date newvalDate) {
        this.apSPL = newvalDate;
    }
    
    
//PROPERTY: ppSpl
    public Date getPpSpl() {
        return (Date)this.ppSpl;
    }
    
    
    public void  setPpSpl(Date newvalDate) {
        this.ppSpl = newvalDate;
    }
    
    
//PROPERTY: adSpl
    public Date getAdSpl() {
        return (Date)this.adSpl;
    }
    
    
    public void  setAdSpl(Date newvalDate) {
        this.adSpl = newvalDate;
    }
    
    
//PROPERTY: topSamp
    public Date getTopSamp() {
        return (Date)this.topSamp;
    }
    
    
    public void  setTopSamp(Date newvalDate) {
        this.topSamp = newvalDate;
    }
    
    
//PROPERTY: topSampComment
    public Date getTopSampComment() {
        return (Date)this.topSampComment;
    }
    
    
    public void  setTopSampComment(Date newvalDate) {
        this.topSampComment = newvalDate;
    }
    
    
//PROPERTY: testSamp
    public Date getTestSamp() {
        return (Date)this.testSamp;
    }
    
    
    public void  setTestSamp(Date newvalDate) {
        this.testSamp = newvalDate;
    }
    
    
//PROPERTY: testRpt
    public Date getTestRpt() {
        return (Date)this.testRpt;
    }
    
    
    public void  setTestRpt(Date newvalDate) {
        this.testRpt = newvalDate;
    }
    
    
//PROPERTY: finalTestSamp
    public Date getFinalTestSamp() {
        return (Date)this.finalTestSamp;
    }
    
    
    public void  setFinalTestSamp(Date newvalDate) {
        this.finalTestSamp = newvalDate;
    }
    
    
//PROPERTY: finalGmtTestRpt
    public Date getFinalGmtTestRpt() {
        return (Date)this.finalGmtTestRpt;
    }
    
    
    public void  setFinalGmtTestRpt(Date newvalDate) {
        this.finalGmtTestRpt = newvalDate;
    }
    
    
//PROPERTY: shipSpl
    public Date getShipSpl() {
        return (Date)this.shipSpl;
    }
    
    
    public void  setShipSpl(Date newvalDate) {
        this.shipSpl = newvalDate;
    }
    
//PROPERTY: srmk1
    public String getSrmk1() {
        return (String)this.srmk1;
    }
    
    
    public void  setSrmk1(String newvalString) {
        this.srmk1 = newvalString;
    }
    
    
//PROPERTY: rmk1
    public String getRmk1() {
        return (String)this.rmk1;
    }
    
    
    public void  setRmk1(String newvalString) {
        this.rmk1 = newvalString;
    }
    
    
//PROPERTY: rmk2
    public String getRmk2() {
        return (String)this.rmk2;
    }
    
    
    public void  setRmk2(String newvalString) {
        this.rmk2 = newvalString;
    }
    
    
//PROPERTY: rmk3
    public String getRmk3() {
        return (String)this.rmk3;
    }
    
    
    public void  setRmk3(String newvalString) {
        this.rmk3 = newvalString;
    }
    
    
    
    //PROPERTY: rmk4
    public String getRmk4() {
        return (String)this.rmk4;
    }
    
    
    public void  setRmk4(String newvalString) {
        this.rmk4 = newvalString;
    }
    
    
    
    
    //PROPERTY: rmk5
    public String getRmk5() {
        return (String)this.rmk5;
    }
    
    
    public void  setRmk5(String newvalString) {
        this.rmk5 = newvalString;
    }
    
    
    
    //PROPERTY: rmk1Date
    public Date getRmk1Date() {
        return (Date)this.rmk1Date;
    }
    
    
    public void  setRmk1Date(Date newvalDate) {
        this.rmk1Date = newvalDate;
    }
    
    
    //PROPERTY: rmk1Date
    public Date getRmk2Date() {
        return (Date)this.rmk2Date;
    }
    
    
    public void  setRmk2Date(Date newvalDate) {
        this.rmk2Date = newvalDate;
    }
    
    
    //PROPERTY: rmk3Date
    public Date getRmk3Date() {
        return (Date)this.rmk3Date;
    }
    
    
    public void  setRmk3Date(Date newvalDate) {
        this.rmk3Date = newvalDate;
    }
    
    
    //PROPERTY: rmk4Date
    public Date getRmk4Date() {
        return (Date)this.rmk4Date;
    }
    
    
    public void  setRmk4Date(Date newvalDate) {
        this.rmk4Date = newvalDate;
    }
    
    
    //PROPERTY: rmk5Date
    public Date getRmk5Date() {
        return (Date)this.rmk5Date;
    }
    
    
    public void  setRmk5Date(Date newvalDate) {
        this.rmk5Date = newvalDate;
    }
    
    
//PROPERTY: delReq
    public boolean getDelReq() {
        return (boolean)this.delReq;
    }
    
    
    public void  setDelReq(boolean newvalboolean) {
        this.delReq = newvalboolean;
    }
    
    
//PROPERTY: fabricDelReq
    public boolean getFabricDelReq() {
        return (boolean)this.fabricDelReq;
    }
    
    
    public void  setFabricDelReq(boolean newvalboolean) {
        this.fabricDelReq = newvalboolean;
    }
    
    
//PROPERTY: fitSub1Req
    public boolean getFitSub1Req() {
        return (boolean)this.fitSub1Req;
    }
    
    
    public void  setFitSub1Req(boolean newvalboolean) {
        this.fitSub1Req = newvalboolean;
    }
    
    
//PROPERTY: commentsReq
    public boolean getCommentsReq() {
        return (boolean)this.commentsReq;
    }
    
    
    public void  setCommentsReq(boolean newvalboolean) {
        this.commentsReq = newvalboolean;
    }
    
    
//PROPERTY: fitSub2Req
    public boolean getFitSub2Req() {
        return (boolean)this.fitSub2Req;
    }
    
    
    public void  setFitSub2Req(boolean newvalboolean) {
        this.fitSub2Req = newvalboolean;
    }
    
    
//PROPERTY: finalApReq
    public boolean getFinalApReq() {
        return (boolean)this.finalApReq;
    }
    
    
    public void  setFinalApReq(boolean newvalboolean) {
        this.finalApReq = newvalboolean;
    }
    
    
//PROPERTY: soSub1Req
    public boolean getSoSub1Req() {
        return (boolean)this.soSub1Req;
    }
    
    
    public void  setSoSub1Req(boolean newvalboolean) {
        this.soSub1Req = newvalboolean;
    }
    
    
//PROPERTY: soComment1Req
    public boolean getSoComment1Req() {
        return (boolean)this.soComment1Req;
    }
    
    
    public void  setSoComment1Req(boolean newvalboolean) {
        this.soComment1Req = newvalboolean;
    }
    
    
//PROPERTY: soSub2Req
    public boolean getSoSub2Req() {
        return (boolean)this.soSub2Req;
    }
    
    
    public void  setSoSub2Req(boolean newvalboolean) {
        this.soSub2Req = newvalboolean;
    }
    
    
//PROPERTY: soAppReq
    public boolean getSoAppReq() {
        return (boolean)this.soAppReq;
    }
    
    
    public void  setSoAppReq(boolean newvalboolean) {
        this.soAppReq = newvalboolean;
    }
    
    
//PROPERTY: apSPLReq
    public boolean getApSPLReq() {
        return (boolean)this.apSPLReq;
    }
    
    
    public void  setApSPLReq(boolean newvalboolean) {
        this.apSPLReq = newvalboolean;
    }
    
    
//PROPERTY: ppSplReq
    public boolean getPpSplReq() {
        return (boolean)this.ppSplReq;
    }
    
    
    public void  setPpSplReq(boolean newvalboolean) {
        this.ppSplReq = newvalboolean;
    }
    
    
//PROPERTY: adSplReq
    public boolean getAdSplReq() {
        return (boolean)this.adSplReq;
    }
    
    
    public void  setAdSplReq(boolean newvalboolean) {
        this.adSplReq = newvalboolean;
    }
    
    
//PROPERTY: topSampReq
    public boolean getTopSampReq() {
        return (boolean)this.topSampReq;
    }
    
    
    public void  setTopSampReq(boolean newvalboolean) {
        this.topSampReq = newvalboolean;
    }
    
    
//PROPERTY: topSampCommentReq
    public boolean getTopSampCommentReq() {
        return (boolean)this.topSampCommentReq;
    }
    
    
    public void  setTopSampCommentReq(boolean newvalboolean) {
        this.topSampCommentReq = newvalboolean;
    }
    
    
//PROPERTY: testSampReq
    public boolean getTestSampReq() {
        return (boolean)this.testSampReq;
    }
    
    
    public void  setTestSampReq(boolean newvalboolean) {
        this.testSampReq = newvalboolean;
    }
    
    
//PROPERTY: testRptReq
    public boolean getTestRptReq() {
        return (boolean)this.testRptReq;
    }
    
    
    public void  setTestRptReq(boolean newvalboolean) {
        this.testRptReq = newvalboolean;
    }
    
    
//PROPERTY: finalTestSampReq
    public boolean getFinalTestSampReq() {
        return (boolean)this.finalTestSampReq;
    }
    
    
    public void  setFinalTestSampReq(boolean newvalboolean) {
        this.finalTestSampReq = newvalboolean;
    }
    
    
//PROPERTY: finalGmtTestRptReq
    public boolean getFinalGmtTestRptReq() {
        return (boolean)this.finalGmtTestRptReq;
    }
    
    
    public void  setFinalGmtTestRptReq(boolean newvalboolean) {
        this.finalGmtTestRptReq = newvalboolean;
    }
    
    
//PROPERTY: shipSplReq
    public boolean getShipSplReq() {
        return (boolean)this.shipSplReq;
    }
    
    
    public void  setShipSplReq(boolean newvalboolean) {
        this.shipSplReq = newvalboolean;
    }
    
    
//PROPERTY: srmk1Req
    public boolean getSrmk1Req() {
        return (boolean)this.srmk1Req;
    }
    
    
    public void  setSrmk1Req(boolean newvalboolean) {
        this.srmk1Req = newvalboolean;
    }
    
    
//PROPERTY: rmk1Req
    public boolean getRmk1Req() {
        return (boolean)this.rmk1Req;
    }
    
    
    public void  setRmk1Req(boolean newvalboolean) {
        this.rmk1Req = newvalboolean;
    }
    
    
//PROPERTY: rmk2Req
    public boolean getRmk2Req() {
        return (boolean)this.rmk2Req;
    }
    
    
    public void  setRmk2Req(boolean newvalboolean) {
        this.rmk2Req = newvalboolean;
    }
    
    
//PROPERTY: rmk3Req
    public boolean getRmk3Req() {
        return (boolean)this.rmk3Req;
    }
    
    
    public void  setRmk3Req(boolean newvalboolean) {
        this.rmk3Req = newvalboolean;
    }
    
    
//PROPERTY: rmk4Req
    public boolean getRmk4Req() {
        return (boolean)this.rmk4Req;
    }
    
    
    public void  setRmk4Req(boolean newvalboolean) {
        this.rmk4Req = newvalboolean;
    }
    
    
//PROPERTY: rmk5Req
    public boolean getRmk5Req() {
        return (boolean)this.rmk5Req;
    }
    
    
    public void  setRmk5Req(boolean newvalboolean) {
        this.rmk5Req = newvalboolean;
    }
    
    
    
    
    public String add(){
        
        if ( this.del != null) {
            this.delReq = true;
        }
        
        if ( this.fabricDel != null) {
            this.fabricDelReq = true;
        }
        
        if ( this.fitSub1 != null) {
            this.fitSub1Req = true;
        }
        
        if ( this.comments != null) {
            this.commentsReq = true;
        }
        
        if ( this.fitSub2 != null) {
            this.fitSub2Req = true;
        }
        
        if ( this.finalAp != null) {
            this.finalApReq = true;
        }
        
        if ( this.soSub1 != null) {
            this.soSub1Req = true;
        }
        
        if ( this.soComment1 != null) {
            this.soComment1Req = true;
        }
        
        if ( this.soSub2 != null) {
            this.soSub2Req = true;
        }
        
        if ( this.soApp != null) {
            this.soAppReq = true;
        }
        
        if ( this.apSPL != null) {
            this.apSPLReq = true;
        }
        
        if ( this.ppSpl != null) {
            this.ppSplReq = true;
        }
        
        if ( this.adSpl != null) {
            this.adSplReq = true;
        }
        
        if ( this.topSamp != null) {
            this.topSampReq = true;
        }
        
        if ( this.topSampComment != null) {
            this.topSampCommentReq = true;
        }
        
        if ( this.testSamp != null) {
            this.testSampReq = true;
        }
        
        if ( this.testRpt != null) {
            this.testRptReq = true;
        }
        
        if ( this.finalTestSamp != null) {
            this.finalTestSampReq = true;
        }
        
        if ( this.finalGmtTestRpt != null) {
            this.finalGmtTestRptReq = true;
        }
        
        if ( this.shipSpl != null) {
            this.shipSplReq = true;
        }
        
        if ( this.srmk1.length() != 0) {
            this.srmk1Req = true;
        }
        
        if ( this.rmk1.length() != 0) {
            this.rmk1Req = true;
        }
        
        if ( this.rmk2.length() != 0) {
            this.rmk2Req = true;
        }
        
        if ( this.rmk3.length() != 0) {
            this.rmk3Req = true;
        }
        
        if ( this.rmk4.length() != 0) {
            this.rmk4Req = true;
        }
        
        if ( this.rmk5.length() != 0) {
            this.rmk5Req = true;
        }
        
        
        try {
            Session session = (Session) HibernateUtil.currentSession();
            Transaction tx= session.beginTransaction();
            
            //Create hibernate object
            ChkLstSampCheckList scl =  new ChkLstSampCheckList();
            scl.setCcode(this.ccode);
            scl.setRefNo(this.refNo);
            scl.setStyle(this.style);
            scl.setBuyer(this.buyer);
            scl.setPoNo(this.poNo);
            scl.setMerchant(this.merchant);
            scl.setQty(this.qty);
            scl.setDel(this.del);
            scl.setFabricDel(this.fabricDel);
            scl.setColor(this.color);
            scl.setFitSub1(this.fitSub1);
            scl.setComments(this.comments);
            scl.setFitSub2(this.fitSub2);
            scl.setFinalAp(this.finalAp);
            scl.setSoSub1(this.soSub1);
            scl.setSoComment1(this.soComment1);
            scl.setSoSub2(this.soSub2);
            scl.setSoApp(this.soApp);
            scl.setApSPL(this.apSPL);
            scl.setPpSpl(this.ppSpl);
            scl.setAdSpl(this.adSpl);
            scl.setTopSamp(this.topSamp);
            scl.setTopSampComment(this.topSampComment);
            scl.setTestSamp(this.testSamp);
            scl.setTestRpt(this.testRpt);
            scl.setFinalTestSamp(this.finalTestSamp);
            scl.setFinalGmtTestRpt(this.finalGmtTestRpt);
            scl.setShipSpl(this.shipSpl);
            scl.setSrmk1(this.srmk1);
            scl.setRmk1(this.rmk1);
            scl.setRmk2(this.rmk2);
            scl.setRmk3(this.rmk3);
            scl.setRmk4(this.rmk4);
            scl.setRmk5(this.rmk5);
            scl.setRmk1Date(this.rmk1Date);
            scl.setRmk2Date(this.rmk2Date);
            scl.setRmk3Date(this.rmk3Date);
            scl.setRmk4Date(this.rmk4Date);
            scl.setRmk5Date(this.rmk5Date);
            scl.setDelReq(this.delReq);
            scl.setFabricDelReq(this.fabricDelReq);
            scl.setFitSub1Req(this.fitSub1Req);
            scl.setCommentsReq(this.commentsReq);
            scl.setFitSub2Req(this.fitSub2Req);
            scl.setFinalApReq(this.finalApReq);
            scl.setSoSub1Req(this.soSub1Req);
            scl.setSoComment1Req(this.soComment1Req);
            scl.setSoSub2Req(this.soSub2Req);
            scl.setSoAppReq(this.soAppReq);
            scl.setApSPLReq(this.apSPLReq);
            scl.setPpSplReq(this.ppSplReq);
            scl.setAdSplReq(this.adSplReq);
            scl.setTopSampReq(this.topSampReq);
            scl.setTopSampCommentReq(this.topSampCommentReq);
            scl.setTestSampReq(this.testSampReq);
            scl.setTestRptReq(this.testRptReq);
            scl.setFinalTestSampReq(this.finalTestSampReq);
            scl.setFinalGmtTestRptReq(this.finalGmtTestRptReq);
            scl.setShipSplReq(this.shipSplReq);
            scl.setSrmk1Req(this.srmk1Req);
            scl.setRmk1Req(this.rmk1Req);
            scl.setRmk2Req(this.rmk2Req);
            scl.setRmk3Req(this.rmk3Req);
            scl.setRmk4Req(this.rmk4Req);
            scl.setRmk5Req(this.rmk5Req);
            session.save(scl);
            tx.commit();
            
            
        } catch (Exception e) {
            System.err.println("Failed coz excveption!!!!");
            FacesMessage fmsg  = new FacesMessage(FacesMessage.SEVERITY_ERROR, e.getCause().toString(), e.getMessage());
            //FacesMessage fmsg  = new FacesMessage(FacesMessage.SEVERITY_ERROR, e.getMessage(), e.getMessage());
            ctx.addMessage(null, fmsg);
            e.printStackTrace();
            return (null);
            //return ("failed");
        } finally {
            HibernateUtil.closeSession();
            //return ("success");
        }
        
        return ("success");
        
        
    }
    
}
