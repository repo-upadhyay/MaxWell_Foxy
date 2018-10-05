<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<%@taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@taglib prefix="h" uri="http://java.sun.com/jsf/html"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<f:view>
    <%@ include file="foxyHeader.jsp" %>
    <table class="box" width="100%">
        <tr><td>
                <h:panelGrid id="UpdAddGrid" styleClass="tablebg" width="100%">
                    <%-- Title for Add --%>
                    <h:outputText value="Ref No Reservation " styleClass="smalltitle"/>

                    <h:form id="UpdAddForm">
                        <h:panelGrid id="UpdAddInput" columns="2" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="50%">

                            <t:outputLabel for="year" value="Year:" rendered="true"/>
                            <h:panelGroup rendered="true">
                                <h:selectOneMenu id="year" styleClass="FOX_INPUT" required="true" 
                                                 value="#{foxyOrderNoReserve.orderIdYear}"
                                                 onchange="if(!alert('Please make sure the year selected correctly, Ref. number will be generated based on year selected')) return false">
                                    <f:selectItems value="#{listData.orderIdYear}"/>
                                </h:selectOneMenu>
                                <h:message errorClass="FOX_ERROR" for="year" showDetail="true" showSummary="true"/>
                            </h:panelGroup>  

                            <t:outputLabel for="Country" value="Main Factory:" rendered="true"/>
                            <h:panelGroup rendered="true">
                                <h:selectOneMenu id="Country" styleClass="FOX_INPUT" required="true" 
                                                 value="#{foxyOrderNoReserve.mainFactoryCode}">

                                    <f:selectItems value="#{listData.factoryList}"/>
                                </h:selectOneMenu>
                                <h:message errorClass="FOX_ERROR" for="Country" showDetail="true" showSummary="true"/>
                            </h:panelGroup>                            


                            <t:outputLabel for="ordnocount" value="Number of RefNo (2-15):" />
                            <h:panelGroup>
                                <t:inputTextHelp id="ordnocount" styleClass="FOX_INPUT" 
                                                 helpText="99"
                                                 maxlength="2" size="2" required="true" 
                                                 value="#{foxyOrderNoReserve.orderNoCount}">
                                    <t:validateRegExpr pattern="^([2-9]|1[0-5])$"/>
                                </t:inputTextHelp> 
                                <h:message errorClass="FOX_ERROR" for="ordnocount" showDetail="true" showSummary="true"/>
                            </h:panelGroup>                                                

                            <t:outputLabel for="validfor" value="Valid For (Days, Max=99):" />
                            <h:panelGroup>
                                <t:inputTextHelp id="validfor" styleClass="FOX_INPUT" 
                                                 maxlength="2" size="2" required="true" 
                                                 value="#{foxyOrderNoReserve.daysToExpired}">
                                    <t:validateRegExpr pattern="^[0-9]{0,2}$"/>
                                </t:inputTextHelp> 
                                <h:message errorClass="FOX_ERROR" for="validfor" showDetail="true" showSummary="true"/>
                            </h:panelGroup>    

                        </h:panelGrid>  

                        <h:panelGrid id="AddButton" columns="1" columnClasses="FOX_BUTTON" width="50%">
                            <h:panelGroup>
                                <h:commandButton id="Save"  value="Save" action="#{foxyOrderNoReserve.saveAdd}"/>
                            </h:panelGroup>
                        </h:panelGrid>

                    </h:form>
                </h:panelGrid>
                <%-- End of Update & Add --%>

            </td></tr>
        <tr>
            <td>
                <!-- Report List -->
            </td>
        </tr>
    </table>
    <%@ include file="foxyFooter.jsp" %>
</f:view>