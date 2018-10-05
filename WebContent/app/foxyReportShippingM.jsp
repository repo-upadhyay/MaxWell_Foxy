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
    <h:panelGrid id="SearchGrid" styleClass="tablebg" rendered="#{not foxyShippingReports.list}" width="100%">
        <h:outputText value="Shipping Report" styleClass="smalltitle" />
        <h:form id="SearchForm">
            <t:saveState value="#{foxyShippingReports.country}"/>
            <t:saveState value="#{foxyShippingReports.mainfactory}"/>
            <h:outputText value="Leave shipmode field blank to list for all shipmode records" styleClass="FOX_HELPMSG"/> 
            <h:panelGrid id="SearchInput" columns="2" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="50%">

                <t:outputLabel for="Country" value="Country:" />
                <h:panelGroup>
                    <a4j:region id="ajaxregioncountryfactory" renderRegionOnly="false" selfRendered="true">
                        <h:selectOneMenu id="Country" styleClass="FOX_INPUT" required="true" value="#{foxyShippingReports.country}">
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
                                     value="#{foxyShippingReports.mainfactory}">
                        <f:selectItems value="#{foxyShippingReports.factoryByCountryList}"/>
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
                                     helpText="YYYY"  value="#{foxyShippingReports.year}"/>
                    <h:message errorClass="FOX_ERROR" for="Year" showDetail="true" showSummary="true"/>
                </h:panelGroup>                        

                <t:outputLabel for="Month" value="Month:" />
                <h:panelGroup>
                    <t:inputTextHelp id="Month" styleClass="FOX_INPUT" required="true" 
                                     helpText="MM" value="#{foxyShippingReports.month}"/>
                    <h:message errorClass="FOX_ERROR" for="Month" showDetail="true" showSummary="true"/>
                </h:panelGroup>  

                <t:outputLabel for="sortByInvoice" value="Sort By Invoice:" />
                <h:panelGroup>
                    <t:selectBooleanCheckbox id="sortByInvoice" styleClass="FOX_INPUT"
                                             required="false"
                                             value="#{foxyShippingReports.sordByInvoice}"/>
                    <h:message errorClass="FOX_ERROR" for="sortByInvoice" showDetail="true" showSummary="true"/>
                </h:panelGroup>                

                <t:outputLabel for="ShipMode" value="Ship Mode" />
                <h:panelGroup>
                    <h:selectOneMenu id="ShipMode" styleClass="FOX_INPUT" required="false" value="#{foxyShippingReports.shipMode}">
                        <f:selectItems value="#{listData.shipTypeList}"/>
                    </h:selectOneMenu>                        
                    <h:message errorClass="FOX_ERROR" for="ShipMode" showDetail="true" showSummary="true"/>
                </h:panelGroup>                   

                <h:commandButton id="Submit"  value="Submit" action="#{foxyShippingReports.search}"/>
            </h:panelGrid>
        </h:form>
    </h:panelGrid>
    <%-- End of Search--%>

    <%-- Panel for Listing --%>
    <h:panelGrid id="ListOrderGrid" styleClass="tablebg" rendered="#{foxyShippingReports.list}" width="100%">        
        <h:form id="ListReportForm">
            <h:panelGrid id="Top" columns="1" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="100%">

                <h:outputText value="Shipping Report for #{foxyShippingReports.title}" styleClass="smalltitle" />

            </h:panelGrid>
            <h:panelGrid id="ListDisplay" columns="1" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="100%">
                <t:dataTable value="#{foxyShippingReports.shippingReportData}" var="shipReport"
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

                    <f:facet name="header">
                        <h:outputText value="" styleClass="FOX_HELPMSG"/>
                    </f:facet>  

                    <t:column width="6%">
                        <f:facet name="header">
                            <h:outputText value="RefNo" />
                        </f:facet>
                        <h:outputText value="#{shipReport.orderId}#{shipReport.month}#{shipReport.location}#{shipReport.subLocation}" rendered="#{shipReport.month != null}"/>
                        <h:outputText value="#{shipReport.orderId}" styleClass="FOXY_REPORT_GRAND_TOTAL" rendered="#{shipReport.month == null}"/>
                    </t:column>

                    <t:column width="10%">
                        <f:facet name="header">
                            <h:outputText value="Chutex Inv" />
                        </f:facet>
                        <h:outputText value="#{shipReport.invoice}"/>
                    </t:column>                                        

                    <t:column width="6%">
                        <f:facet name="header">
                            <h:outputText value="P.O.Number" />
                        </f:facet>
                        <h:outputText value="#{shipReport.poNumber}" />
                    </t:column>

                    <t:column width="12%">
                        <f:facet name="header">
                            <h:outputText value="StyleCode" />
                        </f:facet>
                        <h:outputText value="#{shipReport.stylecode}" />
                    </t:column>                    

                    <t:column width="6%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="Qty(PCS)" />
                            </h:panelGrid>
                        </f:facet>
                        <h:outputText value="#{shipReport.qtyPcs}" rendered="#{shipReport.month != null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>

                        <h:outputText value="#{shipReport.qtyPcs}" styleClass="FOXY_REPORT_GRAND_TOTAL" rendered="#{shipReport.month == null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>
                    </t:column>


                    <t:column width="6%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="CMT U/P(USD)" />
                            </h:panelGrid>
                        </f:facet>
                        <h:outputText value="#{shipReport.cmtUnitPrc}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>                            
                    </t:column>

                    <t:column width="6%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="FOB U/P(USD)" />
                            </h:panelGrid>
                        </f:facet>
                        <h:outputText value="#{shipReport.fobUnitPrc}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>                            
                    </t:column>


                    <t:column width="6%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="CMT Amt" />
                            </h:panelGrid>
                        </f:facet>
                        <h:outputText value="#{shipReport.cmtUnitPrc * shipReport.qtyPcs}" rendered="#{shipReport.month != null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>                            
                    </t:column>


                    <t:column width="6%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="FOB Amt" />
                            </h:panelGrid>
                        </f:facet>
                        <h:outputText value="#{shipReport.fobUnitPrc * shipReport.qtyPcs}" rendered="#{shipReport.month != null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>                            
                    </t:column>



                    <t:column width="6%">
                        <f:facet name="header">
                            <h:outputText value="Cust/Brand/Div" />
                        </f:facet>
                        <h:outputText value="#{shipReport.custCode}/#{shipReport.custBrand}/#{shipReport.custDivision}" rendered="#{shipReport.month != null}"/>
                    </t:column>                    

                    <t:column width="6%">
                        <f:facet name="header">
                            <h:outputText value="ETD" />
                        </f:facet>
                        <h:outputText value="#{shipReport.etd}">
                            <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                        </h:outputText>
                    </t:column>                                                            

                    <t:column width="6%">
                        <f:facet name="header">
                            <h:outputText value="Cat/Dest" />
                        </f:facet>
                        <h:outputText value="#{shipReport.category}/#{shipReport.destination}" rendered="#{shipReport.month != null}"/>
                    </t:column>

                    <t:column width="6%">
                        <f:facet name="header">
                            <h:outputText value="Shipmode" />
                        </f:facet>
                        <h:outputText value="#{shipReport.shipMode}"/>
                    </t:column>

                    <t:column width="6%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="Cost Freight" />
                            </h:panelGrid>
                        </f:facet>
                        <h:outputText value="#{shipReport.costFreight}" rendered="#{shipReport.month != null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>

                        <h:outputText value="#{shipReport.costFreight}" styleClass="FOXY_REPORT_GRAND_TOTAL" rendered="#{shipReport.month == null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>                        
                    </t:column>                                        

                    <t:column width="6%">
                        <f:facet name="header">
                            <h:outputText value="LC.No" />
                        </f:facet>
                        <h:outputText value="#{shipReport.lcNumber}"/>
                    </t:column>

                    <t:column width="10%">
                        <f:facet name="header">
                            <h:outputText value="VisaNo" />
                        </f:facet>
                        <h:outputText value="#{shipReport.visaNo}"/>
                    </t:column>

                    <t:column width="10%">
                        <f:facet name="header">
                            <h:outputText value="C/O.Cert" />
                        </f:facet>
                        <h:outputText value="#{shipReport.coCert}"/>
                    </t:column>

                    <t:column width="10%">
                        <f:facet name="header">
                            <h:outputText value="ExpRegNo" />
                        </f:facet>
                        <h:outputText value="#{shipReport.expRegNo}"/>
                    </t:column>                                        

                </t:dataTable>
            </h:panelGrid>
        </h:form>
    </h:panelGrid>            
    <%-- End of Listing--%>

    <%@ include file="foxyFooter.jsp" %>
</f:view>
