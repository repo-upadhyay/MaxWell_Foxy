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
            <!-- Code segment for Reseting password for existing user --START-- -->
            <h:panelGrid id="ResetPasswdUserGrid" styleClass="tablebg" width="100%">
                <h:outputText value="Reset Current login User's Password" styleClass="smalltitle" />
                <h:form id="ResetUserPasswordForm">
                    <h:panelGrid id="ResetPassInput" columns="2" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="50%">
                        
                        <!-- ==================== Input Filed for [User Id] --START-- ========================= -->
                        <t:outputLabel for="User_Id" value="User Id:" />
                        <h:panelGroup>
                            <t:inputTextHelp id="User_Id" styleClass="FOX_INPUT_RO" readonly="true"
                                helpText="Text"
                                maxlength="10" size="10" required="true"
                                value="#{foxyUserResetPassword.userId}">
                            </t:inputTextHelp>
                            <h:message errorClass="FOX_ERROR" for="User_Id" showDetail="true" showSummary="true"/>
                        </h:panelGroup>
                        <!-- ==================== Input Filed for [User Id] --END  -- ========================= -->
                        
                        <!-- ==================== Input Filed for [Password] --START-- ========================= -->
                        <t:outputLabel for="OldPassword" value="Old Password:" />
                        <h:panelGroup>
                            <t:inputSecret id="OldPassword" styleClass="FOX_INPUT"
                                maxlength="20" size="20" required="true" redisplay="true"
                                value="#{foxyUserResetPassword.oldPassword}">
                            </t:inputSecret>
                            <h:message errorClass="FOX_ERROR" for="OldPassword" showDetail="true" showSummary="true"/>
                        </h:panelGroup>
                        <!-- ==================== Input Filed for [Password] --END  -- ========================= -->                        

                        <!-- ==================== Input Filed for [Password] --START-- ========================= -->
                        <t:outputLabel for="Password" value="New Password:" />
                        <h:panelGroup>
                            <t:inputSecret id="Password" styleClass="FOX_INPUT"
                                maxlength="20" size="20" required="true" redisplay="true"
                                value="#{foxyUserResetPassword.newPassword}">
                            </t:inputSecret>
                            <h:message errorClass="FOX_ERROR" for="Password" showDetail="true" showSummary="true"/>
                        </h:panelGroup>
                        <!-- ==================== Input Filed for [Password] --END  -- ========================= -->


                        <!-- ==================== Input Filed for [Re-Type Password] --START-- ========================= -->
                        <t:outputLabel for="Re-Type_Password" value="Re-Type New Password:" />
                        <h:panelGroup>
                            <t:inputSecret id="Re-Type_Password" styleClass="FOX_INPUT"
                                maxlength="20" size="20" required="true" redisplay="true"
                                value="#{foxyUserResetPassword.rePassword}">
                            </t:inputSecret>
                            <h:message errorClass="FOX_ERROR" for="Re-Type_Password" showDetail="true" showSummary="true"/>
                        </h:panelGroup>
                        <!-- ==================== Input Filed for [Re-Type Password] --END  -- ========================= -->
                        
                    </h:panelGrid>
                    <h:panelGrid columns="1" columnClasses="FOX_BUTTON" width="50%">
                        <h:panelGroup>
                            <h:commandButton id="Reset" value="Reset" action="#{foxyUserResetPassword.savePassword}">
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
