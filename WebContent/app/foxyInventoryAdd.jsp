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
    
    <%-- This save state required to ensure variable value available for rebuild list during  
    Without save state, list will be empty and will get "Value is not a valid option" error message when submit form--%> 
    <t:saveState value="#{foxyInventory.inventoryBean.invType}"/>
    <t:saveState value="#{foxyInventory.inventoryBean.currency}"/> 
    <t:saveState value="#{foxyInventory.inventoryBean.invoiceDate}"/> 
    <t:saveState value="#{foxyInventory.inventoryBean.value}"/> 
    
    <h:messages errorClass="FOX_ERROR" showDetail="true" showSummary="true"/>
    
    
    <%-- Panel for Add --%>
    <h:panelGrid id="UpdAddGrid" styleClass="tablebg" width="100%">
        <h:outputText value="New F&A Invoice" styleClass="smalltitle"/>
        <%-- Update & Add Form --%>
        <h:form id="UpdAddForm" rendered="true">
            
            <h:panelGrid columns="1" style="vertical-align: top;" width="100%" cellpadding="0" cellspacing="0" border="0" frame="none" rules="none">
                <%-- START of column 1 --%>
                <h:panelGrid columns="2" columnClasses="FOXY_SCREEN_2COL,FOXY_SCREEN_2COL" width="100%" cellpadding="0" cellspacing="0" border="0" frame="none" rules="none">
                    <h:panelGrid id="UpdAddInput1_1" columns="2" columnClasses="FOX_LABEL_COL_2, FOX_INPUT_COL_2" width="100%">
                        <t:outputLabel for="InvoiceNumber" value="Invoice Number:" />                
                        <h:panelGroup>
                            <h:inputText id="InvoiceNumber" styleClass="FOX_INPUT" value="#{foxyInventory.inventoryBean.invoice}" maxlength="20" 
                                         size="20" required="true">
                            </h:inputText>
                            <h:message errorClass="FOX_ERROR" for="InvoiceNumber" showDetail="true" showSummary="true"/>
                        </h:panelGroup>
                        
                        <t:outputLabel for="type" value="Inventory Type:" />
                        <h:panelGroup>
                            <a4j:region id="ajaxregion1" renderRegionOnly="false" selfRendered="true">
                                <h:selectOneMenu id="type" styleClass="FOX_INPUT" required="true" value="#{foxyInventory.inventoryBean.invType}">
                                    <f:selectItems value="#{listData.supItemList}"/>
                                    <a4j:support id="ajitemtypecode" event="onchange" action="#{foxyInventory.onItemTypeChange}" 
                                                 reRender="supplier,supplierD" ajaxSingle="true">
                                    </a4j:support>                                     
                                </h:selectOneMenu>                                
                            </a4j:region>
                            <h:message errorClass="FOX_ERROR" for="type" showDetail="true" showSummary="true"/>
                        </h:panelGroup>  
                        
                        <t:outputLabel for="supplier" value="Supplier:" />
                        <h:panelGroup>
                            <h:selectOneMenu id="supplier" styleClass="FOX_INPUT" required="true" value="#{foxyInventory.inventoryBean.supplier}">
                                <f:selectItems value="#{foxyInventory.supplierList}"/>
                            </h:selectOneMenu>
                            <a4j:status for="ajaxregion1">
                                <f:facet name="start">
                                    <h:graphicImage value="/images/ajaxstart.gif" height="12" width="12"/>
                                </f:facet>
                                <f:facet name="stop">
                                    <%-- h:graphicImage value="/images/ajax_stoped.gif" / --%>
                                </f:facet>
                            </a4j:status>                            
                            <h:message errorClass="FOX_ERROR" for="supplier" showDetail="true" showSummary="true"/>                            
                        </h:panelGroup>                                                                    
                        
                        <t:outputLabel for="ItemDesc" value="Item Desc:" />
                        <h:panelGroup>
                            <h:inputText id="ItemDesc" styleClass="FOX_INPUT" value="#{foxyInventory.inventoryBean.itemDesc}" maxlength="128" 
                                         size="50" required="false">
                            </h:inputText>
                            <h:message errorClass="FOX_ERROR" for="ItemDesc" showDetail="true" showSummary="true"/>
                        </h:panelGroup>                                                
                        
                        <t:outputLabel for="Date" value="Invoice Date:" />
                        <h:panelGroup>
                            <a4j:region id="a4j_invDate" renderRegionOnly="false" selfRendered="true">
                                <t:inputCalendar id="Date" styleClass="FOX_INPUT" value="#{foxyInventory.inventoryBean.invoiceDate}"  popupDateFormat="yyyyMMdd" renderAsPopup="true">
                                    <a4j:support id="ajinvdate" event="onchange" action="#{foxyInventory.onCurCodeChange}" 
                                                 reRender="basevalue,forexRateStr" ajaxSingle="true">
                                    </a4j:support>                                                                                                         
                                </t:inputCalendar>  
                                <h:message errorClass="FOX_ERROR" for="Date" showDetail="true" showSummary="true"/>
                            </a4j:region>
                        </h:panelGroup>
                        
                        
                        <t:outputLabel for="Quantity" value="Quantity:" />
                        <h:panelGroup>
                            <h:inputText id="Quantity" styleClass="FOX_INPUT" maxlength="12" size="15" required="true" value="#{foxyInventory.inventoryBean.quantity}"/>
                            <h:message errorClass="FOX_ERROR" for="Quantity" showDetail="true" showSummary="true"/>
                        </h:panelGroup>                                          
                        
                        <t:outputLabel for="Unit" value="Unit:" />                    
                        <h:panelGroup>
                            <h:selectOneMenu id="Unit" styleClass="FOX_INPUT" required="true" value="#{foxyInventory.inventoryBean.unit}">
                                <f:selectItems value="#{listData.invUnitList}"/>
                            </h:selectOneMenu>
                            <h:message errorClass="FOX_ERROR" for="Unit" showDetail="true" showSummary="true"/>
                        </h:panelGroup>                          
                        
                        <t:outputLabel for="Value" value="Value:" />
                        <h:panelGroup>
                            <a4j:region id="a4j_invValue" renderRegionOnly="false" selfRendered="true">
                                <h:inputText id="Value" styleClass="FOX_INPUT" maxlength="12" size="15" required="true" value="#{foxyInventory.inventoryBean.value}">
                                    <a4j:support id="ajinvValue" event="onchange" action="#{foxyInventory.onCurCodeChange}" 
                                                 reRender="basevalue,forexRateStr" ajaxSingle="true">
                                    </a4j:support>                                                                                                                                         
                                </h:inputText>
                                <h:message errorClass="FOX_ERROR" for="Value" showDetail="true" showSummary="true"/>
                            </a4j:region>
                        </h:panelGroup>                                                
                        
                        <t:outputLabel for="Currency" value="Currency:" />
                        <h:panelGroup>
                            <a4j:region id="ajaxregion2" renderRegionOnly="false" selfRendered="true">                            
                                <h:selectOneMenu id="Currency" styleClass="FOX_INPUT" required="true" value="#{foxyInventory.inventoryBean.currency}">
                                    <f:selectItems value="#{listData.forexCurrencyList}"/>
                                    <a4j:support id="ajcurcode" event="onchange" action="#{foxyInventory.onCurCodeChange}" 
                                                 reRender="basevalue,forexRateStr" ajaxSingle="true">
                                    </a4j:support>                                                                     
                                </h:selectOneMenu>
                            </a4j:region>
                            <h:message errorClass="FOX_ERROR" for="Currency" showDetail="true" showSummary="true"/>
                        </h:panelGroup>   
                        
                        <%-- --%>
                        <t:outputLabel for="basevalue" value="Value in SGD:" />
                        <h:panelGroup>
                            <h:inputText id="basevalue" style="background-color: #ffff00;"  styleClass="FOX_INPUT" maxlength="12" size="15" required="true" value="#{foxyInventory.inventoryBean.baseValue}">
                            </h:inputText>
                            <t:outputText value="This field if auto-caculate, Empty means no Forex rate info"  styleClass="FOX_ERROR"/>
                            <a4j:status for="ajaxregion2">
                                <f:facet name="start">
                                    <h:graphicImage value="/images/ajaxstart.gif" height="12" width="12"/>
                                </f:facet>
                                <f:facet name="stop">
                                </f:facet>
                            </a4j:status>                             
                            <h:message errorClass="FOX_ERROR" for="basevalue" showDetail="true" showSummary="true"/>
                        </h:panelGroup>                                                
                        <%-- --%>
                        
                        <t:outputLabel for="Remarks" value="Remarks:" />
                        <h:panelGroup>
                            <h:inputText id="Remarks" styleClass="FOX_INPUT" value="#{foxyInventory.inventoryBean.remarks}" maxlength="128" 
                                         size="50" required="false">
                            </h:inputText>
                            <h:message errorClass="FOX_ERROR" for="Remarks" showDetail="true" showSummary="true"/>
                        </h:panelGroup>                                                
                        
                        <h:outputText value="Currency Rate:" />
                        <h:outputText id="forexRateStr" styleClass="FOX_ERROR" value="#{foxyInventory.forexRateStr}" />
                        
                    </h:panelGrid>
                </h:panelGrid>
                
                <h:panelGrid id="AddButton" columns="1" columnClasses="FOX_BUTTON" width="50%">
                    <h:panelGroup>
                        <h:commandButton id="Save" value="Save" action="#{foxyInventory.saveAdd}"/>
                    </h:panelGroup>
                </h:panelGrid>
            </h:panelGrid>
        </h:form>
    </h:panelGrid>            
    <%-- End of Add --%>                
                
    <%@ include file="foxyFooter.jsp" %>
</f:view>
