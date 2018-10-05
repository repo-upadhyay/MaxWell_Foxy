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
    
    <%-- Panel for Search --%>
    <%-- h:panelGrid id="SearchGrid" styleClass="tablebg" width="100%" rendered="#{foxyCRptsProfit.search}" --%>
    <h:panelGrid id="SearchGrid" styleClass="tablebg" width="100%"  rendered="#{not foxyCRptsProfit.list}">
        <h:outputText value="Profit by Country and Delivery Date Report" styleClass="smalltitle" />
        <%--h:form id="SearchForm" rendered="#{foxyCRptsProfit.search}" --%>
        <h:form id="SearchForm">
            <h:panelGrid id="SearchInput" columns="2" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="50%">                        
                
                <t:outputLabel value="Country Origin:" for="Country"/>
                <h:panelGroup>
                    <a4j:region id="ajaxregion1" renderRegionOnly="false" selfRendered="true">
                        <h:selectOneMenu id="Country" styleClass="FOX_INPUT" 
                                         required="true" 
                                         immediate="true"
                                         value="#{foxyCRptsProfit.country}">
                            <f:selectItems value="#{listData.countryList}"/>
                            <a4j:support event="onchange"  
                                         reRender="QuotaMast_Code" ajaxSingle="true">
                            </a4j:support>                                    
                        </h:selectOneMenu>
                    </a4j:region>
                    <h:message errorClass="FOX_ERROR" for="Country" showDetail="true" showSummary="true"/>
                </h:panelGroup>                                                                                                              
                
                <t:outputLabel for="FromDate" value="Delivery Date From:" />
                <h:panelGroup>
                    <t:inputCalendar id="FromDate" styleClass="FOX_INPUT" value="#{foxyCRptsProfit.fromDate}"  
                                     required="true" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                                     helpText="YYYYMMDD" />    
                    <h:message errorClass="FOX_ERROR" for="FromDate" showDetail="true" showSummary="true"/>
                </h:panelGroup>                        
                
                <t:outputLabel for="ToDate" value="To:" />
                <h:panelGroup>
                    <t:inputCalendar id="ToDate" styleClass="FOX_INPUT" value="#{foxyCRptsProfit.toDate}"  
                                     required="true" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                                     helpText="YYYYMMDD" />
                    <h:message errorClass="FOX_ERROR" for="ToDate" showDetail="true" showSummary="true"/>
                </h:panelGroup>
                
                <t:outputLabel for="Customer_Federated" value="Federated:" />
                <h:panelGroup>
                    <h:selectOneMenu id="Customer_Federated" styleClass="FOX_INPUT" 
                                     required="false" 
                                     value="#{foxyCRptsProfit.federated}">
                        <f:selectItems value="#{listData.custFederatedList}"/>
                    </h:selectOneMenu>
                    <h:message errorClass="FOX_ERROR" for="Customer_Federated" showDetail="true" showSummary="true"/>
                </h:panelGroup>                
                
                <h:commandButton id="Submit"  value="Submit" action="#{foxyCRptsProfit.search}"/>
            </h:panelGrid>
        </h:form>
    </h:panelGrid>
    <%-- End of Search--%>
            
    <%-- Panel for Listing --%>
    <h:panelGrid id="ListOrderGrid" styleClass="tablebg" rendered="#{foxyCRptsProfit.list}" width="100%">        
        <h:form id="ListReportForm">
            <h:panelGrid id="Top" columns="1" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="100%">
                
                <h:outputText value="Profit by Country and Delivery Date Report for #{foxyCRptsProfit.title}" styleClass="smalltitle" />
            </h:panelGrid>
            <h:panelGrid id="ListDisplay" columns="1" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="100%">
                <t:dataTable value="#{foxyCRptsProfit.reportDataByCntryDate}" var="RptRec"
                             id="DetailData"
                             styleClass="FOXY_REPORT_1"
                             headerClass="FOXY_REPORT_HEADER_1"
                             footerClass="FOXY_REPORT_HEADER_1"                    
                             preserveDataModel="false"
                             cellspacing="0"
                             rowClasses="FOXY_REPORT_ROW_1,FOXY_REPORT_ROW_2">
                    <%--rowClasses="FoxyOddRow,FoxyEvenRow"--%>
                    
                    <f:facet name="footer">
                        <h:outputText value="End of Record(s)" styleClass="FOX_HELPMSG"/>
                    </f:facet>
                                        
                    <t:column  width="8%" >
                        <f:facet name="header">
                            <h:outputText value="Ref No" />
                        </f:facet>
                        <h:outputText value="#{RptRec.refno}" rendered="#{RptRec.customer != null}"/>
                        <h:outputText value="#{RptRec.refno}" rendered="#{RptRec.customer == null}" styleClass="FOXY_REPORT_GRAND_TOTAL"/>                        
                    </t:column>
                    
                    <t:column  width="8%" >
                        <f:facet name="header">
                            <h:outputText value="Customer" />
                        </f:facet>
                        <h:outputText value="#{RptRec.customer}"/>
                    </t:column>
                    
                    <t:column  width="8%" >
                        <f:facet name="header">
                            <h:outputText value="Federated" />
                        </f:facet>                    
                        <h:outputText value="Yes" rendered="#{RptRec.federated and RptRec.customer != null}" />
                        <h:outputText value="No" rendered="#{not RptRec.federated and RptRec.customer != null}"/>
                    </t:column>
                    
                    <t:column  width="8%"  styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">                            
                                <h:outputText value="Tot FOB" />
                            </h:panelGrid>
                        </f:facet>
                        <h:outputText value="#{RptRec.fobval}" rendered="#{RptRec.customer != null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>
                        
                        <h:outputText value="#{RptRec.fobval}" rendered="#{RptRec.customer == null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>
                    </t:column>
                    
                    <t:column  width="8%"  styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">                            
                                <h:outputText value="Tot CMT" />
                            </h:panelGrid>
                        </f:facet>
                        <h:outputText value="#{RptRec.cmtval}" rendered="#{not RptRec.federated and RptRec.customer != null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>
                        
                        <h:outputText styleClass="FOXY_REPORT_GRAND_TOTAL"  value="#{RptRec.cmtval}" rendered="#{RptRec.federated and RptRec.customer != null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>
                        
                        <h:outputText styleClass="FOXY_REPORT_GRAND_TOTAL"  value="#{RptRec.cmtval}" rendered="#{RptRec.customer == null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>                          
                        
                    </t:column>                    
                    
                    <t:column  width="8%"  styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">                            
                                <h:outputText value="Fabric Cost" />
                            </h:panelGrid>
                        </f:facet>
                        <h:outputText value="#{RptRec.fabric}" rendered="#{RptRec.customer != null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>
                        
                        <h:outputText value="#{RptRec.fabric}" rendered="#{RptRec.customer == null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>
                    </t:column>
                    
                    
                    <t:column  width="8%"  styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="Accs Cost" />
                            </h:panelGrid>
                        </f:facet>
                        <h:outputText value="#{RptRec.accs}" rendered="#{RptRec.customer != null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>                        
                        <h:outputText value="#{RptRec.accs}" rendered="#{RptRec.customer == null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>
                    </t:column>
                    
                    <t:column  width="8%"  styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="Revenue" />
                            </h:panelGrid>
                        </f:facet>
                        <h:outputText value="#{RptRec.revenue}" rendered="#{RptRec.customer != null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>
                        
                        <h:outputText value="#{RptRec.revenue}" rendered="#{RptRec.customer == null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>
                    </t:column>                    
                    
                    <t:column  width="8%"  styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="Profit" />
                            </h:panelGrid>
                        </f:facet>
                        <h:outputText value="#{RptRec.profit}" rendered="#{RptRec.customer != null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>
                        
                        <h:outputText value="#{RptRec.profit}" rendered="#{RptRec.customer == null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>
                    </t:column>                                                            
                    
                </t:dataTable>
            </h:panelGrid>
        </h:form>
    </h:panelGrid>            
    <%-- End of Listing--%>

    <%@ include file="foxyFooter.jsp" %>
</f:view>
