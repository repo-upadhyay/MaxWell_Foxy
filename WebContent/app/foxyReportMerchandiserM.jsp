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
    <h:panelGrid id="SearchGrid" styleClass="tablebg" rendered="#{not foxyMerchandiserReports.list}" width="100%">
        <h:outputText value="Merchandiser Report" styleClass="smalltitle" />
        <h:form id="SearchForm">
            <t:saveState value="#{foxyMerchandiserReports.country}"/>
            <t:saveState value="#{foxyMerchandiserReports.mainfactory}"/>             
            <h:panelGrid id="SearchInput" columns="2" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="50%">               

                <t:outputLabel for="Country" value="Country:" />
                <h:panelGroup>
                    <a4j:region id="ajaxregioncountryfactory" renderRegionOnly="false" selfRendered="true">
                        <h:selectOneMenu id="Country" styleClass="FOX_INPUT" required="true" value="#{foxyMerchandiserReports.country}">
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
                                     value="#{foxyMerchandiserReports.mainfactory}">
                        <f:selectItems value="#{foxyMerchandiserReports.factoryByCountryList}"/>
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
                    <h:selectOneMenu id="Merchandiser" styleClass="FOX_INPUT" required="true" value="#{foxyMerchandiserReports.merchandiser}">
                        <f:selectItems value="#{listData.merchandiserList}"/>
                    </h:selectOneMenu>
                    <h:message errorClass="FOX_ERROR" for="Merchandiser" showDetail="true" showSummary="true"/>
                </h:panelGroup>                   

                <t:outputLabel for="Year" value="Year of delivery:" />
                <h:panelGroup>
                    <t:inputTextHelp id="Year" styleClass="FOX_INPUT" required="true" 
                                     helpText="YYYY"  value="#{foxyMerchandiserReports.year}"/>
                    <h:message errorClass="FOX_ERROR" for="Year" showDetail="true" showSummary="true"/>
                </h:panelGroup>                        

                <t:outputLabel for="Month" value="Month:" />
                <h:panelGroup>
                    <t:inputTextHelp id="Month" styleClass="FOX_INPUT" required="true" 
                                     helpText="MM" value="#{foxyMerchandiserReports.month}"/>
                    <h:message errorClass="FOX_ERROR" for="Month" showDetail="true" showSummary="true"/>
                </h:panelGroup>                

                <h:commandButton id="Submit"  value="Submit" action="#{foxyMerchandiserReports.search}"/>
            </h:panelGrid>
        </h:form>
    </h:panelGrid>
    <%-- End of Search--%>

    <%-- Panel for Listing --%>
    <h:panelGrid id="ListOrderGrid" styleClass="tablebg" rendered="#{foxyMerchandiserReports.list}" width="100%">        
        <h:form id="ListReportForm">
            <h:panelGrid id="Top" columns="1" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="100%">

                <h:outputText value="Merchandiser Report for #{foxyMerchandiserReports.title}" styleClass="smalltitle" />

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
                <t:dataTable value="#{foxyMerchandiserReports.productionReportData}" var="mrReport"
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
                        <h:outputText value="#{mrReport.orderId}#{mrReport.month}#{mrReport.location}#{mrReport.subLocation}" rendered="#{mrReport.location != null}"/>
                        <h:outputText value="#{mrReport.orderId}" rendered="#{mrReport.location == null}" styleClass="FOXY_REPORT_GRAND_TOTAL"/>
                    </t:column>

                    <t:column width="8%">
                        <f:facet name="header">
                            <h:outputText value="P.O. Number" />
                        </f:facet>
                        <h:outputText value="#{mrReport.poNumber}" />
                    </t:column>

                    <t:column width="5%">
                        <f:facet name="header">
                            <h:outputText value="Make" />
                        </f:facet>
                        <h:outputText value="#{mrReport.origin}" />
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
                        <h:outputText value="#{mrReport.qtyDzn}" rendered="#{mrReport.location != null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>                            
                        <h:outputText value="#{mrReport.qtyDzn}" rendered="#{mrReport.location == null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>                         
                    </t:column>

                    <t:column width="10%">
                        <f:facet name="header">
                            <h:outputText value="Cust/Brand/Div" />
                        </f:facet>
                        <h:outputText value="#{mrReport.custCode}/#{mrReport.custBrand}/#{mrReport.custDivision}" rendered="#{mrReport.location != null}"/>
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
                        <h:outputText value="#{mrReport.category}/#{mrReport.destination}" rendered="#{mrReport.location != null}"/>
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
