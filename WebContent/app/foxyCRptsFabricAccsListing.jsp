<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%@taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<%@taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@taglib uri="https://ajax4jsf.dev.java.net/ajax" prefix="a4j"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<f:view>
    <%@ include file="foxyHeader.jsp" %>
    
    <%-- Panel for Search --%>
    <h:panelGrid id="SearchGrid" columns="3" styleClass="tablebg" rowClasses="FOX_FRAME" rendered="#{not foxyCRptsFabricAccs.list}" width="100%">
        <h:outputText value="F&A Listing Report" styleClass="smalltitle" />
        <h:outputText value="By RefNo" styleClass="smalltitle" />
        <h:outputText value="By Key-In Date" styleClass="smalltitle" />
        <h:form id="SearchForm">
            <h:panelGrid id="SearchInput" columns="2" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="50%">
                
                <t:outputLabel for="FromDate" value="InvDate From:" />
                <h:panelGroup>
                    <t:inputCalendar id="FromDate" required="true" styleClass="FOX_INPUT" value="#{foxyCRptsFabricAccs.fromDate}"  
                                     popupDateFormat="yyyyMMdd" renderAsPopup="true" helpText="YYYYMMDD"/>
                    <h:message errorClass="FOX_ERROR" for="FromDate" showDetail="true" showSummary="true"/>
                </h:panelGroup>                        
                
                <t:outputLabel for="ToDate" value="InvDate To:" />
                <h:panelGroup>
                    <t:inputCalendar id="ToDate" required="true" styleClass="FOX_INPUT" value="#{foxyCRptsFabricAccs.toDate}"  
                                     popupDateFormat="yyyyMMdd" renderAsPopup="true" helpText="YYYYMMDD"/>
                    <h:message errorClass="FOX_ERROR" for="ToDate" showDetail="true" showSummary="true"/>
                </h:panelGroup>
                
                <t:outputLabel for="type" value="Inv Type:" />
                <h:panelGroup>
                    <h:selectOneMenu id="type" styleClass="FOX_INPUT" required="true" value="#{foxyCRptsFabricAccs.invType}">
                        <f:selectItems value="#{listData.supItemList}"/>
                    </h:selectOneMenu>                                
                    <h:message errorClass="FOX_ERROR" for="type" showDetail="true" showSummary="true"/>
                </h:panelGroup>  
                
                <t:outputLabel for="Country"  value="Make in:"/>
                <h:panelGroup>
                    <h:selectOneMenu id="Country" styleClass="FOX_INPUT" required="false" 
                                     value="#{foxyCRptsFabricAccs.country}"
                                     style="width:200px; height:20px">
                        <f:selectItems value="#{listData.countryList}"/>
                    </h:selectOneMenu>
                    <h:message errorClass="FOX_ERROR" for="Country" showDetail="true" showSummary="true"/>
                </h:panelGroup>                                
                
                
                <h:commandButton id="Submit"  value="Submit" action="#{foxyCRptsFabricAccs.search}"/>
            </h:panelGrid>
        </h:form>
        
        <h:form id="SearchFormByRefNo">            
            <h:panelGrid id="SearchInput" columns="2" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="50%">
                <t:outputLabel for="type" value="Inv Type:" />
                <h:panelGroup>
                    <h:selectOneMenu id="type" styleClass="FOX_INPUT" required="true" value="#{foxyCRptsFabricAccs.invType}">
                        <f:selectItems value="#{listData.supItemListWithAll}"/>
                    </h:selectOneMenu>                                
                    <h:message errorClass="FOX_ERROR" for="type" showDetail="true" showSummary="true"/>
                </h:panelGroup>  
                
                <t:outputLabel for="RefNo" value="RefNo" />
                <h:panelGroup>
                    <t:inputTextHelp id="RefNo" styleClass="FOX_INPUT" required="true" maxlength="6" size="6"
                                     helpText="999999"  value="#{foxyCRptsFabricAccs.refno}"/>
                    <h:message errorClass="FOX_ERROR" for="RefNo" showDetail="true" showSummary="true"/>
                </h:panelGroup>
            </h:panelGrid>
            <h:commandButton id="Submit"  value="Search By RefNo" action="#{foxyCRptsFabricAccs.searchByRefNo}"/>
        </h:form> 
        
        <h:form id="SearchFormByInsDate">            
            <h:panelGrid id="SearchInput" columns="2" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="50%">                
                <t:outputLabel for="InsDate" value="Key-In Date" />
                <h:panelGroup>
                    <t:inputCalendar id="InsDate" styleClass="FOX_INPUT" value="#{foxyCRptsFabricAccs.fromDate}"  
                                     required="true" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                                     helpText="YYYYMMDD" />    
                    <h:message errorClass="FOX_ERROR" for="InsDate" showDetail="true" showSummary="true"/>
                </h:panelGroup>                                
            </h:panelGrid>
            <h:commandButton id="Submit"  value="By Key-In Date" action="#{foxyCRptsFabricAccs.searchInsDate}"/>
        </h:form>           
        
    </h:panelGrid>
    <%-- End of Search--%>
            
    <%-- Panel for Listing --%>
    <h:panelGrid id="ListOrderGrid" styleClass="tablebg" rendered="#{foxyCRptsFabricAccs.list}" width="100%">        
        <h:form id="ListReportForm">
            <h:panelGrid id="Top" columns="1" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="100%">                
                <h:outputText value="F&A Listing Report for #{foxyCRptsFabricAccs.title}" styleClass="smalltitle" />
            </h:panelGrid>
            <h:panelGrid id="ListDisplay" columns="1" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="100%">
                <t:dataTable value="#{foxyCRptsFabricAccs.reportData}" var="ReportData"
                             id="DetailData"
                             styleClass="FOXY_REPORT_1"
                             headerClass="FOXY_REPORT_HEADER_1"
                             footerClass="FOXY_REPORT_HEADER_1"                    
                             preserveDataModel="false"
                             cellspacing="0"
                             rowClasses="FOXY_REPORT_ROW_1,FOXY_REPORT_ROW_2">
                    <%--rowClasses="FoxyOddRow,FoxyEvenRow"--%>
                    
                    <f:facet name="header">
                        <h:outputText value="Subtotal for Value(SGD) [ie: Unassiged amt] = Value(SGD) - Assigned Value(SGD)" styleClass="FOX_HELPMSG"/>
                    </f:facet>                      
                    
                    <t:column width="8%">
                        <f:facet name="header">
                            <h:outputText value="Invoice" />
                        </f:facet>
                        <h:outputText value="#{ReportData.invoice}"  rendered="#{ReportData.assignedRefno != null}"/>
                        <h:outputText styleClass="FOXY_REPORT_GRAND_TOTAL" value="#{ReportData.invoice}" rendered="#{ReportData.assignedRefno == null}"/>
                    </t:column>
                    
                    <t:column width="10%">
                        <f:facet name="header">
                            <h:outputText value="InvoiceDate"/>
                        </f:facet>
                        <h:outputText value="#{ReportData.invdate}">
                            <f:convertDateTime type="date" pattern="yyyyMMdd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                        </h:outputText>
                    </t:column>
                    
                    <t:column width="8%">
                        <f:facet name="header">
                            <h:outputText value="Supplier" />
                        </f:facet>
                        <h:outputText value="#{ReportData.supplier}"/>
                    </t:column>
                    
                    <t:column width="8%" rendered="#{foxyCRptsFabricAccs.refno != null}">
                        <f:facet name="header">
                            <h:outputText value="Type" />
                        </f:facet>
                        <h:outputText value="#{ReportData.type}"/>
                    </t:column>
                    
                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">                            
                                <h:outputText value="Inv Qty" />
                            </h:panelGrid>
                        </f:facet>
                        <h:outputText value="#{ReportData.qty}" rendered="#{ReportData.assignedRefno != null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>
                        <h:outputText styleClass="FOXY_REPORT_GRAND_TOTAL" value="#{ReportData.qty}" rendered="#{ReportData.assignedRefno == null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>
                    </t:column>
                    
                    <t:column width="8%">
                        <f:facet name="header">
                            <h:outputText value="Unit" />
                        </f:facet>
                        <h:outputText value="#{ReportData.unit}"/>
                    </t:column>
                    
                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">                            
                                <h:outputText value="Value" />
                            </h:panelGrid>
                        </f:facet>
                        <h:outputText value="#{ReportData.value}" rendered="#{ReportData.assignedRefno != null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>
                    </t:column>                    
                    
                    <t:column width="8%">
                        <f:facet name="header">
                            <h:outputText value="Currency" />
                        </f:facet>
                        <h:outputText value="#{ReportData.currency}"/>                        
                    </t:column>
                    
                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">                            
                                <h:outputText value="Value (SGD)" />
                            </h:panelGrid>
                        </f:facet>
                        <h:outputText value="#{ReportData.basevalue}" rendered="#{ReportData.assignedRefno != null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>
                        <h:outputText styleClass="FOXY_REPORT_GRAND_TOTAL" value="#{ReportData.basevalue}" rendered="#{ReportData.assignedRefno == null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>
                    </t:column>                    
                    
                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">                            
                                <h:outputText value="Unit Cost" />
                            </h:panelGrid>
                        </f:facet>
                        <h:outputText value="#{ReportData.unitcost}" rendered="#{ReportData.assignedRefno != null}">
                            <f:convertNumber minFractionDigits="6" maxFractionDigits="6"/>
                        </h:outputText>
                    </t:column>
                    
                    <%--
                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">                            
                                <h:outputText value="ForexRate" />
                            </h:panelGrid>
                        </f:facet>
                        <h:outputText value="#{ReportData.forexrate}" rendered="#{ReportData.invoice != null}">
                            <f:convertNumber minFractionDigits="6" maxFractionDigits="6"/>
                        </h:outputText>
                    </t:column>
                    --%>
                    
                    <t:column width="8%">
                        <f:facet name="header">
                            <h:outputText value="RefNo" />
                        </f:facet>
                        <h:outputText value="#{ReportData.assignedRefno}"/>                        
                    </t:column>
                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">                            
                                <h:outputText value="Assigned Qty" />
                            </h:panelGrid>                                                        
                        </f:facet>
                        <h:outputText value="#{ReportData.assignedQty}" rendered="#{ReportData.assignedRefno != null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>
                        <h:outputText value="#{ReportData.assignedQty}" rendered="#{ReportData.assignedRefno == null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>                                                 
                    </t:column>
                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R" >
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">                            
                                <h:outputText value="Assigned Unitcost" />
                            </h:panelGrid>                            
                        </f:facet>
                        <h:outputText value="#{ReportData.assignedUnitcost}">
                            <f:convertNumber minFractionDigits="6" maxFractionDigits="6"/>
                        </h:outputText>
                    </t:column>
                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">                            
                                <h:outputText value="Assigned FOC" />
                            </h:panelGrid>                                                        
                        </f:facet>
                        <h:outputText value="#{ReportData.assignedFocval}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>
                    </t:column>
                    
                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">                            
                                <h:outputText value="Assigned Val (SGD)" />
                            </h:panelGrid>                                                        
                        </f:facet>
                        <h:outputText value="#{ReportData.assignedBasevalue}" rendered="#{ReportData.assignedRefno != null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>
                        <h:outputText value="#{ReportData.assignedBasevalue}" rendered="#{ReportData.assignedRefno == null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>                                                 
                    </t:column>
                    
                    
                    <%--
                    <t:column width="8%">
                        <f:facet name="header">
                            <h:outputText value="Assigned ItemDesc" />
                        </f:facet>
                        <h:outputText value="#{ReportData.assignedItemdesc}"/>                        
                    </t:column>                                       
                    
                    
                    <t:column width="8%">
                        <f:facet name="header">
                            <h:outputText value="itemdesc" />
                        </f:facet>
                        <h:outputText value="#{ReportData.itemdesc}"/>                        
                    </t:column>
                    
                    <t:column width="8%">
                        <f:facet name="header">
                            <h:outputText value="remarks" />
                        </f:facet>
                        <h:outputText value="#{ReportData.remarks}"/>                        
                    </t:column>
                    --%>
                    
                </t:dataTable>
            </h:panelGrid>
        </h:form>
    </h:panelGrid>            
    <%-- End of Listing--%>

    <%@ include file="foxyFooter.jsp" %>
</f:view>
