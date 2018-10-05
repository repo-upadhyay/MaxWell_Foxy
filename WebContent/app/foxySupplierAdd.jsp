<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%@taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<%@taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@taglib prefix="h" uri="http://java.sun.com/jsf/html"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<f:view>
    <%@ include file="foxyHeader.jsp" %>
    <table class='box' width='100%'>
        <tr><td>        
                <h:messages errorClass="FOX_ERROR" showDetail="true" showSummary="true"/>
                <h:panelGrid id="AddSupplierGrid" styleClass="tablebg" width="100%">
                    <h:outputText value="New Supplier" styleClass="smalltitle" />
                    <h:form id="AddSupplierForm">
                        <h:panelGrid id="enq" columns="2" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="50%">
                            
                            <!-- ==================== Input Filed for [Supplier Code] --START-- ========================= -->
                            <t:outputLabel for="Supplier_Code" value="Supplier Code:" />
                            <h:panelGroup>
                                <t:inputTextHelp id="Supplier_Code" styleClass="FOX_INPUT"
                                                 helpText="Text"
                                                 maxlength="10" size="10" required="true"
                                                 value="#{foxySupplier.supBean.supCode}">
                                </t:inputTextHelp>
                                <h:message errorClass="FOX_ERROR" for="Supplier_Code" showDetail="true" showSummary="true"/>
                            </h:panelGroup>
                            <!-- ==================== Input Filed for [Supplier Code] --END  -- ========================= -->

                            <t:outputLabel for="SupplierItem_Code" value="Item Supplier:" />
                            <h:panelGroup>
                                <h:selectOneMenu id="SupplierItem_Code" styleClass="FOX_INPUT" required="true" 
                                                 value="#{foxySupplier.supBean.itemCode}" readonly="false"> 
                                    <f:selectItems value="#{listData.supItemList}"/>
                                </h:selectOneMenu>
                                <h:message errorClass="FOX_ERROR" for="SupplierItem_Code" showDetail="true" showSummary="true"/>
                            </h:panelGroup>
                            
                            <!-- ==================== Input Filed for [Supplier Name] --START-- ========================= -->
                            <t:outputLabel for="Supplier_Name" value="Supplier Name:" />
                            <h:panelGroup>
                                <t:inputTextHelp id="Supplier_Name" styleClass="FOX_INPUT"
                                                 helpText="Text"
                                                 maxlength="30" size="30" required="true"
                                                 value="#{foxySupplier.supBean.supName}">
                                </t:inputTextHelp>
                                <h:message errorClass="FOX_ERROR" for="Supplier_Name" showDetail="true" showSummary="true"/>
                            </h:panelGroup>
                            <!-- ==================== Input Filed for [Supplier Name] --END  -- ========================= -->                        
                                                        
                        </h:panelGrid>
                        
                        
                        <h:panelGrid id="AddButton" columns="1" columnClasses="FOX_BUTTON" width="50%">
                            <h:panelGroup>
                                <h:commandButton id="Save" value="Save" action="#{foxySupplier.saveAdd}"/>
                                <h:inputHidden  value="#{foxySuccess.msg}"/>
                            </h:panelGroup>
                        </h:panelGrid>
                        
                    </h:form>
                </h:panelGrid>
                
        </td></tr>
        <tr>
            <td>
                <!-- Report List -->
            </td>
        </tr>
    </table>
    <%@ include file="foxyFooter.jsp" %>
</f:view>
