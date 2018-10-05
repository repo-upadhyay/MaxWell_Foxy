<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%@taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<%@taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@taglib uri="https://ajax4jsf.dev.java.net/ajax" prefix="a4j"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<f:view>
    <%@ include file="foxyHeader.jsp" %>

    <%-- This save state required to ensure variable value available for rebuild list during  
    Without save state, list will be empty and will get "Value is not a valid option" error message when submit form--%> 
    <t:saveState value="#{foxyOrder.orderIdYear}"/>
    <t:saveState value="#{foxyOrder.mainFactoryCode}"/>

    <h:panelGrid id="UpdAddGrid" styleClass="tablebg" width="100%">
        <h:panelGroup >
            <h:outputText value="Transfer Order RefNo" styleClass="smalltitle"/>
            <h:outputText value="#{foxyOrder.recordStamp}" styleClass="FOX_RECSTAMP"/>
        </h:panelGroup>
        <h:form id="UpdAddForm" rendered="true">

            <h:panelGrid columns="1" style="vertical-align: top;" width="100%" cellpadding="0" cellspacing="0" border="0" frame="none" rules="none">
                <h:panelGrid id="UpdAddInput1_1" columns="2" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="50%">
                    <h:outputText value="Ref Number (old):" />
                    <h:inputText id="OrderIdD" styleClass="FOX_INPUT_RO_KEY" readonly="true" size="10" value="#{foxyOrder.orderId}"/>

                    <t:outputLabel for="year" value="Year:" />                       
                    <h:panelGroup>
                        <a4j:region id="ajaxregion_year" renderRegionOnly="false" selfRendered="true">
                            <h:selectOneMenu id="year" styleClass="FOX_INPUT" required="true" value="#{foxyOrder.orderIdYear}"
                                             >
                                <f:selectItems value="#{listData.orderIdYear}"/>
                                <a4j:support id="ajOrderIdYear" event="onchange"  action="#{foxyOrder.onYearOrFactoryChange}" 
                                             reRender="OrderId" ajaxSingle="false" 
                                             oncomplete="if(!alert('Please make sure the year selected correctly, Ref. number will be generated based on year selected')) return false">
                                </a4j:support>  

                            </h:selectOneMenu>
                        </a4j:region>
                        <h:message errorClass="FOX_ERROR" for="year" showDetail="true" showSummary="true"/>
                    </h:panelGroup>                                            

                    <t:outputLabel for="Country" value="Main Factory:" />
                    <h:panelGroup >
                        <a4j:region id="ajaxregion_MainFactory" renderRegionOnly="false" selfRendered="true">
                            <h:selectOneMenu id="Country" styleClass="FOX_INPUT" required="true" value="#{foxyOrder.mainFactoryCode}">
                                <f:selectItems value="#{listData.factoryList}"/>
                                <a4j:support id="ajMainFactory" event="onchange"  action="#{foxyOrder.onYearOrFactoryChange}" 
                                             reRender="OrderId" ajaxSingle="false">
                                </a4j:support>  
                            </h:selectOneMenu>
                        </a4j:region>
                        <h:message errorClass="FOX_ERROR" for="Country" showDetail="true" showSummary="true"/>
                    </h:panelGroup>

                    <t:outputLabel for="OrderId" value="Ref. Number:" />                
                    <h:panelGroup >
                        <h:selectOneMenu id="OrderId" styleClass="FOX_INPUT" required="true" value="#{foxyOrder.orderId}">
                            <f:selectItems value="#{foxyOrder.ordNoReservedList}"/>
                        </h:selectOneMenu>
                        <a4j:status for="ajaxregion_MainFactory">
                            <f:facet name="start">
                                <h:graphicImage value="/images/ajaxstart.gif" height="12" width="12"/>
                            </f:facet>
                            <f:facet name="stop">
                                <%-- h:graphicImage value="/images/ajax_stoped.gif" / --%>
                            </f:facet>
                        </a4j:status>      
                        <h:message errorClass="FOX_ERROR" for="OrderId" showDetail="true" showSummary="true"/>
                    </h:panelGroup>

                </h:panelGrid>
                <h:panelGroup>                    
                    <h:commandButton id="Save" value="Save" action="#{foxyOrder.execOrderIdTransfer}"
                                     onclick="if(!confirm('Please double check to ensure you have selected year and Main Factory correctly')) return false"/>
                    <h:outputText value=" " />                    
                    <h:commandButton id="Reset" value="Reset" type="reset">
                    </h:commandButton>
                </h:panelGroup>
            </h:panelGrid>
        </h:form>
    </h:panelGrid>            
    <%-- End of Update & Add --%>

    <%@ include file="foxyFooter.jsp" %>
</f:view>