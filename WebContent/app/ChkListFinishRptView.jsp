<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%@taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<%@taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@taglib prefix="h" uri="http://java.sun.com/jsf/html"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<style type="text/css" >
    .col1 {
    font-size: 10px;
    text-align: left;
    white-space: nowrap;
    width: 1%;
    }
    
    .col2 {
    font-size: 10px;
    text-align: left;
    white-space: nowrap;
    width: 8%;
    }
    
    .col3 {
    font-size: 10px;
    text-align: left;
    white-space: nowrap;
    width: 10%;
    }
    
    .col31 {
    font-size: 10px;
    text-align: left;
    white-space: nowrap;
    width: 10%;
    }
    
    
    .col4 {
    font-size: 10px;
    text-align: left;
    white-space: nowrap;
    width: 7%;
    }
    
    .col5 {
    font-size: 10px;
    text-align: left;
    white-space: nowrap;
    width: 7%;
    }
    
    
    .col6 {
    font-size: 10px;
    text-align: left;
    white-space: nowrap;
    width: 7%;
    }
    
    .col7 {
    font-size: 10px;
    text-align: left;
    white-space: nowrap;
    width: 7%;
    }
    
    
    .col8 {
    font-size: 10px;
    text-align: left;
    white-space: nowrap;
    width: 7%;
    }
    
    
    .col9 {
    font-size: 10px;
    text-align: left;
    white-space: nowrap;
    width: 7%;
    }
    
    
    .col10 {
    font-size: 10px;
    text-align: left;
    white-space: nowrap;
    width: 7%;
    }
    
    
    .col11 {
    font-size: 10px;
    text-align: left;
    white-space: nowrap;
    width: 7%;
    }
    
    .col12 {
    font-size: 10px;
    text-align: left;
    white-space: nowrap;
    width: 7%;
    }
    
    .col13 {
    font-size: 10px;
    text-align: left;
    white-space: nowrap;
    width: 4%;
    }
    
    
</style>   

<f:view>
    <%@ include file="foxyHeader.jsp" %>
    
    <h:panelGrid id="MainGrid" styleClass="tablebg" width="100%">
        <h:outputText value="View Finish Report record" styleClass="smalltitle" />
        <h:outputText value=" Leave blank to list all record(s)" style="color: #FE0000; font-weight: bold;" />
        <h:messages id="msgs"/>
        
        <h:form id="finishRptsrch">
            <t:outputLabel for="refNo" value="Ref No:"/>
            <t:inputText id="refNo" value="#{foxySessionData.orderId}" />
            <h:commandButton action="#{foxyFinishRptView.searchRec}" value="Search" />
            
            <h:outputText id="q11" value="Sorry no record(s) found" 
                          style="color: #FF0F00; font-weight: bold;"
                          rendered="#{foxyFinishRptView.searchNotFound}"/>
        </h:form>
        
        <h:form id="finishRpt" rendered="#{foxyFinishRptView.objFound}">
            <t:dataTable  rowClasses="FoxyOddRow, FoxyEvenRow" 
                          columnClasses="col1,col2,col3,col31,col4,col5,col6,col7,col8,col9,col10,col11,col12,col13" 
                          style="width :100%; text-align: left;" value="#{foxyFinishRptView.objModel}" var="finishRpt" 
                          align="center" preserveDataModel="true">
                <f:facet name="header">
                    <h:outputText value="Please click on the link to edit" style="color: #ff0000;" />
                </f:facet>
                <f:facet name="footer">
                    <h:outputText value="End of Record(s)"  />
                </f:facet>                    
                
                <h:column>
                    <f:facet name="header">
                        <h:outputText value="CO" styleClass="col1"/>
                    </f:facet>
                    <h:outputText value="#{finishRpt.ccode}"/>
                </h:column>
                
                
                <h:column>
                    <f:facet name="header">
                        <h:outputText value="Ref" styleClass="col1"/>
                    </f:facet>
                    <h:commandLink id="editCurRecLink" action="#{foxyFinishRptView.editCurRec}"
                                   value="#{finishRpt.refNo}" immediate="true">
                        <t:updateActionListener property="#{foxySessionData.pageParameterLong}" value="#{finishRpt.id}"/>
                    </h:commandLink>                            
                </h:column>                                        
                
                <h:column>
                    <f:facet name="header">
                        <h:outputText value="Buyer" styleClass="col1"/>
                    </f:facet>
                    <h:outputText value="#{finishRpt.buyer}"/>
                </h:column>
                
                
                <h:column>
                    <f:facet name="header">
                        <h:outputText value="Merchant" styleClass="col1"/>
                    </f:facet>
                    <h:outputText value="#{finishRpt.merchant}"/>
                </h:column>
                
                
                
                <h:column>
                    <f:facet name="header">
                        <h:panelGrid columns="1">
                            <h:outputText value="Cut" styleClass="col1"/>
                            <h:outputText value="Qty (pcs)" styleClass="col1"/>
                        </h:panelGrid>
                    </f:facet>
                    <h:outputText value="#{finishRpt.cutQty}"/>
                </h:column>                    
                
                
                <h:column>
                    <f:facet name="header">
                        <h:panelGrid columns="1">
                            <h:outputText value="Sew" styleClass="col1"/>
                            <h:outputText value="Qty (pcs)" styleClass="col1"/>
                        </h:panelGrid>
                        
                    </f:facet>
                    <h:outputText value="#{finishRpt.sewQty}"/>
                </h:column>                    
                
                
                <h:column>
                    <f:facet name="header">
                        <h:panelGrid columns="1">
                            <h:outputText value="Wash" styleClass="col1"/>
                            <h:outputText value="Qty (pcs)" styleClass="col1"/>
                        </h:panelGrid>
                        
                    </f:facet>
                    <h:outputText value="#{finishRpt.washQty}"/>
                </h:column>                    
                
                
                <h:column>
                    <f:facet name="header">
                        <h:panelGrid columns="1">
                            <h:outputText value="Pack" styleClass="col1"/>
                            <h:outputText value="Qty (pcs)" styleClass="col1"/>
                        </h:panelGrid>
                        
                    </f:facet>
                    <h:outputText value="#{finishRpt.packQty}"/>
                </h:column>                    
                
                
                <h:column>
                    <f:facet name="header">
                        <h:panelGrid columns="1">
                            <h:outputText value="Export" styleClass="col1"/>
                            <h:outputText value="Qty (pcs)" styleClass="col1"/>
                        </h:panelGrid>
                        
                    </f:facet>
                    <h:outputText value="#{finishRpt.exportQty}"/>
                </h:column>                    
                
                <h:column>
                    <f:facet name="header">
                        <h:panelGrid columns="1">
                            <h:outputText value="Sample" styleClass="col1"/>
                            <h:outputText value="Qty (pcs)" styleClass="col1"/>
                        </h:panelGrid>
                        
                    </f:facet>
                    <h:outputText value="#{finishRpt.sampQty}"/>
                </h:column>                    
                
                <h:column>
                    <f:facet name="header">
                        <h:panelGrid columns="1">
                            <h:outputText value="LOGA" styleClass="col1"/>
                            <h:outputText value="Qty (pcs)" styleClass="col1"/>
                        </h:panelGrid>
                        
                    </f:facet>
                    <h:outputText value="#{finishRpt.logaQty}"/>
                </h:column>                    
                
                <h:column>
                    <f:facet name="header">
                        <h:panelGrid columns="1">
                            <h:outputText value="LOGB" styleClass="col1"/>
                            <h:outputText value="Qty (pcs)" styleClass="col1"/>
                        </h:panelGrid>
                        
                    </f:facet>
                    <h:outputText value="#{finishRpt.logbQty}"/>
                </h:column>                    
                
                
                <h:column>
                    <f:facet name="header">
                        <h:panelGrid columns="1">
                            <h:outputText value="Total" styleClass="col1"/>
                            <h:outputText value="Qty (pcs)" styleClass="col1"/>
                        </h:panelGrid>
                        
                    </f:facet>
                    <h:outputText value="#{finishRpt.totQty}"/>
                </h:column>                    
                
                
                <h:column>
                    <f:facet name="header">
                        <h:outputText value="Delete" styleClass="col1"/>
                    </f:facet>
                    <h:commandButton id="delCurRec" action="#{foxyFinishRptView.delRec}"
                                     value="Delete" immediate="true"
                                     onclick="if(!confirm('Are you sure want to delete?')) return false">
                        <t:updateActionListener property="#{foxySessionData.pageParameterLong}" value="#{finishRpt.id}"/>
                    </h:commandButton>                            
                </h:column>
            </t:dataTable>
        </h:form>
    </h:panelGrid>
    <%@ include file="foxyFooter.jsp" %>
</f:view>