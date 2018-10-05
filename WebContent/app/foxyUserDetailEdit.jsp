<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<%@taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@taglib prefix="h" uri="http://java.sun.com/jsf/html"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<f:view>
    <%@ include file="foxyHeader.jsp" %>
    <table class="box" width="100%">
        <tr><td>
            <h:messages errorClass="FOX_ERROR" showDetail="true" showSummary="true" />            
            <!-- Code segment for Updating existing user --START-- -->
            <h:panelGrid id="UpdUserGrid" styleClass="tablebg" width="100%">
                <h:outputText value="Update User" styleClass="smalltitle" />
                <h:form id="UpdUserForm">
                    <h:panelGrid id="UpdInput" columns="2" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="50%">
                        
                        <!-- ==================== Input Filed for [User Id] --START-- ========================= -->
                        <t:outputLabel for="User_Id" value="User Id:" />
                        <h:panelGroup>
                            <t:inputTextHelp id="User_Id" styleClass="FOX_INPUT_RO" readonly="true"
                                helpText="Text"
                                maxlength="10" size="10" required="true"
                                value="#{foxyUser.dbUserUpd.userId}">
                            </t:inputTextHelp>
                            <h:message errorClass="FOX_ERROR" for="User_Id" showDetail="true" showSummary="true"/>
                        </h:panelGroup>
                        <!-- ==================== Input Filed for [User Id] --END  -- ========================= -->


                        <!-- ==================== Input Filed for [Full Name] --START-- ========================= -->
                        <t:outputLabel for="Full_Name" value="Full Name:" />
                        <h:panelGroup>
                            <t:inputTextHelp id="Full_Name" styleClass="FOX_INPUT"
                                helpText="Text"
                                maxlength="50" size="50" required="true"
                                value="#{foxyUser.dbUserUpd.fullName}">
                            </t:inputTextHelp>
                            <h:message errorClass="FOX_ERROR" for="Full_Name" showDetail="true" showSummary="true"/>
                        </h:panelGroup>
                        <!-- ==================== Input Filed for [Full Name] --END  -- ========================= -->


                        <!-- ==================== Input Filed for [Location] --START-- ========================= -->
                        <t:outputLabel for="Location" value="Location:" />
                        <h:panelGroup>
                            <h:selectOneMenu id="Location" styleClass="FOX_INPUT" required="true" value="#{foxyUser.dbUserUpd.location}">
                                <f:selectItems value="#{listData.countryList}"/>
                            </h:selectOneMenu>
                            <h:message errorClass="FOX_ERROR" for="Location" showDetail="true" showSummary="true"/>                            
                        </h:panelGroup>
                        <!-- ==================== Input Filed for [Location] --END  -- ========================= -->


                        <!-- ==================== Input Filed for [User Group] --START-- ========================= -->
                        <t:outputLabel for="UserGroup" value="User Group:" />
                        <h:panelGroup>
                            <h:selectOneMenu id="UserGroup" styleClass="FOX_INPUT" required="true" value="#{foxyUser.dbUserUpd.userGroup}">
                                <f:selectItems value="#{listData.userGroupList}"/>
                            </h:selectOneMenu>
                            <h:message errorClass="FOX_ERROR" for="UserGroup" showDetail="true" showSummary="true"/>
                        </h:panelGroup>
                        <!-- ==================== Input Filed for [User Group] --END  -- ========================= -->


                        <!-- ==================== Input Filed for [User Status] --START-- ========================= -->
                        <%--
                        <t:outputLabel for="Status" value="User Status:" />
                        <h:panelGroup>
                        <h:selectOneMenu id="Status" styleClass="FOX_INPUT" required="true" value="#{foxyUser.dbUserUpd.status}">
                        <f:selectItems value="#{listData.statList}"/>
                        </h:selectOneMenu>
                        <h:message errorClass="FOX_ERROR" for="Status" showDetail="true" showSummary="true"/>
                        </h:panelGroup>
                        --%>
                        <!-- ==================== Input Filed for [User Status] --END  -- ========================= -->                        
                        
                    </h:panelGrid>
                    <h:panelGrid columns="1" columnClasses="FOX_BUTTON" width="50%">
                        <h:panelGroup>
                            <h:commandButton id="Save" value="Save" action="#{foxyUser.saveUpdate}">
                            </h:commandButton>
                        </h:panelGroup>
                    </h:panelGrid>
                </h:form>
            </h:panelGrid>         
            <!-- Code segment for Updating existing user --End-- -->            
        </td></tr>
        <tr>
            <td>
                <!-- Report List -->
            </td>
        </tr>
    </table>
    <%@ include file="foxyFooter.jsp" %>
</f:view>
