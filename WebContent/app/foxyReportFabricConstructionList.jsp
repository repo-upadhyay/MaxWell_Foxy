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
    <h:panelGrid id="SearchGrid"  columns="2" styleClass="tablebg" rendered="#{not foxyFabricConstructionReports.list}" width="100%">
        <h:outputText value="Fabric Construction Listing (By Ref No)" styleClass="smalltitle" />
        <h:outputText value="(By Style code)" styleClass="smalltitle" />
        <h:form id="SearchForm1">
            <h:panelGrid id="SearchInput1" columns="2" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="50%">
                <t:outputLabel for="OrderId" value="Ref No:" />
                <h:panelGroup>
                    <t:inputTextHelp id="OrderId" value="#{foxyFabricConstructionReports.orderId}"/>
                    <h:message errorClass="FOX_ERROR" for="OrderId" showDetail="true" showSummary="true"/>
                </h:panelGroup>
                
                <h:commandButton id="Submit1"  value="Submit" action="#{foxyFabricConstructionReports.search}"/>
            </h:panelGrid>
        </h:form>
        <h:form id="SearchForm2">
            <h:panelGrid id="SearchInput2" columns="2" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="50%">
                <t:outputLabel for="StyleCode" value="StyleCode:" />
                <h:panelGroup>
                    <t:inputTextHelp id="StyleCode" value="#{foxyFabricConstructionReports.styleCode}"/>
                    <h:message errorClass="FOX_ERROR" for="StyleCode" showDetail="true" showSummary="true"/>
                </h:panelGroup>
                
                <h:commandButton id="Submit2"  value="Submit" action="#{foxyFabricConstructionReports.search}"/>
            </h:panelGrid>
        </h:form>        
    </h:panelGrid>
    <%-- End of Search--%>
            
    <%-- Panel for Listing --%>
    <h:panelGrid id="ListOrderGrid" styleClass="tablebg" rendered="#{foxyFabricConstructionReports.list}" width="100%">        
        <h:form id="ListReportForm">            
            <h:panelGrid id="Top" columns="1" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="100%">                
                <h:outputText value="Fabric Construction Listing for #{foxyFabricConstructionReports.title}" styleClass="smalltitle" />
            </h:panelGrid>
            <h:panelGrid id="ListDisplay" columns="1" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="100%">
                <t:dataTable value="#{foxyFabricConstructionReports.fabricConstructionList}" var="list"
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
                        <h:outputText value="#{list.orderId}"/>
                    </t:column>
                    
                    <t:column width="8%">
                        <f:facet name="header">
                            <h:outputText value="Style Code" />
                        </f:facet>
                        <h:outputText value="#{list.styleCode}"/>                        
                    </t:column>
                    
                    <t:column width="8%">
                        <f:facet name="header">
                            <h:outputText value="Horizontal (cm)" />
                        </f:facet>
                        <h:outputText value="#{list.horiz}"/>                        
                    </t:column>
                    
                    <t:column width="8%">
                        <f:facet name="header">
                            <h:outputText value="Vertical (cm)" />
                        </f:facet>
                        <h:outputText value="#{list.vert}"/>                        
                    </t:column>                    
                </t:dataTable>
                
            </h:panelGrid>
        </h:form>
    </h:panelGrid>            
    <%-- End of Listing--%>

    <%@ include file="foxyFooter.jsp" %>
</f:view>
