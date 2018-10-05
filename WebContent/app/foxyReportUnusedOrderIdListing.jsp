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
    <h:panelGrid id="SearchGrid" styleClass="tablebg" rendered="#{not foxyUnusedOrderIdReports.list}" width="100%">
        <h:outputText value="Unused Order Id Listing Report" styleClass="smalltitle" />
        <h:form id="SearchForm">
            <t:outputLabel for="ToDate" value="To Date:" />
            <h:panelGroup>
                <t:inputCalendar id="ToDate" styleClass="FOX_INPUT" value="#{foxyUnusedOrderIdReports.toDate}"  
                                 popupDateFormat="yyyyMMdd" renderAsPopup="true"
                                 helpText="YYYYMMDD" required="true"/>    
                <h:message errorClass="FOX_ERROR" for="ToDate" showDetail="true" showSummary="true"/>
            </h:panelGroup>

            <h:panelGrid id="SearchInput" columns="2" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="50%">                                
                <h:commandButton id="Submit"  value="Retrieve Data" action="#{foxyUnusedOrderIdReports.search}"/>
            </h:panelGrid>
        </h:form>
    </h:panelGrid>
    <%-- End of Search--%>

    <%-- Panel for Listing --%>
    <h:panelGrid id="ListOrderGrid" styleClass="tablebg" rendered="#{foxyUnusedOrderIdReports.list}" width="100%">        
        <h:form id="ListReportForm">
            <h:panelGrid id="Top" columns="1" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="100%">

                <h:outputText value="#{foxyUnusedOrderIdReports.title}"  styleClass="smalltitle" />
            </h:panelGrid>
            <h:panelGrid id="ListDisplay" columns="1" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="100%">
                <t:dataTable value="#{foxyUnusedOrderIdReports.unusedOrderIdReportData}" var="Report"
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

                    <t:column width="5%">
                        <f:facet name="header">
                            <h:outputText value="Unused RefNo (Old)" />
                        </f:facet>
                        <h:outputText value="#{Report.oldOrderId}" />
                    </t:column>


                    <t:column width="3%">
                        <f:facet name="header">
                            <h:outputText value="New RefNo (Replacement)" />
                        </f:facet>
                        <h:outputText value="#{Report.newOrderId}" />
                    </t:column>                                 

                    <t:column width="3%">
                        <f:facet name="header">
                            <h:outputText value="By" />
                        </f:facet>
                        <h:outputText value="#{Report.insUser}" />
                    </t:column>                    

                    <t:column width="6%">
                        <f:facet name="header">
                            <h:outputText value="Time" />
                        </f:facet>                        
                        <h:outputText value="#{Report.insTime}">
                            <f:convertDateTime type="date" pattern="dd-MM-yyyy HH:mm:ss" timeZone="#{foxyTimeZone.myTimeZone}"/>
                        </h:outputText>
                    </t:column>                                                            
                </t:dataTable>
            </h:panelGrid>
        </h:form>
    </h:panelGrid>            
    <%-- End of Listing--%>

    <%@ include file="foxyFooter.jsp" %>
</f:view>
