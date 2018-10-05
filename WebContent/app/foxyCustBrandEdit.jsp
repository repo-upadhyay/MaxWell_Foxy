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
            <h:panelGrid id="EditCustomerGrid" styleClass="tablebg" width="100%">
                <h:outputText value="Edit Brand for customer" styleClass="smalltitle" />
                <h:form id="EditCustomerForm">
                    <h:panelGrid id="enq" columns="2" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="50%">

                        <!-- ==================== Input Filed for [Customer Code] --START-- ========================= -->                        
                        <t:outputLabel for="Customer_Code" value="Customer Name:" />
                        <h:panelGroup>
                            <h:selectOneMenu id="Customer_Code" styleClass="FOX_INPUT" required="true" 
                                readonly="false" disabled="false"
                                value="#{foxyCustomerBrand.dbEditCustBrandBean.custCode}"> 
                                <f:selectItems value="#{listData.customerList}"/>
                            </h:selectOneMenu>
                            <h:message errorClass="FOX_ERROR" for="Customer_Code" showDetail="true" showSummary="true"/>
                        </h:panelGroup>
                        <!-- ==================== Input Filed for [Customer Code] --END  -- ========================= -->

                        <!-- ==================== Input Filed for [Brand Code] --START-- ========================= -->
                        <t:outputLabel for="BrandCode" value="Brand Code:" />
                        <h:panelGroup>
                            <t:inputTextHelp id="BrandCode" styleClass="FOX_INPUT_RO"  readonly="true"
                                helpText="Text"
                                maxlength="10" size="10" required="true"
                                value="#{foxyCustomerBrand.dbEditCustBrandBean.brandCode}">
                            </t:inputTextHelp>
                            <h:message errorClass="FOX_ERROR" for="BrandCode" showDetail="true" showSummary="true"/>
                        </h:panelGroup>
                        <!-- ==================== Input Filed for [Brand Code] --END  -- ========================= -->

                        
                        <!-- ==================== Input Filed for [Brand Desc] --START-- ========================= -->
                        <t:outputLabel for="BrandDesc" value="Brand Desc:" />
                        <h:panelGroup>
                            <t:inputTextHelp id="BrandDesc" styleClass="FOX_INPUT"  readonly="false"
                                helpText="Text"
                                maxlength="50" size="50" required="true"
                                value="#{foxyCustomerBrand.dbEditCustBrandBean.brandDesc}">
                            </t:inputTextHelp>
                            <h:message errorClass="FOX_ERROR" for="BrandDesc" showDetail="true" showSummary="true"/>
                        </h:panelGroup>
                        <!-- ==================== Input Filed for [Brand Desc] --END  -- ========================= -->

                        <!-- ==================== Input Filed for [Brand Status] --START-- ========================= -->
                        <%--
                        <t:outputLabel for="Status" value="Brand Status:" />
                        <h:panelGroup>
                        <h:selectOneMenu id="Status" styleClass="FOX_INPUT" required="true" value="#{foxyCustomerBrand.dbEditCustBrandBean.status}">
                        <f:selectItems value="#{listData.statList}"/>
                        </h:selectOneMenu>
                        <h:message errorClass="FOX_ERROR" for="Status" showDetail="true" showSummary="true"/>
                        </h:panelGroup>
                        --%>
                        <!-- ==================== Input Filed for [Brand Status] --END  -- ========================= -->
                        
                                                
                        <!-- ==================== Input Filed for [Remark] --START-- ========================= -->
                        <t:outputLabel for="Remark" value="Remark:" />
                        <h:panelGroup>
                            <h:inputTextarea rows="5" cols="50" id="Remark" styleClass="FOX_INPUT" required="false" 
                                value="#{foxyCustomerBrand.dbEditCustBrandBean.remark}">
                            </h:inputTextarea>
                            <h:message errorClass="FOX_ERROR" for="Remark" showDetail="true" showSummary="true"/>
                        </h:panelGroup>
                        <!-- ==================== Input Filed for [Remark] --END  -- ========================= -->

                    </h:panelGrid>
                        
                        
                    <h:panelGrid id="EditButton" columns="1" columnClasses="FOX_BUTTON" width="50%">
                        <h:panelGroup>
                            <h:commandButton id="Save" value="Save" action="#{foxyCustomerBrand.saveEdit}"/>
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
