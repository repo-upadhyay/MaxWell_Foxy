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
    
    <h:panelGrid id="SearchGrid"  styleClass="tablebg" width="100%"  rendered="#{not foxyCRptsSalesInvoiceChecklist.list}">
        <h:outputText value="Sales Invoice Unpaid Checklist" styleClass="smalltitle" />
        <h:form id="SearchForm">            
            <h:commandButton id="Submit" value="Submit" action="#{foxyCRptsSalesInvoiceChecklist.search}"/>
        </h:form>
    </h:panelGrid>
    <%-- End of Search--%>
            
    <%-- Panel for Listing --%>
    <h:panelGrid id="ListOrderGrid" styleClass="tablebg" rendered="#{foxyCRptsSalesInvoiceChecklist.list}" width="100%">        
        <h:form id="ListReportForm">
            <h:panelGrid id="Top" columns="1" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="100%">
                
                <h:outputText value="Sales Invoice Unpaid Checklist #{foxyCRptsSalesInvoiceChecklist.title}" styleClass="smalltitle" />
            </h:panelGrid>
            <h:panelGrid id="ListDisplay" columns="1" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="100%">
                <t:dataTable value="#{foxyCRptsSalesInvoiceChecklist.reportData}" var="RptRec"
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
                        <h:outputText value="All Quantity taken from Lot record" styleClass="FOX_HELPMSG"/>
                    </f:facet>                      
                    
                    <t:column width="10%">
                        <f:facet name="header">
                            <h:outputText value="Inv Date"/>
                        </f:facet>
                        <h:outputText value="#{RptRec.invDate}" >
                            <f:convertDateTime type="date" pattern="yyyyMMdd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                        </h:outputText>
                    </t:column>
                    
                    <t:column  width="8%" >
                        <f:facet name="header">
                            <h:outputText value="ChutexInv" />
                        </f:facet>
                        <h:outputText value="#{RptRec.chutexInv}"/>
                    </t:column>                    
                    
                    <t:column  width="8%" >
                        <f:facet name="header">
                            <h:outputText value="SalesInv" />
                        </f:facet>
                        <h:outputText value="#{RptRec.salesInv}"/>
                    </t:column>
                    
                    <t:column  width="8%" >
                        <f:facet name="header">
                            <h:outputText value="Buyer/Brand" />
                        </f:facet>
                        <h:outputText value="#{RptRec.customer}"/>
                    </t:column>
                    
                    <t:column  width="8%" >
                        <f:facet name="header">
                            <h:outputText value="PO No" />
                        </f:facet>
                        <h:outputText value="#{RptRec.ponumber}"/>
                    </t:column>
                    
                    <t:column  width="8%" >
                        <f:facet name="header">
                            <h:outputText value="Style No" />
                        </f:facet>
                        <h:outputText value="#{RptRec.style}"/>
                    </t:column>                    
                    
                    <t:column  width="8%" >
                        <f:facet name="header">
                            <h:outputText value="Ref No" />
                        </f:facet>
                        <h:outputText value="#{RptRec.refNo}"/>
                    </t:column>
                    
                    <t:column  width="8%"  styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">                            
                                <h:outputText value="Ctns" />
                            </h:panelGrid>
                        </f:facet>
                        <h:outputText value="#{RptRec.ctns}" >
                            <f:convertNumber minFractionDigits="0" maxFractionDigits="0"/>
                        </h:outputText>
                    </t:column>
                    
                    <t:column  width="8%"  styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">                            
                                <h:outputText value="Pcs" />
                            </h:panelGrid>
                        </f:facet>
                        <h:outputText value="#{RptRec.pcs}" >
                            <f:convertNumber minFractionDigits="0" maxFractionDigits="0"/>
                        </h:outputText>
                    </t:column>
                    
                    <t:column width="10%">
                        <f:facet name="header">
                            <h:outputText value="ETD Date"/>
                        </f:facet>
                        <h:outputText value="#{RptRec.etd}">
                            <f:convertDateTime type="date" pattern="yyyyMMdd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                        </h:outputText>
                    </t:column>                    
                    
                    <t:column  width="8%" >
                        <f:facet name="header">
                            <h:outputText value="Ship Mode" />
                        </f:facet>
                        <h:outputText value="#{RptRec.shipMode}"/>
                    </t:column>
                    
                    <t:column  width="8%" >
                        <f:facet name="header">
                            <h:outputText value="Vessel/Flt" />
                        </f:facet>
                        <h:outputText value="#{RptRec.vessel}"/>
                    </t:column>
                    
                    <t:column  width="8%" >
                        <f:facet name="header">
                            <h:outputText value="Destination" />
                        </f:facet>
                        <h:outputText value="#{RptRec.dest}"/>
                    </t:column>                    
                    
                    <t:column  width="8%"  styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">                            
                                <h:outputText value="FOB Val" />
                            </h:panelGrid>
                        </f:facet>
                        <h:outputText value="#{RptRec.fobVal}" rendered="#{RptRec.salesInv != null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>
                        <h:outputText value="#{RptRec.fobVal}" rendered="#{RptRec.salesInv == null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>                        
                    </t:column>
                    
                    <t:column  width="8%"  styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">                            
                                <h:outputText value="CMT Unit Price" />
                            </h:panelGrid>
                        </f:facet>
                        <h:outputText value="#{RptRec.cmtUnitPrice}" >
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>
                        <%-- h:outputText value="#{RptRec.cmtVal}" rendered="#{RptRec.origin == null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText --%>
                    </t:column>
                    
                    <t:column  width="8%"  styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">                            
                                <h:outputText value="CMT Val" />
                            </h:panelGrid>
                        </f:facet>
                        <h:outputText value="#{RptRec.cmtVal}" rendered="#{RptRec.salesInv != null}" >
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>
                        <h:outputText value="#{RptRec.cmtVal}" rendered="#{RptRec.salesInv == null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
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
                        <h:outputText value="#{RptRec.revenue}" rendered="#{RptRec.salesInv != null}" >
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>                        
                        <h:outputText value="#{RptRec.revenue}" rendered="#{RptRec.salesInv == null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>
                    </t:column>
                    
                    <t:column width="10%">
                        <f:facet name="header">
                            <h:outputText value="Pay Date"/>
                        </f:facet>
                        <h:outputText value="#{RptRec.paydate}">
                            <f:convertDateTime type="date" pattern="yyyyMMdd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                        </h:outputText>
                    </t:column>                    
                    
                </t:dataTable>
            </h:panelGrid>
        </h:form>
    </h:panelGrid>            
    <%-- End of Listing--%>

    <%@ include file="foxyFooter.jsp" %>
</f:view>
