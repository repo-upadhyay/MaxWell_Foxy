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
    <h:panelGrid id="SearchGrid" styleClass="tablebg" rendered="#{not foxyCashFlowReports.list}" width="100%">
        <h:outputText value="Sale Cash Flow Report (Based on ETD date)" styleClass="smalltitle" />
        <h:form id="SearchForm">
            <t:saveState value="#{foxyCashFlowReports.country}"/>
            <t:saveState value="#{foxyCashFlowReports.mainfactory}"/>
            <h:panelGrid id="SearchInput" columns="2" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="50%">

                <t:outputLabel value="Country Origin:" for="Country"/>
                <h:panelGroup>
                    <a4j:region id="ajaxregioncountryfactory" renderRegionOnly="false" selfRendered="true">
                        <h:selectOneMenu id="Country" styleClass="FOX_INPUT" 
                                         required="true" 
                                         immediate="true"
                                         value="#{foxyCashFlowReports.country}">
                            <f:selectItems value="#{listData.countryList}"/>
                            <a4j:support event="onchange"  
                                         reRender="factory" ajaxSingle="true">
                            </a4j:support>
                        </h:selectOneMenu>
                    </a4j:region>
                    <h:message errorClass="FOX_ERROR" for="Country" showDetail="true" showSummary="true"/>
                </h:panelGroup>

                <t:outputLabel value="Main Factory:" for="factory"/>
                <h:panelGroup>
                    <h:selectOneMenu id="factory" styleClass="FOX_INPUT" 
                                     required="true" 
                                     immediate="true"
                                     value="#{foxyCashFlowReports.mainfactory}">
                        <f:selectItems value="#{foxyCashFlowReports.factoryByCountryList}"/>
                    </h:selectOneMenu>
                    <a4j:status for="ajaxregioncountryfactory">
                        <f:facet name="start">
                            <h:graphicImage value="/images/ajaxstart.gif"  height="12" width="12"/>
                        </f:facet>
                        <f:facet name="stop">
                            <%-- h:graphicImage value="/images/ajax_stoped.gif" / --%>
                        </f:facet>
                    </a4j:status>
                    <h:message errorClass="FOX_ERROR" for="factory" showDetail="true" showSummary="true"/>
                </h:panelGroup>                 

                <t:outputLabel for="Year" value="Year of delivery:" />
                <h:panelGroup>
                    <t:inputTextHelp id="Year" styleClass="FOX_INPUT" required="true" 
                                     helpText="YYYY"  value="#{foxyCashFlowReports.year}"/>
                    <h:message errorClass="FOX_ERROR" for="Year" showDetail="true" showSummary="true"/>
                </h:panelGroup>                        

                <t:outputLabel for="Month" value="Month:" />
                <h:panelGroup>
                    <t:inputTextHelp id="Month" styleClass="FOX_INPUT" required="true" 
                                     helpText="MM" value="#{foxyCashFlowReports.month}"/>
                    <h:message errorClass="FOX_ERROR" for="Month" showDetail="true" showSummary="true"/>
                </h:panelGroup>

                <h:commandButton id="Submit"  value="Submit" action="#{foxyCashFlowReports.search}"/>
            </h:panelGrid>
        </h:form>
    </h:panelGrid>
    <%-- End of Search--%>

    <%-- Panel for Listing --%>
    <h:panelGrid id="ListOrderGrid" styleClass="tablebg" rendered="#{foxyCashFlowReports.list}" width="100%">        
        <h:form id="ListReportForm">
            <h:panelGrid id="Top" columns="1" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="100%">

                <h:outputText value="Sale Cash Flow Report #{foxyCashFlowReports.title}" styleClass="smalltitle" />

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
                <t:dataTable value="#{foxyCashFlowReports.saleCashFlowForecastData}" var="cfReport"
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
                        <h:outputText value="#{cfReport.refNo}"  rendered="#{cfReport.custCode != null}"/>
                        <h:outputText value="#{cfReport.refNo}"  rendered="#{cfReport.custCode == null}" styleClass="FOXY_REPORT_GRAND_TOTAL"/>                        
                    </t:column>

                    <t:column width="8%">
                        <f:facet name="header">
                            <h:outputText value="custCode" />
                        </f:facet>
                        <h:outputText value="#{cfReport.custCode}" />
                    </t:column>                    

                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="qtyPcs" />
                            </h:panelGrid>
                        </f:facet>
                        <h:outputText value="#{cfReport.qtyPcs}" rendered="#{cfReport.custCode != null}">
                            <f:convertNumber minFractionDigits="0" maxFractionDigits="0"/>
                        </h:outputText>
                        <h:outputText value="#{cfReport.qtyPcs}" rendered="#{cfReport.custCode == null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <f:convertNumber minFractionDigits="0" maxFractionDigits="0"/>
                        </h:outputText>    
                    </t:column>

                    <t:column width="10%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="Unit Price" />
                            </h:panelGrid>
                        </f:facet>
                        <h:outputText value="#{cfReport.unitPrice}">
                            <f:convertNumber minFractionDigits="3" maxFractionDigits="3"/>
                        </h:outputText>
                    </t:column>                                                            

                    <t:column width="10%">
                        <f:facet name="header">
                            <h:outputText value="ETD Date" />
                        </f:facet>
                        <h:outputText value="#{cfReport.delivery}">
                            <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                        </h:outputText>
                    </t:column>

                    <t:column width="10%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="payTerm" />
                            </h:panelGrid>
                        </f:facet>
                        <h:outputText value="#{cfReport.payTerm}">
                            <f:convertNumber minFractionDigits="0" maxFractionDigits="0"/>
                        </h:outputText>
                    </t:column>

                    <t:column width="10%">
                        <f:facet name="header">
                            <h:outputText value="Pay Date" />
                        </f:facet>
                        <h:outputText value="#{cfReport.payDate}">
                            <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                        </h:outputText>
                    </t:column>                                          



                    <t:column width="10%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="Prev Week 1" />
                            </h:panelGrid>
                        </f:facet>
                        <h:outputText value="#{cfReport.totalValue_1}" rendered="#{cfReport.custCode != null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>
                        <h:outputText value="#{cfReport.totalValue_1}" rendered="#{cfReport.custCode == null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>                        
                    </t:column>

                    <t:column width="10%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="Prev Week 2" />
                            </h:panelGrid>
                        </f:facet>
                        <h:outputText value="#{cfReport.totalValue_2}" rendered="#{cfReport.custCode != null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>
                        <h:outputText value="#{cfReport.totalValue_2}" rendered="#{cfReport.custCode == null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>                        
                    </t:column>
                    <t:column width="10%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="Prev Week 3" />
                            </h:panelGrid>
                        </f:facet>
                        <h:outputText value="#{cfReport.totalValue_3}" rendered="#{cfReport.custCode != null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>
                        <h:outputText value="#{cfReport.totalValue_3}" rendered="#{cfReport.custCode == null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>                        
                    </t:column>
                    <t:column width="10%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="Prev Week 4" />
                            </h:panelGrid>
                        </f:facet>
                        <h:outputText value="#{cfReport.totalValue_4}" rendered="#{cfReport.custCode != null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>
                        <h:outputText value="#{cfReport.totalValue_4}" rendered="#{cfReport.custCode == null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>                        
                    </t:column>
                    <t:column width="10%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="Current Week 1" />
                            </h:panelGrid>
                        </f:facet>
                        <h:outputText value="#{cfReport.totalValue_5}" rendered="#{cfReport.custCode != null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>
                        <h:outputText value="#{cfReport.totalValue_5}" rendered="#{cfReport.custCode == null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>                        
                    </t:column>
                    <t:column width="10%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="Current Week 2" />
                            </h:panelGrid>
                        </f:facet>
                        <h:outputText value="#{cfReport.totalValue_6}" rendered="#{cfReport.custCode != null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>
                        <h:outputText value="#{cfReport.totalValue_6}" rendered="#{cfReport.custCode == null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>                        
                    </t:column>
                    <t:column width="10%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="Current Week 3" />
                            </h:panelGrid>
                        </f:facet>
                        <h:outputText value="#{cfReport.totalValue_7}" rendered="#{cfReport.custCode != null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>
                        <h:outputText value="#{cfReport.totalValue_7}" rendered="#{cfReport.custCode == null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>                        
                    </t:column>
                    <t:column width="10%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="Current Week 4" />
                            </h:panelGrid>
                        </f:facet>
                        <h:outputText value="#{cfReport.totalValue_8}" rendered="#{cfReport.custCode != null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>
                        <h:outputText value="#{cfReport.totalValue_8}" rendered="#{cfReport.custCode == null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
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
