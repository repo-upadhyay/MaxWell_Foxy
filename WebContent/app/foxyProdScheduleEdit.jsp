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
            <h:messages errorClass="FOX_ERROR" showDetail="true" showSummary="true" />
            <h:panelGrid id="UpdAddGrid" styleClass="tablebg" width="100%">
                <%-- Title for Add --%>
                <h:outputText value="Edit Production schedule" styleClass="smalltitle"/>
                
                <h:form id="UpdAddForm">
                    <%-- This save state required to ensure variable value available for rebuild list during  
                    Without save state, list will be empty and will get "Value is not a valid option" error message when submit form--%> 
                    <t:saveState value="#{foxyProdScheduleEdit.editProdSchBean.sewStart}"/>
                    <t:saveState value="#{foxyProdScheduleEdit.editProdSchBean.sewEnd}"/>
                    <t:saveState value="#{foxyProdScheduleEdit.editProdSchBean.refNo}"/>
                    <t:saveState value="#{foxyProdScheduleEdit.editLotsMap}"/>
                    <t:saveState value="#{foxyProdScheduleEdit.checkStatus}"/>
                    <t:saveState value="#{foxyProdScheduleEdit.addLotStat}"/>
                    <t:saveState value="#{foxyProdScheduleEdit.selectedLots}"/>
                    <t:saveState value="#{foxyProdScheduleEdit.prodLotBean}"/>
                    
                    
                    
                    <h:panelGrid columns="1"  width="100%" cellpadding="0" cellspacing="0" border="0" frame="none" rules="none">                        
                        <h:panelGrid id="UpdAddInput" columns="2" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="50%">
                            <!-- ==================== Input Filed for [Location] --START-- ========================= -->
                            <t:outputLabel for="Location" value="Location:" />
                            <h:panelGroup>
                                <h:selectOneMenu id="Location" styleClass="FOX_INPUT" required="true" value="#{foxyProdScheduleEdit.editProdSchBean.ccode}">
                                    <f:selectItems value="#{listData.countryList}"/>
                                </h:selectOneMenu>
                                <h:message errorClass="FOX_ERROR" for="Location" showDetail="true" showSummary="true"/>                            
                            </h:panelGroup>
                            <!-- ==================== Input Filed for [Location] --END  -- ========================= -->
                        
                            <t:outputLabel for="lineNo" value="Line No:" />
                            <h:panelGroup>                        
                                <t:inputTextHelp id="lineNo" styleClass="FOX_INPUT"
                                    helpText="999"
                                    maxlength="3" size="3" required="true" 
                                    value="#{foxyProdScheduleEdit.editProdSchBean.lineNo}">
                                    <f:convertNumber integerOnly="true" maxIntegerDigits="3" groupingUsed="false"/>
                                </t:inputTextHelp>
                                <h:message errorClass="FOX_ERROR" for="lineNo" showDetail="true" showSummary="true"/>
                            </h:panelGroup>
                        </h:panelGrid>
                        
                        <h:panelGrid columns="1"  width="100%" cellpadding="0" cellspacing="0" border="0" frame="none" rules="none">
                            <h:panelGrid id="UpdAddInput11" columns="2" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="50%">
                                <t:outputLabel for="RefNo" value="Ref No:" />
                                <h:panelGroup>                        
                                    <a4j:region id="ajaxregion1" renderRegionOnly="false" selfRendered="true">
                                        <t:inputTextHelp id="RefNo" styleClass="FOX_INPUT"
                                            helpText="Text"
                                            maxlength="10" size="10" required="true" immediate="true"
                                            value="#{foxyProdScheduleEdit.editProdSchBean.refNo}" >
                                            <a4j:support id="ajrefno" event="onchange" action="#{foxyProdScheduleEdit.onRefNoChange}"
                                                reRender="checkStatus,Save,subRef" ajaxSingle="true">
                                            </a4j:support>
                                        </t:inputTextHelp>
                                    </a4j:region>
                                    <t:outputText id="checkStatus" styleClass="FOX_ERROR" value="#{foxyProdScheduleEdit.checkStatus}"/>
                                    <a4j:status startText="Check ref no ..." />  
                                        
                                    <h:message errorClass="FOX_ERROR" for="RefNo" showDetail="true" showSummary="true"/>
                                </h:panelGroup>
                            </h:panelGrid>

                                
                            <h:panelGrid id="UpdAddInput1_1" columns="2" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="50%">
                                <t:outputLabel for="SubRefNo" value="Lot (add to list):" />
                                <h:panelGroup>                        
                                    <a4j:region id="ajaxregion2" renderRegionOnly="false" selfRendered="true">
                                        <t:inputTextHelp id="SubRefNo" styleClass="FOX_INPUT"
                                            helpText="Text"
                                            maxlength="10" size="10" required="false" immediate="true"
                                            value="#{foxyProdScheduleEdit.prodLotBean.lot}" >
                                            <a4j:support  event="onchange" ajaxSingle="true" eventsQueue="eq1"/>
                                        </t:inputTextHelp>
                                    </a4j:region>
                                    <h:message errorClass="FOX_ERROR" for="lotDate" showDetail="true" showSummary="true"/>
                                </h:panelGroup>
                                        
                                <t:outputLabel for="lotDate" value="Vessel Date (add to list):" />
                                <h:panelGroup>
                                    <a4j:region id="ajaxregion3" renderRegionOnly="false" selfRendered="true">
                                        <t:inputCalendar  id="lotDate" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                                            helpText="YYYYMMDD" value="#{foxyProdScheduleEdit.prodLotBean.vesselDate}"
                                            required = "false" styleClass="FOX_INPUT" immediate="true">
                                            <a4j:support  event="onchange" ajaxSingle="true" eventsQueue="eq1"/>
                                        </t:inputCalendar>                                    
                                        <h:message errorClass="FOX_ERROR" for="lotDate" showDetail="true" showSummary="true"/>
                                        <a4j:commandButton id="add_items" value="Add Lot" ajaxSingle="false" immediate="true" action="#{foxyProdScheduleEdit.onAddSubRefNo}" 
                                        reRender="subRefList,addLotStatus" eventsQueue="eq1"/>
                                    </a4j:region>
                                    <t:outputText id="addLotStatus" styleClass="FOX_ERROR" value="#{foxyProdScheduleEdit.addLotStat}"/>
                                </h:panelGroup>
                                        
                                <t:outputLabel for="subRefList" value="Vessel Date/Lots:" />
                                <h:panelGroup>
                                    <a4j:region id="ajaxregion4" renderRegionOnly="false" selfRendered="true">
                                        <h:selectManyListbox id="subRefList" style="width:200px; height:60px " styleClass="FOX_INPUT" required="false" immediate="true" value="#{foxyProdScheduleEdit.selectedLots}">
                                            <f:selectItems value="#{foxyProdScheduleEdit.editLotsListItems}"/>
                                            <a4j:support  event="onchange" ajaxSingle="true" eventsQueue="eq1"/>
                                        </h:selectManyListbox>
                                        <a4j:commandButton id="del_items" value="Delete Lot" ajaxSingle="false" immediate="false" action="#{foxyProdScheduleEdit.delLotsListItem}" 
                                        reRender="subRefList" eventsQueue="eq1"/>                                            
                                    </a4j:region>
                                </h:panelGroup>
                            </h:panelGrid>                                
                                                

                            <h:panelGrid id="UpdAddInput21" columns="2" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="50%">
                                <t:outputLabel for="DailyProdQty" value="Daily Prod Qty:" />
                                <h:panelGroup>                        
                                    <t:inputTextHelp id="DailyProdQty" styleClass="FOX_INPUT"
                                        helpText="9999999999"
                                        maxlength="10" size="10" required="true" 
                                        value="#{foxyProdScheduleEdit.editProdSchBean.dailyProdQty}">
                                        <f:convertNumber integerOnly="true" maxIntegerDigits="10" groupingUsed="false"/>
                                    </t:inputTextHelp>
                                    <h:message errorClass="FOX_ERROR" for="DailyProdQty" showDetail="true" showSummary="true"/>
                                </h:panelGroup>
                            </h:panelGrid>

                            <h:panelGrid id="UpdAddInputAjax21" columns="2" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="50%">
                                <t:outputLabel for="SewStart" value="Sewing Start:" />                        
                                <h:panelGroup>
                                    <t:inputCalendar  id="SewStart" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                                        helpText="YYYYMMDD" value="#{foxyProdScheduleEdit.editProdSchBean.sewStart}"
                                        required = "true" styleClass="FOX_INPUT">
                                    </t:inputCalendar>
                                    <h:message errorClass="FOX_ERROR" for="SewStart" showDetail="true" showSummary="true"/>
                                </h:panelGroup>
                        
                                <t:outputLabel for="SewEnd" value="Sewing End:" />                        
                                <h:panelGroup>
                                    <t:inputCalendar  id="SewEnd" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                                        helpText="YYYYMMDD" value="#{foxyProdScheduleEdit.editProdSchBean.sewEnd}"
                                        required = "true" styleClass="FOX_INPUT">
                                    </t:inputCalendar>
                                    <h:message errorClass="FOX_ERROR" for="SewEnd" showDetail="true" showSummary="true"/>
                                </h:panelGroup>                                                                        
                                
                                <t:outputLabel for="Groups" value="Groups:" />
                                <h:panelGroup>                        
                                    <t:inputTextHelp id="Groups" styleClass="FOX_INPUT"
                                        helpText="Text"
                                        maxlength="32" size="32" required="true" 
                                        value="#{foxyProdScheduleEdit.editProdSchBean.groups}">                                        
                                    </t:inputTextHelp>
                                    <h:message errorClass="FOX_ERROR" for="Groups" showDetail="true" showSummary="true"/>
                                </h:panelGroup>                                                                

                                <t:outputLabel for="DaysToComplete" value="Days to complete:" />
                                <h:panelGroup>                        
                                    <t:inputTextHelp id="DaysToComplete" styleClass="FOX_INPUT"
                                        helpText="99999"
                                        maxlength="5" size="5" required="true" 
                                        value="#{foxyProdScheduleEdit.editProdSchBean.numOfDay}">
                                        <f:convertNumber integerOnly="true" maxIntegerDigits="5" groupingUsed="false"/>
                                    </t:inputTextHelp>
                                    <h:message errorClass="FOX_ERROR" for="DaysToComplete" showDetail="true" showSummary="true"/>
                                </h:panelGroup>
                                                                                                
                            </h:panelGrid>
                        
                            <h:panelGrid id="UpdAddInput3" columns="2" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="50%">                        
                        
                                <t:outputLabel for="ordQty" value="Order Qty:" />
                                <h:panelGroup>                        
                                    <t:inputTextHelp id="ordQty" styleClass="FOX_INPUT"
                                        helpText="9999999999"
                                        maxlength="10" size="10" required="true" 
                                        value="#{foxyProdScheduleEdit.editProdSchBean.ordQty}">
                                        <f:convertNumber integerOnly="true" maxIntegerDigits="10" groupingUsed="false"/>
                                    </t:inputTextHelp>
                                    <h:message errorClass="FOX_ERROR" for="ordQty" showDetail="true" showSummary="true"/>
                                </h:panelGroup>

                                <t:outputLabel for="bySubCon" value="By Sub-Contractor:" />
                                <h:panelGroup>                        
                                    <t:selectBooleanCheckbox id="bySubCon" 
                                        styleClass="FOX_INPUT"
                                        required="false"
                                        value="#{foxyProdScheduleEdit.editProdSchBean.bySubCon}">
                                    </t:selectBooleanCheckbox>
                                    <h:message errorClass="FOX_ERROR" for="bySubCon" showDetail="true" showSummary="true"/>
                                </h:panelGroup>
                                
                                <t:outputLabel for="Remark" value="Remark:" />
                                <h:panelGroup>
                                    <t:inputTextHelp id="Remark" styleClass="FOX_INPUT"
                                        helpText="Text"
                                        maxlength="50" size="50" required="false" 
                                        value="#{foxyProdScheduleEdit.editProdSchBean.remark}">                                        
                                    </t:inputTextHelp>
                                    <h:message errorClass="FOX_ERROR" for="Remark" showDetail="true" showSummary="true"/>
                                </h:panelGroup>                                 
                                                
                                <%--
                                <t:outputLabel for="Remark" value="Remark:" />
                                <h:panelGroup>
                                <h:inputTextarea rows="3" cols="30" id="Remark" styleClass="FOX_INPUT" required="false" value="#{foxyProdScheduleEdit.editProdSchBean.remark}">
                                </h:inputTextarea>
                                <h:message errorClass="FOX_ERROR" for="Remark" showDetail="true" showSummary="true"/>
                                </h:panelGroup>
                                --%>
                            </h:panelGrid>
                        
                    
                            <h:panelGrid id="AddButton" columns="1" columnClasses="FOX_BUTTON" width="50%">
                                <h:panelGroup>
                                    <h:commandButton id="Save"  value="Save" action="#{foxyProdScheduleEdit.saveEdit}" disabled="#{not foxyProdScheduleEdit.statusOk}"/>
                                </h:panelGroup>
                            </h:panelGrid>     
                        </h:panelGrid>
                    </h:panelGrid>
                </h:form>
            </h:panelGrid>
            <%-- End of Update & Add --%>

        </td></tr>
        <tr>
            <td>
                <%--
                <hr>
                Code snippets of this page:
                <hr>
                <div style="border: 1px solid darkblue; padding: 5px; overflow: auto; font-size: 9px; height: 150px; width: 100%;" id="logConsole">
                </div>            
                --%>
                <!-- Report List -->
            </td>
        </tr>
    </table>
    <%@ include file="foxyFooter.jsp" %>
</f:view>

