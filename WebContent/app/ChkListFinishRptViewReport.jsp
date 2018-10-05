<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%@taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<%@taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@taglib prefix="h" uri="http://java.sun.com/jsf/html"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">


<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/reportStyle.css" />      



<f:view>
    <%@ include file="foxyHeader.jsp" %>
    <h:panelGrid id="MainGrid" styleClass="tablebg" width="100%">
        <h:outputText value="View Finish Report Listing" styleClass="smalltitle" />
        <h:outputText value=" Leave blank to list all record(s)" style="color: #FE0000; font-weight: bold;" />
        <h:messages id="msgs"/>
        
        <h:form id="finishRptsrch">
            <t:outputLabel for="refNo" value="Ref No:"/>
            <t:inputText id="refNo" value="#{foxySessionData.orderId}" />
            <h:commandButton action="#{foxyFinishRptView.searchRec}" value="Search" />                    
            <t:outputText id="q11" value="Sorry no record(s) found"
                          style="color: #FF0F00; font-weight: bold;"
                          rendered="#{foxyFinishRptView.searchNotFound}" />
        </h:form>
        
        <h:form id="finishRpt" rendered="#{foxyFinishRptView.objFound}">
            <t:dataTable  value="#{foxyFinishRptView.objModel}" var="finishRpt" styleClass="dataTable">
                <f:facet name="header">
                    <h:panelGroup>
                        <h:outputText value="#{foxyFinishRptView.rptTitleStr}" style="color: #ff0000;" styleClass="smalltitle"/>
                    </h:panelGroup>
                </f:facet>
                <f:facet name="footer">
                    <h:outputText value="End of Record(s)"  />
                </f:facet>                    
                
                <h:column>
                    <f:facet name="header">
                        <h:outputText value="CO"/>
                    </f:facet>
                    <h:outputText value="#{finishRpt.ccode}"/>
                </h:column>
                
                
                <h:column>
                    <f:facet name="header">
                        <h:outputText value="Ref"/>
                    </f:facet>
                    <h:outputText id="CurRecrefid" value="#{finishRpt.refNo}" />                        
                </h:column>                                        
                
                <h:column>
                    <f:facet name="header">
                        <h:outputText value="Buyer"/>
                    </f:facet>
                    <h:outputText value="#{finishRpt.buyer}"/>
                </h:column>
                
                
                <h:column>
                    <f:facet name="header">
                        <h:outputText value="Merchant"/>
                    </f:facet>
                    <h:outputText value="#{finishRpt.merchant}"/>
                </h:column>
                
                
                
                <h:column>
                    <f:facet name="header">
                        <h:panelGrid columns="1">
                            <h:outputText value="Cut"/>
                            <h:outputText value="Qty (pcs)"/>
                        </h:panelGrid>
                    </f:facet>
                    <h:outputText value="#{finishRpt.cutQty}"/>
                </h:column>                    
                
                
                <h:column>
                    <f:facet name="header">
                        <h:panelGrid columns="1">
                            <h:outputText value="Sew"/>
                            <h:outputText value="Qty (pcs)"/>
                        </h:panelGrid>
                        
                    </f:facet>
                    <h:outputText value="#{finishRpt.sewQty}"/>
                </h:column>                    
                
                
                <h:column>
                    <f:facet name="header">
                        <h:panelGrid columns="1">
                            <h:outputText value="Wash"/>
                            <h:outputText value="Qty (pcs)"/>
                        </h:panelGrid>
                        
                    </f:facet>
                    <h:outputText value="#{finishRpt.washQty}"/>
                </h:column>                    
                
                
                <h:column>
                    <f:facet name="header">
                        <h:panelGrid columns="1">
                            <h:outputText value="Pack"/>
                            <h:outputText value="Qty (pcs)"/>
                        </h:panelGrid>
                        
                    </f:facet>
                    <h:outputText value="#{finishRpt.packQty}"/>
                </h:column>                    
                
                
                <h:column>
                    <f:facet name="header">
                        <h:panelGrid columns="1">
                            <h:outputText value="Export"/>
                            <h:outputText value="Qty (pcs)"/>
                        </h:panelGrid>
                        
                    </f:facet>
                    <h:outputText value="#{finishRpt.exportQty}"/>
                </h:column>                    
                
                <h:column>
                    <f:facet name="header">
                        <h:panelGrid columns="1">
                            <h:outputText value="Sample"/>
                            <h:outputText value="Qty (pcs)"/>
                        </h:panelGrid>
                        
                    </f:facet>
                    <h:outputText value="#{finishRpt.sampQty}"/>
                </h:column>                    
                
                <h:column>
                    <f:facet name="header">
                        <h:panelGrid columns="1">
                            <h:outputText value="LOGA"/>
                            <h:outputText value="Qty (pcs)"/>
                        </h:panelGrid>
                        
                    </f:facet>
                    <h:outputText value="#{finishRpt.logaQty}"/>
                </h:column>                    
                
                <h:column>
                    <f:facet name="header">
                        <h:panelGrid columns="1">
                            <h:outputText value="LOGB"/>
                            <h:outputText value="Qty (pcs)"/>
                        </h:panelGrid>
                        
                    </f:facet>
                    <h:outputText value="#{finishRpt.logbQty}"/>
                </h:column>                    
                
                
                <h:column>
                    <f:facet name="header">
                        <h:panelGrid columns="1">
                            <h:outputText value="Missing"/>
                            <h:outputText value="Qty (pcs)"/>
                        </h:panelGrid>
                        
                    </f:facet>
                    <h:outputText value="#{finishRpt.cutQty - finishRpt.sampQty - finishRpt.logaQty - finishRpt.logbQty}"/>
                </h:column>                    
                
                <h:column>
                    <f:facet name="header">
                        <h:panelGrid columns="1">
                            <h:outputText value="Total"/>
                            <h:outputText value="Qty (pcs)"/>
                        </h:panelGrid>
                        
                    </f:facet>
                    <h:outputText value="#{finishRpt.totQty}"/>
                </h:column>                    
                
                
            </t:dataTable>
        </h:form>
    </h:panelGrid>
    <%@ include file="foxyFooter.jsp" %>
</f:view>