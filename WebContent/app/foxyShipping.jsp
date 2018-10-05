<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<%@taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@taglib prefix="h" uri="http://java.sun.com/jsf/html"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<f:view>
    <%@ include file="foxyHeader.jsp" %>
    
    <div id="foxyConfirmDeleteBox">
        <table height='100%' width='100%'>
            <tr height='70%'><td>
                    <center>Do you want to exit now?</center>
            </td></tr>
            <tr><td>
                    <center>
                        <a href="../logout.jsp"> Logout </a>&nbsp;&nbsp;
                        <a href="#" onclick="foxyHide('foxyConfirmLogoutBox')"> Cancel </a>
                    </center>
            </td></tr>
        </table>
    </div>
    
    <%-- Panel for Update & Add --%>
    <h:panelGrid id="UpdAddGrid" styleClass="tablebg" rendered="#{foxyShipping.updAdd}" width="100%">
        <%-- Title for Update --%>
        <h:outputText value="Update Shipping" styleClass="smalltitle" rendered="#{foxyShipping.update}"/>
        <%-- Title for Add --%>
        <h:outputText value="Add Shipping" styleClass="smalltitle" rendered="#{foxyShipping.add}"/>
        <h:form id="UpdAddForm" rendered="true">
            <h:inputHidden id="ccRefId" value="#{foxyShipping.ccRefId}"/>
            <h:inputHidden id="refId" value="#{foxyShipping.id}"/>
            <h:inputHidden id="month" value="#{foxyShipping.month}"/>
            <h:inputHidden id="location" value="#{foxyShipping.location}"/>
            <h:inputHidden id="subLocation" value="#{foxyShipping.subLocation}"/>
            
            <h:panelGrid columns="2" columnClasses="FOXY_SCREEN_2COL,FOXY_SCREEN_2COL" width="100%" cellpadding="0" cellspacing="0" border="0" frame="none" rules="none">
                <%-- START column 1 --%>
                <h:panelGrid id="UpdInputcol1" columns="2" columnClasses="FOX_LABEL_COL_2, FOX_INPUT_COL_2" width="100%">
                    <h:outputText value="Ref. Number:" />
                    <h:panelGroup>
                        <h:inputText id="OrderIdD" styleClass="FOX_INPUT_RO_KEY" readonly="true" size="10" required="true" value="#{foxyShipping.orderId}"/>
                        <h:outputText value=" "/>
                        <h:inputText id="SubId" styleClass="FOX_INPUT_RO_KEY" readonly="true" size="10" required="true" value="#{foxyShipping.subId}"/>
                        <h:inputHidden id="OrderId" value="#{foxyShipping.orderId}"/>                    
                    </h:panelGroup>
                    
                    <t:outputLabel for="ETD" value="ETD:" />
                    <h:panelGroup>
                        <t:inputCalendar id="ETD" styleClass="FOX_INPUT" value="#{foxyShipping.etd}"  
                                         popupDateFormat="yyyyMMdd" renderAsPopup="true"
                                         helpText="YYYYMMDD" required="true"/>    
                        <h:message errorClass="FOX_ERROR" for="ETD" showDetail="true" showSummary="true"/>
                    </h:panelGroup>                        
                    
                    <t:outputLabel for="ETA" value="ETA:" />
                    <h:panelGroup>
                        <t:inputCalendar id="ETA" styleClass="FOX_INPUT" value="#{foxyShipping.eta}"  
                                         popupDateFormat="yyyyMMdd" renderAsPopup="true"
                                         helpText="YYYYMMDD"/>    
                        <h:message errorClass="FOX_ERROR" for="ETA" showDetail="true" showSummary="true"/>
                    </h:panelGroup>                        
                    
                    <t:outputLabel for="Amount" value="Amount (USD):" />
                    <h:panelGroup>
                        <h:panelGroup>
                            <t:inputTextHelp id="Amount" helpText="9999999999.99" styleClass="FOX_INPUT_NUM" maxlength="13" size="13" required="true" value="#{foxyShipping.amount}"/>
                        </h:panelGroup>
                        <h:message errorClass="FOX_ERROR" for="Amount" showDetail="true" showSummary="true"/>
                    </h:panelGroup>                        
                    
                    <t:outputLabel for="CTN" value="CTN:" />
                    <h:panelGroup>
                        <t:inputTextHelp id="CTN" styleClass="FOX_INPUT_NUM" helpText="999999999" size="10" required="true" value="#{foxyShipping.ctn}"/>
                        <h:message errorClass="FOX_ERROR" for="CTN" showDetail="true" showSummary="true"/>
                    </h:panelGroup>
                    
                    <t:outputLabel for="status" value="Status:"/>
                    <h:panelGroup>
                        <h:selectOneMenu id="status" styleClass="FOX_INPUT" required="true" value="#{foxyShipping.shipStat}">
                            <f:selectItems value="#{listData.shipStatus}"/>
                        </h:selectOneMenu>
                        <h:message errorClass="FOX_ERROR" for="status" showDetail="true" showSummary="true"/>
                    </h:panelGroup>                    
                    
                    <t:outputLabel for="CostFreight" value="Cost Freight (USD):" />
                    <h:panelGroup>
                        <t:inputTextHelp id="CostFreight" styleClass="FOX_INPUT_NUM" helpText="99999999.99" maxlength="11" size="11" 
                                         required="false" value="#{foxyShipping.costFreight}"/>
                        <h:message errorClass="FOX_ERROR" for="CostFreight" showDetail="true" showSummary="true"/>
                    </h:panelGroup>
                    
                    <t:outputLabel for="CMTUnitPrc" value="CMT Unit Price(USD):" />
                    <h:panelGroup>
                        <t:inputTextHelp id="CMTUnitPrc" styleClass="FOX_INPUT_NUM" helpText="99999999.99" maxlength="11" size="11" 
                                         required="false" value="#{foxyShipping.cmtUnitPrc}"/>
                        <h:message errorClass="FOX_ERROR" for="CMTUnitPrc" showDetail="true" showSummary="true"/>
                    </h:panelGroup>
                    
                    <t:outputLabel for="FOBUnitPrc" value="FOB Unit Price(USD):" />
                    <h:panelGroup>
                        <t:inputTextHelp id="FOBUnitPrc" styleClass="FOX_INPUT_NUM" helpText="99999999.99" maxlength="11" size="11" 
                                         required="false" value="#{foxyShipping.fobUnitPrc}"/>
                        <h:message errorClass="FOX_ERROR" for="FOBUnitPrc" showDetail="true" showSummary="true"/>
                    </h:panelGroup>                    
                    
                </h:panelGrid>
                <%-- END column 1 --%>
                
                <%-- START column 2 --%>
                <h:panelGrid id="UpdInputcol2" columns="2" columnClasses="FOX_LABEL_COL_2, FOX_INPUT_COL_2" width="100%">
                    <t:outputLabel for="InvoiceNumber" value="Invoice Number:" />
                    <h:panelGroup>
                        <h:inputText id="InvoiceNumber" styleClass="FOX_INPUT" maxlength="20" size="20" required="true" value="#{foxyShipping.invoice}"/>
                        <h:message errorClass="FOX_ERROR" for="InvoiceNumber" showDetail="true" showSummary="true"/>
                    </h:panelGroup>                              
                    
                    <t:outputLabel for="LCNumber" value="LC Number:" />
                    <h:panelGroup>
                        <h:inputText id="LCNumber" styleClass="FOX_INPUT" maxlength="50" size="50" required="true" value="#{foxyShipping.lcNumber}"/>
                        <h:message errorClass="FOX_ERROR" for="LCNumber" showDetail="true" showSummary="true"/>
                    </h:panelGroup>                                                              
                    
                    <t:outputLabel for="Quantity" value="Shipping Quantity:" />
                    <h:panelGroup>
                        <t:inputTextHelp id="Quantity" styleClass="FOX_INPUT_NUM" helpText="999999999.99" maxlength="13" size="13" required="true" value="#{foxyShipping.quantity}"/>
                        <h:outputText value=" " />
                        <h:selectOneMenu id="Unit" styleClass="FOX_INPUT" required="true" value="#{foxyShipping.unitc}">
                            <f:selectItems value="#{listData.unitList}"/>
                        </h:selectOneMenu>
                        <h:message errorClass="FOX_ERROR" for="Quantity" showDetail="true" showSummary="true"/>
                        <h:message errorClass="FOX_ERROR" for="Unit" showDetail="true" showSummary="true"/>                                        
                    </h:panelGroup>      
                    
                    <t:outputLabel for="Vessel" value="Vessel:" />
                    <h:panelGroup>
                        <h:inputText id="Vessel" styleClass="FOX_INPUT" maxlength="50" size="30" required="true" value="#{foxyShipping.vessel}">
                        </h:inputText>
                        <h:message errorClass="FOX_ERROR" for="Vessel" showDetail="true" showSummary="true"/>
                    </h:panelGroup>                                                          
                    
                    <t:outputLabel for="Voyage" value="Voyage:" />
                    <h:panelGroup>
                        <h:inputText id="Voyage" styleClass="FOX_INPUT" maxlength="10" size="10" required="true" value="#{foxyShipping.voyage}">
                        </h:inputText>
                        <h:message errorClass="FOX_ERROR" for="Voyage" showDetail="true" showSummary="true"/>
                    </h:panelGroup>
                    
                    <t:outputLabel for="ShipMode" value="Ship Mode" />
                    <h:panelGroup>
                        <h:selectOneMenu id="ShipMode" styleClass="FOX_INPUT" required="true" value="#{foxyShipping.shipMode}">
                            <f:selectItems value="#{listData.shipTypeList}"/>
                        </h:selectOneMenu>                        
                        <h:message errorClass="FOX_ERROR" for="ShipMode" showDetail="true" showSummary="true"/>
                    </h:panelGroup>                                        
                    
                    <t:outputLabel for="VisaNo" value="Visa No:" />
                    <h:panelGroup>
                        <h:inputText id="VisaNo" styleClass="FOX_INPUT" maxlength="10" size="10" required="false" value="#{foxyShipping.visaNo}">
                        </h:inputText>
                        <h:message errorClass="FOX_ERROR" for="VisaNo" showDetail="true" showSummary="true"/>
                    </h:panelGroup>
                    
                    <t:outputLabel for="COCert" value="C/O Cert" />
                    <h:panelGroup>
                        <h:inputText id="COCert" styleClass="FOX_INPUT" maxlength="10" size="10" required="false" value="#{foxyShipping.coCert}">
                        </h:inputText>
                        <h:message errorClass="FOX_ERROR" for="COCert" showDetail="true" showSummary="true"/>
                    </h:panelGroup>
                    
                    <t:outputLabel for="ExpRefNo" value="Export Reg.No" />
                    <h:panelGroup>
                        <h:inputText id="ExpRefNo" styleClass="FOX_INPUT" maxlength="10" size="10" required="false" value="#{foxyShipping.expRegNo}">
                        </h:inputText>
                        <h:message errorClass="FOX_ERROR" for="ExpRefNo" showDetail="true" showSummary="true"/>
                    </h:panelGroup>
                    
                </h:panelGrid>
                <%-- END column 2 --%>
            </h:panelGrid>
            
            <h:panelGrid id="AddButton" columns="1" columnClasses="FOX_BUTTON" width="50%">
                <h:panelGroup>
                    <h:commandButton id="Save" value="Save" action="#{foxyShipping.save}" rendered="#{foxyShipping.add}"/>
                    <h:commandButton id="Update" value="Save" action="#{foxyShipping.save}" rendered="#{foxyShipping.update}" />
                    <h:outputText value=" " />
                    <h:commandButton id="Reset" value="Reset" type="reset"/>
                </h:panelGroup>
            </h:panelGrid>
        </h:form>
        
        <h:form id="OrderDetailForm">
            <h:panelGrid id="ListDisplay" columns="1" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="100%">
                <t:dataTable value="#{foxyShipping.orderDetail}" var="orderDetail"
                             id="DetailData"
                             styleClass="FOXY_ORDER_DETAIL"
                             headerClass="FOXY_ORDER_DETAIL_HEADER"
                             footerClass="FOXY_ORDER_DETAIL_HEADER"                    
                             rowGroupStyleClass="FOX_ROW_GROUP"
                             rowGroupStyle="font-weight: bold;"
                             preserveDataModel="true"
                             cellspacing="0">
                    <%--rowClasses="FoxyOddRow,FoxyEvenRow"--%>
                    
                    <%-- Lot --%>
                    <t:column groupBy="true" width="2%">
                        <f:facet name="header">
                            <h:outputText value="Lot" />
                        </f:facet>
                        <h:outputText value="#{orderDetail.lotS}"/>
                    </t:column>
                    
                    <%-- No --%>
                    <t:column width="6%" styleClass="FOXY_ORDER_DETAIL_COL_L">
                        <f:facet name="header">
                            <h:outputText value="No" />
                        </f:facet>
                        <%--h:outputText value="#{orderDetail.lotD}" /--%>
                        <h:commandLink id="lotD" 
                                       action="#{foxyShipping.enqadd}" value="#{orderDetail.lotD}">
                            <f:param name="orderid" value="#{foxyOrderPO.orderId}"/>
                            <f:param name="refIdC" value="#{orderDetail.refIdC}"/>
                            <f:param name="refIdSp" value="#{orderDetail.refIdSp}"/>
                            <f:param name="month" value="#{orderDetail.month}"/>
                            <f:param name="location" value="#{orderDetail.location}"/>
                            <f:param name="subLocation" value="#{orderDetail.subLocation}"/>
                        </h:commandLink>
                        
                    </t:column>
                    
                    <%-- Category --%>
                    <%--t:column width="6%">
                    <f:facet name="header">
                    <h:outputText value="Category" />
                    </f:facet>
                    <h:outputText value="#{orderDetail.category}" />
                    </t:column--%>
                    
                    <%-- PO Number --%>
                    <t:column width="6%" styleClass="FOXY_ORDER_DETAIL_COL_L">
                        <f:facet name="header">
                            <h:outputText value="PO No" />
                        </f:facet>
                        <h:outputText value="#{orderDetail.poNumber}" />
                    </t:column>
                    
                    <%-- Invoice --%>
                    <t:column width="6%" styleClass="FOXY_ORDER_DETAIL_COL_L">
                        <f:facet name="header">
                            <h:outputText value="Invoice" />
                        </f:facet>
                        <h:outputText value="#{orderDetail.invoice}">
                        </h:outputText>
                    </t:column>
                    
                    <%-- LC Number --%>
                    <t:column width="6%" styleClass="FOXY_ORDER_DETAIL_COL_L">
                        <f:facet name="header">
                            <h:outputText value="LC No" />
                        </f:facet>
                        <h:outputText value="#{orderDetail.lcNumber}">
                        </h:outputText>
                    </t:column>
                    
                    <%-- Destination --%>
                    <t:column width="6%" styleClass="FOXY_ORDER_DETAIL_COL_L">
                        <f:facet name="header">
                            <h:outputText value="Destination" />
                        </f:facet>
                        <h:outputText value="#{orderDetail.destName}">
                        </h:outputText>
                    </t:column>
                    
                    <%-- ETD --%>
                    <t:column width="4%" styleClass="FOXY_ORDER_DETAIL_COL_L">
                        <f:facet name="header">
                            <h:outputText value="ETD" />
                        </f:facet>
                        <h:outputText value="#{orderDetail.etd}">
                            <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                        </h:outputText>
                    </t:column>
                    
                    <%-- ETA --%>
                    <t:column width="4%" styleClass="FOXY_ORDER_DETAIL_COL_L">
                        <f:facet name="header">
                            <h:outputText value="ETA" />
                        </f:facet>
                        <h:outputText value="#{orderDetail.eta}">
                            <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                        </h:outputText>
                    </t:column>
                    
                    <%-- Amount --%>
                    <t:column width="6%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">                                
                                <h:outputText value="Amount" />
                            </h:panelGrid>
                        </f:facet>
                        <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                     cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">                        
                            <h:outputText value="#{orderDetail.amount}">
                                <f:convertNumber pattern="#.00"/>
                            </h:outputText>
                        </h:panelGrid>                        
                    </t:column>                    
                    
                    <%-- Quantity DZN --%>
                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">                            
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">                            
                                <h:outputText value="Qty (DZN)" />
                            </h:panelGrid>
                        </f:facet>
                        <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                     cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">                                                
                            <h:outputText value="#{orderDetail.quantityDzn}" >
                                <f:convertNumber pattern="#.00"/>
                            </h:outputText>
                        </h:panelGrid>
                    </t:column>
                    
                    <%-- Quantity PCS --%>
                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">                            
                                <h:outputText value="Qty (PCS)" />
                            </h:panelGrid>
                        </f:facet>
                        <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                     cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">                                                
                            <h:outputText value="#{orderDetail.quantityPcs}">
                                <f:convertNumber pattern="#.00"/>
                            </h:outputText>
                        </h:panelGrid>
                    </t:column>
                    
                    <%-- CTN --%>
                    <t:column width="6%" styleClass="FOXY_ORDER_DETAIL_COL_L">
                        <f:facet name="header">
                            <h:outputText value="CTN" />
                        </f:facet>
                        <h:outputText value="#{orderDetail.ctn}" />
                    </t:column>
                    
                    <%-- Vessel --%>
                    <t:column width="5%" styleClass="FOXY_ORDER_DETAIL_COL_L">
                        <f:facet name="header">
                            <h:outputText value="Vessel" />
                        </f:facet>
                        <h:outputText value="#{orderDetail.vessel}">
                        </h:outputText>
                    </t:column>
                    
                    <%-- Voyage --%>
                    <t:column width="5%" styleClass="FOXY_ORDER_DETAIL_COL_L">
                        <f:facet name="header">
                            <h:outputText value="Voyage" />
                        </f:facet>
                        <h:outputText value="#{orderDetail.voyage}">
                        </h:outputText>
                    </t:column>
                    
                    <%-- Vessel Date --%>
                    <t:column width="6%" styleClass="FOXY_ORDER_DETAIL_COL_L">
                        <f:facet name="header">
                            <h:outputText value="Vsl Date"/>                                
                        </f:facet>
                        <h:outputText value="#{orderDetail.vesselDate}">
                            <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                        </h:outputText>
                    </t:column>
                    
                </t:dataTable>
            </h:panelGrid>
        </h:form>
    </h:panelGrid>            
    <%-- End of Update & Add --%>

    <%-- Panel for Enquiry --%>
    <h:panelGrid id="EnqGrid" styleClass="tablebg" rendered="#{foxyOrderPO.enquiry}" width="100%">
        <%-- Title for Enquiry --%>
        <h:outputText value="Enquire Shipping" styleClass="smalltitle"/>
        <h:form id="EnqForm" rendered="true">
            <h:inputHidden id="ccRefId" value="#{foxyShipping.ccRefId}"/>
            <h:inputHidden id="refId" value="#{foxyShipping.id}"/>
            <h:inputHidden id="month" value="#{foxyShipping.month}"/>
            <h:inputHidden id="location" value="#{foxyShipping.location}"/>
            <h:inputHidden id="subLocation" value="#{foxyShipping.subLocation}"/>
            
            <h:panelGrid columns="2" columnClasses="FOXY_SCREEN_2COL,FOXY_SCREEN_2COL" width="100%" cellpadding="0" cellspacing="0" border="0" frame="none" rules="none">
                <%-- START column 1 --%>
                <h:panelGrid id="EnqInputcol1" columns="2" columnClasses="FOX_LABEL_COL_2, FOX_INPUT_COL_2" width="100%">
                    <h:outputText value="Ref. Number:" />
                    <h:panelGroup>
                        <h:inputText id="OrderIdD" styleClass="FOX_INPUT_RO_KEY" readonly="true" size="10" required="true" value="#{foxyShipping.orderId}"/>
                        <h:outputText value=" "/>
                        <h:inputText id="SubId" styleClass="FOX_INPUT_RO_KEY" readonly="true" size="10" required="true" value="#{foxyShipping.subId}"/>
                        <h:inputHidden id="OrderId" value="#{foxyShipping.orderId}"/>                     
                    </h:panelGroup>                        
                    
                    <h:outputText value="ETD:" />
                    <h:inputText id="ETD" styleClass="FOX_INPUT_RO" readonly="true" size="30" value="#{foxyShipping.etd}">
                        <f:convertDateTime type="date" pattern="yyyy-MM-dd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                    </h:inputText>
                    
                    <h:outputText value="ETA:" />
                    <h:inputText id="ETA" styleClass="FOX_INPUT_RO" readonly="true" size="30" value="#{foxyShipping.eta}">
                        <f:convertDateTime type="date" pattern="yyyy-MM-dd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                    </h:inputText>
                    
                    <h:outputText value="Amount (USD):" />
                    <h:panelGroup>
                        <h:inputText id="Amount" styleClass="FOX_INPUT_NUM_RO" readonly="true" size="15" value="#{foxyShipping.amount}"/>
                    </h:panelGroup>
                    
                    <h:outputText value="CTN:" />
                    <h:inputText id="CTN" styleClass="FOX_INPUT_NUM_RO" readonly="true" size="10" value="#{foxyShipping.ctn}"/>
                    
                    <h:outputText value="Status:" />
                    <h:inputText id="Status" styleClass="FOX_INPUT_RO" readonly="true" size="10" value="#{foxyShipping.shipStat}"/>                
                    
                    <h:outputText value="Cost Freight (USD):" />
                    <h:inputText id="CostFreight" styleClass="FOX_INPUT_RO"  maxlength="11" size="11" 
                                 readonly="true" value="#{foxyShipping.costFreight}"/>
                    
                    <h:outputText value="CMT Unit Price(USD):" />
                    <h:inputText id="CMTUnitPrc" styleClass="FOX_INPUT_RO"  maxlength="11" size="11" 
                                 readonly="true" value="#{foxyShipping.cmtUnitPrc}"/>
                    
                    <h:outputText value="FOB Unit Price(USD):" />
                    <h:inputText id="FOBUnitPrc" styleClass="FOX_INPUT_RO"  maxlength="11" size="11" 
                                 readonly="true" value="#{foxyShipping.fobUnitPrc}"/>
                    
                </h:panelGrid>
                <%-- END column 1 --%>
                
                <%-- START column 2 --%>
                <h:panelGrid id="EnqInputcol2" columns="2" columnClasses="FOX_LABEL_COL_2, FOX_INPUT_COL_2" width="100%">                    
                    <h:outputText value="Invoice Nmber:" />
                    <h:inputText id="InvoiceNumber" styleClass="FOX_INPUT_RO" readonly="true" size="20" value="#{foxyShipping.invoice}"/>                        
                    
                    <h:outputText value="LC Nmber:" />
                    <h:inputText id="LCNumber" styleClass="FOX_INPUT_RO" readonly="true" size="50" value="#{foxyShipping.lcNumber}"/>                        
                    
                    <h:outputText value="Shipping Quantity:" />
                    <h:panelGroup>
                        <h:inputText id="QtyDzn" styleClass="FOX_INPUT_NUM_RO" readonly="true" size="15" value="#{foxyShipping.qtyDzn}"/>
                        <h:outputText value=" Dozens " />
                        <h:outputText value=" " />
                        <h:inputText id="QtyPcs" styleClass="FOX_INPUT_NUM_RO" readonly="true" size="15" value="#{foxyShipping.qtyPcs}"/>
                        <h:outputText value=" Pieces    " />
                    </h:panelGroup>
                    
                    <h:outputText value="Vessel:" />
                    <h:inputText id="Vessel" styleClass="FOX_INPUT_RO" readonly="true" size="50" value="#{foxyShipping.vessel}"/>
                    
                    <h:outputText value="Voyage:" />
                    <h:inputText id="Voyage" styleClass="FOX_INPUT_RO" readonly="true" size="10" value="#{foxyShipping.voyage}"/>                    
                    
                    <h:outputText value="Ship Mode" />
                    <h:inputText id="ShipMode" styleClass="FOX_INPUT_RO" readonly="true" size="10" value="#{foxyShipping.shipMode}"/>                    
                    
                    <h:outputText value="Visa No:" />
                    <h:inputText id="VisaNo" styleClass="FOX_INPUT_RO" readonly="true" size="10" value="#{foxyShipping.visaNo}"/>
                    
                    <h:outputText value="C/O Cert" />
                    <h:inputText id="COCert" styleClass="FOX_INPUT_RO" readonly="true" size="10" value="#{foxyShipping.coCert}"/>
                    
                    <h:outputText value="Export Reg.No" />
                    <h:inputText id="ExpRefNo" styleClass="FOX_INPUT_RO" readonly="true" size="10" value="#{foxyShipping.expRegNo}"/>
                </h:panelGrid>
                <%-- END column 1 --%>
            </h:panelGrid>
            
            <h:panelGrid id="AddButton" columns="1" columnClasses="FOX_BUTTON" width="50%">
                <h:panelGroup>
                    <h:commandButton id="Edit" value="Edit" action="#{foxyShipping.edit}"/>
                    <h:outputText value=" " />
                    <h:commandButton id="Delete" value="Delete" action="#{foxyShipping.delete}" disabled="false"
                                     onclick="if(!confirm('Are you sure want to delete this record?')) return false"/>
                </h:panelGroup>
            </h:panelGrid>
            
        </h:form>
        
        <h:form id="EnqDetailForm">
            <h:panelGrid id="ListDisplay" columns="1" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="100%">
                <t:dataTable value="#{foxyShipping.orderDetail}" var="orderDetail"
                             id="DetailData"
                             styleClass="FOXY_ORDER_DETAIL"
                             headerClass="FOXY_ORDER_DETAIL_HEADER"
                             footerClass="FOXY_ORDER_DETAIL_HEADER"                    
                             rowGroupStyleClass="FOX_ROW_GROUP"
                             rowGroupStyle="font-weight: bold;"
                             preserveDataModel="true"
                             cellspacing="0">
                    
                    <%-- Lot --%>
                    <t:column groupBy="true" width="2%">
                        <f:facet name="header">
                            <h:outputText value="Lot" />
                        </f:facet>
                        <h:outputText value="#{orderDetail.lotS}"/>
                    </t:column>
                    
                    <%-- No --%>
                    <t:column width="6%" styleClass="FOXY_ORDER_DETAIL_COL_L">
                        <f:facet name="header">
                            <h:outputText value="No" />
                        </f:facet>
                        <%--h:outputText value="#{orderDetail.lotD}" /--%>
                        <h:commandLink id="lotD" 
                                       action="#{foxyShipping.enqadd}" value="#{orderDetail.lotD}">
                            <f:param name="orderid" value="#{foxyOrderPO.orderId}"/>
                            <f:param name="refIdC" value="#{orderDetail.refIdC}"/>
                            <f:param name="refIdSp" value="#{orderDetail.refIdSp}"/>
                            <f:param name="month" value="#{orderDetail.month}"/>
                            <f:param name="location" value="#{orderDetail.location}"/>
                            <f:param name="subLocation" value="#{orderDetail.subLocation}"/>
                        </h:commandLink>
                        
                    </t:column>
                    
                    <%-- Category >
                    <t:column width="6%">
                    <f:facet name="header">
                    <h:outputText value="Category" />
                    </f:facet>
                    <h:outputText value="#{orderDetail.category}" />
                    </t:column--%>
                    
                    <%-- PO Number --%>
                    <t:column width="6%" styleClass="FOXY_ORDER_DETAIL_COL_L">
                        <f:facet name="header">
                            <h:outputText value="PO No" />
                        </f:facet>
                        <h:outputText value="#{orderDetail.poNumber}" />
                    </t:column>
                    
                    <%-- Invoice --%>
                    <t:column width="6%" styleClass="FOXY_ORDER_DETAIL_COL_L">
                        <f:facet name="header">
                            <h:outputText value="Invoice" />
                        </f:facet>
                        <h:outputText value="#{orderDetail.invoice}">
                        </h:outputText>
                    </t:column>
                    
                    <%-- LC Number --%>
                    <t:column width="6%" styleClass="FOXY_ORDER_DETAIL_COL_L">
                        <f:facet name="header">
                            <h:outputText value="LC No" />
                        </f:facet>
                        <h:outputText value="#{orderDetail.lcNumber}">
                        </h:outputText>
                    </t:column>
                    
                    <%-- Destination --%>
                    <t:column width="6%" styleClass="FOXY_ORDER_DETAIL_COL_L">
                        <f:facet name="header">
                            <h:outputText value="Destination" />
                        </f:facet>
                        <h:outputText value="#{orderDetail.destName}">
                        </h:outputText>
                    </t:column>
                    
                    <%-- ETD --%>
                    <t:column width="4%" styleClass="FOXY_ORDER_DETAIL_COL_L">
                        <f:facet name="header">
                            <h:outputText value="ETD" />
                        </f:facet>
                        <h:outputText value="#{orderDetail.etd}">
                            <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                        </h:outputText>
                    </t:column>
                    
                    <%-- ETA --%>
                    <t:column width="4%" styleClass="FOXY_ORDER_DETAIL_COL_L">
                        <f:facet name="header">
                            <h:outputText value="ETA" />
                        </f:facet>
                        <h:outputText value="#{orderDetail.eta}">
                            <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                        </h:outputText>
                    </t:column>
                    
                    <%-- Amount --%>
                    <t:column width="5%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">                                                    
                                <h:outputText value="Amount"/>
                            </h:panelGrid>
                        </f:facet>
                        <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                     cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">                                                
                            <h:outputText value="#{orderDetail.amount}">
                            </h:outputText>
                        </h:panelGrid>
                    </t:column>                    
                    
                    <%-- Quantity DZN --%>
                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">                              
                                <h:outputText value="Qty (DZN)" />
                            </h:panelGrid>
                        </f:facet>
                        <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                     cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">                                                    
                            <h:outputText value="#{orderDetail.quantityDzn}">
                                <f:convertNumber pattern="#.00"/>
                            </h:outputText>
                        </h:panelGrid>
                    </t:column>
                    
                    <%-- Quantity PCS --%>
                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">  
                                <h:outputText value="Qty (PCS)" />
                            </h:panelGrid>
                        </f:facet>
                        <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                     cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">                                                
                            <h:outputText value="#{orderDetail.quantityPcs}">
                                <f:convertNumber pattern="#.00"/>
                            </h:outputText>
                        </h:panelGrid>
                    </t:column>
                    
                    <%-- CTN --%>
                    <t:column width="6%" styleClass="FOXY_ORDER_DETAIL_COL_L">
                        <f:facet name="header">
                            <h:outputText value="CTN" />
                        </f:facet>
                        <h:outputText value="#{orderDetail.ctn}" />
                    </t:column>
                    
                    <%-- Vessel --%>
                    <t:column width="5%" styleClass="FOXY_ORDER_DETAIL_COL_L">
                        <f:facet name="header">
                            <h:outputText value="Vessel" />
                        </f:facet>
                        <h:outputText value="#{orderDetail.vessel}">
                        </h:outputText>
                    </t:column>
                    
                    <%-- Voyage --%>
                    <t:column width="5%" styleClass="FOXY_ORDER_DETAIL_COL_L">
                        <f:facet name="header">
                            <h:outputText value="Voyage" />
                        </f:facet>
                        <h:outputText value="#{orderDetail.voyage}">
                        </h:outputText>
                    </t:column>
                    
                    <%-- Vessel Date --%>
                    <t:column width="6%" styleClass="FOXY_ORDER_DETAIL_COL_L">
                        <f:facet name="header">
                            <h:outputText value="Vsl Date"/>                                
                        </f:facet>
                        <h:outputText value="#{orderDetail.vesselDate}">
                            <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                        </h:outputText>
                    </t:column>
                    
                </t:dataTable>
            </h:panelGrid>
        </h:form>
    </h:panelGrid>            
    <%-- End of Enquiry --%>    
            
    <%-- Begin of Search--%>
    <%-- End of Search--%>
            
    <%-- Begin of Listing--%>
    <%-- End of Listing--%>

    <%@ include file="foxyFooter.jsp" %>
</f:view>
