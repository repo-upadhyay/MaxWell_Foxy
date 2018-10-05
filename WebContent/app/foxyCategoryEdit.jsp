<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%@taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<%@taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@taglib prefix="h" uri="http://java.sun.com/jsf/html"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<f:view>
    <%@ include file="foxyHeader.jsp" %>
    <f:loadBundle basename="com.foxy.page.ValidatorMessages" var="ValidatorMsg"/>
    <table class="box" width="100%">
        <tr><td>
            <h:messages errorClass="FOX_ERROR" showDetail="true" showSummary="true"/>
            <h:panelGrid id="UpdCategoryGrid" styleClass="tablebg" width="100%">
                <h:outputText value="Update Category" styleClass="smalltitle"/>
                <h:form id="UpdCategoryForm">
                    <h:panelGrid id="enq" columns="2" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="50%">
                        
                        <!-- ==================== Input Filed for [Category Code] --START-- ========================= -->
                        <t:outputLabel for="Category_Code" value="Category Code:"/>
                        <h:panelGroup>
                            <t:inputTextHelp id="Category_Code" styleClass="FOX_INPUT_RO" readonly="true"
                                helpText="Text"
                                maxlength="10" size="10" required="true"
                                value="#{foxyCategory.dbEditCatBean.category}">
                            </t:inputTextHelp>
                            <h:message errorClass="FOX_ERROR" for="Category_Code" showDetail="true" showSummary="true"/>
                        </h:panelGroup>
                        <!-- ==================== Input Filed for [Category Code] --END  -- ========================= -->
                        
                        
                        <!-- ==================== Input Filed for [Dest Country] --START-- ========================= -->
                        <t:outputLabel for="Country" value="Dest Country:" />
                        <h:panelGroup>
                            <h:selectOneMenu id="Country" styleClass="FOX_INPUT" required="true" value="#{foxyCategory.dbEditCatBean.country}">
                                <f:selectItems value="#{listData.destinationList}"/>
                            </h:selectOneMenu>
                            <h:message errorClass="FOX_ERROR" for="Country" showDetail="true" showSummary="true"/>
                        </h:panelGroup>                                                                                              
                        <!-- ==================== Input Filed for [Dest Country] --END  -- ========================= -->
                                                                        
                        
                        <!-- ==================== Input Filed for [Unit] --START-- ========================= -->
                        <t:outputLabel for="unit" value="Unit:" />
                        <h:panelGroup>
                            <h:selectOneMenu id="unit" styleClass="FOX_INPUT" required="true" value="#{foxyCategory.dbEditCatBean.unit}">
                                <f:selectItems value="#{listData.unitList}"/>
                            </h:selectOneMenu>
                            <h:message errorClass="FOX_ERROR" for="unit" showDetail="true" showSummary="true"/>                            
                        </h:panelGroup>                         
                        <!-- ==================== Input Filed for [Unit] --END  -- ========================= -->
                        
                        
                        
                        <!-- ==================== Input Filed for [SME factor] --START-- ========================= -->
                        <%--
                        <t:outputLabel for="SME_factor" value="SME Multiplier:" />
                        <h:panelGroup>
                        <t:inputTextHelp id="SME_factor" styleClass="FOX_INPUT"
                        helpText="999999.99"
                        maxlength="11" size="11" required="false"
                        value="#{foxyCategory.dbEditCatBean.sme}">
                        <t:validateRegExpr pattern="#{ValidatorMsg.Pattern6D2F}"
                        message="#{ValidatorMsg.Message6D2F}"/>                                
                        </t:inputTextHelp>
                        <h:message errorClass="FOX_ERROR" for="SME_factor" showDetail="true" showSummary="false"/>
                        </h:panelGroup>
                        --%>
                        <!-- ==================== Input Filed for [SME factor] --END  -- ========================= -->


                        <!-- ==================== Input Filed for [Category Desc] --START-- ========================= -->
                        <t:outputLabel for="Category_Desc" value="Category Desc:" />
                        <h:panelGroup>
                            <t:inputTextHelp id="Category_Desc" styleClass="FOX_INPUT"
                                helpText="Text"
                                maxlength="50" size="50" required="false"
                                value="#{foxyCategory.dbEditCatBean.desc}">
                            </t:inputTextHelp>
                            <h:message errorClass="FOX_ERROR" for="Category_Desc" showDetail="true" showSummary="true"/>
                        </h:panelGroup>
                        <!-- ==================== Input Filed for [Category Desc] --END  -- ========================= -->


                        <!-- ==================== Input Filed for [Fabric] --START-- ========================= -->
                        <t:outputLabel for="Fabric" value="Fabric:" />
                        <h:panelGroup>
                            <t:inputTextHelp id="Fabric" styleClass="FOX_INPUT"
                                helpText="Text"
                                maxlength="50" size="50" required="false"
                                value="#{foxyCategory.dbEditCatBean.fabric}">
                            </t:inputTextHelp>
                            <h:message errorClass="FOX_ERROR" for="Fabric" showDetail="true" showSummary="true"/>
                        </h:panelGroup>
                        <!-- ==================== Input Filed for [Fabric] --END  -- ========================= -->


                        <!-- ==================== Input Filed for [User Status] --START-- ========================= -->
                        <%--
                        <t:outputLabel for="Status" value="Category Status:" />
                        <h:panelGroup>
                        <h:selectOneMenu id="Status" styleClass="FOX_INPUT" required="true" value="#{foxyCategory.dbEditCatBean.status}">
                        <f:selectItems value="#{listData.statList}"/>
                        </h:selectOneMenu>
                        <h:message errorClass="FOX_ERROR" for="Status" showDetail="true" showSummary="true"/>
                        </h:panelGroup>
                        --%>
                        <!-- ==================== Input Filed for [User Status] --END  -- ========================= -->
                        
                    </h:panelGrid>
                    <h:panelGrid columns="1" columnClasses="FOX_BUTTON" width="50%">
                        <h:panelGroup>
                            <h:commandButton id="Save" value="Save" action="#{foxyCategory.saveEdit}"/>
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
