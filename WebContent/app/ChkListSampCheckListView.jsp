<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%@taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<%@taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@taglib prefix="h" uri="http://java.sun.com/jsf/html"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<style type="text/css" >
    .col1 {
    text-align: left;
    white-space: nowrap;
    width: 1%;
    }
    
    .col2 {
    text-align: left;
    white-space: nowrap;
    width: 8%;
    }
    
    .col3 {
    text-align: left;
    white-space: nowrap;
    width: 5%;
    }
    
    .col3_2 {
    text-align: left;
    white-space: nowrap;
    width: 5%;
    }
    
    
    .col4 {
    text-align: left;
    white-space: nowrap;
    width: 20%;
    }
    
    .col5 {
    text-align: left;
    white-space: nowrap;
    width: 20%;
    }
    
    
    .col6 {
    text-align: left;
    white-space: nowrap;
    width: 10%;
    }
    
    
</style>   

<f:view>
    <%@ include file="foxyHeader.jsp" %>
    <h:panelGrid id="MainGrid" styleClass="tablebg" width="100%">
        <h:outputText value="View Sample Check List record" styleClass="smalltitle" />
        <h:outputText value=" Please key in partial or full refno to search record(s)" style="color: #FE0000; font-weight: bold;" />
        
        <h:form id="sampCheckListsrch">
            <t:outputLabel for="refNo" value="Ref No:"/>
            <t:inputText id="refNo" value="#{foxySessionData.orderId}" />
            <h:commandButton action="#{foxySampCheckListView.searchRec}" value="Search" />
            
            <t:outputText id="q11" value="Sorry no record(s) found"
                          style="color: #FF0F00; font-weight: bold;"
                          rendered="#{foxySampCheckListView.searchNotFound}" />
        </h:form>
        
        <h:form id="sampCheckList" rendered="#{foxySampCheckListView.objFound}">
            <t:dataTable  rowClasses="FoxyOddRow, FoxyEvenRow" columnClasses="col1,col2,col3,col3_2,col4,col5,col6" 
                          style="width :100%; text-align: left;" value="#{foxySampCheckListView.objModel}" var="sampCheckList" 
                          align="center" preserveDataModel="true" >
                <f:facet name="header">
                    <h:outputText value="Please click on the link to edit" style="color: #ff0000;" />
                </f:facet>
                <f:facet name="footer">
                    <h:outputText value="End of Record(s)"  />
                </f:facet>                    
                
                <h:column>
                    <f:facet name="header">
                        <h:outputText value="Country Code"/>
                    </f:facet>
                    <h:outputText value="#{sampCheckList.ccode}"/>
                </h:column>
                
                
                <h:column>
                    <f:facet name="header">
                        <h:outputText value="Ref No"/>
                    </f:facet>
                    <h:commandLink id="editCurRecLink" action="#{foxySampCheckListView.editCurRec}"
                                   value="#{sampCheckList.refNo}" immediate="true">
                        <t:updateActionListener property="#{foxySessionData.pageParameterLong}" value="#{sampCheckList.id}"/>
                    </h:commandLink>                            
                </h:column>                    
                
                
                <h:column>
                    <f:facet name="header">
                        <h:outputText value="Delivery"/>
                    </f:facet>
                    <h:outputText value="#{sampCheckList.del}">
                        <f:convertDateTime type="date" pattern="yyyyMMdd" timeZone="#{myTimeZone.myTimeZone}"/>
                    </h:outputText>
                </h:column>
                
                
                <h:column>
                    <f:facet name="header">
                        <h:outputText value="Ship SPL"/>
                    </f:facet>
                    <h:outputText value="#{sampCheckList.shipSpl}">
                        <f:convertDateTime type="date" pattern="yyyyMMdd" timeZone="#{myTimeZone.myTimeZone}"/>
                    </h:outputText>
                </h:column>
                
                
                
                <h:column>
                    <f:facet name="header">
                        <h:outputText value="Style"/>
                    </f:facet>
                    <h:outputText value="#{sampCheckList.style}"/>
                </h:column>
                
                
                
                <h:column>
                    <f:facet name="header">
                        <h:outputText value="Merchant:"/>
                    </f:facet>
                    <h:outputText value="#{sampCheckList.merchant}"/>
                </h:column>                    
                
                
                <h:column>
                    <f:facet name="header">
                        <h:outputText value="Delete"/>
                    </f:facet>
                    <h:commandButton id="delCurRec" action="#{foxySampCheckListView.delRec}"
                                     value="Delete" immediate="true"
                                     onclick="if(!confirm('Are you sure want to delete?')) return false">
                        <t:updateActionListener property="#{foxySessionData.pageParameterLong}" value="#{sampCheckList.id}"/>
                    </h:commandButton>                            
                </h:column>
                
                
                
            </t:dataTable>
        </h:form>
    </h:panelGrid>    
    <%@ include file="foxyFooter.jsp" %>
</f:view>