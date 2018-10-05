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
    <t:saveState value="#{foxySalesInvoice.editSalesInvoiceBean.currency}"/> 
    <t:saveState value="#{foxySalesInvoice.editSalesInvoiceBean.invdate}"/> 
    <t:saveState value="#{foxySalesInvoice.editSalesInvoiceBean.cmtval}"/> 
    <t:saveState value="#{foxySalesInvoice.editSalesInvoiceBean.fobval}"/> 
    <t:saveState value="#{foxySalesInvoice.editSalesInvoiceBean.revenue}"/> 
    <t:saveState value="#{foxySalesInvoice.tmpForexRate}"/> 
    
    <h:messages errorClass="FOX_ERROR" showDetail="true" showSummary="true"/>
    
    
    
    <h:panelGrid id="EditSalesInvGrid" styleClass="tablebg" width="100%">
        <h:outputText value="Edit Sales Invoice" styleClass="smalltitle" />
        <h:form id="EditSaleInvForm">
            <h:panelGrid id="enq" columns="2" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="50%">
                
                <!-- ==================== Input Filed for [Supplier Code] --START-- ========================= -->
                <t:outputLabel for="InvoiceNo" value="Invoice No:" />
                <h:panelGroup>
                    <t:inputTextHelp id="InvoiceNo" styleClass="FOX_INPUT"
                                     helpText="Text"
                                     maxlength="20" size="20" required="true"
                                     value="#{foxySalesInvoice.editSalesInvoiceBean.invno}">
                    </t:inputTextHelp>
                    <h:message errorClass="FOX_ERROR" for="InvoiceNo" showDetail="true" showSummary="true"/>
                </h:panelGroup>
                <!-- ==================== Input Filed for [Supplier Code] --END  -- ========================= -->
                                     
                <t:outputLabel for="Date" value="Invoice Date:" />
                <h:panelGroup>
                    <a4j:region id="a4j_invDate" renderRegionOnly="false" selfRendered="true">
                        <t:inputCalendar id="Date" styleClass="FOX_INPUT" value="#{foxySalesInvoice.editSalesInvoiceBean.invdate}"  popupDateFormat="yyyyMMdd" renderAsPopup="true">
                            <a4j:support id="ajinvdate" event="onchange" action="#{foxySalesInvoice.onCurCodeChange}" 
                                         reRender="CMTbasevalue,FOBbasevalue,RevenueBaseVal,forexRateStr" ajaxSingle="true">
                            </a4j:support>                                                                                                         
                        </t:inputCalendar>  
                        <h:message errorClass="FOX_ERROR" for="Date" showDetail="true" showSummary="true"/>
                    </a4j:region>
                </h:panelGroup>
                
                <!-- ==================== Input Filed for [Customer Code] --START-- ========================= -->
                <t:outputLabel for="Customer_Code" value="Customer Name:" />
                <h:panelGroup >
                    <h:selectOneMenu id="Customer_Code" value="#{foxySalesInvoice.editSalesInvoiceBean.custcode}"
                                     styleClass="FOX_INPUT" required="true" immediate="false">
                        <f:selectItems value="#{listData.customerList}"/>
                    </h:selectOneMenu>
                    <h:message errorClass="FOX_ERROR" for="Customer_Code" showDetail="true" showSummary="true"/>
                </h:panelGroup>
                <!-- ==================== Input Filed for [Customer Code] --END  -- ========================= -->
                        
                <!-- ==================== Input Filed for [Brand Code] --START-- ========================= -->
                <t:outputLabel for="BrandCode" value="Buyer:" />
                <h:panelGroup >
                    <t:inputTextHelp id="BrandCode" styleClass="FOX_INPUT"
                                     helpText="Text"
                                     maxlength="10" size="10" required="false" 
                                     value="#{foxySalesInvoice.editSalesInvoiceBean.custbrand}">
                    </t:inputTextHelp>
                    <h:message errorClass="FOX_ERROR" for="BrandCode" showDetail="true" showSummary="true"/>
                </h:panelGroup>
                <!-- ==================== Input Filed for [Brand code] --END  -- ========================= -->

                        
                <!-- ==================== Input Filed for [Division Code] --START-- ========================= -->
                <t:outputLabel for="divcode" value="Destination:" />
                <h:panelGroup >
                    <t:inputTextHelp id="divcode" styleClass="FOX_INPUT"
                                     helpText="Text"
                                     maxlength="25" size="25" required="false" 
                                     value="#{foxySalesInvoice.editSalesInvoiceBean.destination}">
                    </t:inputTextHelp>
                    <h:message errorClass="FOX_ERROR" for="divcode" showDetail="true" showSummary="true"/>
                </h:panelGroup>
                <!-- ==================== Input Filed for [Division Code] --END  -- ========================= -->                                      
                                                
                <t:outputLabel for="FOBValue" value="FOB Value:" />
                <h:panelGroup>
                    <a4j:region id="a4j_invValue1" renderRegionOnly="false" selfRendered="true">
                        <h:inputText id="FOBValue" styleClass="FOX_INPUT" maxlength="12" size="15" required="true" value="#{foxySalesInvoice.editSalesInvoiceBean.fobval}">
                            <a4j:support id="ajinvValue1" event="onchange" action="#{foxySalesInvoice.onCurCodeChange}" 
                                         reRender="FOBbasevalue" ajaxSingle="true">
                            </a4j:support>                                                                                                                                         
                        </h:inputText>
                        <h:message errorClass="FOX_ERROR" for="FOBValue" showDetail="true" showSummary="true"/>
                    </a4j:region>
                </h:panelGroup>
                
                <t:outputLabel for="CMTValue" value="CMT Value:" />
                <h:panelGroup>
                    <a4j:region id="a4j_invValue2" renderRegionOnly="false" selfRendered="true">
                        <h:inputText id="CMTValue" styleClass="FOX_INPUT" maxlength="12" size="15" required="false" value="#{foxySalesInvoice.editSalesInvoiceBean.cmtval}">
                            <a4j:support id="ajinvValue2" event="onchange" action="#{foxySalesInvoice.onCurCodeChange}" 
                                         reRender="CMTbasevalue" ajaxSingle="true">
                            </a4j:support>                                                                                                                                         
                        </h:inputText>
                        <h:message errorClass="FOX_ERROR" for="CMTValue" showDetail="true" showSummary="true"/>
                    </a4j:region>
                </h:panelGroup>
                
                <t:outputLabel for="Revenue" value="Revenue:" />
                <h:panelGroup>
                    <a4j:region id="a4j_invValue4" renderRegionOnly="false" selfRendered="true">
                        <h:inputText id="Revenue" styleClass="FOX_INPUT" maxlength="12" size="15" required="true" value="#{foxySalesInvoice.editSalesInvoiceBean.revenue}">
                            <a4j:support id="ajinvValue4" event="onchange" action="#{foxySalesInvoice.onCurCodeChange}" 
                                         reRender="RevenueBaseVal" ajaxSingle="true">
                            </a4j:support>                                                                                                                                         
                        </h:inputText>
                        <h:message errorClass="FOX_ERROR" for="Revenue" showDetail="true" showSummary="true"/>
                    </a4j:region>
                </h:panelGroup>
                
                
                
                <t:outputLabel for="Currency" value="Currency:" />
                <h:panelGroup>
                    <a4j:region id="ajaxregion2" renderRegionOnly="false" selfRendered="true">                            
                        <h:selectOneMenu id="Currency" styleClass="FOX_INPUT" required="true" value="#{foxySalesInvoice.editSalesInvoiceBean.currency}">
                            <f:selectItems value="#{listData.forexCurrencyList}"/>
                            <a4j:support id="ajcurcode" event="onchange" action="#{foxySalesInvoice.onCurCodeChange}" 
                                         reRender="CMTbasevalue,FOBbasevalue,RevenueBaseVal,forexRateStr" ajaxSingle="true">
                            </a4j:support>                                                                     
                        </h:selectOneMenu>
                    </a4j:region>
                    <h:message errorClass="FOX_ERROR" for="Currency" showDetail="true" showSummary="true"/>
                </h:panelGroup>
                
                <t:outputLabel for="FOBbasevalue" value="FOB in SGD:" />
                <h:panelGroup>
                    <h:inputText id="FOBbasevalue" style="background-color: #ffff00;"  styleClass="FOX_INPUT" maxlength="15" size="15" required="true" 
                                 value="#{foxySalesInvoice.editSalesInvoiceBean.fobbaseval}">
                    </h:inputText>
                    <t:outputText value="This field if auto-caculate, Empty means no Forex rate info"  styleClass="FOX_ERROR"/>
                    <a4j:status for="ajaxregion2">
                        <f:facet name="start">
                            <h:graphicImage value="/images/ajaxstart.gif" height="12" width="12"/>
                        </f:facet>
                        <f:facet name="stop">
                        </f:facet>
                    </a4j:status>                             
                    <h:message errorClass="FOX_ERROR" for="FOBbasevalue" showDetail="true" showSummary="true"/>
                </h:panelGroup>                                                                                                
                
                <%-- --%>
                <t:outputLabel for="CMTbasevalue" value="CMT in SGD:" />
                <h:panelGroup>
                    <h:inputText id="CMTbasevalue" style="background-color: #ffff00;"  styleClass="FOX_INPUT" maxlength="15" size="15" required="false" 
                                 value="#{foxySalesInvoice.editSalesInvoiceBean.cmtbaseval}">
                    </h:inputText>
                    <t:outputText value="This field if auto-caculate, Empty means no Forex rate info"  styleClass="FOX_ERROR"/>
                    <a4j:status for="ajaxregion2">
                        <f:facet name="start">
                            <h:graphicImage value="/images/ajaxstart.gif" height="12" width="12"/>
                        </f:facet>
                        <f:facet name="stop">
                        </f:facet>
                    </a4j:status>                             
                    <h:message errorClass="FOX_ERROR" for="CMTbasevalue" showDetail="true" showSummary="true"/>
                </h:panelGroup>
                
                <t:outputLabel for="RevenueBaseVal" value="Revenue in SGD:" />
                <h:panelGroup>
                    <h:inputText id="RevenueBaseVal" style="background-color: #ffff00;"  styleClass="FOX_INPUT" maxlength="15" size="15" required="true" 
                                 value="#{foxySalesInvoice.editSalesInvoiceBean.revenuebaseval}">
                    </h:inputText>
                    <t:outputText value="This field if auto-caculate, Empty means no Forex rate info"  styleClass="FOX_ERROR"/>
                    <a4j:status for="ajaxregion2">
                        <f:facet name="start">
                            <h:graphicImage value="/images/ajaxstart.gif" height="12" width="12"/>
                        </f:facet>
                        <f:facet name="stop">
                        </f:facet>
                    </a4j:status>                             
                    <h:message errorClass="FOX_ERROR" for="RevenueBaseVal" showDetail="true" showSummary="true"/>
                </h:panelGroup>                                                
                
                <t:outputLabel for="ShipmentType" value="Ship Mode:" />
                <h:panelGroup>
                    <h:selectOneMenu id="ShipmentType" styleClass="FOX_INPUT" required="false" value="#{foxySalesInvoice.editSalesInvoiceBean.shipmode}">
                        <f:selectItems value="#{listData.shipTypeList}"/>
                    </h:selectOneMenu>
                    <h:message errorClass="FOX_ERROR" for="ShipmentType" showDetail="true" showSummary="true"/>
                </h:panelGroup>                
                
                <t:outputLabel for="Vessel" value="Vessel/FLT:" />
                <h:panelGroup>
                    <h:inputText id="Vessel" styleClass="FOX_INPUT" value="#{foxySalesInvoice.editSalesInvoiceBean.vessel}" maxlength="25" 
                                 size="25" required="false">
                    </h:inputText>
                    <h:message errorClass="FOX_ERROR" for="Vessel" showDetail="true" showSummary="true"/>
                </h:panelGroup>                 
                
                <t:outputLabel for="StyleCode" value="StyleCode:" />
                <h:panelGroup>
                    <h:inputText id="StyleCode" styleClass="FOX_INPUT" value="#{foxySalesInvoice.editSalesInvoiceBean.stylecode}" maxlength="30" 
                                 size="30" required="false">
                    </h:inputText>
                    <h:message errorClass="FOX_ERROR" for="StyleCode" showDetail="true" showSummary="true"/>
                </h:panelGroup>                                                
                
                
                <t:outputLabel for="RefDoc" value="Chutex Inv:" />
                <h:panelGroup>
                    <h:inputText id="RefDoc" styleClass="FOX_INPUT" value="#{foxySalesInvoice.editSalesInvoiceBean.refdoc}" maxlength="25" 
                                 size="25" required="false">
                    </h:inputText>
                    <h:message errorClass="FOX_ERROR" for="RefDoc" showDetail="true" showSummary="true"/>
                </h:panelGroup>                                                
                
                <%-- --%>                            
                
                <t:outputLabel for="Remarks" value="Remarks:" />
                <h:panelGroup>
                    <h:inputText id="Remarks" styleClass="FOX_INPUT" value="#{foxySalesInvoice.editSalesInvoiceBean.remarks}" maxlength="128" 
                                 size="50" required="false">
                    </h:inputText>
                    <h:message errorClass="FOX_ERROR" for="Remarks" showDetail="true" showSummary="true"/>
                </h:panelGroup>                                                
                
                <h:outputText value="Currency Rate:" />
                <h:outputText id="forexRateStr" styleClass="FOX_ERROR" value="#{foxySalesInvoice.forexRateStr}" />                
            </h:panelGrid>
            
            
            <h:panelGrid id="SaveButton" columns="1" columnClasses="FOX_BUTTON" width="50%">
                <h:panelGroup>
                    <h:commandButton id="Save" value="Save" action="#{foxySalesInvoice.saveUpd}"/>
                    <h:inputHidden  value="#{foxySuccess.msg}"/>
                </h:panelGroup>
            </h:panelGrid>
            
        </h:form>
    </h:panelGrid>
    
    <%@ include file="foxyFooter.jsp" %>
</f:view>
