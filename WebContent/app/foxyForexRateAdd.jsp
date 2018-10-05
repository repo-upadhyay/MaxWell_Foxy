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
                <h:panelGrid id="AddForexRateGrid" styleClass="tablebg" width="100%">
                    <h:outputText value="New ForexRate" styleClass="smalltitle" />
                    <h:form id="AddForexRateForm">
                        <h:panelGrid id="enq" columns="2" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="50%">
                            
                            <!-- ==================== Input Filed for [ForexRate Code] --START-- ========================= -->
                            <t:outputLabel for="ForexRate_Code" value="Currency Code:" />
                            <h:panelGroup>
                                <h:selectOneMenu id="ForexRate_Code" styleClass="FOX_INPUT" required="true" 
                                                 value="#{foxyForexRate.forexRateBean.curCode}" readonly="false"> 
                                    <f:selectItems value="#{listData.forexCurrencyList}"/>
                                </h:selectOneMenu>
                                <h:message errorClass="FOX_ERROR" for="ForexRate_Code" showDetail="true" showSummary="true"/>
                            </h:panelGroup>
                            <!-- ==================== Input Filed for [ForexRate Code] --END  -- ========================= -->

                            <t:outputLabel for="ForexRate_Date" value="Rate Date" />
                            <h:panelGroup>
                                <t:inputCalendar  id="ForexRate_Date" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                                                  helpText="YYYYMMDD" value="#{foxyForexRate.forexRateBean.rateDate}"
                                                  required = "true" styleClass="FOX_INPUT">
                                </t:inputCalendar>
                                <h:message errorClass="FOX_ERROR" for="ForexRate_Date" showDetail="true" showSummary="true"/>
                            </h:panelGroup>
                            
                            <!-- ==================== Input Filed for [ForexRate ] --START-- ========================= -->
                            <t:outputLabel for="PerUSDRate" value="Rate per USD:" />
                            <h:panelGroup>
                                <t:inputTextHelp id="PerUSDRate" styleClass="FOX_INPUT"
                                                 helpText="9999.999"
                                                 maxlength="12" size="12" required="true"
                                                 value="#{foxyForexRate.forexRateBean.perUsdRate}">
                                    <t:validateRegExpr pattern="^[+]{0,1}[0-9]{0,4}(\\.[0-9]{0,3}){0,1}$"/>
                                </t:inputTextHelp>
                                <h:message errorClass="FOX_ERROR" for="PerUSDRate" showDetail="true" showSummary="true"/>
                            </h:panelGroup>
                            <!-- ==================== Input Filed for [ForexRate ] --END  -- ========================= -->
                            
                            <!-- ==================== Input Filed for [ForexRate ] --START-- ========================= -->
                            <t:outputLabel for="autocreate" value="Auto Create:" />
                            <h:panelGroup>
                                <t:selectBooleanCheckbox  id="autocreate" value="#{foxyForexRate.autoPopulateForex}" />
                                <t:outputText value="For next #{foxyForexRate.populateDays} days" />
                            </h:panelGroup>
                            <!-- ==================== Input Filed for [ForexRate ] --END  -- ========================= -->                            
                        </h:panelGrid>
                        
                        
                        
                        <h:panelGrid id="AddButton" columns="1" columnClasses="FOX_BUTTON" width="50%">
                            <h:panelGroup>
                                <h:commandButton id="Save" value="Save" action="#{foxyForexRate.saveAdd}"/>
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
