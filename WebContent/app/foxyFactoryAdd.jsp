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
                <h:messages errorClass="FOX_ERROR" showDetail="true" showSummary="true" />
                <h:panelGrid id="UpdAddGrid" styleClass="tablebg" width="100%">
                    <%-- Title for Add --%>
                    <h:outputText value="Add Factory Record" styleClass="smalltitle"/>

                    <h:form id="UpdAddForm">
                        <h:panelGrid id="UpdAddInput" columns="2" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="50%">

                            <t:outputLabel for="country" value="Country Located:" />               
                            <h:panelGroup>
                                <h:selectOneMenu id="country" styleClass="FOX_INPUT" required="true" value="#{foxyFactory.factoryBean.countryCode}">
                                    <f:selectItems value="#{listData.countryList}"/>
                                </h:selectOneMenu>
                                <h:message errorClass="FOX_ERROR" for="country" showDetail="true" showSummary="true"/>
                            </h:panelGroup>


                            <t:outputLabel for="Code" value="factory Code [0-9]:" />
                            <h:panelGroup>                                               
                                <t:inputTextHelp id="Code" styleClass="FOX_INPUT"
                                                 helpText="Text"
                                                 maxlength="10" size="10" required="true" 
                                                 value="#{foxyFactory.factoryBean.factoryCode}">
                                    <t:validateRegExpr pattern="^[0-9]{0,1}$"/>
                                </t:inputTextHelp>
                                <h:message errorClass="FOX_ERROR" for="Code" showDetail="true" showSummary="true"/>
                            </h:panelGroup>


                            <t:outputLabel for="ShortDesc" value="Short Description:" />
                            <h:panelGroup>
                                <t:inputTextHelp id="ShortDesc" styleClass="FOX_INPUT" 
                                                 helpText="Text"
                                                 maxlength="10" size="10" required="true" 
                                                 value="#{foxyFactory.factoryBean.factoryName}">
                                </t:inputTextHelp> 
                                <h:message errorClass="FOX_ERROR" for="ShortDesc" showDetail="true" showSummary="true"/>
                            </h:panelGroup>

                            <t:outputLabel for="Description" value="Description:" />
                            <h:panelGroup>
                                <t:inputTextHelp id="Description" styleClass="FOX_INPUT" 
                                                 helpText="Text"
                                                 maxlength="50" size="50" required="true" 
                                                 value="#{foxyFactory.factoryBean.factoryNameLong}">
                                </t:inputTextHelp> 
                                <h:message errorClass="FOX_ERROR" for="Description" showDetail="true" showSummary="true"/>
                            </h:panelGroup>                                                

                            <t:outputLabel for="seq" value="Display Sequence:" />
                            <h:panelGroup>
                                <t:inputTextHelp id="seq" styleClass="FOX_INPUT" 
                                                 helpText="999"
                                                 maxlength="3" size="3" required="false" 
                                                 value="#{foxyFactory.factoryBean.seqNo}">
                                    <t:validateRegExpr pattern="^[0-9]{0,3}$"/>
                                </t:inputTextHelp> 
                                <h:message errorClass="FOX_ERROR" for="seq" showDetail="true" showSummary="true"/>
                            </h:panelGroup>                                                

                            <%--
                            <t:outputLabel for="Status" value="Status:" />                    
                            <h:panelGroup>
                            <h:selectOneMenu id="Status" styleClass="FOX_INPUT" required="true" value="#{foxyFactory.factoryBean.status}">
                            <f:selectItems value="#{listData.statList}"/>
                            </h:selectOneMenu>
                            <h:message errorClass="FOX_ERROR" for="Status" showDetail="true" showSummary="true"/>
                            </h:panelGroup>
                            --%>
                        </h:panelGrid>  

                        <h:panelGrid id="AddButton" columns="1" columnClasses="FOX_BUTTON" width="50%">
                            <h:panelGroup>
                                <h:commandButton id="Save"  value="Save" action="#{foxyFactory.saveAdd}"/>
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