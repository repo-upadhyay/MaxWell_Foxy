/*
 * ChkLstAccsCheckList.java
 *
 * Created on July 2, 2006, 7:51 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package com.foxy.db;

import java.io.Serializable;
import java.util.Date;

/**
 *
 * @author hcting
 */
public class ChkLstAccsCheckList implements Serializable {
    
    private long id;
    private String refNo = null;
    private Integer ccode = null;
    private String style = null;
    private String buyer = null;
    private String merchant = null;
    private Integer qty = null;
    private String poNo = null;
    private Date del = null;
    private Date smrypo = null;
    private Date dcpo = null;
    private Date finalMarker = null;
    private Date prodSheet = null;
    private Date mainLbl = null;
    private Date careLbl = null;
    private Date jokerLbl = null;
    private Date gpuLbl = null;
    private Date jpnLbl = null;
    private Date ukLbl = null;
    private Date fireLbl = null;
    private Date sideLbl = null;
    private Date sizeLbl = null;
    private Date ctnLbl = null;
    private Date elasticBand = null;
    private Date priceTkt = null;
    private Date sizeSticker = null;
    private Date thread = null;
    private Date skubarCode = null;
    private Date onlPlyBag = null;
    private Date ppackSticker = null;
    private Date ribbon = null;
    private Date interLining = null;
    private Date bow = null;
    private Date twillTape = null;
    private Date grossGain = null;
    private Date drawCord = null;
    private Date zipper = null;
    private Date button = null;
    private Date snapButton = null;
    private Date eyeLet = null;
    private Date magicTape = null;
    private Date lace = null;
    private Date hanger = null;
    private Date sizer = null;
    private Date cpyrLbl = null;
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
    private boolean smrypoReq = false;
    private boolean dcpoReq = false;
    private boolean finalMarkerReq = false;
    private boolean prodSheetReq = false;
    private boolean mainLblReq = false;
    private boolean careLblReq = false;
    private boolean jokerLblReq = false;
    private boolean gpuLblReq = false;
    private boolean jpnLblReq = false;
    private boolean ukLblReq = false;
    private boolean fireLblReq = false;
    private boolean sideLblReq = false;
    private boolean sizeLblReq = false;
    private boolean ctnLblReq = false;
    private boolean elasticBandReq = false;
    private boolean priceTktReq = false;
    private boolean sizeStickerReq = false;
    private boolean threadReq = false;
    private boolean skubarCodeReq = false;
    private boolean onlPlyBagReq = false;
    private boolean ppackStickerReq = false;
    private boolean ribbonReq = false;
    private boolean interLiningReq = false;
    private boolean bowReq = false;
    private boolean twillTapeReq = false;
    private boolean grossGainReq = false;
    private boolean drawCordReq = false;
    private boolean zipperReq = false;
    private boolean buttonReq = false;
    private boolean snapButtonReq = false;
    private boolean eyeLetReq = false;
    private boolean magicTapeReq = false;
    private boolean laceReq = false;
    private boolean hangerReq = false;
    private boolean sizerReq = false;
    private boolean cpyrLblReq = false;
    private boolean srmk1Req = false;
    private boolean rmk1Req = false;
    private boolean rmk2Req = false;
    private boolean rmk3Req = false;
    private boolean rmk4Req = false;
    private boolean rmk5Req = false;
    
    
    
    /**
     * Creates a new instance of ChkLstAccsCheckList
     */
    public ChkLstAccsCheckList() {
    }
    
    
    
//PROPERTY: id
    public long getId() {
        return (long)this.id;
    }
    
    
    public void  setId(long newvalLong) {
        this.id = newvalLong;
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
    
    
//PROPERTY: poNo
    public String getPoNo() {
        return (String)this.poNo;
    }
    
    
    public void  setPoNo(String newvalString) {
        this.poNo = newvalString;
    }
    
    
//PROPERTY: del
    public Date getDel() {
        return (Date)this.del;
    }
    
    
    public void  setDel(Date newvalDate) {
        this.del = newvalDate;
    }
    
    
//PROPERTY: smrypo
    public Date getSmrypo() {
        return (Date)this.smrypo;
    }
    
    
    public void  setSmrypo(Date newvalDate) {
        this.smrypo = newvalDate;
    }
    
    
//PROPERTY: dcpo
    public Date getDcpo() {
        return (Date)this.dcpo;
    }
    
    
    public void  setDcpo(Date newvalDate) {
        this.dcpo = newvalDate;
    }
    
    
//PROPERTY: finalMarker
    public Date getFinalMarker() {
        return (Date)this.finalMarker;
    }
    
    
    public void  setFinalMarker(Date newvalDate) {
        this.finalMarker = newvalDate;
    }
    
    
//PROPERTY: prodSheet
    public Date getProdSheet() {
        return (Date)this.prodSheet;
    }
    
    
    public void  setProdSheet(Date newvalDate) {
        this.prodSheet = newvalDate;
    }
    
    
//PROPERTY: mainLbl
    public Date getMainLbl() {
        return (Date)this.mainLbl;
    }
    
    
    public void  setMainLbl(Date newvalDate) {
        this.mainLbl = newvalDate;
    }
    
    
//PROPERTY: careLbl
    public Date getCareLbl() {
        return (Date)this.careLbl;
    }
    
    
    public void  setCareLbl(Date newvalDate) {
        this.careLbl = newvalDate;
    }
    
    
//PROPERTY: jokerLbl
    public Date getJokerLbl() {
        return (Date)this.jokerLbl;
    }
    
    
    public void  setJokerLbl(Date newvalDate) {
        this.jokerLbl = newvalDate;
    }
    
    
//PROPERTY: gpuLbl
    public Date getGpuLbl() {
        return (Date)this.gpuLbl;
    }
    
    
    public void  setGpuLbl(Date newvalDate) {
        this.gpuLbl = newvalDate;
    }
    
    
//PROPERTY: jpnLbl
    public Date getJpnLbl() {
        return (Date)this.jpnLbl;
    }
    
    
    public void  setJpnLbl(Date newvalDate) {
        this.jpnLbl = newvalDate;
    }
    
    
//PROPERTY: ukLbl
    public Date getUkLbl() {
        return (Date)this.ukLbl;
    }
    
    
    public void  setUkLbl(Date newvalDate) {
        this.ukLbl = newvalDate;
    }
    
    
//PROPERTY: fireLbl
    public Date getFireLbl() {
        return (Date)this.fireLbl;
    }
    
    
    public void  setFireLbl(Date newvalDate) {
        this.fireLbl = newvalDate;
    }
    
    
//PROPERTY: sideLbl
    public Date getSideLbl() {
        return (Date)this.sideLbl;
    }
    
    
    public void  setSideLbl(Date newvalDate) {
        this.sideLbl = newvalDate;
    }
    
    
//PROPERTY: sizeLbl
    public Date getSizeLbl() {
        return (Date)this.sizeLbl;
    }
    
    
    public void  setSizeLbl(Date newvalDate) {
        this.sizeLbl = newvalDate;
    }
    
    
//PROPERTY: ctnLbl
    public Date getCtnLbl() {
        return (Date)this.ctnLbl;
    }
    
    
    public void  setCtnLbl(Date newvalDate) {
        this.ctnLbl = newvalDate;
    }
    
    
//PROPERTY: elasticBand
    public Date getElasticBand() {
        return (Date)this.elasticBand;
    }
    
    
    public void  setElasticBand(Date newvalDate) {
        this.elasticBand = newvalDate;
    }
    
    
//PROPERTY: priceTkt
    public Date getPriceTkt() {
        return (Date)this.priceTkt;
    }
    
    
    public void  setPriceTkt(Date newvalDate) {
        this.priceTkt = newvalDate;
    }
    
    
//PROPERTY: sizesTicker
    public Date getSizeSticker() {
        return (Date)this.sizeSticker;
    }
    
    
    public void  setSizeSticker(Date newvalDate) {
        this.sizeSticker = newvalDate;
    }
    
    
//PROPERTY: thread
    public Date getThread() {
        return (Date)this.thread;
    }
    
    
    public void  setThread(Date newvalDate) {
        this.thread = newvalDate;
    }
    
    
//PROPERTY: skubarCode
    public Date getSkubarCode() {
        return (Date)this.skubarCode;
    }
    
    
    public void  setSkubarCode(Date newvalDate) {
        this.skubarCode = newvalDate;
    }
    
    
//PROPERTY: onlPlyBag
    public Date getOnlPlyBag() {
        return (Date)this.onlPlyBag;
    }
    
    
    public void  setOnlPlyBag(Date newvalDate) {
        this.onlPlyBag = newvalDate;
    }
    
    
//PROPERTY: ppackSticker
    public Date getPpackSticker() {
        return (Date)this.ppackSticker;
    }
    
    
    public void  setPpackSticker(Date newvalDate) {
        this.ppackSticker = newvalDate;
    }
    
    
//PROPERTY: ribbon
    public Date getRibbon() {
        return (Date)this.ribbon;
    }
    
    
    public void  setRibbon(Date newvalDate) {
        this.ribbon = newvalDate;
    }
    
    
//PROPERTY: interLining
    public Date getInterLining() {
        return (Date)this.interLining;
    }
    
    
    public void  setInterLining(Date newvalDate) {
        this.interLining = newvalDate;
    }
    
    
//PROPERTY: bow
    public Date getBow() {
        return (Date)this.bow;
    }
    
    
    public void  setBow(Date newvalDate) {
        this.bow = newvalDate;
    }
    
    
//PROPERTY: twillTape
    public Date getTwillTape() {
        return (Date)this.twillTape;
    }
    
    
    public void  setTwillTape(Date newvalDate) {
        this.twillTape = newvalDate;
    }
    
    
//PROPERTY: grossGain
    public Date getGrossGain() {
        return (Date)this.grossGain;
    }
    
    
    public void  setGrossGain(Date newvalDate) {
        this.grossGain = newvalDate;
    }
    
    
//PROPERTY: drawCord
    public Date getDrawCord() {
        return (Date)this.drawCord;
    }
    
    
    public void  setDrawCord(Date newvalDate) {
        this.drawCord = newvalDate;
    }
    
    
//PROPERTY: zipper
    public Date getZipper() {
        return (Date)this.zipper;
    }
    
    
    public void  setZipper(Date newvalDate) {
        this.zipper = newvalDate;
    }
    
    
//PROPERTY: button
    public Date getButton() {
        return (Date)this.button;
    }
    
    
    public void  setButton(Date newvalDate) {
        this.button = newvalDate;
    }
    
    
//PROPERTY: snapButton
    public Date getSnapButton() {
        return (Date)this.snapButton;
    }
    
    
    public void  setSnapButton(Date newvalDate) {
        this.snapButton = newvalDate;
    }
    
    
//PROPERTY: eyeLet
    public Date getEyeLet() {
        return (Date)this.eyeLet;
    }
    
    
    public void  setEyeLet(Date newvalDate) {
        this.eyeLet = newvalDate;
    }
    
    
//PROPERTY: magicTape
    public Date getMagicTape() {
        return (Date)this.magicTape;
    }
    
    
    public void  setMagicTape(Date newvalDate) {
        this.magicTape = newvalDate;
    }
    
    
//PROPERTY: lace
    public Date getLace() {
        return (Date)this.lace;
    }
    
    
    public void  setLace(Date newvalDate) {
        this.lace = newvalDate;
    }
    
    
//PROPERTY: hanger
    public Date getHanger() {
        return (Date)this.hanger;
    }
    
    
    public void  setHanger(Date newvalDate) {
        this.hanger = newvalDate;
    }
    
    
//PROPERTY: sizer
    public Date getSizer() {
        return (Date)this.sizer;
    }
    
    
    public void  setSizer(Date newvalDate) {
        this.sizer = newvalDate;
    }
    
    
//PROPERTY: cpyrLbl
    public Date getCpyrLbl() {
        return (Date)this.cpyrLbl;
    }
    
    
    public void  setCpyrLbl(Date newvalDate) {
        this.cpyrLbl = newvalDate;
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
    
    
//PROPERTY: smrypoReq
    public boolean getSmrypoReq() {
        return (boolean)this.smrypoReq;
    }
    
    
    public void  setSmrypoReq(boolean newvalboolean) {
        this.smrypoReq = newvalboolean;
    }
    
    
//PROPERTY: dcpoReq
    public boolean getDcpoReq() {
        return (boolean)this.dcpoReq;
    }
    
    
    public void  setDcpoReq(boolean newvalboolean) {
        this.dcpoReq = newvalboolean;
    }
    
    
//PROPERTY: finalMarkerReq
    public boolean getFinalMarkerReq() {
        return (boolean)this.finalMarkerReq;
    }
    
    
    public void  setFinalMarkerReq(boolean newvalboolean) {
        this.finalMarkerReq = newvalboolean;
    }
    
    
//PROPERTY: prodSheetReq
    public boolean getProdSheetReq() {
        return (boolean)this.prodSheetReq;
    }
    
    
    public void  setProdSheetReq(boolean newvalboolean) {
        this.prodSheetReq = newvalboolean;
    }
    
    
//PROPERTY: mainLblReq
    public boolean getMainLblReq() {
        return (boolean)this.mainLblReq;
    }
    
    
    public void  setMainLblReq(boolean newvalboolean) {
        this.mainLblReq = newvalboolean;
    }
    
    
//PROPERTY: careLblReq
    public boolean getCareLblReq() {
        return (boolean)this.careLblReq;
    }
    
    
    public void  setCareLblReq(boolean newvalboolean) {
        this.careLblReq = newvalboolean;
    }
    
    
//PROPERTY: jokerLblReq
    public boolean getJokerLblReq() {
        return (boolean)this.jokerLblReq;
    }
    
    
    public void  setJokerLblReq(boolean newvalboolean) {
        this.jokerLblReq = newvalboolean;
    }
    
    
//PROPERTY: gpuLblReq
    public boolean getGpuLblReq() {
        return (boolean)this.gpuLblReq;
    }
    
    
    public void  setGpuLblReq(boolean newvalboolean) {
        this.gpuLblReq = newvalboolean;
    }
    
    
//PROPERTY: jpnLblReq
    public boolean getJpnLblReq() {
        return (boolean)this.jpnLblReq;
    }
    
    
    public void  setJpnLblReq(boolean newvalboolean) {
        this.jpnLblReq = newvalboolean;
    }
    
    
//PROPERTY: ukLblReq
    public boolean getUkLblReq() {
        return (boolean)this.ukLblReq;
    }
    
    
    public void  setUkLblReq(boolean newvalboolean) {
        this.ukLblReq = newvalboolean;
    }
    
    
//PROPERTY: fireLblReq
    public boolean getFireLblReq() {
        return (boolean)this.fireLblReq;
    }
    
    
    public void  setFireLblReq(boolean newvalboolean) {
        this.fireLblReq = newvalboolean;
    }
    
    
//PROPERTY: sideLblReq
    public boolean getSideLblReq() {
        return (boolean)this.sideLblReq;
    }
    
    
    public void  setSideLblReq(boolean newvalboolean) {
        this.sideLblReq = newvalboolean;
    }
    
    
//PROPERTY: sizeLblReq
    public boolean getSizeLblReq() {
        return (boolean)this.sizeLblReq;
    }
    
    
    public void  setSizeLblReq(boolean newvalboolean) {
        this.sizeLblReq = newvalboolean;
    }
    
    
//PROPERTY: ctnLblReq
    public boolean getCtnLblReq() {
        return (boolean)this.ctnLblReq;
    }
    
    
    public void  setCtnLblReq(boolean newvalboolean) {
        this.ctnLblReq = newvalboolean;
    }
    
    
//PROPERTY: elasticBrandReq
    public boolean getElasticBandReq() {
        return (boolean)this.elasticBandReq;
    }
    
    
    public void  setElasticBandReq(boolean newvalboolean) {
        this.elasticBandReq = newvalboolean;
    }
    
    
//PROPERTY: priceTktReq
    public boolean getPriceTktReq() {
        return (boolean)this.priceTktReq;
    }
    
    
    public void  setPriceTktReq(boolean newvalboolean) {
        this.priceTktReq = newvalboolean;
    }
    
    
//PROPERTY: sizeStickerReq
    public boolean getSizeStickerReq() {
        return (boolean)this.sizeStickerReq;
    }
    
    
    public void  setSizeStickerReq(boolean newvalboolean) {
        this.sizeStickerReq = newvalboolean;
    }
    
    
//PROPERTY: threadReq
    public boolean getThreadReq() {
        return (boolean)this.threadReq;
    }
    
    
    public void  setThreadReq(boolean newvalboolean) {
        this.threadReq = newvalboolean;
    }
    
    
//PROPERTY: skubarCodeReq
    public boolean getSkubarCodeReq() {
        return (boolean)this.skubarCodeReq;
    }
    
    
    public void  setSkubarCodeReq(boolean newvalboolean) {
        this.skubarCodeReq = newvalboolean;
    }
    
    
//PROPERTY: onlPlyBagReq
    public boolean getOnlPlyBagReq() {
        return (boolean)this.onlPlyBagReq;
    }
    
    
    public void  setOnlPlyBagReq(boolean newvalboolean) {
        this.onlPlyBagReq = newvalboolean;
    }
    
    
//PROPERTY: ppackStickerReq
    public boolean getPpackStickerReq() {
        return (boolean)this.ppackStickerReq;
    }
    
    
    public void  setPpackStickerReq(boolean newvalboolean) {
        this.ppackStickerReq = newvalboolean;
    }
    
    
//PROPERTY: ribbonReq
    public boolean getRibbonReq() {
        return (boolean)this.ribbonReq;
    }
    
    
    public void  setRibbonReq(boolean newvalboolean) {
        this.ribbonReq = newvalboolean;
    }
    
    
//PROPERTY: interLiningReq
    public boolean getInterLiningReq() {
        return (boolean)this.interLiningReq;
    }
    
    
    public void  setInterLiningReq(boolean newvalboolean) {
        this.interLiningReq = newvalboolean;
    }
    
    
//PROPERTY: bowReq
    public boolean getBowReq() {
        return (boolean)this.bowReq;
    }
    
    
    public void  setBowReq(boolean newvalboolean) {
        this.bowReq = newvalboolean;
    }
    
    
//PROPERTY: twillTapeReq
    public boolean getTwillTapeReq() {
        return (boolean)this.twillTapeReq;
    }
    
    
    public void  setTwillTapeReq(boolean newvalboolean) {
        this.twillTapeReq = newvalboolean;
    }
    
    
//PROPERTY: grossGainReq
    public boolean getGrossGainReq() {
        return (boolean)this.grossGainReq;
    }
    
    
    public void  setGrossGainReq(boolean newvalboolean) {
        this.grossGainReq = newvalboolean;
    }
    
    
//PROPERTY: drawCordReq
    public boolean getDrawCordReq() {
        return (boolean)this.drawCordReq;
    }
    
    
    public void  setDrawCordReq(boolean newvalboolean) {
        this.drawCordReq = newvalboolean;
    }
    
    
//PROPERTY: zipperReq
    public boolean getZipperReq() {
        return (boolean)this.zipperReq;
    }
    
    
    public void  setZipperReq(boolean newvalboolean) {
        this.zipperReq = newvalboolean;
    }
    
    
//PROPERTY: buttonReq
    public boolean getButtonReq() {
        return (boolean)this.buttonReq;
    }
    
    
    public void  setButtonReq(boolean newvalboolean) {
        this.buttonReq = newvalboolean;
    }
    
    
//PROPERTY: snapButtonReq
    public boolean getSnapButtonReq() {
        return (boolean)this.snapButtonReq;
    }
    
    
    public void  setSnapButtonReq(boolean newvalboolean) {
        this.snapButtonReq = newvalboolean;
    }
    
    
//PROPERTY: eyeLetReq
    public boolean getEyeLetReq() {
        return (boolean)this.eyeLetReq;
    }
    
    
    public void  setEyeLetReq(boolean newvalboolean) {
        this.eyeLetReq = newvalboolean;
    }
    
    
//PROPERTY: magicTapeReq
    public boolean getMagicTapeReq() {
        return (boolean)this.magicTapeReq;
    }
    
    
    public void  setMagicTapeReq(boolean newvalboolean) {
        this.magicTapeReq = newvalboolean;
    }
    
    
//PROPERTY: laceReq
    public boolean getLaceReq() {
        return (boolean)this.laceReq;
    }
    
    
    public void  setLaceReq(boolean newvalboolean) {
        this.laceReq = newvalboolean;
    }
    
    
//PROPERTY: hangerReq
    public boolean getHangerReq() {
        return (boolean)this.hangerReq;
    }
    
    
    public void  setHangerReq(boolean newvalboolean) {
        this.hangerReq = newvalboolean;
    }
    
    
//PROPERTY: sizerReq
    public boolean getSizerReq() {
        return (boolean)this.sizerReq;
    }
    
    
    public void  setSizerReq(boolean newvalboolean) {
        this.sizerReq = newvalboolean;
    }
    
    
//PROPERTY: cpyrLblReq
    public boolean getCpyrLblReq() {
        return (boolean)this.cpyrLblReq;
    }
    
    
    public void  setCpyrLblReq(boolean newvalboolean) {
        this.cpyrLblReq = newvalboolean;
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
    
    
}