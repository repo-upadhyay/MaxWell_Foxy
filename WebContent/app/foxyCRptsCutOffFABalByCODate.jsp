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
    <%-- h:panelGrid id="SearchGrid" styleClass="tablebg" width="100%" rendered="#{foxyCRptsCutOffFABal.search}" --%>
    <h:panelGrid id="SearchGrid" styleClass="tablebg" width="100%"  rendered="#{not foxyCRptsCutOffFABal.list}">
        <h:outputText value="Fabric Balance By Country Report" styleClass="smalltitle" />
        <%--h:form id="SearchForm" rendered="#{foxyCRptsCutOffFABal.search}" --%>
        <h:form id="SearchForm">
            <h:panelGrid id="SearchInput" columns="2" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="50%">                        
                
                <t:outputLabel value="Country Origin:" for="Country"/>
                <h:panelGroup>
                    <h:selectOneMenu id="Country" styleClass="FOX_INPUT" 
                                     required="true"
                                     immediate="true"
                                     value="#{foxyCRptsCutOffFABal.country}">
                        <f:selectItems value="#{listData.countryList}"/>
                    </h:selectOneMenu>
                    <h:message errorClass="FOX_ERROR" for="Country" showDetail="true" showSummary="true"/>
                </h:panelGroup>                                                                                                              
                
                <t:outputLabel for="FromDate" value="Cut Off date (Mkt Delivery date):" />
                <h:panelGroup>
                    <t:inputCalendar id="FromDate" styleClass="FOX_INPUT" value="#{foxyCRptsCutOffFABal.fromDate}"  
                                     required="true" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                                     helpText="YYYYMMDD" />    
                    <h:message errorClass="FOX_ERROR" for="FromDate" showDetail="true" showSummary="true"/>
                </h:panelGroup>                        
                
                <t:outputLabel value="Status:" for="Status"/>
                <h:panelGroup>
                    <h:selectOneMenu id="Status" styleClass="FOX_INPUT" 
                                     required="fase"
                                     immediate="true"
                                     value="#{foxyCRptsCutOffFABal.remarkfilter}">
                        <f:selectItems value="#{foxyCRptsCutOffFABal.remarkList}"/>
                    </h:selectOneMenu>
                    <h:message errorClass="FOX_ERROR" for="Country" showDetail="true" showSummary="true"/>
                </h:panelGroup>                                                                                                              
                
                
                <h:commandButton id="Submit"  value="Submit" action="#{foxyCRptsCutOffFABal.search}"/>
            </h:panelGrid>
        </h:form>
    </h:panelGrid>
    <%-- End of Search--%>
            
    <%-- Panel for Listing --%>
    <h:panelGrid id="ListOrderGrid" styleClass="tablebg" rendered="#{foxyCRptsCutOffFABal.list}" width="100%">        
        <h:form id="ListReportForm">
            <h:panelGrid id="Top" columns="1" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="100%">
                
                <h:outputText value="Fabric Balance By Country Report for #{foxyCRptsCutOffFABal.title}" styleClass="smalltitle" />
            </h:panelGrid>
            <h:panelGrid id="ListDisplay" columns="1" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="100%">
                <t:dataTable value="#{foxyCRptsCutOffFABal.reportDataByCountry}" var="RptRec"
                             id="DetailData"
                             styleClass="FOXY_REPORT_1"
                             headerClass="FOXY_REPORT_HEADER_1"
                             footerClass="FOXY_REPORT_HEADER_1"                    
                             preserveDataModel="false"
                             cellspacing="0"
                             rowClasses="FOXY_REPORT_ROW_1,FOXY_REPORT_ROW_2">
                    <%--rowClasses="FoxyOddRow,FoxyEvenRow"--%>
                    
                    <f:facet name="header">
                        <h:outputText value="Remarks [Pending] if MktOrdQty and SalesQty differ more or equal 5%" styleClass="FOX_HELPMSG"/>                        
                    </f:facet>
                    
                    <f:facet name="footer">
                        <h:outputText value="End of Record(s)" styleClass="FOX_HELPMSG"/>
                    </f:facet>
                    
                    <t:column  width="8%" >
                        <f:facet name="header">
                            <h:outputText value="Ref No" />
                        </f:facet>
                        <h:outputText value="#{RptRec.refno}" rendered="#{RptRec.mktUnitPrice != null}"/>
                        <h:outputText value="#{RptRec.refno}" rendered="#{RptRec.mktUnitPrice == null}" styleClass="FOXY_REPORT_GRAND_TOTAL"/>
                    </t:column>
                    
                    <t:column  width="8%" >
                        <f:facet name="header">
                            <h:outputText value="Cust Code" />
                        </f:facet>
                        <h:outputText value="#{RptRec.cust}"/>
                    </t:column>                    
                    
                    <t:column width="10%">
                        <f:facet name="header">
                            <h:outputText value="First Delivery"/>
                        </f:facet>
                        <h:outputText value="#{RptRec.firstDelivery}">
                            <f:convertDateTime type="date" pattern="yyyyMMdd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                        </h:outputText>
                    </t:column>
                    
                    <t:column width="10%">
                        <f:facet name="header">
                            <h:outputText value="Last Delivery"/>
                        </f:facet>
                        <h:outputText value="#{RptRec.lastDelivery}">
                            <f:convertDateTime type="date" pattern="yyyyMMdd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                        </h:outputText>
                    </t:column>                                
                    
                    <t:column  width="8%"  styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">                            
                                <h:outputText value="Mkt UnitPrice" />
                            </h:panelGrid>
                        </f:facet>
                        <h:outputText value="#{RptRec.mktUnitPrice}" >
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>
                    </t:column>                    
                    
                    <t:column  width="8%"  styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">                            
                                <h:outputText value="Mkt OrdQty (pcs)" />
                            </h:panelGrid>
                        </f:facet>
                        <h:outputText value="#{RptRec.mktQty}" >
                            <f:convertNumber minFractionDigits="0" maxFractionDigits="0"/>
                        </h:outputText>
                    </t:column>                    
                    
                    <t:column  width="8%"  styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">                            
                                <h:outputText value="Sales Qty(pcs)" />
                            </h:panelGrid>
                        </f:facet>
                        <h:outputText value="#{RptRec.salesQty}" >
                            <f:convertNumber minFractionDigits="0" maxFractionDigits="0"/>
                        </h:outputText>
                    </t:column>                    
                    
                    <%--
                    <t:column  width="8%"  styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">                            
                                <h:outputText value="Fabric(LBS) B4" />
                            </h:panelGrid>
                        </f:facet>
                        <h:outputText value="#{RptRec.fabricQtyB4}" >
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>
                    </t:column>
                    --%>
                    
                    <t:column  width="8%"  styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">                            
                                <h:outputText value="Fabric Bal(LBS)" />
                            </h:panelGrid>
                        </f:facet>
                        <h:outputText value="#{RptRec.fabricQtyAft}" rendered="#{RptRec.mktUnitPrice != null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>
                        <h:outputText value="#{RptRec.fabricQtyAft}" rendered="#{RptRec.mktUnitPrice == null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>
                    </t:column>
                    
                    
                    <t:column  width="8%"  styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="Unship Bal(pcs)" />
                            </h:panelGrid>
                        </f:facet>
                        <h:outputText value="#{RptRec.unShipQty}" rendered="#{RptRec.mktUnitPrice != null}">
                            <f:convertNumber minFractionDigits="0" maxFractionDigits="0"/>
                        </h:outputText>
                        <h:outputText value="#{RptRec.unShipQty}" rendered="#{RptRec.mktUnitPrice == null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <f:convertNumber minFractionDigits="0" maxFractionDigits="0"/>
                        </h:outputText>
                    </t:column>                                                            
                    
                    <t:column  width="8%"  styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="Unship Value(SGD)" />
                            </h:panelGrid>
                        </f:facet>
                        <h:outputText value="#{RptRec.unShipMktValue}" rendered="#{RptRec.mktUnitPrice != null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>
                        <h:outputText value="#{RptRec.unShipMktValue}" rendered="#{RptRec.mktUnitPrice == null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>
                    </t:column>
                    
                    <t:column  width="8%" >
                        <f:facet name="header">
                            <h:outputText value="Remarks" />
                        </f:facet>
                        <h:outputText value="#{RptRec.remarks}" />
                    </t:column>
                    
                </t:dataTable>
            </h:panelGrid>
        </h:form>
    </h:panelGrid>            
    <%-- End of Listing--%>

    <%@ include file="foxyFooter.jsp" %>
</f:view>
