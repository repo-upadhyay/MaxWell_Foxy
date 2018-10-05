<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%@taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<%@taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@taglib prefix="h" uri="http://java.sun.com/jsf/html"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<f:view>
    <%@ include file="foxyHeader.jsp" %>
    <table class="box" width="100%">
        <tr><td>
                <h:messages errorClass="FOX_ERROR" showDetail="true" showSummary="true"/>
                <h:panelGrid id="UpdCustomerGrid" styleClass="tablebg" width="100%">
                    <h:outputText value="Update Customer" styleClass="smalltitle"/>
                    <h:form id="UpdCustomerForm">
                        <h:panelGrid id="enq" columns="2" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="50%">
                            
                            <!-- ==================== Input Filed for [Customer Code] --START-- ========================= -->
                            <t:outputLabel for="Customer_Code" value="Customer Code:" />
                            <h:panelGroup>
                                <t:inputTextHelp id="Customer_Code" styleClass="FOX_INPUT_RO" readonly="true"
                                                 helpText="Text"
                                                 maxlength="10" size="10" required="true"
                                                 value="#{foxyCustomer.dbEditCustBean.custCode}">
                                </t:inputTextHelp>
                                <h:message errorClass="FOX_ERROR" for="Customer_Code" showDetail="true" showSummary="true"/>
                            </h:panelGroup>
                            <!-- ==================== Input Filed for [Customer Code] --END  -- ========================= -->


                            <!-- ==================== Input Filed for [Customer Name] --START-- ========================= -->
                            <t:outputLabel for="Customer_Name" value="Customer Name:" />
                            <h:panelGroup>
                                <t:inputTextHelp id="Customer_Name" styleClass="FOX_INPUT"
                                                 helpText="Text"
                                                 maxlength="30" size="30" required="true"
                                                 value="#{foxyCustomer.dbEditCustBean.custName}">
                                </t:inputTextHelp>
                                <h:message errorClass="FOX_ERROR" for="Customer_Name" showDetail="true" showSummary="true"/>
                            </h:panelGroup>
                            <!-- ==================== Input Filed for [Customer Name] --END  -- ========================= -->

                            <!-- ==================== Input Filed for [Federated customer?] --START-- ========================= -->
                            <t:outputLabel for="Customer_Federated" value="Federated:" />
                            <h:panelGroup>
                                <t:selectBooleanCheckbox id="Customer_Federated" styleClass="FOX_INPUT"
                                                         required="false"
                                                         value="#{foxyCustomer.dbEditCustBean.federated}"/>
                                <h:message errorClass="FOX_ERROR" for="Customer_Federated" showDetail="true" showSummary="true"/>
                            </h:panelGroup>
                            <!-- ==================== Input Filed for [Federated customer?] --END  -- ========================= -->                       
                            
                            <!-- ==================== Input Filed for [Payment Term?] --START-- ========================= -->
                            <t:outputLabel for="payTerm" value="Payment Term" />
                            <h:panelGroup>
                                <t:inputTextHelp id="payTerm" styleClass="FOX_INPUT"
                                                 helpText="999"
                                                 maxlength="3" size="3" required="true"
                                                 value="#{foxyCustomer.dbEditCustBean.payTerm}"/>
                                <h:message errorClass="FOX_ERROR" for="payTerm" showDetail="true" showSummary="true"/>
                            </h:panelGroup>
                            <!-- ==================== Input Filed for [Payment term?] --END  -- ========================= -->                                                   
                        
                            <!-- ==================== Input Filed for [Address] --START-- ========================= -->
                            <t:outputLabel for="Address" value="Address:" />
                            <h:panelGroup>
                                <t:inputTextHelp id="Address" styleClass="FOX_INPUT"
                                                 helpText="Text"
                                                 maxlength="150" size="60" required="false"
                                                 value="#{foxyCustomer.dbEditCustBean.custAddress}">
                                </t:inputTextHelp>
                                <h:message errorClass="FOX_ERROR" for="Address" showDetail="true" showSummary="true"/>
                            </h:panelGroup>
                            <!-- ==================== Input Filed for [Address] --END  -- ========================= -->


                            <!-- ==================== Input Filed for [Phone Number] --START-- ========================= -->
                            <t:outputLabel for="Phone_Number" value="Phone Number:" />
                            <h:panelGroup>
                                <t:inputTextHelp id="Phone_Number" styleClass="FOX_INPUT"
                                                 helpText="Text"
                                                 maxlength="20" size="20" required="false"
                                                 value="#{foxyCustomer.dbEditCustBean.custTel}">
                                </t:inputTextHelp>
                                <h:message errorClass="FOX_ERROR" for="Phone_Number" showDetail="true" showSummary="true"/>
                            </h:panelGroup>
                            <!-- ==================== Input Filed for [Phone Number] --END  -- ========================= -->


                            <!-- ==================== Input Filed for [Fax Number] --START-- ========================= -->
                            <t:outputLabel for="Fax_Number" value="Fax Number:" />
                            <h:panelGroup>
                                <t:inputTextHelp id="Fax_Number" styleClass="FOX_INPUT"
                                                 helpText="Text"
                                                 maxlength="20" size="20" required="false"
                                                 value="#{foxyCustomer.dbEditCustBean.custFax}">
                                </t:inputTextHelp>
                                <h:message errorClass="FOX_ERROR" for="Fax_Number" showDetail="true" showSummary="true"/>
                            </h:panelGroup>
                            <!-- ==================== Input Filed for [Fax Number] --END  -- ========================= -->

                        
                            <!-- ==================== Input Filed for [User Status] --START-- ========================= -->
                            <%--
                        <t:outputLabel for="Status" value="Customer Status:" />
                        <h:panelGroup>
                        <h:selectOneMenu id="Status" styleClass="FOX_INPUT" required="true" value="#{foxyCustomer.dbEditCustBean.status}">
                        <f:selectItems value="#{listData.statList}"/>
                        </h:selectOneMenu>
                        <h:message errorClass="FOX_ERROR" for="Status" showDetail="true" showSummary="true"/>
                        </h:panelGroup>
                        --%>
                            <!-- ==================== Input Filed for [User Status] --END  -- ========================= -->
                        

                            <!-- ==================== Input Filed for [Remark] --START-- ========================= -->
                            <t:outputLabel for="Remark" value="Remark:" />
                            <h:panelGroup>
                                <h:inputTextarea rows="5" cols="50" id="Remark" styleClass="FOX_INPUT" required="false" 
                                                 value="#{foxyCustomer.dbEditCustBean.remark}">
                                </h:inputTextarea>
                                <h:message errorClass="FOX_ERROR" for="Remark" showDetail="true" showSummary="true"/>
                            </h:panelGroup>                        
                            <!-- ==================== Input Filed for [Remark] --END  -- ========================= -->
                                              
                        </h:panelGrid>
                        <h:panelGrid columns="1" columnClasses="FOX_BUTTON" width="50%">
                            <h:panelGroup>
                                <h:commandButton id="Save" value="Save" action="#{foxyCustomer.saveEdit}"/>
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
