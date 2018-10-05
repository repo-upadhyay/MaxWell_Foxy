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
    <t:saveState value="#{foxyInvMovement.orderId}"/>
    <t:saveState value="#{foxyInvMovement.sumRefId}"/>
    
    
    <h:messages errorClass="FOX_ERROR" showDetail="true" showSummary="true"/>
    
    <%-- Panel for Assign --%>
    <h:panelGrid id="AssignGrid" styleClass="tablebg" width="100%">
        <h:panelGrid id="AssignInput1" columns="2" columnClasses="FOX_LABEL_COL_2, FOX_INPUT_COL_2" width="100%">
            <h:panelGroup>
                <h:outputText value="F&A Invoice Detail" styleClass="smalltitle" />
            </h:panelGroup>
        </h:panelGrid>
        <h:form id="AssignForm" rendered="true">
            <%-- First, Slipt the screen into two equal size column --%>
            <h:panelGrid columns="2" columnClasses="FOXY_SCREEN_2COL,FOXY_SCREEN_2COL" width="100%" cellpadding="0" cellspacing="0" border="0" frame="none" rules="none">
                
                <%-- START column 1 --%>
                <h:panelGrid id="AssignInputcol1" columns="2" columnClasses="FOX_LABEL_COL_2, FOX_INPUT_COL_2" width="100%">
                    <%-- START column 1 --%>                
                    <h:outputText value="Invoice Number:" />
                    <h:panelGroup>
                        <h:inputText id="InvoiceNumber" styleClass="FOX_INPUT_RO_KEY" readonly="true" size="30" value="#{foxyInvMovement.inventoryBean.invoice}"/>
                    </h:panelGroup>
                    
                    <t:outputLabel for="Supplier" value="Supplier:" />
                    <h:inputText id="Supplier" styleClass="FOX_INPUT_RO_KEY" readonly="true" size="30" value="#{foxyInvMovement.inventoryBean.supplier}"/>
                    
                    <h:outputText value="Invoice Date:" />
                    <h:inputText id="InvoiceDate" styleClass="FOX_INPUT_RO" readonly="true" size="30" value="#{foxyInvMovement.inventoryBean.invoiceDate}">
                        <f:convertDateTime type="date" pattern="yyyyMMdd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                    </h:inputText>
                    
                    <t:outputLabel for="InventoryType" value="Inventory Type:" />
                    <h:inputText id="InventoryType" styleClass="FOX_INPUT_RO" readonly="true" size="30" value="#{foxyInvMovement.inventoryBean.invType}"/>
                    
                    <t:outputLabel for="ItemDesc" value="Item Desc:" />
                    <h:inputText id="ItemDesc" styleClass="FOX_INPUT_RO" value="#{foxyInvMovement.inventoryBean.itemDesc}" maxlength="128" size="50" required="false"/>                    
                    
                    <h:outputText value="Quantity:" />
                    <h:panelGroup>
                        <h:inputText id="Quantity" styleClass="FOX_INPUT_NUM_RO" readonly="true" size="15" value="#{foxyInvMovement.inventoryBean.quantity}"/>
                    </h:panelGroup>
                    
                    <h:outputText value="Unit:" />
                    <h:panelGroup>
                        <h:inputText id="Unit" styleClass="FOX_INPUT_NUM_RO" readonly="true" size="15" value="#{foxyInvMovement.inventoryBean.unit}"/>
                    </h:panelGroup>
                    
                    <h:outputText value="Value:" />
                    <h:panelGroup>
                        <h:outputText id="Value" styleClass="FOX_INPUT_NUM_RO" value="#{foxyInvMovement.inventoryBean.value}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>                            
                    </h:panelGroup>
                    
                    <h:outputText value="Currency:" />
                    <h:panelGroup>
                        <h:inputText id="Currency" styleClass="FOX_INPUT_NUM_RO" readonly="true" size="15" value="#{foxyInvMovement.inventoryBean.currency}"/>
                    </h:panelGroup>                                                            
                    
                    <h:outputText value="Value in SGD:" />
                    <h:panelGroup>
                        <h:outputText id="BaseValue" styleClass="FOX_INPUT_NUM_RO" value="#{foxyInvMovement.inventoryBean.baseValue}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>
                    </h:panelGroup>
                    
                    <t:outputLabel for="Remarks" value="Remarks:" />
                    <h:inputText id="Remarks" styleClass="FOX_INPUT_RO" value="#{foxyInvMovement.inventoryBean.remarks}" maxlength="128" size="50" required="false"/>                    
                    
                    <h:outputText value="Currency Rate:" />
                    <h:outputText id="forexRateStr" styleClass="FOX_ERROR" value="#{foxyInvMovement.forexRateStr}" />                    
                    
                    <h:commandButton id="gotolist" value="Back To List" action="#{foxyInvMovement.gotolist}" immediate="true"/>
                    
                </h:panelGrid>
                <%-- END column 1 --%>
                
                <%-- START column 2 --%>
                <h:panelGrid id="AssignInputcol2" columns="2" columnClasses="FOX_LABEL_COL_2, FOX_INPUT_COL_2" width="100%">
                    
                    <t:outputLabel for="refNumber" value="Ref. Number:" />
                    <a4j:region id="ajaxregion1" renderRegionOnly="false" selfRendered="true">
                        <h:inputText id="refNumber" styleClass="FOX_INPUT" readonly="false" size="30" value="#{foxyInvMovement.orderId}">
                            <a4j:support event="onblur" reRender="lotId" ajaxSingle="true"/>
                        </h:inputText>
                    </a4j:region>
                    
                    <t:outputLabel for="lotId" value="Lot Id:" />
                    <h:panelGroup>
                        <h:selectOneMenu id="lotId" styleClass="FOX_INPUT" value="#{foxyInvMovement.sumRefId}"
                                         style="width:220px; height:25px "  required="true" immediate="true"> 
                            <f:selectItems value="#{foxyInvMovement.osList}"/>
                        </h:selectOneMenu>
                        <a4j:status for="ajaxregion1">
                            <f:facet name="start">
                                <h:graphicImage value="/images/ajaxstart.gif"  height="12" width="12"/>
                            </f:facet>
                            <f:facet name="stop">
                                <%-- h:graphicImage value="/images/ajax_stoped.gif" / --%>
                            </f:facet>
                        </a4j:status>                                                                        
                    </h:panelGroup>
                    
                    
                    <t:outputLabel for="AssignQuantity" value="Quantity:" />
                    <h:inputText id="AssignQuantity" styleClass="FOX_INPUT" readonly="false" required="true" size="14" value="#{foxyInvMovement.invMovementBean.quantity}"/>                    
                    
                    <t:outputLabel for="unitCost" value="Unit Cost" />
                    <h:inputText id="unitCost" styleClass="FOX_INPUT" readonly="false" required="true" size="14" value="#{foxyInvMovement.invMovementBean.unitCost}"/>                                        
                    
                    <t:outputLabel for="FOCVAL" value="FOC Value" />
                    <h:inputText id="FOCVAL" styleClass="FOX_INPUT" readonly="false" required="false" size="14" value="#{foxyInvMovement.invMovementBean.focVal}"/>                       
                    
                    <t:outputLabel for="DetailItemDesc" value="Desc:" />
                    <h:inputText id="DetailItemDesc" styleClass="FOX_INPUT" readonly="false"  required="false" size="30" value="#{foxyInvMovement.invMovementBean.itemDesc}"/>                    
                    
                    <t:outputLabel for="AssignUsedQuantity" value="Used Qty:" />
                    <h:inputText id="AssignUsedQuantity" styleClass="FOX_INPUT" readonly="false" required="false" size="14" value="#{foxyInvMovement.invMovementBean.usedQty}"/>
                    
                </h:panelGrid>
                <%-- END column 2 --%>
            </h:panelGrid>
            
            <h:panelGrid id="AddButton" columns="1" columnClasses="FOX_BUTTON" width="100%" >
                <h:panelGroup>
                    <h:commandButton id="SaveAssignment" value="Save" action="#{foxyInvMovement.saveUpd}"/>
                    <h:commandButton id="AddAssignmentbtm" value="Add" action="#{foxyInvMovement.saveAdd}" />
                </h:panelGroup>
            </h:panelGrid>
        </h:form>
        
        
        <h:form id="InventoryDetailForm">
            <h:panelGrid id="ListDisplay" columns="1" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="100%">
                <t:dataTable id="DetailData"
                             binding="#{foxyInvMovement.foxyTable}"
                             headerClass="FOXY_ORDER_DETAIL_HEADER"
                             footerClass="FOXY_ORDER_DETAIL_HEADER"
                             rowClasses="standardTable_Row1,standardTable_Row2"
                             columnClasses="standardTable_Column,standardTable_ColumnCentered,standardTable_Column"
                             var="invDetail"
                             value="#{foxyInvMovement.inventoryDetail}"
                             preserveDataModel="true"
                             rows="2000" width="100%">
                    
                    <t:column width="10%">
                        <f:facet name="header">
                            <h:outputText value="Ref. Number" />
                        </f:facet>
                        
                        <h:commandLink id="linksassign" 
                                       value="#{invDetail.refNo}#{invDetail.lotid}"   
                                       action="#{foxyInvMovement.updateAssignment}" immediate="true">
                            <t:updateActionListener property="#{foxySessionData.pageParameterLong2}" value="#{invDetail.invmrefid}"/>                                           
                        </h:commandLink>
                    </t:column>
                    
                    
                    <t:column width="10%">
                        <f:facet name="header">
                            <h:outputText value="Delete" />
                        </f:facet>
                        
                        <h:commandLink id="deletelinks" 
                                       value="Delete"
                                       rendered="#{invDetail.unitcost != null}"
                                       action="#{foxyInvMovement.delete}" immediate="true"
                                       onclick="if(!confirm('Are you sure want to delete?')) return false">
                            <t:updateActionListener property="#{foxySessionData.pageParameterLong2}" value="#{invDetail.invmrefid}"/>                                           
                        </h:commandLink>
                    </t:column>
                    
                    
                    <t:column width="10%">
                        <f:facet name="header">
                            <h:outputText value="Delivery" />
                        </f:facet>
                        <h:outputText value="#{invDetail.ttDate}">
                            <f:convertDateTime type="date" pattern="yyyyMMdd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                        </h:outputText>
                    </t:column>

                    <t:column width="10%">
                        <f:facet name="header">
                            <h:outputText value="Origin" />
                        </f:facet>
                        <h:outputText value="#{invDetail.origin}">
                        </h:outputText>
                    </t:column>                    
                    
                    <t:column width="10%">
                        <f:facet name="header">
                            <h:outputText value="Unit Cost" />
                        </f:facet>
                        <h:outputText value="#{invDetail.unitcost}">
                        </h:outputText>
                    </t:column>
                    
                    
                    <t:column width="10%"  styleClass="FOXY_ORDER_DETAIL_COL_R" rendered="#{foxyInvMovement.dozenApplicable}">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="Quantity (DZN)" />
                            </h:panelGrid>                            
                        </f:facet>
                        <h:outputText value="#{invDetail.qty/12}" rendered="#{invDetail.lotid != null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>
                        
                        <h:outputText value="#{invDetail.qty/12}" rendered="#{invDetail.lotid == null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>                        
                    </t:column>   
                    
                    
                    
                    <t:column width="10%"  styleClass="FOXY_ORDER_DETAIL_COL_R" rendered="#{foxyInvMovement.dozenApplicable}">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="Quantity (PCS)" />
                            </h:panelGrid>                            
                        </f:facet>
                        <h:outputText value="#{invDetail.qty}" rendered="#{invDetail.lotid != null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>
                        
                        <h:outputText value="#{invDetail.qty}" rendered="#{invDetail.lotid == null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>                        
                    </t:column>   
                    
                    
                    <t:column width="10%"  styleClass="FOXY_ORDER_DETAIL_COL_R" rendered="#{not foxyInvMovement.dozenApplicable}">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="Quantity (LBS)" />
                            </h:panelGrid>                            
                        </f:facet>
                        <h:outputText value="#{invDetail.qty}" rendered="#{invDetail.lotid != null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>
                        
                        <h:outputText value="#{invDetail.qty}" rendered="#{invDetail.lotid == null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>                        
                    </t:column>   
                    
                    
                    <t:column width="10%"  styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="Value (#{foxyInvMovement.inventoryBean.currency})" />
                            </h:panelGrid>                            
                        </f:facet>
                        <h:outputText value="#{invDetail.inputValue}" rendered="#{invDetail.lotid != null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>
                        <h:outputText value="#{invDetail.inputValue}" rendered="#{invDetail.lotid == null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>
                    </t:column>                                           
                    
                    <t:column width="10%"  styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="Value (SGD)" />
                            </h:panelGrid>                            
                        </f:facet>
                        <h:outputText value="#{invDetail.sgdValue}" rendered="#{invDetail.lotid != null}">
                            <f:convertNumber minFractionDigits="4" maxFractionDigits="4"/>
                        </h:outputText>
                        <h:outputText value="#{invDetail.sgdValue}" rendered="#{invDetail.lotid == null}" styleClass="FOXY_REPORT_GRAND_TOTAL">
                            <f:convertNumber minFractionDigits="4" maxFractionDigits="4"/>
                        </h:outputText>
                    </t:column>                                           
                    
                </t:dataTable>
                
                <%--
                <h:panelGrid columns="1" styleClass="scrollerTable2" columnClasses="standardTable_ColumnCentered" >
                    <t:dataScroller id="scroll_1"
                                    for="DetailData"
                                    fastStep="10"
                                    pageCountVar="pageCount"
                                    pageIndexVar="pageIndex"
                                    styleClass="scroller"
                                    paginator="true"
                                    paginatorMaxPages="9"
                                    paginatorTableClass="paginator"
                                    paginatorActiveColumnStyle="font-weight:bold;"
                                    immediate="true"
                    >
                        <f:facet name="first" >
                            <t:graphicImage url="../images/arrow-first.gif" border="1" />
                        </f:facet>
                        <f:facet name="last">
                            <t:graphicImage url="../images/arrow-last.gif" border="1" />
                        </f:facet>
                        <f:facet name="previous">
                            <t:graphicImage url="../images/arrow-previous.gif" border="1" />
                        </f:facet>
                        <f:facet name="next">
                            <t:graphicImage url="../images/arrow-next.gif" border="1" />
                        </f:facet>
                        <f:facet name="fastforward">
                            <t:graphicImage url="../images/arrow-ff.gif" border="1" />
                        </f:facet>
                        <f:facet name="fastrewind">
                            <t:graphicImage url="../images/arrow-fr.gif" border="1" />
                        </f:facet>
                    </t:dataScroller>
                    <t:dataScroller id="scroll_2"
                                    for="DetailData"
                                    rowsCountVar="rowsCount"
                                    displayedRowsCountVar="displayedRowsCountVar"
                                    firstRowIndexVar="firstRowIndex"
                                    lastRowIndexVar="lastRowIndex"
                                    pageCountVar="pageCount"
                                    immediate="true"
                                    pageIndexVar="pageIndex"
                    >
                        <h:outputFormat value="Testing Total Rec {0}, DispayRowCount {1}, First row index {2}, last row index {3} pageindex {4}, pagecount {5}" styleClass="standard" >
                            <f:param value="#{rowsCount}" />
                            <f:param value="#{displayedRowsCountVar}" />
                            <f:param value="#{firstRowIndex}" />
                            <f:param value="#{lastRowIndex}" />
                            <f:param value="#{pageIndex}" />
                            <f:param value="#{pageCount}" />
                        </h:outputFormat>
                    </t:dataScroller>
                </h:panelGrid>                
                --%>
                
            </h:panelGrid>
        </h:form>
    </h:panelGrid>            
    <%-- End of Assign--%>    

    <%@ include file="foxyFooter.jsp" %>
</f:view>
