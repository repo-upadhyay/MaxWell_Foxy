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
    <h:panelGrid id="SearchGrid" columns="1" columnClasses="FOXY_SCREEN_2COL,FOXY_SCREEN_2COL" styleClass="tablebg" rendered="#{not foxyLocalMerchandiserReports.list}" width="100%">        
        <h:outputText value="Local Merchandiser Report" styleClass="smalltitle" />
        <h:form id="SearchForm">
            <t:saveState value="#{foxyLocalMerchandiserReports.country}"/>
            <t:saveState value="#{foxyLocalMerchandiserReports.mainfactory}"/>
            <h:panelGrid id="SearchInput" columns="2" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="50%">

                <t:outputLabel for="FromDate" value="Delivery Date From:" />
                <h:panelGroup>
                    <t:inputCalendar id="FromDate" styleClass="FOX_INPUT" value="#{foxyLocalMerchandiserReports.fromDate}"  
                                     popupDateFormat="yyyyMMdd" renderAsPopup="true"
                                     helpText="YYYYMMDD" required="true"/>    
                    <h:message errorClass="FOX_ERROR" for="FromDate" showDetail="true" showSummary="true"/>
                </h:panelGroup>                        

                <t:outputLabel for="ToDate" value="To Date:" />
                <h:panelGroup>
                    <t:inputCalendar id="ToDate" styleClass="FOX_INPUT" value="#{foxyLocalMerchandiserReports.toDate}"  
                                     popupDateFormat="yyyyMMdd" renderAsPopup="true"
                                     helpText="YYYYMMDD" required="true"/>    
                    <h:message errorClass="FOX_ERROR" for="ToDate" showDetail="true" showSummary="true"/>
                </h:panelGroup>

                <t:outputLabel for="Country" value="Country:" />
                <h:panelGroup>
                    <a4j:region id="ajaxregioncountryfactory" renderRegionOnly="false" selfRendered="true">
                        <h:selectOneMenu id="Country" styleClass="FOX_INPUT" required="true" value="#{foxyLocalMerchandiserReports.country}">
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
                                     value="#{foxyLocalMerchandiserReports.mainfactory}">
                        <f:selectItems value="#{foxyLocalMerchandiserReports.factoryByCountryList}"/>
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

                <t:outputLabel for="Merchandiser" value="Merchandiser:" />
                <h:panelGroup>
                    <h:selectOneMenu id="Merchandiser" styleClass="FOX_INPUT" required="true" value="#{foxyLocalMerchandiserReports.merchandiser}">
                        <f:selectItems value="#{listData.merchandiserList}"/>
                    </h:selectOneMenu>
                    <h:message errorClass="FOX_ERROR" for="Merchandiser" showDetail="true" showSummary="true"/>
                </h:panelGroup>                   

            </h:panelGrid>
            <h:commandButton id="Submit" value="Submit" action="#{foxyLocalMerchandiserReports.search}"/>
        </h:form>

    </h:panelGrid>
    <%-- End of Search--%>

    <%-- Panel for Listing --%>
    <h:panelGrid id="ListOrderGrid" styleClass="tablebg" rendered="#{foxyLocalMerchandiserReports.list}" width="100%">        
        <h:form id="ListReportForm">
            <h:panelGrid id="Top" columns="1" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="100%">

                <h:outputText value="Local Merchandiser Report for #{foxyLocalMerchandiserReports.title}" styleClass="smalltitle" />

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
                <t:dataTable value="#{foxyLocalMerchandiserReports.productionReportData}" var="mrReport"
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

                    <t:column width="8%">
                        <f:facet name="header">
                            <h:outputText value="Ref No" />
                        </f:facet>
                        <h:outputText value="#{mrReport.orderId}#{mrReport.month}#{mrReport.location}#{mrReport.subLocation}" />
                    </t:column>

                    <t:column width="8%">
                        <f:facet name="header">
                            <h:outputText value="P.O. Number" />
                        </f:facet>
                        <h:outputText value="#{mrReport.poNumber}" />
                    </t:column>

                    <t:column width="5%">
                        <f:facet name="header">
                            <h:outputText value="Style Code" />
                        </f:facet>
                        <h:outputText value="#{mrReport.stylecode}" />
                    </t:column>                    

                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="Qty(DZN)" />
                            </h:panelGrid>
                        </f:facet>
                        <h:outputText value="#{mrReport.qtyDzn}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>                            
                    </t:column>

                    <t:column width="10%">
                        <f:facet name="header">
                            <h:outputText value="Cust/Brand/Div" />
                        </f:facet>
                        <h:outputText value="#{mrReport.custCode}/#{mrReport.custBrand}/#{mrReport.custDivision}" />
                    </t:column>                    

                    <t:column width="8%">
                        <f:facet name="header">
                            <h:outputText value="Cust's MR" />
                        </f:facet>
                        <h:outputText value="#{mrReport.mrForCust}"/>
                    </t:column>                    

                    <t:column width="5%">
                        <f:facet name="header">
                            <h:outputText value="Fabric" />
                        </f:facet>
                        <h:outputText value="#{mrReport.fabricDate}">
                            <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                        </h:outputText>
                    </t:column>                                        

                    <t:column width="5%">
                        <f:facet name="header">
                            <h:outputText value="Closing"/>
                        </f:facet>
                        <h:outputText value="#{mrReport.closeDate}">
                            <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                        </h:outputText>
                    </t:column>

                    <t:column width="5%">
                        <f:facet name="header">
                            <h:outputText value="Vessel" />
                        </f:facet>
                        <h:outputText value="#{mrReport.vesselDate}">
                            <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                        </h:outputText>
                    </t:column>


                    <t:column width="5%">
                        <f:facet name="header">
                            <h:outputText value="Delivery" />
                        </f:facet>
                        <h:outputText value="#{mrReport.deliveryDate}">
                            <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                        </h:outputText>
                    </t:column>                    

                    <t:column width="5%">
                        <f:facet name="header">
                            <h:outputText value="ETD" />
                        </f:facet>
                        <h:outputText value="#{mrReport.etd}">
                            <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                        </h:outputText>
                    </t:column>                                                            

                    <t:column width="8%">
                        <f:facet name="header">
                            <h:outputText value="Cat/Dest" />
                        </f:facet>
                        <h:outputText value="#{mrReport.category}/#{mrReport.destination}"/>
                    </t:column>

                    <t:column width="8%">
                        <f:facet name="header">
                            <h:outputText value="Ship" />
                        </f:facet>
                        <h:outputText value="#{mrReport.ship}"/>
                    </t:column>

                    <t:column width="8%">
                        <f:facet name="header">
                            <h:outputText value="EMB" />
                        </f:facet>
                        <h:outputText value="#{mrReport.emb}"/>
                    </t:column>

                    <t:column width="10%">
                        <f:facet name="header">
                            <h:outputText value="Wash" />
                        </f:facet>
                        <h:outputText value="#{mrReport.wash}"/>
                    </t:column>

                    <t:column width="10%">
                        <f:facet name="header">
                            <h:outputText value="Remark" />
                        </f:facet>
                        <h:outputText value="#{mrReport.remark}"/>
                    </t:column>                    

                </t:dataTable>
            </h:panelGrid>
        </h:form>
    </h:panelGrid>            
    <%-- End of Listing--%>

    <%@ include file="foxyFooter.jsp" %>
</f:view>
