<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%@taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<%@taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@taglib uri="https://ajax4jsf.dev.java.net/ajax" prefix="a4j"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<f:view>
    <%@ include file="foxyHeader.jsp" %>
    
    
    <%-- This save state required to ensure variable value available for rebuild list during  
    Without save state, list will be empty and will get "Value is not a valid option" error message when submit form--%> 
    <t:saveState value="#{foxySalesInvoiceDetail.orderId}"/>
    <t:saveState value="#{foxySalesInvoiceDetail.sumRefId}"/>
    
    
    <h:messages errorClass="FOX_ERROR" showDetail="true" showSummary="true"/>
    
    <%-- Panel for Assign --%>
    <h:panelGrid id="AssignGrid" styleClass="tablebg" width="100%">
        <h:panelGrid id="AssignInput1" columns="2" columnClasses="FOX_LABEL_COL_2, FOX_INPUT_COL_2" width="100%">
            <h:panelGroup>
                <h:outputText value="Sales Invoice Detail" styleClass="smalltitle" />
            </h:panelGroup>
        </h:panelGrid>
        <h:form id="AssignForm" rendered="true">
            <%-- First, Slipt the screen into two equal size column --%>
            <h:panelGrid columns="2" columnClasses="FOXY_SCREEN_2COL,FOXY_SCREEN_2COL" width="100%" cellpadding="0" cellspacing="0" border="0" frame="none" rules="none">
                
                <%-- START column 1 --%>
                <h:panelGrid id="AssignInputcol1" columns="2" columnClasses="FOX_LABEL_COL_2, FOX_INPUT_COL_2" width="100%">
                    <%-- START column 1 --%>                
                    
                    <!-- ==================== Input Filed for [Supplier Code] --START-- ========================= -->
                    <t:outputLabel for="V_InvoiceNo" value="Invoice No:" />
                    <h:panelGroup>
                        <t:inputTextHelp id="V_InvoiceNo" styleClass="FOX_INPUT_RO"
                                         helpText="Text"
                                         maxlength="20" size="20" required="true"
                                         value="#{foxySalesInvoiceDetail.salesInvoiceBean.invno}">
                        </t:inputTextHelp>
                    </h:panelGroup>
                    <!-- ==================== Input Filed for [Supplier Code] --END  -- ========================= -->
                                   
                    
                    <t:outputLabel for="V_Date" value="Invoice Date:" />                    
                    <h:inputText id="V_Date" styleClass="FOX_INPUT_RO" readonly="true" size="30" value="#{foxySalesInvoiceDetail.salesInvoiceBean.invdate}">
                        <f:convertDateTime type="date" pattern="yyyyMMdd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                    </h:inputText>
                    
                    <!-- ==================== Input Filed for [Customer Code] --START-- ========================= -->
                    <t:outputLabel for="V_Customer_Code" value="Customer Name:" />
                    <h:inputText id="V_Customer_Code" value="#{foxySalesInvoiceDetail.salesInvoiceBean.custcode}"
                                 styleClass="FOX_INPUT_RO" required="true" immediate="false">
                    </h:inputText>
                    <!-- ==================== Input Filed for [Customer Code] --END  -- ========================= -->
                        
                    <!-- ==================== Input Filed for [Brand Code] --START-- ========================= -->
                    <t:outputLabel for="V_BrandCode" value="Buyer:" />
                    <h:inputText id="V_BrandCode" value="#{foxySalesInvoiceDetail.salesInvoiceBean.custbrand}"
                                 styleClass="FOX_INPUT_RO" required="false" immediate="false">
                    </h:inputText>
                    <!-- ==================== Input Filed for [Brand code] --END  -- ========================= -->

                        
                    <!-- ==================== Input Filed for [Division Code] --START-- ========================= -->
                    <t:outputLabel for="V_divcode" value="Destination:" />
                    <h:inputText id="V_divcode" value="#{foxySalesInvoiceDetail.salesInvoiceBean.destination}"
                                 styleClass="FOX_INPUT_RO" required="false" immediate="false">
                    </h:inputText>
                    <!-- ==================== Input Filed for [Division Code] --END  -- ========================= -->                                      

                    <h:outputText value="FOB Value:" />
                    <h:panelGroup>
                        <h:outputText id="V_FOBValue" styleClass="FOX_INPUT_RO" value="#{foxySalesInvoiceDetail.salesInvoiceBean.fobval}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>                            
                        </h:outputText>
                    </h:panelGroup>                    
                    
                    <h:outputText value="CMT Value:" />
                    <h:panelGroup>
                        <h:outputText id="V_CMTValue" styleClass="FOX_INPUT_RO" value="#{foxySalesInvoiceDetail.salesInvoiceBean.cmtval}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>
                    </h:panelGroup>
                    
                    <h:outputText value="Revenue:" />
                    <h:panelGroup>
                        <h:outputText id="V_Revenue" styleClass="FOX_INPUT_RO" value="#{foxySalesInvoiceDetail.salesInvoiceBean.revenue}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>                            
                        </h:outputText>
                    </h:panelGroup>                                        
                    
                    <h:outputText value="Currency:" />
                    <h:inputText id="V_Currency" styleClass="FOX_INPUT_RO" required="true" value="#{foxySalesInvoiceDetail.salesInvoiceBean.currency}">
                    </h:inputText>
                    
                    <%-- --%>
                    <h:outputText value="FOB in SGD:" />
                    <h:panelGroup>
                        <h:outputText id="V_FOBbasevalue" style="background-color: #ffff00;"  styleClass="FOX_INPUT_RO"  
                                      value="#{foxySalesInvoiceDetail.salesInvoiceBean.fobbaseval}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>
                    </h:panelGroup>                                                                                                                        
                    
                    <h:outputText value="CMT in SGD:" />
                    <h:panelGroup>
                        <h:outputText id="V_CMTbasevalue" style="background-color: #ffff00;"  styleClass="FOX_INPUT_RO" 
                                      value="#{foxySalesInvoiceDetail.salesInvoiceBean.cmtbaseval}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>                                         
                        </h:outputText>
                    </h:panelGroup>
                    
                    <h:outputText value="Revenue in SGD:" />
                    <h:panelGroup>
                        <h:outputText id="V_RevenueBaseVal" style="background-color: #ffff00;"  styleClass="FOX_INPUT_RO" 
                                      value="#{foxySalesInvoiceDetail.salesInvoiceBean.revenuebaseval}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>
                    </h:panelGroup>                                                
                    
                    <t:outputLabel for="V_ShipmentType" value="Ship Mode:" />
                    <h:inputText id="V_ShipmentType" styleClass="FOX_INPUT_RO" required="false" value="#{foxySalesInvoiceDetail.salesInvoiceBean.shipmode}">
                    </h:inputText>
                    
                    <t:outputLabel for="V_Vessel" value="Vessel/FLT:" />
                    <h:inputText id="V_Vessel" styleClass="FOX_INPUT_RO" required="false" value="#{foxySalesInvoiceDetail.salesInvoiceBean.vessel}">
                    </h:inputText>                    
                    
                    <t:outputLabel for="V_StyleCode" value="StyleCode:" />
                    <h:panelGroup>
                        <h:inputText id="V_StyleCode" styleClass="FOX_INPUT_RO" value="#{foxySalesInvoiceDetail.salesInvoiceBean.stylecode}" maxlength="30" 
                                     size="30" required="false">
                        </h:inputText>
                    </h:panelGroup>                                                
                    
                    
                    <t:outputLabel for="V_RefDoc" value="Chutex Inv:" />
                    <h:panelGroup>
                        <h:inputText id="V_RefDoc" styleClass="FOX_INPUT_RO" value="#{foxySalesInvoiceDetail.salesInvoiceBean.refdoc}" maxlength="25" 
                                     size="25" required="false">
                        </h:inputText>
                    </h:panelGroup>                                                
                    
                    <h:outputText value="Currency Rate:" />
                    <h:outputText id="forexRateStr" styleClass="FOX_ERROR" value="#{foxySalesInvoiceDetail.forexRateStr}" />
                    
                    <h:commandButton id="gotolist" value="Back To List" action="#{foxySalesInvoiceDetail.gotolist}" immediate="true" />
                </h:panelGrid>
                
                <%-- END column 1 --%>
                
                <%-- START column 2 --%>
                <h:panelGrid id="AssignInputcol2" columns="2" columnClasses="FOX_LABEL_COL_2, FOX_INPUT_COL_2" width="100%">
                    
                    <t:outputLabel for="refNumber" value="Ref. Number:" />
                    <a4j:region id="ajaxregion1" renderRegionOnly="false" selfRendered="true">
                        <h:inputText id="refNumber" styleClass="FOX_INPUT" readonly="false" size="30" value="#{foxySalesInvoiceDetail.orderId}">
                            <a4j:support event="onblur" reRender="lotId" ajaxSingle="true"/>
                        </h:inputText>
                    </a4j:region>
                    
                    <t:outputLabel for="lotId" value="Lot Id:" />
                    <h:panelGroup>
                        <h:selectOneMenu id="lotId" styleClass="FOX_INPUT" value="#{foxySalesInvoiceDetail.sumRefId}"
                                         style="width:220px; height:25px "  required="true" immediate="true"> 
                            <f:selectItems value="#{foxySalesInvoiceDetail.osList}"/>
                        </h:selectOneMenu>
                        <a4j:status for="ajaxregion1">
                            <f:facet name="start">
                                <h:graphicImage value="/images/ajaxstart.gif"  height="12" width="12"/>
                            </f:facet>
                            <f:facet name="stop">
                                <%-- h:graphicImage value="/images/ajax_stoped.gif" / --%>
                            </f:facet>
                        </a4j:status>                                                                        
                    </h:panelGroup>
                    
                    <t:outputLabel for="lotidship" value="LotID(Ship):" />
                    <h:panelGroup>
                        <t:inputTextHelp id="lotidship" styleClass="FOX_INPUT"
                                         helpText="Text"
                                         maxlength="16" size="16" required="false"
                                         value="#{foxySalesInvoiceDetail.salesInvoiceDetailBean.lotid}">
                        </t:inputTextHelp>
                        <h:message errorClass="FOX_ERROR" for="lotidship" showDetail="true" showSummary="true"/>
                    </h:panelGroup>                    
                    
                    
                    <t:outputLabel for="PONUM" value="PO No:" />
                    <h:panelGroup>
                        <t:inputTextHelp id="PONUM" styleClass="FOX_INPUT"
                                         helpText="Text"
                                         maxlength="30" size="30" required="true"
                                         value="#{foxySalesInvoiceDetail.salesInvoiceDetailBean.ponumber}">
                        </t:inputTextHelp>
                        <h:message errorClass="FOX_ERROR" for="PONUM" showDetail="true" showSummary="true"/>
                    </h:panelGroup>                                                            
                    
                    <t:outputLabel for="QtyCtns" value="Qty(CTNS):" />
                    <h:panelGroup>
                        <t:inputTextHelp id="QtyCtns" styleClass="FOX_INPUT"
                                         helpText="999999"
                                         maxlength="6" size="6" required="false"
                                         value="#{foxySalesInvoiceDetail.salesInvoiceDetailBean.qtyctns}">
                        </t:inputTextHelp>
                        <h:message errorClass="FOX_ERROR" for="QtyCtns" showDetail="true" showSummary="true"/>
                    </h:panelGroup>                    
                    
                    
                    <t:outputLabel for="QtyPcs" value="Qty(PCS):" />
                    <h:panelGroup>
                        <t:inputTextHelp id="QtyPcs" styleClass="FOX_INPUT"
                                         helpText="999999"
                                         maxlength="6" size="6" required="true"
                                         value="#{foxySalesInvoiceDetail.salesInvoiceDetailBean.qtypcs}">
                        </t:inputTextHelp>
                        <h:message errorClass="FOX_ERROR" for="QtyPcs" showDetail="true" showSummary="true"/>
                    </h:panelGroup>                    
                    
                    
                    <t:outputLabel for="ETDDate" value="ETD Date:" />
                    <h:panelGroup>
                        <t:inputCalendar id="ETDDate" styleClass="FOX_INPUT" value="#{foxySalesInvoiceDetail.salesInvoiceDetailBean.etd}"  
                                         required="true"
                                         popupDateFormat="yyyyMMdd" renderAsPopup="true">
                        </t:inputCalendar>  
                        <h:message errorClass="FOX_ERROR" for="ETDDate" showDetail="true" showSummary="true"/>
                    </h:panelGroup>                                                            
                    
                    <t:outputLabel for="FOBVAL" value="FOB:" />
                    <h:panelGroup>
                        <t:inputTextHelp id="FOBVAL" styleClass="FOX_INPUT"
                                         helpText="99999999.99"
                                         maxlength="11" size="11" required="true"
                                         value="#{foxySalesInvoiceDetail.salesInvoiceDetailBean.fobval}">
                        </t:inputTextHelp>
                        <h:message errorClass="FOX_ERROR" for="FOBVAL" showDetail="true" showSummary="true"/>
                    </h:panelGroup>                    
                    
                    <t:outputLabel for="CMTUPrx" value="CMT Unit Price" />
                    <h:panelGroup>
                        <t:inputTextHelp id="CMTUPrx" styleClass="FOX_INPUT"
                                         helpText="99.99"
                                         maxlength="5" size="5" required="true"
                                         value="#{foxySalesInvoiceDetail.salesInvoiceDetailBean.cmtuprc}">
                        </t:inputTextHelp>
                        <h:message errorClass="FOX_ERROR" for="CMTUPrx" showDetail="true" showSummary="true"/>
                    </h:panelGroup>                                        
                    
                    <t:outputLabel for="CMTVAL" value="CMT:" />
                    <h:panelGroup>
                        <t:inputTextHelp id="CMTVAL" styleClass="FOX_INPUT"
                                         helpText="99999999.99"
                                         maxlength="11" size="11" required="false"
                                         value="#{foxySalesInvoiceDetail.salesInvoiceDetailBean.cmtval}">
                        </t:inputTextHelp>
                        <h:message errorClass="FOX_ERROR" for="CMTVAL" showDetail="true" showSummary="true"/>
                    </h:panelGroup>                                        
                    
                    <t:outputLabel for="Revenue" value="Revenue:" />
                    <h:panelGroup>
                        <t:inputTextHelp id="Revenue" styleClass="FOX_INPUT"
                                         helpText="99999999.99"
                                         maxlength="11" size="11" required="true"
                                         value="#{foxySalesInvoiceDetail.salesInvoiceDetailBean.revenue}">
                        </t:inputTextHelp>
                        <h:message errorClass="FOX_ERROR" for="Revenue" showDetail="true" showSummary="true"/>
                    </h:panelGroup>                                        
                    
                    <t:outputLabel for="PayDate" value="Pay Date:" />
                    <h:panelGroup>
                        <t:inputCalendar id="PayDate" styleClass="FOX_INPUT" value="#{foxySalesInvoiceDetail.salesInvoiceDetailBean.paydate}"  
                                         required="false"
                                         popupDateFormat="yyyyMMdd" renderAsPopup="true">
                        </t:inputCalendar>  
                        <h:message errorClass="FOX_ERROR" for="PayDate" showDetail="true" showSummary="true"/>
                    </h:panelGroup>                                                            
                    
                    <t:outputLabel for="Remarks" value="Remarks:" />
                    <h:panelGroup>
                        <h:inputText id="Remarks" styleClass="FOX_INPUT" value="#{foxySalesInvoiceDetail.salesInvoiceDetailBean.remarks}" maxlength="128" 
                                     size="50" required="false">
                        </h:inputText>
                        <h:message errorClass="FOX_ERROR" for="Remarks" showDetail="true" showSummary="true"/>
                    </h:panelGroup>                                                
                    
                    
                </h:panelGrid>
                <%-- END column 2 --%>
            </h:panelGrid>
            
            <h:panelGrid id="AddButton" columns="1" columnClasses="FOX_BUTTON" width="100%" >
                <h:panelGroup>
                    <h:commandButton id="SaveAssignment" value="Save" action="#{foxySalesInvoiceDetail.saveUpd}"/>
                    <h:commandButton id="AddAssignmentbtm" value="Add" action="#{foxySalesInvoiceDetail.saveAdd}" />
                </h:panelGroup>
            </h:panelGrid>
        </h:form>
        
        
        <h:form id="InventoryDetailForm">
            <h:panelGrid id="ListDisplay" columns="1" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="100%">
                <t:dataTable id="DetailData"
                             binding="#{foxySalesInvoiceDetail.foxyTable}"
                             headerClass="FOXY_ORDER_DETAIL_HEADER"
                             footerClass="FOXY_ORDER_DETAIL_HEADER"
                             rowClasses="standardTable_Row1,standardTable_Row2"
                             columnClasses="standardTable_Column,standardTable_ColumnCentered,standardTable_Column"
                             var="salesInvDetail"
                             value="#{foxySalesInvoiceDetail.salesInvoiceDetail}"
                             preserveDataModel="true"
                             rows="2000" width="100%">
                    
                    <t:column width="10%">
                        <f:facet name="header">
                            <h:outputText value="Ref. Number" />
                        </f:facet>
                        
                        <h:commandLink id="linksassign" 
                                       value="#{salesInvDetail.refno}#{salesInvDetail.lotid}"   
                                       action="#{foxySalesInvoiceDetail.updateAssignment}" immediate="true">
                            <t:updateActionListener property="#{foxySessionData.pageParameterLong2}" value="#{salesInvDetail.saleinvdetailid}"/>                                           
                        </h:commandLink>
                    </t:column>
                    
                    
                    <t:column width="5%">
                        <f:facet name="header">
                            <h:outputText value="Delete" />
                        </f:facet>
                        
                        <h:commandLink id="deletelinks" 
                                       value="Delete"
                                       rendered="#{salesInvDetail.lotid != null}"
                                       action="#{foxySalesInvoiceDetail.delete}" immediate="true"
                                       onclick="if(!confirm('Are you sure want to delete?')) return false">
                            <t:updateActionListener property="#{foxySessionData.pageParameterLong2}" value="#{salesInvDetail.saleinvdetailid}"/>                                           
                        </h:commandLink>
                    </t:column>
                    
                    
                    <t:column width="10%">
                        <f:facet name="header">
                            <h:outputText value="PO Number" />
                        </f:facet>
                        <h:outputText value="#{salesInvDetail.ponumber}">
                        </h:outputText>
                    </t:column>                    
                    
                    <t:column width="5%"  styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="CMT U/P" />
                            </h:panelGrid>                            
                        </f:facet>
                        <h:outputText value="#{salesInvDetail.cmtuprc}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>
                    </t:column>                       
                    
                    <t:column width="10%"  styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="Qty (PCS)" />
                            </h:panelGrid>                            
                        </f:facet>
                        <h:outputText value="#{salesInvDetail.qtypcs}" rendered="#{salesInvDetail.lotid != null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>
                        
                        <h:outputText value="#{salesInvDetail.qtypcs}" rendered="#{salesInvDetail.lotid == null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>                        
                    </t:column>   
                    
                    <t:column width="10%"  styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="Qty (Ctns)" />
                            </h:panelGrid>                            
                        </f:facet>
                        <h:outputText value="#{salesInvDetail.qtyctns}" rendered="#{salesInvDetail.lotid != null}">
                            <f:convertNumber minFractionDigits="0" maxFractionDigits="0"/>
                        </h:outputText>
                        
                        <h:outputText value="#{salesInvDetail.qtyctns}" rendered="#{salesInvDetail.lotid == null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <f:convertNumber minFractionDigits="0" maxFractionDigits="0"/>
                        </h:outputText>                        
                    </t:column>   
                    
                    
                    <t:column width="10%"  styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="FOB (#{foxySalesInvoiceDetail.salesInvoiceBean.currency})" />
                            </h:panelGrid>                            
                        </f:facet>
                        <h:outputText value="#{salesInvDetail.fobval}" rendered="#{salesInvDetail.lotid != null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>
                        
                        <h:outputText value="#{salesInvDetail.fobval}" rendered="#{salesInvDetail.lotid == null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>                        
                    </t:column>   
                    
                    <t:column width="10%"  styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="CMT (#{foxySalesInvoiceDetail.salesInvoiceBean.currency})" />
                            </h:panelGrid>                            
                        </f:facet>
                        <h:outputText value="#{salesInvDetail.cmtval}" rendered="#{salesInvDetail.lotid != null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>
                        
                        <h:outputText value="#{salesInvDetail.cmtval}" rendered="#{salesInvDetail.lotid == null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>                        
                    </t:column>                 
                    
                    
                    <t:column width="10%"  styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="Revenue (#{foxySalesInvoiceDetail.salesInvoiceBean.currency})" />
                            </h:panelGrid>                            
                        </f:facet>
                        <h:outputText value="#{salesInvDetail.revenue}" rendered="#{salesInvDetail.lotid != null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>
                        
                        <h:outputText value="#{salesInvDetail.revenue}" rendered="#{salesInvDetail.lotid == null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>                        
                    </t:column>   
                    
                    
                    
                    
                    
                    <t:column width="10%"  styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="FOB (SGD)" />
                            </h:panelGrid>                            
                        </f:facet>
                        <h:outputText value="#{salesInvDetail.fobvalBase}" rendered="#{salesInvDetail.lotid != null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>
                        
                        <h:outputText value="#{salesInvDetail.fobvalBase}" rendered="#{salesInvDetail.lotid == null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>                        
                    </t:column>   
                    
                    <t:column width="10%"  styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="CMT (SGD)" />
                            </h:panelGrid>                            
                        </f:facet>
                        <h:outputText value="#{salesInvDetail.cmtvalBase}" rendered="#{salesInvDetail.lotid != null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>
                        
                        <h:outputText value="#{salesInvDetail.cmtvalBase}" rendered="#{salesInvDetail.lotid == null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>                        
                    </t:column>                 
                    
                    
                    <t:column width="10%"  styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="Revenue (SGD)" />
                            </h:panelGrid>                            
                        </f:facet>
                        <h:outputText value="#{salesInvDetail.revenueBase}" rendered="#{salesInvDetail.lotid != null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>
                        
                        <h:outputText value="#{salesInvDetail.revenueBase}" rendered="#{salesInvDetail.lotid == null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>                        
                    </t:column>   
                    
                    
                    
                </t:dataTable>
                
                <%--
                <h:panelGrid columns="1" styleClass="scrollerTable2" columnClasses="standardTable_ColumnCentered" >
                    <t:dataScroller id="scroll_1"
                                    for="DetailData"
                                    fastStep="10"
                                    pageCountVar="pageCount"
                                    pageIndexVar="pageIndex"
                                    styleClass="scroller"
                                    paginator="true"
                                    paginatorMaxPages="9"
                                    paginatorTableClass="paginator"
                                    paginatorActiveColumnStyle="font-weight:bold;"
                                    immediate="true"
                    >
                        <f:facet name="first" >
                            <t:graphicImage url="../images/arrow-first.gif" border="1" />
                        </f:facet>
                        <f:facet name="last">
                            <t:graphicImage url="../images/arrow-last.gif" border="1" />
                        </f:facet>
                        <f:facet name="previous">
                            <t:graphicImage url="../images/arrow-previous.gif" border="1" />
                        </f:facet>
                        <f:facet name="next">
                            <t:graphicImage url="../images/arrow-next.gif" border="1" />
                        </f:facet>
                        <f:facet name="fastforward">
                            <t:graphicImage url="../images/arrow-ff.gif" border="1" />
                        </f:facet>
                        <f:facet name="fastrewind">
                            <t:graphicImage url="../images/arrow-fr.gif" border="1" />
                        </f:facet>
                    </t:dataScroller>
                    <t:dataScroller id="scroll_2"
                                    for="DetailData"
                                    rowsCountVar="rowsCount"
                                    displayedRowsCountVar="displayedRowsCountVar"
                                    firstRowIndexVar="firstRowIndex"
                                    lastRowIndexVar="lastRowIndex"
                                    pageCountVar="pageCount"
                                    immediate="true"
                                    pageIndexVar="pageIndex"
                    >
                        <h:outputFormat value="Testing Total Rec {0}, DispayRowCount {1}, First row index {2}, last row index {3} pageindex {4}, pagecount {5}" styleClass="standard" >
                            <f:param value="#{rowsCount}" />
                            <f:param value="#{displayedRowsCountVar}" />
                            <f:param value="#{firstRowIndex}" />
                            <f:param value="#{lastRowIndex}" />
                            <f:param value="#{pageIndex}" />
                            <f:param value="#{pageCount}" />
                        </h:outputFormat>
                    </t:dataScroller>
                </h:panelGrid>                
                --%>
                
            </h:panelGrid>
        </h:form>
    </h:panelGrid>            
    <%-- End of Assign--%>    

    <%@ include file="foxyFooter.jsp" %>
</f:view>
