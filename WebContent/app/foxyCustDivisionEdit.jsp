<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%@taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<%@taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@taglib uri="https://ajax4jsf.dev.java.net/ajax" prefix="a4j"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<f:view>
    <%@ include file="foxyHeader.jsp" %>
    <table class='box' width='100%'>
        <tr><td>    
            <%-- This save state required to ensure brandList can be rebuild during sabmit form 
            Without save state, brandList will be empty and will get "Value is not a valid option" error message --%>
            <t:saveState value="#{foxyCustomerDivision.dbEditCustDivBean.custCode}"/>
        
            <h:messages errorClass="FOX_ERROR" showDetail="true" showSummary="true"/>
            <h:panelGrid id="EditCustomerDivGrid" styleClass="tablebg" width="100%">
                <h:outputText value="New Division for customer" styleClass="smalltitle" />
                <h:form id="EditCustomerDivisionForm">                    
                    <h:panelGrid id="division" columns="1" columnClasses="FOX_INPUT_COL" width="100%">
                        <h:panelGroup>
                            <h:panelGrid id="divisionbrandcode" columns="2" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="50%">
                                <!-- ==================== Input Filed for [Customer Code] --START-- ========================= -->                        
                                <t:outputLabel for="Customer_Code" value="Customer Name:" />
                                <h:panelGroup>
                                    <a4j:region id="ajaxregion1" renderRegionOnly="false" selfRendered="true">
                                        <h:selectOneMenu id="Customer_Code" styleClass="FOX_INPUT" value="#{foxyCustomerDivision.dbEditCustDivBean.custCode}"
                                            disabled="false" style="width:180px;" required="true" immediate="false"> 
                                            <f:selectItems value="#{listData.customerList}"/>
                                            <a4j:support id="ajcustcode" event="onchange"  
                                                reRender="BrandCode" ajaxSingle="true">
                                                <a4j:actionparam name="custCode" value="testing param"/>
                                            </a4j:support>
                                        </h:selectOneMenu>
                                    </a4j:region>
                                    <h:message errorClass="FOX_ERROR" for="Customer_Code" showDetail="true" showSummary="true"/>
                                </h:panelGroup>
                                <!-- ==================== Input Filed for [Customer Code] --END  -- ========================= -->                                
                                
                                <!-- ==================== Input Filed for [Brand Desc] --START-- ========================= -->
                                <t:outputLabel for="BrandCode" value="Customer's Brand:" />
                                <h:panelGroup>
                                    <h:selectOneMenu id="BrandCode" styleClass="FOX_INPUT" value="#{foxyCustomerDivision.dbEditCustDivBean.brandCode}"
                                        style="width:220px; height:25px "  required="true" immediate="true"> 
                                        <f:selectItems value="#{foxyCustomerDivision.brandItemsListEdit}"/>
                                    </h:selectOneMenu>
                                    <a4j:status for="ajaxregion1">
                                        <f:facet name="start">
                                            <h:graphicImage value="/images/ajaxstart.gif"  height="12" width="12"/>
                                        </f:facet>
                                        <f:facet name="stop">
                                            <%-- h:graphicImage value="/images/ajax_stoped.gif" / --%>
                                        </f:facet>
                                    </a4j:status>                                    
                                    <h:message errorClass="FOX_ERROR" for="BrandCode" showDetail="true" showSummary="true"/>
                                </h:panelGroup>
                                <!-- ==================== Input Filed for [Brand Desc] --END  -- ========================= -->                                                     
                            </h:panelGrid>
                        </h:panelGroup>
                        
                        
                        
                        <%-- None ajax aware section --%>
                        <h:panelGrid id="divisiondetail" columns="2" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="50%">
                            <!-- ==================== Input Filed for [Devision Code] --START-- ========================= -->
                            <t:outputLabel for="DivisionCode" value="Division Code:" />
                            <h:panelGroup>
                                <t:inputTextHelp id="DivisionCode" styleClass="FOX_INPUT_RO"  readonly="true"
                                    helpText="Text"
                                    maxlength="10" size="10" required="true"
                                    value="#{foxyCustomerDivision.dbEditCustDivBean.divCode}">
                                </t:inputTextHelp>
                                <h:message errorClass="FOX_ERROR" for="DivisionCode" showDetail="true" showSummary="true"/>
                            </h:panelGroup>
                            <!-- ==================== Input Filed for [Devision Code] --END  -- ========================= -->
                        
                        
                            <!-- ==================== Input Filed for [Devision Desc] --START-- ========================= -->
                            <t:outputLabel for="DivisionDesc" value="Division Desc:" />
                            <h:panelGroup>
                                <t:inputTextHelp id="DivisionDesc" styleClass="FOX_INPUT"  readonly="false"
                                    helpText="Text"
                                    maxlength="50" size="50" required="true"
                                    value="#{foxyCustomerDivision.dbEditCustDivBean.divDesc}">
                                </t:inputTextHelp>
                                <h:message errorClass="FOX_ERROR" for="DivisionDesc" showDetail="true" showSummary="true"/>
                            </h:panelGroup>
                            <!-- ==================== Input Filed for [Customer Name] --END  -- ========================= -->

                            <!-- ==================== Input Filed for [Division Status] --START-- ========================= -->
                            <%--
                            <t:outputLabel for="Status" value="Division Status:" />
                            <h:panelGroup>
                            <h:selectOneMenu id="Status" styleClass="FOX_INPUT" required="true" 
                            value="#{foxyCustomerDivision.dbEditCustDivBean.status}">
                            <f:selectItems value="#{listData.statList}"/>
                            </h:selectOneMenu>
                            <h:message errorClass="FOX_ERROR" for="Status" showDetail="true" showSummary="true"/>
                            </h:panelGroup>
                            --%>
                            <!-- ==================== Input Filed for [Division Status] --END  -- ========================= -->
                        
                                                
                            <!-- ==================== Input Filed for [Remark] --START-- ========================= -->
                            <t:outputLabel for="Remark" value="Remark:" />
                            <h:panelGroup>
                                <h:inputTextarea rows="5" cols="50" id="Remark" styleClass="FOX_INPUT" required="false" 
                                    value="#{foxyCustomerDivision.dbEditCustDivBean.remark}">
                                </h:inputTextarea>
                                <h:message errorClass="FOX_ERROR" for="Remark" showDetail="true" showSummary="true"/>
                            </h:panelGroup>
                            <!-- ==================== Input Filed for [Remark] --END  -- ========================= -->
                        </h:panelGrid>
                        
                    </h:panelGrid>
                        
                        
                    <h:panelGrid id="EditButton" columns="1" columnClasses="FOX_BUTTON" width="50%">
                        <h:panelGroup>
                            <h:commandButton id="Save" value="Save" action="#{foxyCustomerDivision.saveEdit}"/>
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
