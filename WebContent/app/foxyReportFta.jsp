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
    <h:panelGrid id="SearchGrid" styleClass="tablebg" rendered="#{not foxyFTAReports.list}" width="100%">
        <h:outputText value="FTA Report" styleClass="smalltitle" />
        <h:form id="SearchForm">
            <h:panelGrid id="SearchInput" columns="2" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="50%">
                
                <t:outputLabel for="FromDate" value="Close Date From:" />
                <h:panelGroup>
                    <t:inputCalendar id="FromDate" styleClass="FOX_INPUT" required="true" value="#{foxyFTAReports.fromDate}"  popupDateFormat="yyyy-MM-dd" renderAsPopup="true"/>    
                    <h:message errorClass="FOX_ERROR" for="FromDate" showDetail="true" showSummary="true"/>
                </h:panelGroup>                        
                
                <t:outputLabel for="ToDate" value="To:" />
                <h:panelGroup>
                    <t:inputCalendar id="ToDate" styleClass="FOX_INPUT" required="true" value="#{foxyFTAReports.toDate}"  popupDateFormat="yyyy-MM-dd" renderAsPopup="true"/>    
                    <h:message errorClass="FOX_ERROR" for="ToDate" showDetail="true" showSummary="true"/>
                </h:panelGroup>
                
                <t:outputLabel for="Country" value="Country of Origin:" />
                <h:panelGroup>
                    <h:selectOneMenu id="Country" styleClass="FOX_INPUT" required="true" value="#{foxyFTAReports.country}">
                        <f:selectItems value="#{listData.countryList}"/>
                    </h:selectOneMenu>
                    <h:message errorClass="FOX_ERROR" for="Country" showDetail="true" showSummary="true"/>
                </h:panelGroup>      
                
                <t:outputLabel for="status" value="Shipping Status:"/>
                <h:panelGroup>
                    <h:selectOneMenu id="status" styleClass="FOX_INPUT" required="true" value="#{foxyFTAReports.shipStat}">
                        <f:selectItems value="#{listData.shipStatus}"/>
                    </h:selectOneMenu>
                    <h:message errorClass="FOX_ERROR" for="status" showDetail="true" showSummary="true"/>
                </h:panelGroup>                                                
                
                <h:commandButton id="Submit"  value="Submit" action="#{foxyFTAReports.search}"/>
            </h:panelGrid>
        </h:form>
    </h:panelGrid>
    <%-- End of Search--%>
            
    <%-- Panel for Listing --%>
    <h:panelGrid id="ListOrderGrid" styleClass="tablebg" rendered="#{foxyFTAReports.list}" width="100%">        
        <h:form id="ListReportForm">
            <h:panelGrid id="Top" columns="1" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="100%">
                
                <h:outputText value="FTA Report for #{foxyFTAReports.title}" styleClass="smalltitle" />
            </h:panelGrid>
            <h:panelGrid id="ListDisplay" columns="1" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="100%">
                <t:dataTable value="#{foxyFTAReports.ftaReportData}" var="ftaReport"
                             id="DetailData"
                             styleClass="FOXY_REPORT_1"
                             headerClass="FOXY_REPORT_HEADER_1"
                             footerClass="FOXY_REPORT_HEADER_1"                    
                             preserveDataModel="false"
                             cellspacing="0"
                             rowClasses="FOXY_REPORT_ROW_1,FOXY_REPORT_ROW_2">
                    
                    <f:facet name="footer">
                        <h:outputText value="End of Record(s)" styleClass="FOX_HELPMSG"/>
                    </f:facet>                      
                    
                    <t:column width="8%">
                        <f:facet name="header">
                            <h:outputText value="Ref No" />
                        </f:facet>
                        <h:outputText value="#{ftaReport.refNo}" rendered="#{ftaReport.closedate != null}"/>
                        <h:outputText styleClass="FOXY_REPORT_GRAND_TOTAL" value="#{ftaReport.refNo}" rendered="#{ftaReport.closedate == null}"/>
                    </t:column>
                    
                    
                    <t:column width="8%">
                        <f:facet name="header">
                            <h:outputText value="PO Num" />
                        </f:facet>
                        <h:outputText value="#{ftaReport.po}"/>
                    </t:column>            
                    
                    
                    <t:column width="8%">
                        <f:facet name="header">
                            <h:outputText value="Style Code" />
                        </f:facet>
                        <h:outputText value="#{ftaReport.styleCode}"/>
                    </t:column>            
                    
                    <t:column width="8%">
                        <f:facet name="header">
                            <h:outputText value="Cust/Brand/Division" />
                        </f:facet>
                        <h:outputText value="#{ftaReport.custCode}/#{ftaReport.custBrand}/#{ftaReport.custDiv}" rendered="#{ftaReport.closedate != null}"/>
                    </t:column>                   
                    
                    <t:column width="8%">
                        <f:facet name="header">
                            <h:outputText value="Category" />
                        </f:facet>
                        <h:outputText value="#{ftaReport.cat}"/>
                    </t:column>            
                    
                    <t:column width="8%">
                        <f:facet name="header">
                            <h:outputText value="Destination" />
                        </f:facet>
                        <h:outputText value="#{ftaReport.dest}"/>
                    </t:column>
                    
                    <t:column width="10%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">                            
                                <h:outputText value="Quantity (PCS)" />
                            </h:panelGrid>
                        </f:facet>
                        <h:outputText value="#{ftaReport.qtyPcs}" rendered="#{ftaReport.closedate != null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>
                        <h:outputText styleClass="FOXY_REPORT_GRAND_TOTAL" value="#{ftaReport.qtyPcs}" rendered="#{ftaReport.closedate == null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>
                    </t:column>                    
                    
                    <t:column width="10%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">                            
                                <h:outputText value="Quantity (DZN)" />
                            </h:panelGrid>
                        </f:facet>
                        <h:outputText value="#{ftaReport.qtyDzn}" rendered="#{ftaReport.closedate != null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>
                        
                        <h:outputText styleClass="FOXY_REPORT_GRAND_TOTAL" value="#{ftaReport.qtyDzn}" rendered="#{ftaReport.closedate == null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>                            
                    </t:column>
                    
                    <t:column width="8%">
                        <f:facet name="header">
                            <h:outputText value="ETD" />
                        </f:facet>
                        <h:outputText value="#{ftaReport.etd}">
                            <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                        </h:outputText>
                    </t:column>        
                    
                    <t:column width="8%">
                        <f:facet name="header">
                            <h:outputText value="Closedate" />
                        </f:facet>
                        <h:outputText value="#{ftaReport.closedate}">
                            <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                        </h:outputText>
                    </t:column>                            
                    
                </t:dataTable>
            </h:panelGrid>
        </h:form>
    </h:panelGrid>            
    <%-- End of Listing--%>

    <%@ include file="foxyFooter.jsp" %>
</f:view>
