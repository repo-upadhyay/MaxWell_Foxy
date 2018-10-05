<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<%@taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@taglib uri="https://ajax4jsf.dev.java.net/ajax" prefix="a4j"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<f:view>
    <%@ include file="foxyHeader.jsp" %>
    
    <%-- Panel for Search --%>
    <h:panelGrid id="SearchGrid" styleClass="tablebg" rendered="#{not foxyQtyCheckListReports.list}" width="100%">
        <h:outputText value="Quantity Checklist" styleClass="smalltitle" />
        <h:form id="SearchForm">
            <h:panelGrid id="SearchInput" columns="2" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="50%">
                
                <t:outputLabel for="FromDate" value="Delivery Date From:" />
                <h:panelGroup>
                    <t:inputCalendar id="FromDate" required="true" styleClass="FOX_INPUT" value="#{foxyQtyCheckListReports.fromDate}"  
                                     popupDateFormat="yyyyMMdd" renderAsPopup="true" helpText="YYYYMMDD"/>
                    <h:message errorClass="FOX_ERROR" for="FromDate" showDetail="true" showSummary="true"/>
                </h:panelGroup>                        
                
                <t:outputLabel for="ToDate" value="To:" />
                <h:panelGroup>
                    <t:inputCalendar id="ToDate" required="true" styleClass="FOX_INPUT" value="#{foxyQtyCheckListReports.toDate}"  
                                     popupDateFormat="yyyyMMdd" renderAsPopup="true" helpText="YYYYMMDD"/>
                    <h:message errorClass="FOX_ERROR" for="ToDate" showDetail="true" showSummary="true"/>
                </h:panelGroup>
                
                <t:outputLabel for="Country" value="Country:" />
                <h:panelGroup>
                    <t:selectOneMenu id="Country" styleClass="FOX_INPUT" required="true" value="#{foxyQtyCheckListReports.country}">
                        <f:selectItems value="#{listData.countryList}"/>
                    </t:selectOneMenu>
                    <h:message errorClass="FOX_ERROR" for="Country" showDetail="true" showSummary="true"/>
                </h:panelGroup>          
                
                <h:commandButton id="Submit"  value="Submit" action="#{foxyQtyCheckListReports.search}"/>
            </h:panelGrid>
        </h:form>
    </h:panelGrid>
    <%-- End of Search--%>
            
    <%-- Panel for Listing --%>
    <h:panelGrid id="ListOrderGrid" styleClass="tablebg" rendered="#{foxyQtyCheckListReports.list}" width="100%">        
        <h:form id="ListReportForm">
            <h:outputText value="Quantity in red color if 10% different from order quantity" styleClass="FOX_HELPMSG"/> 
            <h:panelGrid id="Top" columns="1" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="100%">
                
                <h:outputText value="Quantity Checklist for #{foxyQtyCheckListReports.title}" styleClass="smalltitle" />
                
                <%--h:panelGroup>
                    <h:commandLink id="PrevMonth" value="<< Prev Month " action="#{foxyReport.PrevMonth}">
                        <f:param name="recordid" value="#{order.orderId}"/>
                    </h:commandLink>    
                    <h:outputText value="#{foxyReport.month}" />
                    <h:commandLink id="NextMonth" value=" Next Month >>" action="#{foxyReport.NextMonth}">
                        <f:param name="recordid" value="#{order.orderId}"/>
                    </h:commandLink>    
                </h:panelGroup--%>
            </h:panelGrid>
            <h:panelGrid id="ListDisplay" columns="1" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="100%">
                <t:dataTable value="#{foxyQtyCheckListReports.quantityCheckList}" var="qtyClReport"
                             id="DetailData"
                             styleClass="FOXY_REPORT_1"
                             headerClass="FOXY_REPORT_HEADER_1"
                             footerClass="FOXY_REPORT_HEADER_1"                    
                             preserveDataModel="false"
                             cellspacing="0"
                             rowClasses="FOXY_REPORT_ROW_1,FOXY_REPORT_ROW_2">
                    <%--rowClasses="FoxyOddRow,FoxyEvenRow"--%>
                    <t:column width="8%">
                        <f:facet name="header">
                            <h:outputText value="Ref No" />
                        </f:facet>
                        <h:outputText value="#{qtyClReport.orderId}#{qtyClReport.month}#{qtyClReport.location}" rendered="#{qtyClReport.month != null}"/>
                        <h:outputText styleClass="FOXY_REPORT_GRAND_TOTAL" value="#{qtyClReport.orderId}" rendered="#{qtyClReport.month == null}"/>
                        
                    </t:column>
                    
                    <t:column width="8%">
                        <f:facet name="header">
                            <h:outputText value="MR In-charge" />
                        </f:facet>
                        <h:outputText value="#{qtyClReport.merchandiser}"/>                        
                    </t:column>
                    
                    <t:column width="8%">
                        <f:facet name="header">
                            <h:outputText value="Created By" />
                        </f:facet>
                        <h:outputText value="#{qtyClReport.createdBy}"/>                        
                    </t:column>
                    
                    <t:column width="8%">
                        <f:facet name="header">
                            <h:outputText value="Last Upd By" />
                        </f:facet>
                        <h:outputText value="#{qtyClReport.lastupdBy}"/>                        
                    </t:column>                                        
                    
                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">                            
                                <h:outputText value="Order Qty (Pcs)" />
                            </h:panelGrid>                            
                            
                        </f:facet>
                        <h:outputText value="#{qtyClReport.ordQtyPcs}" rendered="#{qtyClReport.month != null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>
                        <h:outputText styleClass="FOXY_REPORT_GRAND_TOTAL" value="#{qtyClReport.ordQtyPcs}" rendered="#{qtyClReport.month == null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>                        
                    </t:column>                                        
                    
                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">                            
                                <h:outputText value="M.R. Qty (Pcs)" />
                            </h:panelGrid>
                            
                        </f:facet>
                        <h:outputText value="#{qtyClReport.confirmQtyPcs}"
                                      rendered="#{not qtyClReport.alertConfirmQtyPcs and qtyClReport.month != null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>
                        <h:outputText value="#{qtyClReport.confirmQtyPcs}"
                                      styleClass="FOXY_REPORT_GRAND_TOTAL"
                                      rendered="#{qtyClReport.alertConfirmQtyPcs and qtyClReport.month != null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>
                        <h:outputText styleClass="FOXY_REPORT_GRAND_TOTAL" value="#{qtyClReport.confirmQtyPcs}" rendered="#{qtyClReport.month == null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>
                    </t:column>
                    
                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="Ship Qty (pcs)" />
                            </h:panelGrid>
                        </f:facet>
                        <h:outputText value="#{qtyClReport.shipQtyPcs}"
                                      rendered="#{not qtyClReport.alertShipQtyPcs and qtyClReport.month != null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>
                        <h:outputText value="#{qtyClReport.shipQtyPcs}"
                                      styleClass="FOXY_REPORT_GRAND_TOTAL"
                                      rendered="#{qtyClReport.alertShipQtyPcs and qtyClReport.month != null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>
                        
                        <h:outputText styleClass="FOXY_REPORT_GRAND_TOTAL" value="#{qtyClReport.shipQtyPcs}" rendered="#{qtyClReport.month == null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>                                                
                    </t:column>
                    
                    <t:column width="10%">
                        <f:facet name="header">
                            <h:outputText value="Delivery Date"/>
                        </f:facet>
                        <h:outputText value="#{qtyClReport.delivery}">
                            <f:convertDateTime type="date" pattern="yyyy-MM-dd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                        </h:outputText>
                    </t:column>
                    
                    
                </t:dataTable>
            </h:panelGrid>
        </h:form>
    </h:panelGrid>            
    <%-- End of Listing--%>

    <%@ include file="foxyFooter.jsp" %>
</f:view>
