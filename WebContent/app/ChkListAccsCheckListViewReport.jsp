<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%@taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<%@taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@taglib prefix="h" uri="http://java.sun.com/jsf/html"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/reportStyle.css" />   



<f:view>
    <%@ include file="foxyHeader.jsp" %>
    <h:panelGrid id="MainGrid" styleClass="tablebg" width="100%">
        <h:outputText value="View Accesories Check List Report" styleClass="smalltitle" />
        <h:outputText value=" Please key in partial or full refno to search record(s)" style="color: #FE0000; font-weight: bold;" />
        <h:messages id="msgs"/>
        
        <h:form id="accsCheckListsrchbyref">
            <t:outputLabel for="refNo" value="Ref No:" />
            <t:inputText id="refNo" value="#{foxySessionData.orderId}" />
            <t:outputLabel for="showremarkbyref" value="Show Remark:"/>
            <h:selectBooleanCheckbox id="showremarkbyref" value="#{foxyAccsCheckListView.showRmkByRefSrch}"/>                
            <h:commandButton action="#{foxyAccsCheckListView.searchRec}" value="Search By Ref" />
            <t:outputText id="q11ref" value="Sorry no record(s) found" 
                          style="color: #FF0F00; font-weight: bold;" 
                          rendered="#{foxyAccsCheckListView.searchNotFound}"/>
        </h:form>
        <h:outputText value=" Leave Date field default/blank to include all dates" style="color: #FE0000; font-weight: bold;" />
        
        <h:form id="accsCheckListsrch">
            <table class="box" width="100%">
                <tr>
                    <td width='120px' align='left'>Country:</td>
                    <td width='220px' align='left'>Del Start Date:</td>
                    <td width='220px' align='left'>Del End   Date:</td>
                    <td width='90px' align='left'>Show Remark</td>
                    <td align='left' > </td>
                </tr>                    
                <tr>
                    <td align='left'>
                        <h:selectOneMenu id="country" styleClass="FOX_INPUT" value="#{foxySessionData.pageParameter}">
                            <f:selectItems id="countrycodelist" value="#{listData.countryList}" />
                        </h:selectOneMenu>
                        <h:message errorClass="FOX_ERROR" for="country"  showDetail="true" showSummary="true"/>
                    </td>
                    <td align='left'>
                        <t:inputCalendar  id="startDate1" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                                          popupButtonString="Select Date" helpText="YYYYMMDD" value="#{foxyAccsCheckListView.fromDate}"
                                          required = "false" styleClass="FOX_INPUT" />
                        <h:message errorClass="FOX_ERROR" for="startDate1" showDetail="true" showSummary="true"/>                        
                    </td>
                    <td align='left'>
                        <t:inputCalendar  id="endDate1" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                                          popupButtonString="Select Date" helpText="YYYYMMDD" value="#{foxyAccsCheckListView.toDate}"
                                          required = "false" styleClass="FOX_INPUT" />
                        <h:message errorClass="FOX_ERROR" for="endDate1" showDetail="true" showSummary="true"/>
                    </td>
                    <td align="left">
                        <h:selectBooleanCheckbox id="showremark" value="#{foxyAccsCheckListView.showRmkByDate}"/>
                    </td>                        
                    <td align='left'>
                        <h:commandButton action="#{foxyAccsCheckListView.searchRecByDate}" value="Search By Date" />                
                        <h:outputText value="Sorry no record(s) found" 
                                      style="color: #FF0F00; font-weight: bold;" 
                                      rendered="#{foxyAccsCheckListView.searchNotFound}"/>
                    </td>
                </tr>
            </table>
        </h:form> 
        <h:outputText value="#{foxyAccsCheckListView.rptTitleStr}" styleClass="smalltitle" rendered="#{foxyAccsCheckListView.rptTitle}" />  
        <h:form id="accsCheckList" rendered="#{foxyAccsCheckListView.objFound}">                    
            <t:dataTable  value="#{foxyAccsCheckListView.aclModel}" var="accsCheckList" styleClass="dataTable">
                
                <f:facet name="header">
                    <!-- h:outputText value="Record Start" style="color: #ff0000; text-align: center;"/ -->
                </f:facet>
                <f:facet name="footer">
                    <h:outputText value="End of Record(s)      Note:All dates in YYMMDD format" style="color: #ff0000; text-align: center;" />
                </f:facet>                    
                
                <h:column>                    
                    <f:facet name="header" >
                        <h:outputText value="CO"/>
                    </f:facet>
                    <h:outputText value="#{accsCheckList.ccode}"/>                        
                </h:column>              
                
                <h:column>                    
                    <f:facet name="header" >
                        <h:outputText value="Ref"/>
                    </f:facet>
                    <h:outputText value="#{accsCheckList.refNo}"/>                        
                </h:column>              
                
                <h:column >                    
                    <f:facet name="header" >
                        <h:outputText value="Qty"/>
                    </f:facet>
                    <h:outputText value="#{accsCheckList.qty}"/>                        
                </h:column>              
                
                <h:column >                    
                    <f:facet name="header" >
                        <h:outputText value="Style"/>
                    </f:facet>
                    <h:outputText value="#{accsCheckList.style}"/>                        
                </h:column>              
                
                
                <h:column >                    
                    <f:facet name="header" >
                        <h:outputText value="Buyer"/>
                    </f:facet>
                    <h:outputText value="#{accsCheckList.buyer}"/>                        
                </h:column>              
                
                <h:column >                    
                    <f:facet name="header" >
                        <h:outputText value="MR"/>
                    </f:facet>
                    <h:outputText value="#{accsCheckList.merchant}"/>                        
                </h:column>              
                
                <h:column >                    
                    <f:facet name="header" >
                        <h:outputText value="PO"/>
                    </f:facet>
                    <h:outputText value="#{accsCheckList.poNo}"/>                        
                </h:column>              
                
                
                
                <h:column>
                    <f:facet name="header" >
                        <h:outputText value="Del"/>
                    </f:facet>
                    <h:outputText style="color: #ff0000;" value="TBA"
                                  rendered="#{accsCheckList.del == null}" />
                    <h:outputText value="#{accsCheckList.del}"  rendered="#{accsCheckList.del != null}">
                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{myTimeZone.myTimeZone}"/>
                    </h:outputText>
                </h:column>
                
                <h:column>
                    <f:facet name="header" >
                        <h:outputText value="SMRY PO"/>
                    </f:facet>
                    <h:outputText style="color: #ff0000;" value="TBA"
                                  rendered="#{accsCheckList.smrypo == null && accsCheckList.smrypoReq}" />
                    <h:outputText value="#{accsCheckList.smrypo}"  rendered="#{accsCheckList.smrypo != null}">
                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{myTimeZone.myTimeZone}"/>
                    </h:outputText>
                </h:column>
                
                <h:column>
                    <f:facet name="header" >
                        <h:outputText value="DCPO"/>
                    </f:facet>
                    <h:outputText style="color: #ff0000;" value="TBA"
                                  rendered="#{accsCheckList.dcpo == null && accsCheckList.dcpoReq}" />
                    <h:outputText value="#{accsCheckList.dcpo}"  rendered="#{accsCheckList.dcpo != null}">
                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{myTimeZone.myTimeZone}"/>
                    </h:outputText>
                </h:column>
                
                <h:column>
                    <f:facet name="header" >
                        <h:outputText value="F.Marker"/>
                    </f:facet>
                    <h:outputText style="color: #ff0000;" value="TBA"
                                  rendered="#{accsCheckList.finalMarker == null && accsCheckList.finalMarkerReq}" />
                    <h:outputText value="#{accsCheckList.finalMarker}"  rendered="#{accsCheckList.finalMarker != null}">
                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{myTimeZone.myTimeZone}"/>
                    </h:outputText>
                </h:column>
                
                <h:column>
                    <f:facet name="header" >
                        <h:outputText value="P.Sht"/>
                    </f:facet>
                    <h:outputText style="color: #ff0000;" value="TBA"
                                  rendered="#{accsCheckList.prodSheet == null && accsCheckList.prodSheetReq}" />
                    <h:outputText value="#{accsCheckList.prodSheet}"  rendered="#{accsCheckList.prodSheet != null}">
                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{myTimeZone.myTimeZone}"/>
                    </h:outputText>
                </h:column>
                
                <h:column>
                    <f:facet name="header" >
                        <h:outputText value="Main LB"/>
                    </f:facet>
                    <h:outputText style="color: #ff0000;" value="TBA"
                                  rendered="#{accsCheckList.mainLbl == null && accsCheckList.mainLblReq}" />
                    <h:outputText value="#{accsCheckList.mainLbl}"  rendered="#{accsCheckList.mainLbl != null}">
                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{myTimeZone.myTimeZone}"/>
                    </h:outputText>
                </h:column>
                
                <h:column>
                    <f:facet name="header" >
                        <h:outputText value="Care LB"/>
                    </f:facet>
                    <h:outputText style="color: #ff0000;" value="TBA"
                                  rendered="#{accsCheckList.careLbl == null && accsCheckList.careLblReq}" />
                    <h:outputText value="#{accsCheckList.careLbl}"  rendered="#{accsCheckList.careLbl != null}">
                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{myTimeZone.myTimeZone}"/>
                    </h:outputText>
                </h:column>
                
                <h:column>
                    <f:facet name="header" >
                        <h:outputText value="Joker LB"/>
                    </f:facet>
                    <h:outputText style="color: #ff0000;" value="TBA"
                                  rendered="#{accsCheckList.jokerLbl == null && accsCheckList.jokerLblReq}" />
                    <h:outputText value="#{accsCheckList.jokerLbl}"  rendered="#{accsCheckList.jokerLbl != null}">
                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{myTimeZone.myTimeZone}"/>
                    </h:outputText>
                </h:column>
                
                <h:column>
                    <f:facet name="header" >
                        <h:outputText value="GPU LB"/>
                    </f:facet>
                    <h:outputText style="color: #ff0000;" value="TBA"
                                  rendered="#{accsCheckList.gpuLbl == null && accsCheckList.gpuLblReq}" />
                    <h:outputText value="#{accsCheckList.gpuLbl}"  rendered="#{accsCheckList.gpuLbl != null}">
                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{myTimeZone.myTimeZone}"/>
                    </h:outputText>
                </h:column>
                
                <h:column>
                    <f:facet name="header" >
                        <h:outputText value="JPN LB"/>
                    </f:facet>
                    <h:outputText style="color: #ff0000;" value="TBA"
                                  rendered="#{accsCheckList.jpnLbl == null && accsCheckList.jpnLblReq}" />
                    <h:outputText value="#{accsCheckList.jpnLbl}"  rendered="#{accsCheckList.jpnLbl != null}">
                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{myTimeZone.myTimeZone}"/>
                    </h:outputText>
                </h:column>
                
                <h:column>
                    <f:facet name="header" >
                        <h:outputText value="UK LB"/>
                    </f:facet>
                    <h:outputText style="color: #ff0000;" value="TBA"
                                  rendered="#{accsCheckList.ukLbl == null && accsCheckList.ukLblReq}" />
                    <h:outputText value="#{accsCheckList.ukLbl}"  rendered="#{accsCheckList.ukLbl != null}">
                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{myTimeZone.myTimeZone}"/>
                    </h:outputText>
                </h:column>
                
                <h:column>
                    <f:facet name="header" >
                        <h:outputText value="Fire LB"/>
                    </f:facet>
                    <h:outputText style="color: #ff0000;" value="TBA"
                                  rendered="#{accsCheckList.fireLbl == null && accsCheckList.fireLblReq}" />
                    <h:outputText value="#{accsCheckList.fireLbl}"  rendered="#{accsCheckList.fireLbl != null}">
                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{myTimeZone.myTimeZone}"/>
                    </h:outputText>
                </h:column>
                
                <h:column>
                    <f:facet name="header" >
                        <h:outputText value="Side LB"/>
                    </f:facet>
                    <h:outputText style="color: #ff0000;" value="TBA"
                                  rendered="#{accsCheckList.sideLbl == null && accsCheckList.sideLblReq}" />
                    <h:outputText value="#{accsCheckList.sideLbl}"  rendered="#{accsCheckList.sideLbl != null}">
                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{myTimeZone.myTimeZone}"/>
                    </h:outputText>
                </h:column>
                
                <h:column>
                    <f:facet name="header" >
                        <h:outputText value="Size LB"/>
                    </f:facet>
                    <h:outputText style="color: #ff0000;" value="TBA"
                                  rendered="#{accsCheckList.sizeLbl == null && accsCheckList.sizeLblReq}" />
                    <h:outputText value="#{accsCheckList.sizeLbl}"  rendered="#{accsCheckList.sizeLbl != null}">
                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{myTimeZone.myTimeZone}"/>
                    </h:outputText>
                </h:column>
                
                <h:column>
                    <f:facet name="header" >
                        <h:outputText value="CTN LB"/>
                    </f:facet>
                    <h:outputText style="color: #ff0000;" value="TBA"
                                  rendered="#{accsCheckList.ctnLbl == null && accsCheckList.ctnLblReq}" />
                    <h:outputText value="#{accsCheckList.ctnLbl}"  rendered="#{accsCheckList.ctnLbl != null}">
                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{myTimeZone.myTimeZone}"/>
                    </h:outputText>
                </h:column>
                
                <h:column>
                    <f:facet name="header" >
                        <h:outputText value="E.Band"/>
                    </f:facet>
                    <h:outputText style="color: #ff0000;" value="TBA"
                                  rendered="#{accsCheckList.elasticBand == null && accsCheckList.elasticBandReq}" />
                    <h:outputText value="#{accsCheckList.elasticBand}"  rendered="#{accsCheckList.elasticBand != null}">
                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{myTimeZone.myTimeZone}"/>
                    </h:outputText>
                </h:column>
                
                <h:column>
                    <f:facet name="header" >
                        <h:outputText value="Prx Tkt"/>
                    </f:facet>
                    <h:outputText style="color: #ff0000;" value="TBA"
                                  rendered="#{accsCheckList.priceTkt == null && accsCheckList.priceTktReq}" />
                    <h:outputText value="#{accsCheckList.priceTkt}"  rendered="#{accsCheckList.priceTkt != null}">
                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{myTimeZone.myTimeZone}"/>
                    </h:outputText>
                </h:column>
                
                <h:column>
                    <f:facet name="header" >
                        <h:outputText value="Size Stkr"/>
                    </f:facet>
                    <h:outputText style="color: #ff0000;" value="TBA"
                                  rendered="#{accsCheckList.sizeSticker == null && accsCheckList.sizeStickerReq}" />
                    <h:outputText value="#{accsCheckList.sizeSticker}"  rendered="#{accsCheckList.sizeSticker != null}">
                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{myTimeZone.myTimeZone}"/>
                    </h:outputText>
                </h:column>
                
                <h:column>
                    <f:facet name="header" >
                        <h:outputText value="Thread"/>
                    </f:facet>
                    <h:outputText style="color: #ff0000;" value="TBA"
                                  rendered="#{accsCheckList.thread == null && accsCheckList.threadReq}" />
                    <h:outputText value="#{accsCheckList.thread}"  rendered="#{accsCheckList.thread != null}">
                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{myTimeZone.myTimeZone}"/>
                    </h:outputText>
                </h:column>
                
                <h:column>
                    <f:facet name="header" >
                        <h:outputText value="SKU BC"/>
                    </f:facet>
                    <h:outputText style="color: #ff0000;" value="TBA"
                                  rendered="#{accsCheckList.skubarCode == null && accsCheckList.skubarCodeReq}" />
                    <h:outputText value="#{accsCheckList.skubarCode}"  rendered="#{accsCheckList.skubarCode != null}">
                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{myTimeZone.myTimeZone}"/>
                    </h:outputText>
                </h:column>
                
                <h:column>
                    <f:facet name="header" >
                        <h:outputText value="OnlPlyBag"/>
                    </f:facet>
                    <h:outputText style="color: #ff0000;" value="TBA"
                                  rendered="#{accsCheckList.onlPlyBag == null && accsCheckList.onlPlyBagReq}" />
                    <h:outputText value="#{accsCheckList.onlPlyBag}"  rendered="#{accsCheckList.onlPlyBag != null}">
                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{myTimeZone.myTimeZone}"/>
                    </h:outputText>
                </h:column>
                
                <h:column>
                    <f:facet name="header" >
                        <h:outputText value="PPK Stkr"/>
                    </f:facet>
                    <h:outputText style="color: #ff0000;" value="TBA"
                                  rendered="#{accsCheckList.ppackSticker == null && accsCheckList.ppackStickerReq}" />
                    <h:outputText value="#{accsCheckList.ppackSticker}"  rendered="#{accsCheckList.ppackSticker != null}">
                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{myTimeZone.myTimeZone}"/>
                    </h:outputText>
                </h:column>
                
                <h:column>
                    <f:facet name="header" >
                        <h:outputText value="Ribbon"/>
                    </f:facet>
                    <h:outputText style="color: #ff0000;" value="TBA"
                                  rendered="#{accsCheckList.ribbon == null && accsCheckList.ribbonReq}" />
                    <h:outputText value="#{accsCheckList.ribbon}"  rendered="#{accsCheckList.ribbon != null}">
                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{myTimeZone.myTimeZone}"/>
                    </h:outputText>
                </h:column>
                
                <h:column>
                    <f:facet name="header" >
                        <h:outputText value="I.Lining"/>
                    </f:facet>
                    <h:outputText style="color: #ff0000;" value="TBA"
                                  rendered="#{accsCheckList.interLining == null && accsCheckList.interLiningReq}" />
                    <h:outputText value="#{accsCheckList.interLining}"  rendered="#{accsCheckList.interLining != null}">
                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{myTimeZone.myTimeZone}"/>
                    </h:outputText>
                </h:column>
                
                <h:column>
                    <f:facet name="header" >
                        <h:outputText value="Bow"/>
                    </f:facet>
                    <h:outputText style="color: #ff0000;" value="TBA"
                                  rendered="#{accsCheckList.bow == null && accsCheckList.bowReq}" />
                    <h:outputText value="#{accsCheckList.bow}"  rendered="#{accsCheckList.bow != null}">
                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{myTimeZone.myTimeZone}"/>
                    </h:outputText>
                </h:column>
                
                <h:column>
                    <f:facet name="header" >
                        <h:outputText value="TwillTape"/>
                    </f:facet>
                    <h:outputText style="color: #ff0000;" value="TBA"
                                  rendered="#{accsCheckList.twillTape == null && accsCheckList.twillTapeReq}" />
                    <h:outputText value="#{accsCheckList.twillTape}"  rendered="#{accsCheckList.twillTape != null}">
                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{myTimeZone.myTimeZone}"/>
                    </h:outputText>
                </h:column>
                
                <h:column>
                    <f:facet name="header" >
                        <h:outputText value="GrossGain"/>
                    </f:facet>
                    <h:outputText style="color: #ff0000;" value="TBA"
                                  rendered="#{accsCheckList.grossGain == null && accsCheckList.grossGainReq}" />
                    <h:outputText value="#{accsCheckList.grossGain}"  rendered="#{accsCheckList.grossGain != null}">
                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{myTimeZone.myTimeZone}"/>
                    </h:outputText>
                </h:column>
                
                <h:column>
                    <f:facet name="header" >
                        <h:outputText value="DrawCord"/>
                    </f:facet>
                    <h:outputText style="color: #ff0000;" value="TBA"
                                  rendered="#{accsCheckList.drawCord == null && accsCheckList.drawCordReq}" />
                    <h:outputText value="#{accsCheckList.drawCord}"  rendered="#{accsCheckList.drawCord != null}">
                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{myTimeZone.myTimeZone}"/>
                    </h:outputText>
                </h:column>
                
                <h:column>
                    <f:facet name="header" >
                        <h:outputText value="Zipper"/>
                    </f:facet>
                    <h:outputText style="color: #ff0000;" value="TBA"
                                  rendered="#{accsCheckList.zipper == null && accsCheckList.zipperReq}" />
                    <h:outputText value="#{accsCheckList.zipper}"  rendered="#{accsCheckList.zipper != null}">
                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{myTimeZone.myTimeZone}"/>
                    </h:outputText>
                </h:column>
                
                <h:column>
                    <f:facet name="header" >
                        <h:outputText value="Btn"/>
                    </f:facet>
                    <h:outputText style="color: #ff0000;" value="TBA"
                                  rendered="#{accsCheckList.button == null && accsCheckList.buttonReq}" />
                    <h:outputText value="#{accsCheckList.button}"  rendered="#{accsCheckList.button != null}">
                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{myTimeZone.myTimeZone}"/>
                    </h:outputText>
                </h:column>
                
                <h:column>
                    <f:facet name="header" >
                        <h:outputText value="SNAP Btn"/>
                    </f:facet>
                    <h:outputText style="color: #ff0000;" value="TBA"
                                  rendered="#{accsCheckList.snapButton == null && accsCheckList.snapButtonReq}" />
                    <h:outputText value="#{accsCheckList.snapButton}"  rendered="#{accsCheckList.snapButton != null}">
                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{myTimeZone.myTimeZone}"/>
                    </h:outputText>
                </h:column>
                
                <h:column>
                    <f:facet name="header" >
                        <h:outputText value="EyeLet"/>
                    </f:facet>
                    <h:outputText style="color: #ff0000;" value="TBA"
                                  rendered="#{accsCheckList.eyeLet == null && accsCheckList.eyeLetReq}" />
                    <h:outputText value="#{accsCheckList.eyeLet}"  rendered="#{accsCheckList.eyeLet != null}">
                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{myTimeZone.myTimeZone}"/>
                    </h:outputText>
                </h:column>
                
                <h:column>
                    <f:facet name="header" >
                        <h:outputText value="MagicTape"/>
                    </f:facet>
                    <h:outputText style="color: #ff0000;" value="TBA"
                                  rendered="#{accsCheckList.magicTape == null && accsCheckList.magicTapeReq}" />
                    <h:outputText value="#{accsCheckList.magicTape}"  rendered="#{accsCheckList.magicTape != null}">
                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{myTimeZone.myTimeZone}"/>
                    </h:outputText>
                </h:column>
                
                <h:column>
                    <f:facet name="header" >
                        <h:outputText value="Lace"/>
                    </f:facet>
                    <h:outputText style="color: #ff0000;" value="TBA"
                                  rendered="#{accsCheckList.lace == null && accsCheckList.laceReq}" />
                    <h:outputText value="#{accsCheckList.lace}"  rendered="#{accsCheckList.lace != null}">
                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{myTimeZone.myTimeZone}"/>
                    </h:outputText>
                </h:column>
                
                <h:column>
                    <f:facet name="header" >
                        <h:outputText value="Hanger"/>
                    </f:facet>
                    <h:outputText style="color: #ff0000;" value="TBA"
                                  rendered="#{accsCheckList.hanger == null && accsCheckList.hangerReq}" />
                    <h:outputText value="#{accsCheckList.hanger}"  rendered="#{accsCheckList.hanger != null}">
                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{myTimeZone.myTimeZone}"/>
                    </h:outputText>
                </h:column>
                
                <h:column>
                    <f:facet name="header" >
                        <h:outputText value="Sizer"/>
                    </f:facet>
                    <h:outputText style="color: #ff0000;" value="TBA"
                                  rendered="#{accsCheckList.sizer == null && accsCheckList.sizerReq}" />
                    <h:outputText value="#{accsCheckList.sizer}"  rendered="#{accsCheckList.sizer != null}">
                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{myTimeZone.myTimeZone}"/>
                    </h:outputText>
                </h:column>
                
                <h:column>
                    <f:facet name="header" >
                        <h:outputText value="CpyRight LB"/>
                    </f:facet>
                    <h:outputText style="color: #ff0000;" value="TBA"
                                  rendered="#{accsCheckList.cpyrLbl == null && accsCheckList.cpyrLblReq}" />
                    <h:outputText value="#{accsCheckList.cpyrLbl}"  rendered="#{accsCheckList.cpyrLbl != null}">
                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{myTimeZone.myTimeZone}"/>
                    </h:outputText>
                </h:column>
            </t:dataTable>
            
            
            <t:dataTable  value="#{foxyAccsCheckListView.aclModel}" var="accsCheckList" styleClass="dataTable" 
                          rendered="#{(foxyAccsCheckListView.rptTitle && foxyAccsCheckListView.showRmkByDate) || (not foxyAccsCheckListView.rptTitle && foxyAccsCheckListView.showRmkByRefSrch)}">
                
                <f:facet name="header">
                    <!-- h:outputText value="Record Start" style="color: #ff0000; text-align: center;"/ -->
                </f:facet>
                <f:facet name="footer">
                    <h:outputText value="End of Record(s)      Note:All dates in YYMMDD format" style="color: #ff0000; text-align: center;" />
                </f:facet>
                
                <h:column>                    
                    <f:facet name="header" >
                        <h:outputText value="CO"/>
                    </f:facet>
                    <h:outputText value="#{accsCheckList.ccode}"/>                        
                </h:column>                       
                
                <h:column>                    
                    <f:facet name="header" >
                        <h:outputText value="Ref"/>
                    </f:facet>
                    <h:outputText value="#{accsCheckList.refNo}"/>                        
                </h:column>              
                
                <h:column >                    
                    <f:facet name="header" >
                        <h:outputText value="Store Remark"/>
                    </f:facet>
                    <h:outputText value="#{accsCheckList.srmk1}"/>                        
                </h:column>              
                
                <h:column>
                    <f:facet name="header" >
                        <h:outputText value="Date1"/>
                    </f:facet>
                    <h:outputText value="#{accsCheckList.rmk1Date}"  rendered="#{accsCheckList.rmk1Req}">
                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{myTimeZone.myTimeZone}"/>
                    </h:outputText>
                </h:column>
                
                
                <h:column >                    
                    <f:facet name="header" >
                        <h:outputText value="Remark1"/>
                    </f:facet>                        
                    <h:outputText value="#{accsCheckList.rmk1}"  rendered="#{accsCheckList.rmk1Req}" />
                </h:column>              
                
                <h:column>
                    <f:facet name="header" >
                        <h:outputText value="Date2"/>
                    </f:facet>
                    <h:outputText value="#{accsCheckList.rmk2Date}"  rendered="#{accsCheckList.rmk2Req}">
                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{myTimeZone.myTimeZone}"/>
                    </h:outputText>
                </h:column>
                
                
                <h:column >                    
                    <f:facet name="header" >
                        <h:outputText value="Remark2"/>
                    </f:facet>
                    <h:outputText value="#{accsCheckList.rmk2}"  rendered="#{accsCheckList.rmk2Req}" />                        
                </h:column>              
                
                <h:column>
                    <f:facet name="header" >
                        <h:outputText value="Date3"/>
                    </f:facet>
                    <h:outputText value="#{accsCheckList.rmk3Date}"  rendered="#{accsCheckList.rmk3Req}">
                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{myTimeZone.myTimeZone}"/>
                    </h:outputText>
                </h:column>
                
                
                <h:column >                    
                    <f:facet name="header" >
                        <h:outputText value="Remark3"/>
                    </f:facet>
                    <h:outputText value="#{accsCheckList.rmk3}"  rendered="#{accsCheckList.rmk3Req}" />
                </h:column>              
                
                <h:column>
                    <f:facet name="header" >
                        <h:outputText value="Date4"/>
                    </f:facet>
                    <h:outputText value="#{accsCheckList.rmk4Date}"  rendered="#{accsCheckList.rmk4Req}">
                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{myTimeZone.myTimeZone}"/>
                    </h:outputText>
                </h:column>
                
                
                <h:column >                    
                    <f:facet name="header" >
                        <h:outputText value="Remark4"/>
                    </f:facet>
                    <h:outputText value="#{accsCheckList.rmk4}"   rendered="#{accsCheckList.rmk4Req}" />
                </h:column>              
                
                <h:column>
                    <f:facet name="header" >
                        <h:outputText value="Date5"/>
                    </f:facet>
                    <h:outputText value="#{accsCheckList.rmk5Date}"  rendered="#{accsCheckList.rmk5Req}">
                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{myTimeZone.myTimeZone}"/>
                    </h:outputText>
                </h:column>                    
                
                
                <h:column >                    
                    <f:facet name="header" >
                        <h:outputText value="Remark5"/>
                    </f:facet>
                    <h:outputText value="#{accsCheckList.rmk5}"   rendered="#{accsCheckList.rmk5Req}" />
                </h:column>                                  
            </t:dataTable>                
            
            
            
        </h:form>
    </h:panelGrid>    
    <%@ include file="foxyFooter.jsp" %>
</f:view>