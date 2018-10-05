<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%@taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<%@taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@taglib prefix="h" uri="http://java.sun.com/jsf/html"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
   
   

<f:view>
    <%@ include file="foxyHeader.jsp" %>
    <table class="box" width="100%">
        <tr><td align="center">
            <h:outputText value="Edit Accesories Check List record" styleClass="smalltitle" />
        </td></tr>
        <tr><td align="center">
            <h:outputText value="Please check/tick all required items" style="color: #FE0000; font-weight: bold;" />
        </td></tr>        
        <tr><td>
            <h:panelGrid id="norec" rendered="#{not foxyAccsCheckListEdit.recSelected}" columns="1">
                <h:outputText id="q11" value="Sorry no record(s) found" />
            </h:panelGrid>        
            
            <h:form id="accsCheckList" rendered="#{foxyAccsCheckListEdit.recSelected}">
                <table class="tablebg" width="100%">
                    <tr><td width='20%' align='right' >Country:</td>
                        <td align='left'>
                            <h:outputText id="countryCode" styleClass="FOX_INPUT" value="#{foxyAccsCheckListEdit.aclBean.ccode}" />
                        </td>                        
                    </tr>
                    
                    <tr><td width='20%' align='right' >Ref No:</td>
                        <td align='left'>
                            <h:outputText id="refNo" styleClass="FOX_INPUT" value="#{foxyAccsCheckListEdit.aclBean.refNo}" />                        
                        </td>
                    </tr>


                    <tr><td width='20%' align='right' >Qty:</td>
                        <td align='left'>
                            <h:inputText id="qty" styleClass="FOX_INPUT" maxlength="11" size="11" required="false" value="#{foxyAccsCheckListEdit.aclBean.qty}">
                            </h:inputText>
                            <h:outputText value="pcs"/>
                            <h:message errorClass="FOX_ERROR" for="qty" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>                    
                    
                    
                    
                    <tr><td width='20%' align='right' >Style:</td>
                        <td align='left'>
                            <h:inputText id="style" styleClass="FOX_INPUT" maxlength="32" size="32" required="false" value="#{foxyAccsCheckListEdit.aclBean.style}">
                                <f:validateLength maximum="32"/>
                            </h:inputText>
                            <h:message errorClass="FOX_ERROR" for="style" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>

                    <tr><td width='20%' align='right' >Buyer:</td>
                        <td align='left'>
                            <h:inputText id="buyer" styleClass="FOX_INPUT" maxlength="32" size="32" required="false" value="#{foxyAccsCheckListEdit.aclBean.buyer}">
                                <f:validateLength maximum="32"/>
                            </h:inputText>
                            <h:message errorClass="FOX_ERROR" for="buyer" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>

                    <tr><td width='20%' align='right' >Merchant:</td>
                        <td align='left'>
                            <h:inputText id="merchant" styleClass="FOX_INPUT" maxlength="32" size="32" required="false" value="#{foxyAccsCheckListEdit.aclBean.merchant}">
                                <f:validateLength maximum="32"/>
                            </h:inputText>
                            <h:message errorClass="FOX_ERROR" for="merchant" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>

                    <tr><td width='20%' align='right' >PO No:</td>
                        <td align='left'>
                            <h:inputText id="poNo" styleClass="FOX_INPUT" maxlength="32" size="32" required="false" value="#{foxyAccsCheckListEdit.aclBean.poNo}">
                                <f:validateLength maximum="32"/>
                            </h:inputText>
                            <h:message errorClass="FOX_ERROR" for="poNo" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>
                    

                    <tr><td width='20%' align='right' >Summary PO:</td>
                        <td align='left'>
                            <t:inputCalendar  id="smrypo" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                            popupButtonString="Select Date" helpText="YYYYMMDD" value="#{foxyAccsCheckListEdit.aclBean.smrypo}"
                            required = "false" styleClass="FOX_INPUT" />
                            <h:message errorClass="FOX_ERROR" for="smrypo" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>

                    <tr><td width='20%' align='right' >DC PO:</td>
                        <td align='left'>
                            <t:inputCalendar  id="dcpo" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                            popupButtonString="Select Date" helpText="YYYYMMDD" value="#{foxyAccsCheckListEdit.aclBean.dcpo}"
                            required = "false" styleClass="FOX_INPUT" />
                            <h:message errorClass="FOX_ERROR" for="dcpo" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>
                    
                    <tr><td width='20%' align='right'>Delivery:</td>
                        <td align='left'>                            
                            <t:inputCalendar  id="del" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                            popupButtonString="Select Date" helpText="YYYYMMDD" value="#{foxyAccsCheckListEdit.aclBean.del}"
                            required = "false" styleClass="FOX_INPUT" />
                            <h:message errorClass="FOX_ERROR" for="del" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>

                    
                    <tr><td width='20%' align='right'>1. Final Marker:</td>
                        <td align='left'>
                            <h:selectBooleanCheckbox value="#{foxyAccsCheckListEdit.aclBean.finalMarkerReq}"/>
                            <t:inputCalendar  id="finalMarker" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                            popupButtonString="Select Date" helpText="YYYYMMDD" value="#{foxyAccsCheckListEdit.aclBean.finalMarker}"
                            required = "false" styleClass="FOX_INPUT" />
                            <h:message errorClass="FOX_ERROR" for="finalMarker" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>

                    <tr><td width='20%' align='right'>2. (MO) Prod Sheet:</td>
                        <td align='left'>
                            <h:selectBooleanCheckbox value="#{foxyAccsCheckListEdit.aclBean.prodSheetReq}"/>
                            <t:inputCalendar  id="prodSheet" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                            popupButtonString="Select Date" helpText="YYYYMMDD" value="#{foxyAccsCheckListEdit.aclBean.prodSheet}"
                            required = "false" styleClass="FOX_INPUT" />
                            <h:message errorClass="FOX_ERROR" for="prodSheet" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>

                    <tr><td width='20%' align='right'>3. Main Label:</td>
                        <td align='left'>
                            <h:selectBooleanCheckbox value="#{foxyAccsCheckListEdit.aclBean.mainLblReq}"/>
                            <t:inputCalendar  id="mainLbl" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                            popupButtonString="Select Date" helpText="YYYYMMDD" value="#{foxyAccsCheckListEdit.aclBean.mainLbl}"
                            required = "false" styleClass="FOX_INPUT" />
                            <h:message errorClass="FOX_ERROR" for="mainLbl" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>

                    <tr><td width='20%' align='right'>4. Care Label:</td>
                        <td align='left'>
                            <h:selectBooleanCheckbox value="#{foxyAccsCheckListEdit.aclBean.careLblReq}"/>
                            <t:inputCalendar  id="careLbl" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                            popupButtonString="Select Date" helpText="YYYYMMDD" value="#{foxyAccsCheckListEdit.aclBean.careLbl}"
                            required = "false" styleClass="FOX_INPUT" />
                            <h:message errorClass="FOX_ERROR" for="careLbl" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>

                    <tr><td width='20%' align='right'>5. Joker Label:</td>
                        <td align='left'>
                            <h:selectBooleanCheckbox value="#{foxyAccsCheckListEdit.aclBean.jokerLblReq}"/>
                            <t:inputCalendar  id="jokerLbl" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                            popupButtonString="Select Date" helpText="YYYYMMDD" value="#{foxyAccsCheckListEdit.aclBean.jokerLbl}"
                            required = "false" styleClass="FOX_INPUT" />
                            <h:message errorClass="FOX_ERROR" for="jokerLbl" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>

                    <tr><td width='20%' align='right'>6. GPU Label:</td>
                        <td align='left'>
                            <h:selectBooleanCheckbox value="#{foxyAccsCheckListEdit.aclBean.gpuLblReq}"/>
                            <t:inputCalendar  id="gpuLbl" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                            popupButtonString="Select Date" helpText="YYYYMMDD" value="#{foxyAccsCheckListEdit.aclBean.gpuLbl}"
                            required = "false" styleClass="FOX_INPUT" />
                            <h:message errorClass="FOX_ERROR" for="gpuLbl" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>

                    <tr><td width='20%' align='right'>7. JPN Label:</td>
                        <td align='left'>
                            <h:selectBooleanCheckbox value="#{foxyAccsCheckListEdit.aclBean.jpnLblReq}"/>
                            <t:inputCalendar  id="jpnLbl" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                            popupButtonString="Select Date" helpText="YYYYMMDD" value="#{foxyAccsCheckListEdit.aclBean.jpnLbl}"
                            required = "false" styleClass="FOX_INPUT" />
                            <h:message errorClass="FOX_ERROR" for="jpnLbl" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>

                    <tr><td width='20%' align='right'>8. UK Label:</td>
                        <td align='left'>
                            <h:selectBooleanCheckbox value="#{foxyAccsCheckListEdit.aclBean.ukLblReq}"/>
                            <t:inputCalendar  id="ukLbl" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                            popupButtonString="Select Date" helpText="YYYYMMDD" value="#{foxyAccsCheckListEdit.aclBean.ukLbl}"
                            required = "false" styleClass="FOX_INPUT" />
                            <h:message errorClass="FOX_ERROR" for="ukLbl" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>

                    <tr><td width='20%' align='right'>9. Fire Label:</td>
                        <td align='left'>
                            <h:selectBooleanCheckbox value="#{foxyAccsCheckListEdit.aclBean.fireLblReq}"/>
                            <t:inputCalendar  id="fireLbl" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                            popupButtonString="Select Date" helpText="YYYYMMDD" value="#{foxyAccsCheckListEdit.aclBean.fireLbl}"
                            required = "false" styleClass="FOX_INPUT" />
                            <h:message errorClass="FOX_ERROR" for="fireLbl" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>

                    <tr><td width='20%' align='right'>10. Side Label:</td>
                        <td align='left'>
                            <h:selectBooleanCheckbox value="#{foxyAccsCheckListEdit.aclBean.sideLblReq}"/>
                            <t:inputCalendar  id="sideLbl" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                            popupButtonString="Select Date" helpText="YYYYMMDD" value="#{foxyAccsCheckListEdit.aclBean.sideLbl}"
                            required = "false" styleClass="FOX_INPUT" />
                            <h:message errorClass="FOX_ERROR" for="sideLbl" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>

                    <tr><td width='20%' align='right'>11. Size Label:</td>
                        <td align='left'>
                            <h:selectBooleanCheckbox value="#{foxyAccsCheckListEdit.aclBean.sizeLblReq}"/>
                            <t:inputCalendar  id="sizeLbl" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                            popupButtonString="Select Date" helpText="YYYYMMDD" value="#{foxyAccsCheckListEdit.aclBean.sizeLbl}"
                            required = "false" styleClass="FOX_INPUT" />
                            <h:message errorClass="FOX_ERROR" for="sizeLbl" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>

                    <tr><td width='20%' align='right'>12. CTN Label:</td>
                        <td align='left'>
                            <h:selectBooleanCheckbox value="#{foxyAccsCheckListEdit.aclBean.ctnLblReq}"/>
                            <t:inputCalendar  id="ctnLbl" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                            popupButtonString="Select Date" helpText="YYYYMMDD" value="#{foxyAccsCheckListEdit.aclBean.ctnLbl}"
                            required = "false" styleClass="FOX_INPUT" />
                            <h:message errorClass="FOX_ERROR" for="ctnLbl" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>

                    <tr><td width='20%' align='right'>13. Elastic Band:</td>
                        <td align='left'>
                            <h:selectBooleanCheckbox value="#{foxyAccsCheckListEdit.aclBean.elasticBandReq}"/>
                            <t:inputCalendar  id="elasticBand" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                            popupButtonString="Select Date" helpText="YYYYMMDD" value="#{foxyAccsCheckListEdit.aclBean.elasticBand}"
                            required = "false" styleClass="FOX_INPUT" />
                            <h:message errorClass="FOX_ERROR" for="elasticBand" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>

                    <tr><td width='20%' align='right'>14. Price TKT:</td>
                        <td align='left'>
                            <h:selectBooleanCheckbox value="#{foxyAccsCheckListEdit.aclBean.priceTktReq}"/>
                            <t:inputCalendar  id="priceTkt" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                            popupButtonString="Select Date" helpText="YYYYMMDD" value="#{foxyAccsCheckListEdit.aclBean.priceTkt}"
                            required = "false" styleClass="FOX_INPUT" />
                            <h:message errorClass="FOX_ERROR" for="priceTkt" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>

                    <tr><td width='20%' align='right'>15. Size Sticker:</td>
                        <td align='left'>
                            <h:selectBooleanCheckbox value="#{foxyAccsCheckListEdit.aclBean.sizeStickerReq}"/>
                            <t:inputCalendar  id="sizeSticker" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                            popupButtonString="Select Date" helpText="YYYYMMDD" value="#{foxyAccsCheckListEdit.aclBean.sizeSticker}"
                            required = "false" styleClass="FOX_INPUT" />
                            <h:message errorClass="FOX_ERROR" for="sizeSticker" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>

                    <tr><td width='20%' align='right'>16. Thread:</td>
                        <td align='left'>
                            <h:selectBooleanCheckbox value="#{foxyAccsCheckListEdit.aclBean.threadReq}"/>
                            <t:inputCalendar  id="thread" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                            popupButtonString="Select Date" helpText="YYYYMMDD" value="#{foxyAccsCheckListEdit.aclBean.thread}"
                            required = "false" styleClass="FOX_INPUT" />
                            <h:message errorClass="FOX_ERROR" for="thread" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>

                    <tr><td width='20%' align='right'>17. SKU BarCode:</td>
                        <td align='left'>
                            <h:selectBooleanCheckbox value="#{foxyAccsCheckListEdit.aclBean.skubarCodeReq}"/>
                            <t:inputCalendar  id="skubarCode" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                            popupButtonString="Select Date" helpText="YYYYMMDD" value="#{foxyAccsCheckListEdit.aclBean.skubarCode}"
                            required = "false" styleClass="FOX_INPUT" />
                            <h:message errorClass="FOX_ERROR" for="skubarCode" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>

                    <tr><td width='20%' align='right'>18. Online PLY BAG:</td>
                        <td align='left'>
                            <h:selectBooleanCheckbox value="#{foxyAccsCheckListEdit.aclBean.onlPlyBagReq}"/>
                            <t:inputCalendar  id="onlPlyBag" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                            popupButtonString="Select Date" helpText="YYYYMMDD" value="#{foxyAccsCheckListEdit.aclBean.onlPlyBag}"
                            required = "false" styleClass="FOX_INPUT" />
                            <h:message errorClass="FOX_ERROR" for="onlPlyBag" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>

                    <tr><td width='20%' align='right'>19. Ppack Sticker:</td>
                        <td align='left'>
                            <h:selectBooleanCheckbox value="#{foxyAccsCheckListEdit.aclBean.ppackStickerReq}"/>
                            <t:inputCalendar  id="ppackSticker" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                            popupButtonString="Select Date" helpText="YYYYMMDD" value="#{foxyAccsCheckListEdit.aclBean.ppackSticker}"
                            required = "false" styleClass="FOX_INPUT" />
                            <h:message errorClass="FOX_ERROR" for="ppackSticker" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>

                    <tr><td width='20%' align='right'>20. Ribbon:</td>
                        <td align='left'>
                            <h:selectBooleanCheckbox value="#{foxyAccsCheckListEdit.aclBean.ribbonReq}"/>
                            <t:inputCalendar  id="ribbon" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                            popupButtonString="Select Date" helpText="YYYYMMDD" value="#{foxyAccsCheckListEdit.aclBean.ribbon}"
                            required = "false" styleClass="FOX_INPUT" />
                            <h:message errorClass="FOX_ERROR" for="ribbon" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>

                    <tr><td width='20%' align='right'>21. InterLining:</td>
                        <td align='left'>
                            <h:selectBooleanCheckbox value="#{foxyAccsCheckListEdit.aclBean.interLiningReq}"/>
                            <t:inputCalendar  id="interLining" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                            popupButtonString="Select Date" helpText="YYYYMMDD" value="#{foxyAccsCheckListEdit.aclBean.interLining}"
                            required = "false" styleClass="FOX_INPUT" />
                            <h:message errorClass="FOX_ERROR" for="interLining" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>

                    <tr><td width='20%' align='right'>22. Bow:</td>
                        <td align='left'>
                            <h:selectBooleanCheckbox value="#{foxyAccsCheckListEdit.aclBean.bowReq}"/>
                            <t:inputCalendar  id="bow" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                            popupButtonString="Select Date" helpText="YYYYMMDD" value="#{foxyAccsCheckListEdit.aclBean.bow}"
                            required = "false" styleClass="FOX_INPUT" />
                            <h:message errorClass="FOX_ERROR" for="bow" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>

                    <tr><td width='20%' align='right'>23. Twill Tape:</td>
                        <td align='left'>
                            <h:selectBooleanCheckbox value="#{foxyAccsCheckListEdit.aclBean.twillTapeReq}"/>
                            <t:inputCalendar  id="twillTape" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                            popupButtonString="Select Date" helpText="YYYYMMDD" value="#{foxyAccsCheckListEdit.aclBean.twillTape}"
                            required = "false" styleClass="FOX_INPUT" />
                            <h:message errorClass="FOX_ERROR" for="twillTape" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>

                    <tr><td width='20%' align='right'>24. Gross Gain:</td>
                        <td align='left'>
                            <h:selectBooleanCheckbox value="#{foxyAccsCheckListEdit.aclBean.grossGainReq}"/>
                            <t:inputCalendar  id="grossGain" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                            popupButtonString="Select Date" helpText="YYYYMMDD" value="#{foxyAccsCheckListEdit.aclBean.grossGain}"
                            required = "false" styleClass="FOX_INPUT" />
                            <h:message errorClass="FOX_ERROR" for="grossGain" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>

                    <tr><td width='20%' align='right'>25. Draw Cord:</td>
                        <td align='left'>
                            <h:selectBooleanCheckbox value="#{foxyAccsCheckListEdit.aclBean.drawCordReq}"/>
                            <t:inputCalendar  id="drawCord" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                            popupButtonString="Select Date" helpText="YYYYMMDD" value="#{foxyAccsCheckListEdit.aclBean.drawCord}"
                            required = "false" styleClass="FOX_INPUT" />
                            <h:message errorClass="FOX_ERROR" for="drawCord" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>

                    <tr><td width='20%' align='right'>26. Zipper:</td>
                        <td align='left'>
                            <h:selectBooleanCheckbox value="#{foxyAccsCheckListEdit.aclBean.zipperReq}"/>
                            <t:inputCalendar  id="zipper" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                            popupButtonString="Select Date" helpText="YYYYMMDD" value="#{foxyAccsCheckListEdit.aclBean.zipper}"
                            required = "false" styleClass="FOX_INPUT" />
                            <h:message errorClass="FOX_ERROR" for="zipper" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>

                    <tr><td width='20%' align='right'>27. Button:</td>
                        <td align='left'>
                            <h:selectBooleanCheckbox value="#{foxyAccsCheckListEdit.aclBean.buttonReq}"/>
                            <t:inputCalendar  id="button" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                            popupButtonString="Select Date" helpText="YYYYMMDD" value="#{foxyAccsCheckListEdit.aclBean.button}"
                            required = "false" styleClass="FOX_INPUT" />
                            <h:message errorClass="FOX_ERROR" for="button" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>

                    <tr><td width='20%' align='right'>28. Snap Button:</td>
                        <td align='left'>
                            <h:selectBooleanCheckbox value="#{foxyAccsCheckListEdit.aclBean.snapButtonReq}"/>
                            <t:inputCalendar  id="snapButton" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                            popupButtonString="Select Date" helpText="YYYYMMDD" value="#{foxyAccsCheckListEdit.aclBean.snapButton}"
                            required = "false" styleClass="FOX_INPUT" />
                            <h:message errorClass="FOX_ERROR" for="snapButton" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>

                    <tr><td width='20%' align='right'>29. Eye Let:</td>
                        <td align='left'>
                            <h:selectBooleanCheckbox value="#{foxyAccsCheckListEdit.aclBean.eyeLetReq}"/>
                            <t:inputCalendar  id="eyeLet" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                            popupButtonString="Select Date" helpText="YYYYMMDD" value="#{foxyAccsCheckListEdit.aclBean.eyeLet}"
                            required = "false" styleClass="FOX_INPUT" />
                            <h:message errorClass="FOX_ERROR" for="eyeLet" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>

                    <tr><td width='20%' align='right'>30. Magic Tape:</td>
                        <td align='left'>
                            <h:selectBooleanCheckbox value="#{foxyAccsCheckListEdit.aclBean.magicTapeReq}"/>
                            <t:inputCalendar  id="magicTape" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                            popupButtonString="Select Date" helpText="YYYYMMDD" value="#{foxyAccsCheckListEdit.aclBean.magicTape}"
                            required = "false" styleClass="FOX_INPUT" />
                            <h:message errorClass="FOX_ERROR" for="magicTape" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>

                    <tr><td width='20%' align='right'>31. Lace:</td>
                        <td align='left'>
                            <h:selectBooleanCheckbox value="#{foxyAccsCheckListEdit.aclBean.laceReq}"/>
                            <t:inputCalendar  id="lace" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                            popupButtonString="Select Date" helpText="YYYYMMDD" value="#{foxyAccsCheckListEdit.aclBean.lace}"
                            required = "false" styleClass="FOX_INPUT" />
                            <h:message errorClass="FOX_ERROR" for="lace" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>

                    <tr><td width='20%' align='right'>32. Hanger:</td>
                        <td align='left'>
                            <h:selectBooleanCheckbox value="#{foxyAccsCheckListEdit.aclBean.hangerReq}"/>
                            <t:inputCalendar  id="hanger" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                            popupButtonString="Select Date" helpText="YYYYMMDD" value="#{foxyAccsCheckListEdit.aclBean.hanger}"
                            required = "false" styleClass="FOX_INPUT" />
                            <h:message errorClass="FOX_ERROR" for="hanger" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>

                    <tr><td width='20%' align='right'>33. Sizer:</td>
                        <td align='left'>
                            <h:selectBooleanCheckbox value="#{foxyAccsCheckListEdit.aclBean.sizerReq}"/>
                            <t:inputCalendar  id="sizer" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                            popupButtonString="Select Date" helpText="YYYYMMDD" value="#{foxyAccsCheckListEdit.aclBean.sizer}"
                            required = "false" styleClass="FOX_INPUT" />
                            <h:message errorClass="FOX_ERROR" for="sizer" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>

                    <tr><td width='20%' align='right'>34. Copyright Label:</td>
                        <td align='left'>
                            <h:selectBooleanCheckbox value="#{foxyAccsCheckListEdit.aclBean.cpyrLblReq}"/>
                            <t:inputCalendar  id="cpyrLbl" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                            popupButtonString="Select Date" helpText="YYYYMMDD" value="#{foxyAccsCheckListEdit.aclBean.cpyrLbl}"
                            required = "false" styleClass="FOX_INPUT" />
                            <h:message errorClass="FOX_ERROR" for="cpyrLbl" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>
                    
                    
                    <tr><td width='20%'  valign="top" align='right'>Store Remark:</td>
                        <td align='left'>
                            <h:inputText id="SRemark1" styleClass="FOX_INPUT" maxlength="128" size="128"  required="false" value="#{foxyAccsCheckListEdit.aclBean.srmk1}">
                            </h:inputText>
                            <h:message errorClass="FOX_ERROR" for="SRemark1" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>                    
                    
                    
                    <tr><td width='20%'  valign="top" align='right'>35. Remark 1:</td>
                        <td align='left'>
                            <h:selectBooleanCheckbox value="#{foxyAccsCheckListEdit.aclBean.rmk1Req}"/>
                            <t:inputCalendar  id="rmk1date" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                            popupButtonString="Select Date" helpText="YYYYMMDD" value="#{foxyAccsCheckListEdit.aclBean.rmk1Date}"
                            required = "false" styleClass="FOX_INPUT" />
                            <h:inputText id="Remark1" styleClass="FOX_INPUT" maxlength="128" size="128"  required="false" value="#{foxyAccsCheckListEdit.aclBean.rmk1}">
                            </h:inputText>
                            
                            <h:message errorClass="FOX_ERROR" for="Remark1" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>
                    

                    <tr><td width='20%'  valign="top" align='right'>36. Remark 2:</td>
                        <td align='left'>
                            <h:selectBooleanCheckbox value="#{foxyAccsCheckListEdit.aclBean.rmk2Req}"/>
                            <t:inputCalendar  id="rmk2date" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                            popupButtonString="Select Date" helpText="YYYYMMDD" value="#{foxyAccsCheckListEdit.aclBean.rmk2Date}"
                            required = "false" styleClass="FOX_INPUT" />
                            <h:inputText id="Remark2" styleClass="FOX_INPUT" maxlength="128" size="128"  required="false" value="#{foxyAccsCheckListEdit.aclBean.rmk2}">
                            </h:inputText>

                            <h:message errorClass="FOX_ERROR" for="Remark2" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>

                    
                    <tr><td width='20%' valign="top"  align='right'>37. Remark 3:</td>
                        <td align='left' >
                            <h:selectBooleanCheckbox value="#{foxyAccsCheckListEdit.aclBean.rmk3Req}"/>
                            <t:inputCalendar  id="rmk3date" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                            popupButtonString="Select Date" helpText="YYYYMMDD" value="#{foxyAccsCheckListEdit.aclBean.rmk3Date}"
                            required = "false" styleClass="FOX_INPUT" />
                            <h:inputText id="Remark3" styleClass="FOX_INPUT" maxlength="128" size="128"  required="false" value="#{foxyAccsCheckListEdit.aclBean.rmk3}">
                            </h:inputText>

                            <h:message errorClass="FOX_ERROR" for="Remark3" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>

                    
                    <tr><td width='20%' valign="top" align='right'>38. Remark 4:</td>
                        <td align='left'>
                            <h:selectBooleanCheckbox value="#{foxyAccsCheckListEdit.aclBean.rmk4Req}"/>
                            <t:inputCalendar  id="rmk4date" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                            popupButtonString="Select Date" helpText="YYYYMMDD" value="#{foxyAccsCheckListEdit.aclBean.rmk4Date}"
                            required = "false" styleClass="FOX_INPUT" />
                            <h:inputText id="Remark4" styleClass="FOX_INPUT" maxlength="128" size="128"  required="false" value="#{foxyAccsCheckListEdit.aclBean.rmk4}">
                            </h:inputText>

                            <h:message errorClass="FOX_ERROR" for="Remark4" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>

                    
                    <tr><td width='20%' valign="top" align='right'>39. Remark 5:</td>
                        <td align='left'>
                            <h:selectBooleanCheckbox value="#{foxyAccsCheckListEdit.aclBean.rmk5Req}"/>
                            <t:inputCalendar  id="rmk5date" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                            popupButtonString="Select Date" helpText="YYYYMMDD" value="#{foxyAccsCheckListEdit.aclBean.rmk5Date}"
                            required = "false" styleClass="FOX_INPUT" />
                            <h:inputText id="Remark5" styleClass="FOX_INPUT" maxlength="128" size="128"  required="false" value="#{foxyAccsCheckListEdit.aclBean.rmk5}">
                            </h:inputText>
                            
                            <h:message errorClass="FOX_ERROR" for="Remark5" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>

                    
                    <tr>
                        <td align="center" colspan='2'><h:commandButton id="Save" value="Save" action="#{foxyAccsCheckListEdit.save}"/></td>
                    </tr>

                </table>
            </h:form>
        </td></tr>
        <tr>
            <td>
                <!-- Report List -->
            </td>
        </tr>
    </table>
    
    
    <%@ include file="foxyFooter.jsp" %>
</f:view>