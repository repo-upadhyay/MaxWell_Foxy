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
    <%-- h:panelGrid id="SearchGrid" styleClass="tablebg" width="100%" rendered="#{foxyFactoryYearlyRpt.search}" --%>
    <h:panelGrid id="SearchGrid" styleClass="tablebg" width="100%"  rendered="#{not foxyFactoryYearlyRpt.list}">
        <h:outputText value="Factory Report By Delivery Date" styleClass="smalltitle" />
        <%--h:form id="SearchForm" rendered="#{foxyFactoryYearlyRpt.search}" --%>

        <h:form id="SearchForm">
            <t:saveState value="#{foxyFactoryYearlyRpt.country}"/>
            <t:saveState value="#{foxyFactoryYearlyRpt.mainfactory}"/>
            <h:panelGrid id="SearchInput" columns="2" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="50%">                        

                <t:outputLabel value="Country Origin:" for="Country"/>
                <h:panelGroup>
                    <a4j:region id="ajaxregioncountryfactory" renderRegionOnly="false" selfRendered="true">
                        <h:selectOneMenu id="Country" styleClass="FOX_INPUT" 
                                         required="true" 
                                         immediate="true"
                                         value="#{foxyFactoryYearlyRpt.country}">
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
                                     value="#{foxyFactoryYearlyRpt.mainfactory}">
                        <f:selectItems value="#{foxyFactoryYearlyRpt.factoryByCountryList}"/>
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

                <t:outputLabel for="Year" value="Year:" />
                <h:panelGroup>
                    <t:inputTextHelp id="Year" styleClass="FOX_INPUT" required="true" 
                                     helpText="YYYY"  value="#{foxyFactoryYearlyRpt.year}"/>
                    <h:message errorClass="FOX_ERROR" for="Year" showDetail="true" showSummary="true"/>
                </h:panelGroup>                        


                <h:commandButton id="Submit"  value="Submit" action="#{foxyFactoryYearlyRpt.search}"/>
            </h:panelGrid>
        </h:form>
    </h:panelGrid>
    <%-- End of Search--%>

    <%-- Panel for Listing --%>
    <h:panelGrid id="ListOrderGrid" styleClass="tablebg" rendered="#{foxyFactoryYearlyRpt.list}" width="100%">        
        <h:form id="ListReportForm">
            <h:panelGrid id="Top" columns="1" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="100%">

                <h:outputText value="Factory Report By Delivery Date #{foxyFactoryYearlyRpt.title}" styleClass="smalltitle" />
            </h:panelGrid>
            <h:panelGrid id="ListDisplay" columns="1" width="100%">
                <t:dataTable value="#{foxyFactoryYearlyRpt.custSalesListModel}" var="custOrder"
                             id="DetailData"
                             styleClass="FOXY_REPORT_1"
                             headerClass="FOXY_REPORT_HEADER_1"
                             footerClass="FOXY_REPORT_HEADER_1"                    
                             preserveDataModel="false"
                             cellspacing="0"
                             rowClasses="FOXY_REPORT_ROW_1,FOXY_REPORT_ROW_2">

                    <f:facet name="header">
                        <h:outputText value="All quantity in Dozen and format as [quantity]/[day of delivery]" styleClass="FOX_HELPMSG" />
                    </f:facet>
                    <f:facet name="footer">
                        <h:outputText value="End of Record(s)" styleClass="FOX_HELPMSG"/>
                    </f:facet>                     

                    <t:column groupBy="true" width="8%">
                        <f:facet name="header">
                            <h:outputText value="Ref No" />
                        </f:facet>
                        <h:outputText styleClass="FOXY_REPORT_GRAND_TOTAL"  value="#{custOrder.refNo}" rendered="#{custOrder.customer == null}" />
                        <h:outputText value="#{custOrder.refNo}#{custOrder.month}#{custOrder.location}"  rendered="#{custOrder.customer != null}"/>
                    </t:column>                   

                    <t:column width="8%">
                        <f:facet name="header">
                            <h:outputText value="Customer" />
                        </f:facet>                        
                        <h:outputText value="#{custOrder.customer}" />
                    </t:column>

                    <t:column width="10%">
                        <f:facet name="header">
                            <h:outputText value="Brand" />
                        </f:facet>                        
                        <h:outputText value="#{custOrder.brand}" />
                    </t:column>

                    <t:column width="10%">
                        <f:facet name="header">
                            <h:outputText value="Division" />
                        </f:facet>                        
                        <h:outputText value="#{custOrder.division}" />
                    </t:column>


                    <t:column width="8%">
                        <f:facet name="header">
                            <h:outputText value="Style" />
                        </f:facet>
                        <h:outputText value="#{custOrder.style}" />
                    </t:column>           


                    <t:column width="8%">
                        <f:facet name="header">
                            <h:outputText value="Category" />
                        </f:facet>
                        <h:outputText value="#{custOrder.category}" />
                    </t:column>           


                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="JAN" />
                            </h:panelGrid>
                        </f:facet>
                        <h:panelGroup rendered="#{custOrder.customer != null and custOrder.qtyd_M01 != null}">
                            <h:outputText value="#{custOrder.qtyd_M01}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>
                            <h:outputText value="/#{custOrder.dayinmonth_M01}"/>
                        </h:panelGroup>
                        <h:panelGroup rendered="#{custOrder.customer == null and custOrder.qtyd_M01 != null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <h:outputText value="#{custOrder.qtyd_M01}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>
                        </h:panelGroup>
                    </t:column>

                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="FEB" />
                            </h:panelGrid>
                        </f:facet>
                        <h:panelGroup rendered="#{custOrder.customer != null and custOrder.qtyd_M02 != null}">
                            <h:outputText value="#{custOrder.qtyd_M02}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>
                            <h:outputText value="/#{custOrder.dayinmonth_M02}"/>
                        </h:panelGroup>
                        <h:panelGroup rendered="#{custOrder.customer == null and custOrder.qtyd_M02 != null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <h:outputText value="#{custOrder.qtyd_M02}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>
                        </h:panelGroup>
                    </t:column>

                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="MAR" />
                            </h:panelGrid>
                        </f:facet>
                        <h:panelGroup rendered="#{custOrder.customer != null and custOrder.qtyd_M03 != null}">
                            <h:outputText value="#{custOrder.qtyd_M03}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>
                            <h:outputText value="/#{custOrder.dayinmonth_M03}"/>
                        </h:panelGroup>
                        <h:panelGroup rendered="#{custOrder.customer == null and custOrder.qtyd_M03 != null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <h:outputText value="#{custOrder.qtyd_M03}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>
                        </h:panelGroup>
                    </t:column>

                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="APR" />
                            </h:panelGrid>
                        </f:facet>
                        <h:panelGroup rendered="#{custOrder.customer != null and custOrder.qtyd_M04 != null}">
                            <h:outputText value="#{custOrder.qtyd_M04}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>
                            <h:outputText value="/#{custOrder.dayinmonth_M04}"/>
                        </h:panelGroup>
                        <h:panelGroup rendered="#{custOrder.customer == null and custOrder.qtyd_M04 != null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <h:outputText value="#{custOrder.qtyd_M04}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>
                        </h:panelGroup>
                    </t:column>

                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="MAY" />
                            </h:panelGrid>
                        </f:facet>
                        <h:panelGroup rendered="#{custOrder.customer != null and custOrder.qtyd_M05 != null}">
                            <h:outputText value="#{custOrder.qtyd_M05}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>
                            <h:outputText value="/#{custOrder.dayinmonth_M05}"/>
                        </h:panelGroup>
                        <h:panelGroup rendered="#{custOrder.customer == null and custOrder.qtyd_M05 != null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <h:outputText value="#{custOrder.qtyd_M05}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>
                        </h:panelGroup>
                    </t:column>

                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="JUN" />
                            </h:panelGrid>
                        </f:facet>
                        <h:panelGroup rendered="#{custOrder.customer != null and custOrder.qtyd_M06 != null}">
                            <h:outputText value="#{custOrder.qtyd_M06}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>
                            <h:outputText value="/#{custOrder.dayinmonth_M06}"/>
                        </h:panelGroup>
                        <h:panelGroup rendered="#{custOrder.customer == null and custOrder.qtyd_M06 != null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <h:outputText value="#{custOrder.qtyd_M06}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>                            
                        </h:panelGroup>
                    </t:column>

                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="JUL" />
                            </h:panelGrid>
                        </f:facet>
                        <h:panelGroup rendered="#{custOrder.customer != null and custOrder.qtyd_M07 != null}">
                            <h:outputText value="#{custOrder.qtyd_M07}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>
                            <h:outputText value="/#{custOrder.dayinmonth_M07}"/>
                        </h:panelGroup>
                        <h:panelGroup rendered="#{custOrder.customer == null and custOrder.qtyd_M07 != null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <h:outputText value="#{custOrder.qtyd_M07}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>
                        </h:panelGroup>
                    </t:column>

                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="AUG" />
                            </h:panelGrid>
                        </f:facet>
                        <h:panelGroup rendered="#{custOrder.customer != null and custOrder.qtyd_M08 != null}">
                            <h:outputText value="#{custOrder.qtyd_M08}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>
                            <h:outputText value="/#{custOrder.dayinmonth_M08}"/>
                        </h:panelGroup>
                        <h:panelGroup rendered="#{custOrder.customer == null and custOrder.qtyd_M08 != null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <h:outputText value="#{custOrder.qtyd_M08}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>
                        </h:panelGroup>
                    </t:column>

                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="SEP" />
                            </h:panelGrid>
                        </f:facet>
                        <h:panelGroup rendered="#{custOrder.customer != null and custOrder.qtyd_M09 != null}">
                            <h:outputText value="#{custOrder.qtyd_M09}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>
                            <h:outputText value="/#{custOrder.dayinmonth_M09}"/>
                        </h:panelGroup>
                        <h:panelGroup rendered="#{custOrder.customer == null and custOrder.qtyd_M09 != null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <h:outputText value="#{custOrder.qtyd_M09}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>
                        </h:panelGroup>
                    </t:column>

                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="OCT" />
                            </h:panelGrid>
                        </f:facet>
                        <h:panelGroup rendered="#{custOrder.customer != null and custOrder.qtyd_M10 != null}">
                            <h:outputText value="#{custOrder.qtyd_M10}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>
                            <h:outputText value="/#{custOrder.dayinmonth_M10}"/>
                        </h:panelGroup>
                        <h:panelGroup rendered="#{custOrder.customer == null and custOrder.qtyd_M10 != null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <h:outputText value="#{custOrder.qtyd_M10}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>
                        </h:panelGroup>
                    </t:column>

                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="NOV" />
                            </h:panelGrid>
                        </f:facet>
                        <h:panelGroup rendered="#{custOrder.customer != null and custOrder.qtyd_M11 != null}">
                            <h:outputText value="#{custOrder.qtyd_M11}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>
                            <h:outputText value="/#{custOrder.dayinmonth_M11}"/>
                        </h:panelGroup>
                        <h:panelGroup rendered="#{custOrder.customer == null and custOrder.qtyd_M11 != null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <h:outputText value="#{custOrder.qtyd_M11}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>
                        </h:panelGroup>
                    </t:column>

                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="DEC" />
                            </h:panelGrid>
                        </f:facet>
                        <h:panelGroup rendered="#{custOrder.customer != null and custOrder.qtyd_M12 != null}">
                            <h:outputText value="#{custOrder.qtyd_M12}">
                                <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                            </h:outputText>
                            <h:outputText value="/#{custOrder.dayinmonth_M12}"/>
                        </h:panelGroup>
                        <h:panelGroup rendered="#{custOrder.customer == null and custOrder.qtyd_M12 != null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <h:outputText value="#{custOrder.qtyd_M12}">
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
