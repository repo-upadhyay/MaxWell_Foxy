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
    <table class="box" width="100%">
        <tr><td>
            <%-- This save state required to ensure brandList can be rebuild during sabmit form 
            Without save state, brandList will be empty and will get "Value is not a valid option" error message --%>
            <t:saveState value="#{foxyQuotaMastEdit.editQuotaCatsMap}"/>
            <t:saveState value="#{foxyQuotaMastEdit.qtaCatBean}"/>
            <t:saveState value="#{foxyQuotaMastEdit.selectedCats}"/>
            <t:saveState value="#{foxyQuotaMastEdit.addQuotaCatSta}"/>
        
            <h:messages errorClass="FOX_ERROR" showDetail="true" showSummary="true"/>
            <h:panelGrid id="AddQuotaMastGrid" styleClass="tablebg" width="100%">
                <h:outputText value="Edit Existing Quota Type" styleClass="smalltitle" />
                <h:form id="AddQuotaMastForm">
                    <h:panelGrid id="enq" columns="2" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="50%">
                        <!-- ==================== Input Filed for [Dest Country] --START-- ========================= -->
                        <t:outputLabel value="Country Origin:" for="Country"/>
                        <h:panelGroup>
                            <h:selectOneMenu id="Country" styleClass="FOX_INPUT" required="true" value="#{foxyQuotaMastEdit.dbEditQtaBean.country}">
                                <f:selectItems value="#{listData.countryList}"/>
                            </h:selectOneMenu>
                            <h:message errorClass="FOX_ERROR" for="Country" showDetail="true" showSummary="true"/>
                        </h:panelGroup>                                                                                              
                        <!-- ==================== Input Filed for [Dest Country] --END  -- ========================= -->
                    
    
                        <!-- ==================== Input Filed for [QuotaMast Code] --START-- ========================= -->
                        <t:outputLabel value="Quota Code:" for="QuotaMast_Code"/>
                        <h:panelGroup>
                            <t:inputTextHelp id="QuotaMast_Code" styleClass="FOX_INPUT_RO" readonly="true"
                                helpText="Text"
                                maxlength="10" size="10" required="true"
                                value="#{foxyQuotaMastEdit.dbEditQtaBean.quota}">
                            </t:inputTextHelp>
                            <h:message errorClass="FOX_ERROR" for="QuotaMast_Code" showDetail="true" showSummary="true"/>
                        </h:panelGroup>
                        <!-- ==================== Input Filed for [QuotaMast Code] --END  -- ========================= -->
                        
                        
                        <!-- ==================== Input Filed for [QuotaMast Desc] --START-- ========================= -->
                        <t:outputLabel for="QuotaMast_Desc" value="Quota Desc:" />
                        <h:panelGroup>                            
                            <t:inputTextHelp id="QuotaMast_Desc" styleClass="FOX_INPUT"
                                helpText="Text"
                                maxlength="50" size="50" required="false"
                                value="#{foxyQuotaMastEdit.dbEditQtaBean.qname}">
                            </t:inputTextHelp>
                            <h:message errorClass="FOX_ERROR" for="QuotaMast_Desc" showDetail="true" showSummary="true"/>
                        </h:panelGroup>
                        <!-- ==================== Input Filed for [QuotaMast Desc] --END  -- ========================= -->
                        
                        <!-- ==================== Input Filed for [QuotaMast Caegories] --START-- ========================= -->
                        <t:outputLabel for="Category" value="Category(add to list):"/>
                        <a4j:region id="ajaxregion1" renderRegionOnly="false" selfRendered="true">
                            <h:selectOneMenu id="Category" styleClass="FOX_INPUT" required="false" 
                                value="#{foxyQuotaMastEdit.qtaCatBean.catId}">
                                <f:selectItems value="#{listData.categoryList}"/>
                                <a4j:support  event="onchange" ajaxSingle="true" eventsQueue="eq1"/>
                            </h:selectOneMenu>
                            <h:message errorClass="FOX_ERROR" for="Category" showDetail="true" showSummary="true"/>
                        </a4j:region>
                        
                        <t:outputLabel for="Multiplier" value="Multiplier(add to list):" />
                        <h:panelGroup>
                            <a4j:region id="ajaxregion2" renderRegionOnly="false" selfRendered="true">
                                <t:inputTextHelp id="Multiplier" styleClass="FOX_INPUT" readonly="false"
                                    helpText="99999.99"
                                    maxlength="8" size="8" required="false"
                                    value="#{foxyQuotaMastEdit.qtaCatBean.multiplier}">
                                    <a4j:support  event="onchange" ajaxSingle="true" eventsQueue="eq1"/>
                                </t:inputTextHelp>                            
                                <a4j:commandButton id="add_items" value="Add Category"
                                ajaxSingle="false" immediate="true" action="#{foxyQuotaMastEdit.onAddCats}" 
                                reRender="quota_cats,addCatsStatus" eventsQueue="eq1"/>
                            </a4j:region>
                            <t:outputText id="addCatsStatus" styleClass="FOX_ERROR" value="#{foxyQuotaMastEdit.addQuotaCatSta}"/>
                            <h:message errorClass="FOX_ERROR" for="Multiplier" showDetail="true" showSummary="true"/>
                        </h:panelGroup>
                        
                        <t:outputText value=" " />
                        <t:outputText value="[Category] = [multiplier] pcs"  styleClass="FOX_ERROR"/>
                        
                        <t:outputLabel for="quota_cats" value="Quota Categories:"/>
                        <h:panelGroup>           
                            <a4j:region id="ajaxregion3" renderRegionOnly="false" selfRendered="true">
                                <h:selectManyListbox id="quota_cats" style="width:200px; height:60px " 
                                    styleClass="FOX_INPUT" 
                                    required="false" 
                                    immediate="true" 
                                    value="#{foxyQuotaMastEdit.selectedCats}">
                                    <f:selectItems value="#{foxyQuotaMastEdit.editQuotaCatsList}"/>
                                    <a4j:support  event="onchange" ajaxSingle="true" eventsQueue="eq1"/>
                                </h:selectManyListbox>
                                <a4j:commandButton id="del_items" value="Delete Category" ajaxSingle="false" immediate="true" action="#{foxyQuotaMastEdit.delQuotaCatsListItem}" 
                                reRender="quota_cats" eventsQueue="eq1"/>                                            
                            </a4j:region>
                            <h:message errorClass="FOX_ERROR" for="quota_cats" showDetail="true" showSummary="true"/>
                        </h:panelGroup>
                        <!-- ==================== Input Filed for [QuotaMast Caegories] --END  -- ========================= -->
                        
                        
                        <!-- ==================== Input Filed for [User Status] --START-- ========================= -->
                        <%--
                        <t:outputLabel value="Quota Status:" for="Status"/>
                        <h:panelGroup>
                        <h:selectOneMenu id="Status" styleClass="FOX_INPUT" required="true" value="#{foxyQuotaMastEdit.dbEditQtaBean.status}">
                        <f:selectItems value="#{listData.statList}"/>
                        </h:selectOneMenu>
                        <h:message errorClass="FOX_ERROR" for="Status" showDetail="true" showSummary="true"/>
                        </h:panelGroup>
                        --%>
                        <!-- ==================== Input Filed for [User Status] --END  -- ========================= -->
                        
                    </h:panelGrid>
                    <h:panelGrid id="AddButton" columns="1" columnClasses="FOX_BUTTON" width="50%">
                        <h:panelGroup>
                            <h:commandButton id="Save" value="Save" action="#{foxyQuotaMastEdit.saveEdit}"/>
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
