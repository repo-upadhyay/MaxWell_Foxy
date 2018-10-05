<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<%@taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@taglib uri="https://ajax4jsf.dev.java.net/ajax" prefix="a4j"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<f:view>
    <%@ include file="foxyHeader.jsp" %>

    <%-- Panel for Search --%>
    <%-- h:panelGrid id="SearchGrid" styleClass="tablebg" width="100%" rendered="#{foxySummaryCustSalesRpt.search}" --%>
    <h:panelGrid id="SearchGrid" styleClass="tablebg" width="100%"  rendered="#{not foxySummaryCustSalesRpt.list}">
        <h:outputText value="Customer Sales Yearly Summary Report" styleClass="smalltitle" />
        <%--h:form id="SearchForm" rendered="#{foxySummaryCustSalesRpt.search}" --%>

        <h:form id="SearchForm">

            <h:panelGrid id="SearchInput" columns="2" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="50%">
                <!-- ==================== Input Filed for [Company Name] --START-- ========================= -->
                <t:outputLabel for="CName" value="Company Name:" />
                <h:panelGroup >
                    <h:selectOneMenu id="CName" value="#{foxySummaryCustSalesRpt.cnameCode}" styleClass="FOX_INPUT" required="true" immediate="false">
                        <f:selectItems value="#{listData.companyNameListAll}"/>                                  
                    </h:selectOneMenu>
                    <h:message errorClass="FOX_ERROR" for="CName" showDetail="true" showSummary="true"/>
                </h:panelGroup>
                <!-- ==================== Input Filed for [Company Name] --END  -- ========================= -->                  

                <t:outputLabel for="Year" value="Year:" />
                <h:panelGroup>
                    <t:inputTextHelp id="Year" styleClass="FOX_INPUT" required="true" 
                                     helpText="YYYY"  value="#{foxySummaryCustSalesRpt.year}"/>
                    <h:message errorClass="FOX_ERROR" for="Year" showDetail="true" showSummary="true"/>
                </h:panelGroup>

                <t:outputLabel for="ReportUnit" value="Report Unit:" />
                <h:panelGroup>
                    <h:selectOneMenu id="ReportUnit" styleClass="FOX_INPUT" required="true" value="#{foxySummaryCustSalesRpt.displayUnit}">
                        <f:selectItems value="#{listData.unitList}"/>
                    </h:selectOneMenu>
                    <h:message errorClass="FOX_ERROR" for="ReportUnit" showDetail="true" showSummary="true"/>
                </h:panelGroup>

                <h:commandButton id="Submit"  value="Submit" action="#{foxySummaryCustSalesRpt.search}"/>
            </h:panelGrid>
        </h:form>
    </h:panelGrid>
    <%-- End of Search--%>

    <%-- Panel for Listing --%>
    <h:panelGrid id="ListOrderGrid" styleClass="tablebg" rendered="#{foxySummaryCustSalesRpt.list}" width="100%">
        <h:form id="ListReportForm">
            <h:panelGrid id="Top" columns="1" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="100%">

                <h:outputText value="Customer Sales Yearly Summary Report #{foxySummaryCustSalesRpt.title}" styleClass="smalltitle" />
            </h:panelGrid>
            <h:panelGrid id="ListDisplay" columns="1" width="100%">
                <t:dataTable value="#{foxySummaryCustSalesRpt.custSalesListModel}" var="custOrder"
                             id="DetailData"
                             styleClass="FOXY_REPORT_1"
                             headerClass="FOXY_REPORT_HEADER_1"
                             footerClass="FOXY_REPORT_HEADER_1"                    
                             preserveDataModel="false"
                             cellspacing="0"
                             rowClasses="FOXY_REPORT_ROW_1,FOXY_REPORT_ROW_2">

                    <%-- f:facet name="header">
                        <h:outputText value="All quantity in Dozen and format as [quantity]/[day of delivery]" styleClass="FOX_HELPMSG" />
                    </f:facet --%>
                    <f:facet name="footer">
                        <h:outputText value="End of Record(s)" styleClass="FOX_HELPMSG"/>
                    </f:facet>                     

                    <t:column width="10%">
                        <f:facet name="header">
                            <h:outputText value="Customer" />
                        </f:facet>                        
                        <h:outputText value="#{custOrder.custName}" />
                    </t:column>                                        

                    <%-- JANUARY --%>
                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R" rendered="#{foxySummaryCustSalesRpt.displayUnit == 'DZN'}">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="[JAN] Qty Dzn" />
                            </h:panelGrid>
                        </f:facet>
                        <h:panelGroup rendered="#{custOrder.custName != null}">
                            <h:outputText value="#{custOrder.qtyDznM01}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>                            
                        </h:panelGroup>
                        <h:panelGroup rendered="#{custOrder.custName == null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <h:outputText value="#{custOrder.qtyDznM01}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>
                        </h:panelGroup>
                    </t:column>                    
                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R"  rendered="#{foxySummaryCustSalesRpt.displayUnit == 'PCS'}">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="[JAN] Qty PCS" />
                            </h:panelGrid>
                        </f:facet>
                        <h:panelGroup rendered="#{custOrder.custName != null}">
                            <h:outputText value="#{custOrder.qtyPcsM01}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>                            
                        </h:panelGroup>
                        <h:panelGroup rendered="#{custOrder.custName == null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <h:outputText value="#{custOrder.qtyPcsM01}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>
                        </h:panelGroup>
                    </t:column>                    
                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="Tot Val" />
                            </h:panelGrid>
                        </f:facet>
                        <h:panelGroup rendered="#{custOrder.custName != null}">
                            <h:outputText value="#{custOrder.totValM01}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>                            
                        </h:panelGroup>
                        <h:panelGroup rendered="#{custOrder.custName == null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <h:outputText value="#{custOrder.totValM01}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>
                        </h:panelGroup>
                    </t:column>


                    <%-- Febuary --%>
                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R" rendered="#{foxySummaryCustSalesRpt.displayUnit == 'DZN'}">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="[FEB] Qty Dzn" />
                            </h:panelGrid>
                        </f:facet>
                        <h:panelGroup rendered="#{custOrder.custName != null}">
                            <h:outputText value="#{custOrder.qtyDznM02}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>                            
                        </h:panelGroup>
                        <h:panelGroup rendered="#{custOrder.custName == null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <h:outputText value="#{custOrder.qtyDznM02}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>
                        </h:panelGroup>
                    </t:column>                    
                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R"  rendered="#{foxySummaryCustSalesRpt.displayUnit == 'PCS'}">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="[FEB] Qty PCS" />
                            </h:panelGrid>
                        </f:facet>
                        <h:panelGroup rendered="#{custOrder.custName != null}">
                            <h:outputText value="#{custOrder.qtyPcsM02}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>                            
                        </h:panelGroup>
                        <h:panelGroup rendered="#{custOrder.custName == null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <h:outputText value="#{custOrder.qtyPcsM02}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>
                        </h:panelGroup>
                    </t:column>                    
                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="Tot Val" />
                            </h:panelGrid>
                        </f:facet>
                        <h:panelGroup rendered="#{custOrder.custName != null}">
                            <h:outputText value="#{custOrder.totValM02}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>                            
                        </h:panelGroup>
                        <h:panelGroup rendered="#{custOrder.custName == null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <h:outputText value="#{custOrder.totValM02}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>
                        </h:panelGroup>
                    </t:column>


                    <%-- MARCH --%>
                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R" rendered="#{foxySummaryCustSalesRpt.displayUnit == 'DZN'}">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="[MAR] Qty Dzn" />
                            </h:panelGrid>
                        </f:facet>
                        <h:panelGroup rendered="#{custOrder.custName != null}">
                            <h:outputText value="#{custOrder.qtyDznM03}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>                            
                        </h:panelGroup>
                        <h:panelGroup rendered="#{custOrder.custName == null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <h:outputText value="#{custOrder.qtyDznM03}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>
                        </h:panelGroup>
                    </t:column>                    
                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R" rendered="#{foxySummaryCustSalesRpt.displayUnit == 'PCS'}">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="[MAR] Qty PCS" />
                            </h:panelGrid>
                        </f:facet>
                        <h:panelGroup rendered="#{custOrder.custName != null}">
                            <h:outputText value="#{custOrder.qtyPcsM03}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>                            
                        </h:panelGroup>
                        <h:panelGroup rendered="#{custOrder.custName == null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <h:outputText value="#{custOrder.qtyPcsM03}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>
                        </h:panelGroup>
                    </t:column>                    
                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="Tot Val" />
                            </h:panelGrid>
                        </f:facet>
                        <h:panelGroup rendered="#{custOrder.custName != null}">
                            <h:outputText value="#{custOrder.totValM03}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>                            
                        </h:panelGroup>
                        <h:panelGroup rendered="#{custOrder.custName == null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <h:outputText value="#{custOrder.totValM03}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>
                        </h:panelGroup>
                    </t:column>


                    <%-- APRIL --%>
                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R" rendered="#{foxySummaryCustSalesRpt.displayUnit == 'DZN'}">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="[APR] Qty Dzn" />
                            </h:panelGrid>
                        </f:facet>
                        <h:panelGroup rendered="#{custOrder.custName != null}">
                            <h:outputText value="#{custOrder.qtyDznM04}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>                            
                        </h:panelGroup>
                        <h:panelGroup rendered="#{custOrder.custName == null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <h:outputText value="#{custOrder.qtyDznM04}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>
                        </h:panelGroup>
                    </t:column>                    
                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R" rendered="#{foxySummaryCustSalesRpt.displayUnit == 'PCS'}">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="[APR] Qty PCS" />
                            </h:panelGrid>
                        </f:facet>
                        <h:panelGroup rendered="#{custOrder.custName != null}">
                            <h:outputText value="#{custOrder.qtyPcsM04}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>                            
                        </h:panelGroup>
                        <h:panelGroup rendered="#{custOrder.custName == null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <h:outputText value="#{custOrder.qtyPcsM04}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>
                        </h:panelGroup>
                    </t:column>                    
                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="Tot Val" />
                            </h:panelGrid>
                        </f:facet>
                        <h:panelGroup rendered="#{custOrder.custName != null}">
                            <h:outputText value="#{custOrder.totValM04}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>                            
                        </h:panelGroup>
                        <h:panelGroup rendered="#{custOrder.custName == null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <h:outputText value="#{custOrder.totValM04}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>
                        </h:panelGroup>
                    </t:column>


                    <%-- MAY --%>
                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R" rendered="#{foxySummaryCustSalesRpt.displayUnit == 'DZN'}">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="[MAY] Qty Dzn" />
                            </h:panelGrid>
                        </f:facet>
                        <h:panelGroup rendered="#{custOrder.custName != null}">
                            <h:outputText value="#{custOrder.qtyDznM05}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>                            
                        </h:panelGroup>
                        <h:panelGroup rendered="#{custOrder.custName == null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <h:outputText value="#{custOrder.qtyDznM05}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>
                        </h:panelGroup>
                    </t:column>                    
                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R" rendered="#{foxySummaryCustSalesRpt.displayUnit == 'PCS'}">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="[MAY] Qty PCS" />
                            </h:panelGrid>
                        </f:facet>
                        <h:panelGroup rendered="#{custOrder.custName != null}">
                            <h:outputText value="#{custOrder.qtyPcsM05}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>                            
                        </h:panelGroup>
                        <h:panelGroup rendered="#{custOrder.custName == null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <h:outputText value="#{custOrder.qtyPcsM05}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>
                        </h:panelGroup>
                    </t:column>                    
                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="Tot Val" />
                            </h:panelGrid>
                        </f:facet>
                        <h:panelGroup rendered="#{custOrder.custName != null}">
                            <h:outputText value="#{custOrder.totValM05}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>                            
                        </h:panelGroup>
                        <h:panelGroup rendered="#{custOrder.custName == null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <h:outputText value="#{custOrder.totValM05}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>
                        </h:panelGroup>
                    </t:column>


                    <%-- JUNE --%>
                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R" rendered="#{foxySummaryCustSalesRpt.displayUnit == 'DZN'}">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="[JUN] Qty Dzn" />
                            </h:panelGrid>
                        </f:facet>
                        <h:panelGroup rendered="#{custOrder.custName != null}">
                            <h:outputText value="#{custOrder.qtyDznM06}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>                            
                        </h:panelGroup>
                        <h:panelGroup rendered="#{custOrder.custName == null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <h:outputText value="#{custOrder.qtyDznM06}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>
                        </h:panelGroup>
                    </t:column>                    
                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R" rendered="#{foxySummaryCustSalesRpt.displayUnit == 'PCS'}">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="[JUN] Qty PCS" />
                            </h:panelGrid>
                        </f:facet>
                        <h:panelGroup rendered="#{custOrder.custName != null}">
                            <h:outputText value="#{custOrder.qtyPcsM06}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>                            
                        </h:panelGroup>
                        <h:panelGroup rendered="#{custOrder.custName == null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <h:outputText value="#{custOrder.qtyPcsM06}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>
                        </h:panelGroup>
                    </t:column>                    
                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="Tot Val" />
                            </h:panelGrid>
                        </f:facet>
                        <h:panelGroup rendered="#{custOrder.custName != null}">
                            <h:outputText value="#{custOrder.totValM06}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>                            
                        </h:panelGroup>
                        <h:panelGroup rendered="#{custOrder.custName == null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <h:outputText value="#{custOrder.totValM06}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>
                        </h:panelGroup>
                    </t:column>


                    <%-- JULY --%>
                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R" rendered="#{foxySummaryCustSalesRpt.displayUnit == 'DZN'}">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="[JUL] Qty Dzn" />
                            </h:panelGrid>
                        </f:facet>
                        <h:panelGroup rendered="#{custOrder.custName != null}">
                            <h:outputText value="#{custOrder.qtyDznM07}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>                            
                        </h:panelGroup>
                        <h:panelGroup rendered="#{custOrder.custName == null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <h:outputText value="#{custOrder.qtyDznM07}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>
                        </h:panelGroup>
                    </t:column>                    
                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R" rendered="#{foxySummaryCustSalesRpt.displayUnit == 'PCS'}">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="[JUL] Qty PCS" />
                            </h:panelGrid>
                        </f:facet>
                        <h:panelGroup rendered="#{custOrder.custName != null}">
                            <h:outputText value="#{custOrder.qtyPcsM07}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>                            
                        </h:panelGroup>
                        <h:panelGroup rendered="#{custOrder.custName == null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <h:outputText value="#{custOrder.qtyPcsM07}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>
                        </h:panelGroup>
                    </t:column>                    
                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="Tot Val" />
                            </h:panelGrid>
                        </f:facet>
                        <h:panelGroup rendered="#{custOrder.custName != null}">
                            <h:outputText value="#{custOrder.totValM07}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>                            
                        </h:panelGroup>
                        <h:panelGroup rendered="#{custOrder.custName == null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <h:outputText value="#{custOrder.totValM07}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>
                        </h:panelGroup>
                    </t:column>


                    <%-- AUGUST --%>
                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R" rendered="#{foxySummaryCustSalesRpt.displayUnit == 'DZN'}">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="[AUG] Qty Dzn" />
                            </h:panelGrid>
                        </f:facet>
                        <h:panelGroup rendered="#{custOrder.custName != null}">
                            <h:outputText value="#{custOrder.qtyDznM08}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>                            
                        </h:panelGroup>
                        <h:panelGroup rendered="#{custOrder.custName == null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <h:outputText value="#{custOrder.qtyDznM08}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>
                        </h:panelGroup>
                    </t:column>                    
                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R" rendered="#{foxySummaryCustSalesRpt.displayUnit == 'PCS'}">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="[AUG] Qty PCS" />
                            </h:panelGrid>
                        </f:facet>
                        <h:panelGroup rendered="#{custOrder.custName != null}">
                            <h:outputText value="#{custOrder.qtyPcsM08}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>                            
                        </h:panelGroup>
                        <h:panelGroup rendered="#{custOrder.custName == null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <h:outputText value="#{custOrder.qtyPcsM08}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>
                        </h:panelGroup>
                    </t:column>                    
                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="Tot Val" />
                            </h:panelGrid>
                        </f:facet>
                        <h:panelGroup rendered="#{custOrder.custName != null}">
                            <h:outputText value="#{custOrder.totValM08}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>                            
                        </h:panelGroup>
                        <h:panelGroup rendered="#{custOrder.custName == null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <h:outputText value="#{custOrder.totValM08}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>
                        </h:panelGroup>
                    </t:column>


                    <%-- SEPTEMBER --%>
                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R" rendered="#{foxySummaryCustSalesRpt.displayUnit == 'DZN'}">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="[SEP] Qty Dzn" />
                            </h:panelGrid>
                        </f:facet>
                        <h:panelGroup rendered="#{custOrder.custName != null}">
                            <h:outputText value="#{custOrder.qtyDznM09}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>                            
                        </h:panelGroup>
                        <h:panelGroup rendered="#{custOrder.custName == null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <h:outputText value="#{custOrder.qtyDznM09}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>
                        </h:panelGroup>
                    </t:column>                    
                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R" rendered="#{foxySummaryCustSalesRpt.displayUnit == 'PCS'}">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="[SEP] Qty PCS" />
                            </h:panelGrid>
                        </f:facet>
                        <h:panelGroup rendered="#{custOrder.custName != null}">
                            <h:outputText value="#{custOrder.qtyPcsM09}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>                            
                        </h:panelGroup>
                        <h:panelGroup rendered="#{custOrder.custName == null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <h:outputText value="#{custOrder.qtyPcsM09}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>
                        </h:panelGroup>
                    </t:column>                    
                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="Tot Val" />
                            </h:panelGrid>
                        </f:facet>
                        <h:panelGroup rendered="#{custOrder.custName != null}">
                            <h:outputText value="#{custOrder.totValM09}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>                            
                        </h:panelGroup>
                        <h:panelGroup rendered="#{custOrder.custName == null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <h:outputText value="#{custOrder.totValM09}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>
                        </h:panelGroup>
                    </t:column>


                    <%-- OCTOBER --%>
                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R" rendered="#{foxySummaryCustSalesRpt.displayUnit == 'DZN'}">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="[OCT] Qty Dzn" />
                            </h:panelGrid>
                        </f:facet>
                        <h:panelGroup rendered="#{custOrder.custName != null}">
                            <h:outputText value="#{custOrder.qtyDznM10}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>                            
                        </h:panelGroup>
                        <h:panelGroup rendered="#{custOrder.custName == null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <h:outputText value="#{custOrder.qtyDznM10}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>
                        </h:panelGroup>
                    </t:column>                    
                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R" rendered="#{foxySummaryCustSalesRpt.displayUnit == 'PCS'}">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="[OCT] Qty PCS" />
                            </h:panelGrid>
                        </f:facet>
                        <h:panelGroup rendered="#{custOrder.custName != null}">
                            <h:outputText value="#{custOrder.qtyPcsM10}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>                            
                        </h:panelGroup>
                        <h:panelGroup rendered="#{custOrder.custName == null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <h:outputText value="#{custOrder.qtyPcsM10}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>
                        </h:panelGroup>
                    </t:column>                    
                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="Tot Val" />
                            </h:panelGrid>
                        </f:facet>
                        <h:panelGroup rendered="#{custOrder.custName != null}">
                            <h:outputText value="#{custOrder.totValM10}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>                            
                        </h:panelGroup>
                        <h:panelGroup rendered="#{custOrder.custName == null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <h:outputText value="#{custOrder.totValM10}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>
                        </h:panelGroup>
                    </t:column>


                    <%-- NOVEMBER --%>
                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R" rendered="#{foxySummaryCustSalesRpt.displayUnit == 'DZN'}">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="[NOV] Qty Dzn" />
                            </h:panelGrid>
                        </f:facet>
                        <h:panelGroup rendered="#{custOrder.custName != null}">
                            <h:outputText value="#{custOrder.qtyDznM11}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>                            
                        </h:panelGroup>
                        <h:panelGroup rendered="#{custOrder.custName == null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <h:outputText value="#{custOrder.qtyDznM11}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>
                        </h:panelGroup>
                    </t:column>                    
                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R" rendered="#{foxySummaryCustSalesRpt.displayUnit == 'PCS'}">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="[NOV] Qty PCS" />
                            </h:panelGrid>
                        </f:facet>
                        <h:panelGroup rendered="#{custOrder.custName != null}">
                            <h:outputText value="#{custOrder.qtyPcsM11}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>                            
                        </h:panelGroup>
                        <h:panelGroup rendered="#{custOrder.custName == null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <h:outputText value="#{custOrder.qtyPcsM11}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>
                        </h:panelGroup>
                    </t:column>                    
                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="Tot Val" />
                            </h:panelGrid>
                        </f:facet>
                        <h:panelGroup rendered="#{custOrder.custName != null}">
                            <h:outputText value="#{custOrder.totValM11}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>                            
                        </h:panelGroup>
                        <h:panelGroup rendered="#{custOrder.custName == null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <h:outputText value="#{custOrder.totValM11}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>
                        </h:panelGroup>
                    </t:column>


                    <%-- DECEMBER --%>
                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R" rendered="#{foxySummaryCustSalesRpt.displayUnit == 'DZN'}">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="[DEC] Qty Dzn" />
                            </h:panelGrid>
                        </f:facet>
                        <h:panelGroup rendered="#{custOrder.custName != null}">
                            <h:outputText value="#{custOrder.qtyDznM12}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>                            
                        </h:panelGroup>
                        <h:panelGroup rendered="#{custOrder.custName == null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <h:outputText value="#{custOrder.qtyDznM12}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>
                        </h:panelGroup>
                    </t:column>                    
                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R" rendered="#{foxySummaryCustSalesRpt.displayUnit == 'PCS'}">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="[DEC] Qty PCS" />
                            </h:panelGrid>
                        </f:facet>
                        <h:panelGroup rendered="#{custOrder.custName != null}">
                            <h:outputText value="#{custOrder.qtyPcsM12}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>                            
                        </h:panelGroup>
                        <h:panelGroup rendered="#{custOrder.custName == null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <h:outputText value="#{custOrder.qtyPcsM12}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>
                        </h:panelGroup>
                    </t:column>                    
                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="Tot Val" />
                            </h:panelGrid>
                        </f:facet>
                        <h:panelGroup rendered="#{custOrder.custName != null}">
                            <h:outputText value="#{custOrder.totValM12}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>                            
                        </h:panelGroup>
                        <h:panelGroup rendered="#{custOrder.custName == null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <h:outputText value="#{custOrder.totValM12}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>
                        </h:panelGroup>
                    </t:column>




                </t:dataTable>                           
            </h:panelGrid>
        </h:form>
    </h:panelGrid>            
    <%-- End of Listing--%>

    <%@ include file="foxyFooter.jsp" %>
</f:view>
