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
                <!-- Code segment for Reseting password for existing user --START-- -->
                <h:panelGrid id="EditUserRoleGrid" styleClass="tablebg" width="100%">
                    <h:outputText value="Editing User's Role" styleClass="smalltitle" />
                    
                    <h:form id="EditUserRoleAdminForm">
                        <h:panelGrid id="editUserRole" columns="2" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="80%">
                            <t:outputLabel for="UserId" value="User Id:" />               
                            <h:panelGroup>
                                <h:inputText id="UserId" styleClass="FOX_INPUT" 
                                             maxlength="9" size="20" required="true" 
                                             value="#{foxyUserRole.userId}" readonly="true">
                                </h:inputText>
                                <h:message errorClass="FOX_ERROR" for="UserId" showDetail="true" showSummary="true"/>
                            </h:panelGroup>
                        </h:panelGrid>
                        
                        <h:selectManyCheckbox id="selectUserRoles" 
                                              styleClass="checkBoxList"
                                              value="#{foxyUserRole.menuCodeSelected}" 
                                              layout="pageDirection" binding="#{foxyUserRole.selMany}">
                            <f:selectItems value="#{foxyUserRole.fullMenuList}" />
                        </h:selectManyCheckbox>
                        
                        
                        <h:panelGrid columns="1" columnClasses="FOX_BUTTON" width="50%">
                            <h:panelGroup>
                                <h:commandButton id="save" value="Save" action="#{foxyUserRole.saveUserRole}">
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
