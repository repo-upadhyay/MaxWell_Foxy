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
                <t:saveState value="#{foxyQuotaEntry.qtaEntryBean.country}"/>
                
                <h:messages errorClass="FOX_ERROR" showDetail="true" showSummary="true"/>
                <h:panelGrid id="AddQuotaEntryGrid" styleClass="tablebg" width="100%">
                    <h:outputText value="New Quota Entry" styleClass="smalltitle" />
                    <h:form id="AddQuotaMastForm">
                        <h:panelGrid id="enq" columns="2" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="50%">
                            <!-- ==================== Input Filed for [Dest Country] --START-- ========================= -->
                            <t:outputLabel value="Country Origin:" for="Country"/>
                            <h:panelGroup>
                                <a4j:region id="ajaxregion1" renderRegionOnly="false" selfRendered="true">
                                    <h:selectOneMenu id="Country" styleClass="FOX_INPUT" 
                                                     required="true" 
                                                     immediate="true"
                                                     value="#{foxyQuotaEntry.qtaEntryBean.country}">
                                        <f:selectItems value="#{listData.countryList}"/>
                                        <a4j:support event="onchange"  
                                                     reRender="QuotaMast_Code" ajaxSingle="true">
                                        </a4j:support>                                    
                                    </h:selectOneMenu>
                                </a4j:region>
                                <h:message errorClass="FOX_ERROR" for="Country" showDetail="true" showSummary="true"/>
                            </h:panelGroup>                                                                                              
                            <!-- ==================== Input Filed for [Dest Country] --END  -- ========================= -->
                    
    
                            <!-- ==================== Input Filed for [QuotaMast Code] --START-- ========================= -->
                            <t:outputLabel value="Quota Code:" for="QuotaMast_Code"/>
                            <h:panelGroup>
                                <h:selectOneMenu id="QuotaMast_Code" styleClass="FOX_INPUT" value="#{foxyQuotaEntry.qtaEntryBean.quota}"
                                                 style="width:220px; " required="true" immediate="true"> 
                                    <f:selectItems value="#{foxyQuotaEntry.qtaByCountryList}"/>
                                </h:selectOneMenu>
                                <a4j:status for="ajaxregion1">
                                    <f:facet name="start">
                                        <h:graphicImage value="/images/ajaxstart.gif" height="12" width="12"/>
                                    </f:facet>
                                    <f:facet name="stop">
                                        <%-- h:graphicImage value="/images/ajax_stoped.gif" / --%>
                                    </f:facet>
                                </a4j:status>                                                                
                                <h:message errorClass="FOX_ERROR" for="QuotaMast_Code" showDetail="true" showSummary="true"/>
                            </h:panelGroup>
                            <!-- ==================== Input Filed for [QuotaMast Code] --END  -- ========================= -->
                        
                        
                            <!-- ==================== Effective Date Field  -- ========================= -->
                            <t:outputLabel for="effDate" value="Effective Date:" />                        
                            <h:panelGroup>
                                <t:inputCalendar  id="effDate" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                                                  helpText="YYYYMMDD" value="#{foxyQuotaEntry.qtaEntryBean.effDate}"
                                                  required = "true" styleClass="FOX_INPUT">
                                </t:inputCalendar>
                                <h:message errorClass="FOX_ERROR" for="effDate" showDetail="true" showSummary="true"/>
                            </h:panelGroup>
                            
                            
                            <!-- ==================== Expire Date Field  -- ========================= -->
                            <t:outputLabel for="expDate" value="Expiry Date:" />                        
                            <h:panelGroup>
                                <t:inputCalendar  id="expDate" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                                                  helpText="YYYYMMDD" value="#{foxyQuotaEntry.qtaEntryBean.expDate}"
                                                  required = "true" styleClass="FOX_INPUT">
                                </t:inputCalendar>
                                <h:message errorClass="FOX_ERROR" for="expDate" showDetail="true" showSummary="true"/>
                            </h:panelGroup>
                            
                            <!-- ==================== Input Filed for [Type] --START-- ========================= -->
                            <t:outputLabel value="Type:" for="type"/>
                            <h:panelGroup>
                                <h:selectOneMenu id="type" styleClass="FOX_INPUT" required="true" value="#{foxyQuotaEntry.qtaEntryBean.type}">
                                    <f:selectItems value="#{foxyQuotaEntry.qtaTypeList}"/>
                                </h:selectOneMenu>
                                <h:message errorClass="FOX_ERROR" for="type" showDetail="true" showSummary="true"/>
                            </h:panelGroup>                                                                                              
                            
                            
                            <!-- ==================== Input Filed for [Qty] --START-- ========================= -->
                            <t:outputLabel for="Qty" value="Quota Qty:" />
                            <h:panelGroup>                            
                                <t:inputTextHelp id="Qty" styleClass="FOX_INPUT"
                                                 helpText="99999.99"
                                                 maxlength="12" size="12" required="true"
                                                 value="#{foxyQuotaEntry.qtaEntryBean.quotaQty}">
                                </t:inputTextHelp>
                                <h:message errorClass="FOX_ERROR" for="Qty" showDetail="true" showSummary="true"/>
                            </h:panelGroup>                                                                                              
                            
                            <!-- ==================== Input Filed for [Cost] --START-- ========================= -->
                            <t:outputLabel for="Cost" value="Cost Payable:" />
                            <h:panelGroup>                            
                                <t:inputTextHelp id="Cost" styleClass="FOX_INPUT"
                                                 helpText="99999.99"
                                                 maxlength="12" size="12" required="true"
                                                 value="#{foxyQuotaEntry.qtaEntryBean.cost}">
                                </t:inputTextHelp>
                                <h:message errorClass="FOX_ERROR" for="Cost" showDetail="true" showSummary="true"/>
                            </h:panelGroup>
                            
                            
                            <!-- ==================== Input Filed for [Quota Doc Ref No] --START-- ========================= -->
                            <t:outputLabel for="QuotaDocRefNo" value="Quota Doc Ref#:" />
                            <h:panelGroup>                            
                                <t:inputTextHelp id="QuotaDocRefNo" styleClass="FOX_INPUT"
                                                 helpText="Text"
                                                 maxlength="50" size="50" required="false"
                                                 value="#{foxyQuotaEntry.qtaEntryBean.quotaRefNo}">
                                </t:inputTextHelp>
                                <h:message errorClass="FOX_ERROR" for="QuotaDocRefNo" showDetail="true" showSummary="true"/>
                            </h:panelGroup>
                            
                            
                            <!-- ==================== Input Filed for [User Status] --START-- ========================= -->
                            <%--
                        <t:outputLabel value="Status:" for="Status"/>
                        <h:panelGroup>
                        <h:selectOneMenu id="Status" styleClass="FOX_INPUT" required="true" value="#{foxyQuotaEntry.qtaEntryBean.status}">
                        <f:selectItems value="#{listData.statList}"/>
                        </h:selectOneMenu>
                        <h:message errorClass="FOX_ERROR" for="Status" showDetail="true" showSummary="true"/>
                        </h:panelGroup>
                        --%>
                            <!-- ==================== Input Filed for [User Status] --END  -- ========================= -->
                        
                        </h:panelGrid>
                        <h:panelGrid id="AddButton" columns="1" columnClasses="FOX_BUTTON" width="50%">
                            <h:panelGroup>
                                <h:commandButton id="Save" value="Save" action="#{foxyQuotaEntry.saveAdd}"/>
                            </h:panelGroup>
                        </h:panelGrid>
                    </h:form>
                </h:panelGrid>
                
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
