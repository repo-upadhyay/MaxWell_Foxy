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
    <%-- h:panelGrid id="SearchGrid" styleClass="tablebg" width="100%" rendered="#{foxyCRptsForexRate.search}" --%>
    <h:panelGrid id="SearchGrid" styleClass="tablebg" width="100%"  rendered="#{not foxyCRptsForexRate.list}">
        <h:outputText value="Forex Rate Listing (Per USD Rate) " styleClass="smalltitle" />
        <%--h:form id="SearchForm" rendered="#{foxyCRptsForexRate.search}" --%>
        <h:form id="SearchForm">            
            <h:panelGrid id="SearchInput" columns="2" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="50%">                                                
                <t:outputLabel for="FromDate" value="From Date:" />
                <h:panelGroup>
                    <t:inputCalendar id="FromDate" styleClass="FOX_INPUT" value="#{foxyCRptsForexRate.fromDate}"  
                                     popupDateFormat="yyyyMMdd" renderAsPopup="true"
                                     helpText="YYYYMMDD" required="true"/>    
                    <h:message errorClass="FOX_ERROR" for="FromDate" showDetail="true" showSummary="true"/>
                </h:panelGroup>
                
                <t:outputLabel for="ToDate" value="To Date:" />
                <h:panelGroup>
                    <t:inputCalendar id="ToDate" styleClass="FOX_INPUT" value="#{foxyCRptsForexRate.toDate}"  
                                     popupDateFormat="yyyyMMdd" renderAsPopup="true"
                                     helpText="YYYYMMDD" required="true"/>    
                    <h:message errorClass="FOX_ERROR" for="ToDate" showDetail="true" showSummary="true"/>
                </h:panelGroup>
            </h:panelGrid>
            <h:commandButton id="Submit" value="Submit" action="#{foxyCRptsForexRate.search}"/>
        </h:form>
    </h:panelGrid>
    <%-- End of Search--%>
            
    <%-- Panel for Listing --%>
    <h:panelGrid id="ListOrderGrid" styleClass="tablebg" rendered="#{foxyCRptsForexRate.list}" width="100%">        
        <h:form id="ListReportForm">
            <h:panelGrid id="Top" columns="1" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="100%">
                
                <h:outputText value="Forex Rate Listing (Per USD Rate) for #{foxyCRptsForexRate.title}" styleClass="smalltitle" />
            </h:panelGrid>
            <h:panelGrid id="ListDisplay" columns="1" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="100%">
                <t:dataTable value="#{foxyCRptsForexRate.reportData}" var="RptRec"
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
                    
                    <f:facet name="header">
                        <h:outputText value="All Currency conversion rate is based on Per 1 USD Dollar Rate" styleClass="FOX_HELPMSG"/>
                    </f:facet>                      
                    
                    <t:column width="10%">
                        <f:facet name="header">
                            <h:outputText value="Date"/>
                        </f:facet>
                        <h:outputText value="#{RptRec.dateRate}" >
                            <f:convertDateTime type="date" pattern="yyyyMMdd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                        </h:outputText>
                    </t:column>
                    
                    <t:column  width="8%"  styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">                            
                                <h:outputText value="SgdRate" />
                            </h:panelGrid>
                        </f:facet>
                        <h:outputText value="#{RptRec.sgdRate}" >
                            <f:convertNumber minFractionDigits="3" maxFractionDigits="3"/>
                        </h:outputText>
                    </t:column>
                    
                    <t:column  width="8%"  styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">                            
                                <h:outputText value="HkdRate" />
                            </h:panelGrid>
                        </f:facet>
                        <h:outputText value="#{RptRec.hkdRate}" >
                            <f:convertNumber minFractionDigits="3" maxFractionDigits="3"/>
                        </h:outputText>
                    </t:column>
                    
                    <t:column  width="8%"  styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">                            
                                <h:outputText value="UsdRate" />
                            </h:panelGrid>
                        </f:facet>
                        <h:outputText value="#{RptRec.usdRate}" >
                            <f:convertNumber minFractionDigits="3" maxFractionDigits="3"/>
                        </h:outputText>
                    </t:column>
                    
                </t:dataTable>
            </h:panelGrid>
        </h:form>
    </h:panelGrid>            
    <%-- End of Listing--%>

    <%@ include file="foxyFooter.jsp" %>
</f:view>
