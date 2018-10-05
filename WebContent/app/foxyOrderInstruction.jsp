<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<%@taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@taglib uri="https://ajax4jsf.dev.java.net/ajax" prefix="a4j"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<f:view>
    <%@ include file="foxyHeader.jsp" %>
    
    <h:messages errorClass="FOX_ERROR" showDetail="true" showSummary="true" />
    
    <%-- Panel for Update & Add --%>
    <h:panelGrid id="UpdAddGrid" styleClass="tablebg" rendered="#{foxyOrderInstruction.updAdd}" width="100%">
        <%-- Title for Update --%>
        <h:outputText value="Add Lot" styleClass="smalltitle" rendered="#{foxyOrderInstruction.add}"/>
        <%-- Title for Add --%>
        <h:outputText value="Update Lot" styleClass="smalltitle" rendered="#{foxyOrderInstruction.update}"/>
        <%-- Update & Add Form --%>
        <h:form id="UpdAddForm" rendered="true">
            
            <%-- This save state required to ensure variable value available for rebuild list during  
            Without save state, list will be empty and will get "Value is not a valid option" error message when submit form--%> 
            <t:saveState value="#{foxyOrderInstruction.factory}"/>
            <t:saveState value="#{foxyOrderInstruction.catId}"/>
            
            
            <h:inputHidden id="refId" value="#{foxyOrderInstruction.refId}" rendered="#{foxyOrderInstruction.update}"/>
            <h:inputHidden id="month" value="#{foxyOrderInstruction.month}" rendered="#{foxyOrderInstruction.update}"/>
            <h:inputHidden id="location" value="#{foxyOrderInstruction.location}" rendered="#{foxyOrderInstruction.update}"/>
            
            
            <h:panelGrid columns="2" columnClasses="FOXY_SCREEN_2COL,FOXY_SCREEN_2COL" width="100%" cellpadding="0" cellspacing="0" border="0" frame="none" rules="none">
                <%-- START column 1 --%>
                <h:panelGrid id="UpdInputcol1" columns="2" columnClasses="FOX_LABEL_COL_2, FOX_INPUT_COL_2" width="100%">
                    <t:outputLabel for="OrderIdD" value="Ref. Number:" />
                    <h:panelGroup>
                        <h:inputText id="OrderIdD" styleClass="FOX_INPUT_RO_KEY" readonly="true" size="10" value="#{foxyOrderInstruction.orderId}"/>
                    </h:panelGroup>
                    
                    <t:outputLabel for="factory"  value="Main Factory:"/>
                    <h:panelGroup>
                        <a4j:region id="ajaxregion2" renderRegionOnly="false" selfRendered="true">
                            <h:selectOneMenu id="factory" styleClass="FOX_INPUT" required="true" 
                                             value="#{foxyOrderInstruction.factory}"
                                             style="width:200px; height:20px">
                                <f:selectItems value="#{listData.factoryList}"/>
                                <a4j:support event="onchange" reRender="Quota" ajaxSingle="true"/>
                            </h:selectOneMenu>
                        </a4j:region>
                        <h:message errorClass="FOX_ERROR" for="factory" showDetail="true" showSummary="true"/>
                    </h:panelGroup>                                
                    
                    
                    <t:outputLabel for="Category" value="Category:" />
                    <h:panelGroup>
                        <a4j:region id="ajaxregion1" renderRegionOnly="false" selfRendered="true">
                            <h:selectOneMenu id="Category" styleClass="FOX_INPUT" required="true" value="#{foxyOrderInstruction.catId}">
                                <f:selectItems value="#{listData.categoryList}"/>
                                <a4j:support event="onchange" reRender="Quota" ajaxSingle="true"/>
                            </h:selectOneMenu>
                        </a4j:region>
                        <h:message errorClass="FOX_ERROR" for="Category" showDetail="true" showSummary="true"/>
                    </h:panelGroup>
                    
                    <t:outputLabel for="Quota"  value="Quota Applicable:"/>
                    <h:panelGroup>
                        <h:selectOneMenu id="Quota" styleClass="FOX_INPUT" required="true" value="#{foxyOrderInstruction.quota}">
                            <f:selectItems value="#{foxyOrderInstruction.applicableQuotaList}"/>
                        </h:selectOneMenu>          
                        <a4j:status for="ajaxregion1">
                            <f:facet name="start">
                                <h:graphicImage value="/images/ajaxstart.gif" height="12" width="12"/>
                            </f:facet>
                            <f:facet name="stop">
                                
                            </f:facet>
                        </a4j:status>
                        <a4j:status for="ajaxregion2">
                            <f:facet name="start">
                                <h:graphicImage value="/images/ajaxstart.gif" height="12" width="12"/>
                            </f:facet>
                            <f:facet name="stop">
                                
                            </f:facet>
                        </a4j:status>                    
                        <h:message errorClass="FOX_ERROR" for="Quota" showDetail="true" showSummary="true"/>
                    </h:panelGroup>                
                    
                    <t:outputLabel for="Quantity"  value="Quantity:" />
                    <h:panelGroup>
                        <h:inputText id="Quantity" styleClass="FOX_INPUT" size="30" required="true" value="#{foxyOrderInstruction.quantity}"/>
                        <h:outputText value=" " />
                        <h:selectOneMenu id="Unit" styleClass="FOX_INPUT" required="true" value="#{foxyOrderInstruction.unitc}">
                            <f:selectItems value="#{listData.unitList}"/>
                        </h:selectOneMenu>
                        <h:message errorClass="FOX_ERROR" for="Quantity" showDetail="true" showSummary="true"/>
                        <h:message errorClass="FOX_ERROR" for="Unit" showDetail="true" showSummary="true"/>                                        
                    </h:panelGroup>
                    
                    
                    <t:outputLabel for="Remark"  value="Remark:" />
                    <h:panelGroup>
                        <h:inputTextarea rows="3" cols="30" id="Remark" styleClass="FOX_INPUT" required="false" value="#{foxyOrderInstruction.remark}">
                        </h:inputTextarea>
                        <h:message errorClass="FOX_ERROR" for="Remark" showDetail="true" showSummary="true"/>
                    </h:panelGroup>
                    
                </h:panelGrid>
                <%-- END column 1 --%>
                
                <%-- START column 2 --%>
                <h:panelGrid id="UpdInputcol2" columns="2" columnClasses="FOX_LABEL_COL_2, FOX_INPUT_COL_2" width="100%">
                    <t:outputLabel for="Lot"  value="Lot Id:" rendered="#{foxyOrderInstruction.add}"/>
                    <h:panelGroup rendered="#{foxyOrderInstruction.add}">
                        <h:selectOneMenu id="Lot" styleClass="FOX_INPUT" required="true" value="#{foxyOrderInstruction.month}">
                            <f:selectItems value="#{listData.lotList}"/>
                        </h:selectOneMenu>
                        <h:outputText value=" " />
                        <t:inputText id="Location" styleClass="FOX_INPUT" maxlength="7" size="8" required="false" value="#{foxyOrderInstruction.location}">
                            <t:validateRegExpr pattern="^[^']+$"  message="Sorry, this field can not have single quote character"/>
                        </t:inputText>                       
                        <h:message errorClass="FOX_ERROR" for="Lot" showDetail="true" showSummary="true"/>
                        <h:message errorClass="FOX_ERROR" for="Location" showDetail="false" showSummary="true"/>
                    </h:panelGroup>
                    
                    <t:outputLabel for="LotNumber"  value="Lot Number:" rendered="#{foxyOrderInstruction.update}"/>
                    <h:panelGroup rendered="#{foxyOrderInstruction.update}">
                        <t:inputText id="LotNumber" styleClass="FOX_INPUT_RO_KEY" readonly="true" maxlength="8" 
                                     size="8" value="#{foxyOrderInstruction.lotId}">
                        </t:inputText>
                    </h:panelGroup>
                    
                    
                    <t:outputLabel for="ImportTax"  value="Import Tax:" />
                    <h:panelGroup>
                        <h:selectOneMenu id="ImportTax" styleClass="FOX_INPUT" required="true" value="#{foxyOrderInstruction.importTax}">
                            <f:selectItems value="#{listData.taxList}"/>
                        </h:selectOneMenu>
                        <h:message errorClass="FOX_ERROR" for="ImportTax" showDetail="true" showSummary="true"/>
                    </h:panelGroup>
                    
                    <t:outputLabel for="ShipmentType"  value="Shipment Type:" />
                    <h:panelGroup>
                        <h:selectOneMenu id="ShipmentType" styleClass="FOX_INPUT" required="true" value="#{foxyOrderInstruction.ship}">
                            <f:selectItems value="#{listData.shipTypeList}"/>
                        </h:selectOneMenu>
                        <h:message errorClass="FOX_ERROR" for="ShipmentType" showDetail="true" showSummary="true"/>
                    </h:panelGroup>                
                    
                    <t:outputLabel for="Delivery"  value="Delivery Date:" />
                    <h:panelGroup>
                        <t:inputCalendar id="Delivery" styleClass="FOX_INPUT" value="#{foxyOrderInstruction.delivery}"  popupDateFormat="yyyy-MM-dd" renderAsPopup="true" />    
                        <h:message errorClass="FOX_ERROR" for="Delivery" showDetail="true" showSummary="true"/>
                    </h:panelGroup>
                    
                    <t:outputLabel for="FDelivery"  value="Fabric Delivery:" />
                    <h:panelGroup>
                        <t:inputCalendar id="FDelivery" styleClass="FOX_INPUT" value="#{foxyOrderInstruction.fabricDeliveryDate}"  popupDateFormat="yyyy-MM-dd" renderAsPopup="true" />    
                        <h:message errorClass="FOX_ERROR" for="FDelivery" showDetail="true" showSummary="true"/>
                    </h:panelGroup>                    
                    
                    <t:outputLabel for="OrderMethod"  value="Order Method:" />
                    <h:panelGroup>
                        <h:selectOneMenu id="OrderMethod" styleClass="FOX_INPUT" required="false" value="#{foxyOrderInstruction.orderMethod}">
                            <f:selectItems value="#{listData.ordMethodList}"/>
                        </h:selectOneMenu>
                        <h:message errorClass="FOX_ERROR" for="OrderMethod" showDetail="true" showSummary="true"/>
                    </h:panelGroup>
                    
                </h:panelGrid>
                <%-- END column 2 --%>                                
            </h:panelGrid>
            
            <h:panelGrid id="AddButton" columns="1" columnClasses="FOX_BUTTON" width="50%">
                <h:panelGroup>
                    <h:commandButton id="Save" value="Save" action="#{foxyOrderInstruction.save}" rendered="#{foxyOrderInstruction.add}"/>
                    <h:commandButton id="Update" value="Save" action="#{foxyOrderInstruction.save}" rendered="#{foxyOrderInstruction.update}" />
                    <h:outputText value=" " />
                    <h:commandButton id="Reset" value="Reset" type="reset"/>
                </h:panelGroup>
            </h:panelGrid>
        </h:form>
        
        <h:form id="AddUpdDetailForm">
            <h:panelGrid id="ListDisplay" columns="1" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="100%">
                <t:dataTable value="#{foxyOrderInstruction.orderDetail}" var="orderDetail"
                             id="DetailData"
                             styleClass="FOXY_ORDER_DETAIL"
                             headerClass="FOXY_ORDER_DETAIL_HEADER"
                             footerClass="FOXY_ORDER_DETAIL_HEADER"                    
                             rowGroupStyleClass="FOX_ROW_GROUP"
                             rowGroupStyle="font-weight: bold;"
                             preserveDataModel="true"
                             cellspacing="0">
                    <%--rowClasses="FoxyOddRow,FoxyEvenRow"--%>
                    <t:column groupBy="true" width="6%">
                        <f:facet name="header">
                            <h:outputText value="Lot" />
                        </f:facet>
                        
                        <t:commandLink id="links" 
                                       action="#{foxyOrderInstruction.enquire}" value="#{orderDetail.lot}">
                            <f:param name="refid" value="#{orderDetail.refIdS}"/>
                            <f:param name="month" value="#{orderDetail.month}"/>
                            <f:param name="location" value="#{orderDetail.location}"/>
                            <f:param name="OrderId" value="#{orderDetail.orderId}"/>
                        </t:commandLink>
                        <h:outputText value="#{orderDetail.lot}" style="color: #ffffff; font-size: 1px;" />
                    </t:column>
                    <t:column width="10%">
                        <f:facet name="header">
                            <h:outputText value="No" />
                        </f:facet>
                        <h:outputText value="#{orderDetail.lotD}" />
                    </t:column>
                    <t:column groupBy="true" width="8%">
                        <f:facet name="header">
                            <h:outputText value="Category" />
                        </f:facet>
                        <h:outputText value="#{orderDetail.category}" />
                    </t:column>
                    <t:column groupBy="true" width="5%">
                        <f:facet name="header">
                            <h:outputText value="Main Factory" />
                        </f:facet>
                        <h:outputText value="#{orderDetail.mainFactoryShortName}" />
                    </t:column>
                    <t:column width="10%">
                        <f:facet name="header">
                            <h:outputText value="PO No" />
                        </f:facet>
                        <h:outputText value="#{orderDetail.poNumber}" />
                    </t:column>
                    <t:column width="10%">
                        <f:facet name="header">
                            <h:outputText value="PO Date" />
                        </f:facet>
                        <h:outputText value="#{orderDetail.poDate}">
                            <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                        </h:outputText>
                    </t:column>
                    <t:column width="10%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">                            
                                <h:outputText value="Quantity (DZN)" />
                            </h:panelGrid>
                        </f:facet>
                        
                        <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                     cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">                                                
                            <h:outputText value="#{orderDetail.quantityDzn}">
                                <f:convertNumber pattern="#.00"/>
                            </h:outputText>
                        </h:panelGrid>
                    </t:column>
                    <t:column width="10%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">                            
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="Quantity (PCS)" />
                            </h:panelGrid>
                        </f:facet>
                        
                        <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                     cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">                                                
                            <h:outputText value="#{orderDetail.quantityPcs}">
                                <f:convertNumber pattern="#.00"/>
                            </h:outputText>
                        </h:panelGrid>
                    </t:column>
                    <t:column width="2%">
                        <f:facet name="header">
                            <h:outputText value="Unit" />
                        </f:facet>
                        <h:outputText value="#{orderDetail.unit}" />
                    </t:column>
                    <t:column width="10%">
                        <f:facet name="header">
                            <h:outputText value="Fabric Date" />
                        </f:facet>
                        <h:outputText value="#{orderDetail.fabricDate}">
                            <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                        </h:outputText>
                    </t:column>
                    <t:column groupBy="true" width="8%">
                        <f:facet name="header">
                            <h:outputText value="Delivery" />
                        </f:facet>
                        <h:outputText value="#{orderDetail.delivery}">
                            <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                        </h:outputText>
                    </t:column>                                        
                    <t:column width="8%">
                        <f:facet name="header">
                            <h:outputText value="Vessel Date" />
                        </f:facet>
                        <h:outputText value="#{orderDetail.vesselDate}">
                            <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                        </h:outputText>
                    </t:column>
                    <t:column groupBy="true" width="18%">
                        <f:facet name="header">
                            <h:outputText value="Destination" />
                        </f:facet>
                        <h:outputText value="#{orderDetail.destName} #{orderDetail.orderMethodD}"/>
                    </t:column>
                    
                </t:dataTable>
            </h:panelGrid>
        </h:form>
        
    </h:panelGrid>            
    <%-- End of Update & Add --%>

    <%-- Panel for Enquiry --%>
    <h:panelGrid id="EnqGrid" styleClass="tablebg" rendered="#{foxyOrderInstruction.enquiry}" width="100%">
        <%-- Title for Enquiry --%>
        <h:outputText value="Enquire Lot" styleClass="smalltitle" rendered="#{foxyOrderInstruction.enquiry}"/>
        <%-- Enquiry Form --%>
        <h:form id="EnqForm" rendered="true">
            <h:inputHidden id="month" value="#{foxyOrderInstruction.month}"/>
            <h:inputHidden id="location" value="#{foxyOrderInstruction.location}"/>
            <h:inputHidden id="refId" value="#{foxyOrderInstruction.refId}"/>
            
            <h:panelGrid columns="2" columnClasses="FOXY_SCREEN_2COL,FOXY_SCREEN_2COL" width="100%" cellpadding="0" cellspacing="0" border="0" frame="none" rules="none">
                <%-- START column 1 --%>
                <h:panelGrid id="EnqInputcol1" columns="2" columnClasses="FOX_LABEL_COL_2, FOX_INPUT_COL_2" width="100%">
                    <h:outputText value="Ref. Number:" />
                    <h:panelGroup>
                        <h:inputText id="OrderIdD" styleClass="FOX_INPUT_RO_KEY" readonly="true" size="10" value="#{foxyOrderInstruction.orderId}"/>
                        <h:inputHidden id="OrderId" value="#{foxyOrderInstruction.orderId}"/>
                    </h:panelGroup>
                    
                    <h:outputText value="Main Factory:" />
                    <h:inputText id="factory" styleClass="FOX_INPUT_RO" readonly="true" size="50" value="#{foxyOrderInstruction.factoryD}"/> 
                    
                    <h:outputText value="Category:" />
                    <h:inputText id="CategoryD" styleClass="FOX_INPUT_RO" readonly="true" size="50" value="#{foxyOrderInstruction.categoryD}"/>
                    
                    <h:outputText value="Quota Applicable:" />
                    <h:inputText id="Quota" styleClass="FOX_INPUT_RO" readonly="true" size="10" value="#{foxyOrderInstruction.quota}"/>                                
                    
                    <h:outputText value="Quantity:" />
                    <h:panelGroup>
                        <h:inputText id="QtyDzn" styleClass="FOX_INPUT_NUM_RO" readonly="true" size="15" value="#{foxyOrderInstruction.qtyDzn}"/>
                        <h:outputText value=" Dozens " />
                        <h:outputText value=" " />
                        <h:inputText id="QtyPcs" styleClass="FOX_INPUT_NUM_RO" readonly="true" size="15" value="#{foxyOrderInstruction.qtyPcs}"/>
                        <h:outputText value=" Pieces    " />
                    </h:panelGroup>
                    
                    <h:outputText value="Remark:" />
                    <h:panelGroup>
                        <h:inputTextarea rows="3" cols="30" id="Remark" styleClass="FOX_INPUT_RO" readonly="true" value="#{foxyOrderInstruction.remark}"/>
                    </h:panelGroup>                    
                </h:panelGrid>
                <%-- END column 1 --%>
                
                
                <%-- START column 2 --%>
                <h:panelGrid id="EnqInputcol2" columns="2" columnClasses="FOX_LABEL_COL_2, FOX_INPUT_COL_2" width="100%">                                        
                    <h:outputText value="Lot Number:" />
                    <h:inputText id="LotNumber" styleClass="FOX_INPUT_RO_KEY" readonly="true" size="8" value="#{foxyOrderInstruction.lotId}"/>                                
                    
                    <h:outputText value="Import Tax:" />
                    <h:inputText id="ImportTax" styleClass="FOX_INPUT_RO" readonly="true" size="10" value="#{foxyOrderInstruction.importTax}"/>                
                    
                    <h:outputText value="Shipment Type:" />
                    <h:inputText id="ShipType" styleClass="FOX_INPUT_RO" readonly="true" size="30" value="#{foxyOrderInstruction.ship}"/>                
                    
                    <h:outputText value="Delivery Date:" />
                    <h:inputText id="Delivery" styleClass="FOX_INPUT_RO" readonly="true" size="30" value="#{foxyOrderInstruction.delivery}">
                        <f:convertDateTime type="date" pattern="yyyy-MM-dd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                    </h:inputText>
                    
                    <h:outputText value="Fabric Delivery:" />
                    <h:inputText id="FDelivery" styleClass="FOX_INPUT_RO" readonly="true" size="30" value="#{foxyOrderInstruction.fabricDeliveryDate}">
                        <f:convertDateTime type="date" pattern="yyyy-MM-dd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                    </h:inputText>
                    
                    <h:outputText value="Order Method:" />
                    <h:inputText id="OrderMethod" styleClass="FOX_INPUT_RO" readonly="true" size="10" value="#{foxyOrderInstruction.orderMethod}"/>                    
                </h:panelGrid>
                <%-- END column 2 --%>
            </h:panelGrid>
            
            <h:panelGrid id="AddButton" columns="1" columnClasses="FOX_BUTTON" width="50%">
                <h:panelGroup>
                    <h:commandButton id="Edit" value="Edit" action="#{foxyOrderInstruction.edit}"/>
                    <h:outputText value=" " />
                    <h:commandButton id="Delete" value="Delete" action="#{foxyOrderInstruction.delete}" disabled="false"
                                     onclick="if(!confirm('Are you sure want to delete this record?')) return false"/>
                    <h:outputText value=" " />
                    <h:commandButton id="Add" value="Add" action="#{foxyOrderInstruction.add}" disabled="false"/>                    
                </h:panelGroup>
            </h:panelGrid>
        </h:form>
        
        <h:form id="EnqDetailForm">
            <h:panelGrid id="ListDisplay" columns="1" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="100%">
                <t:dataTable value="#{foxyOrderInstruction.orderDetail}" var="orderDetail"
                             id="DetailData"
                             styleClass="FOXY_ORDER_DETAIL"
                             headerClass="FOXY_ORDER_DETAIL_HEADER"
                             footerClass="FOXY_ORDER_DETAIL_HEADER"                    
                             rowGroupStyleClass="FOX_ROW_GROUP"
                             rowGroupStyle="font-weight: bold;"
                             preserveDataModel="true"
                             cellspacing="0">
                    <%--rowClasses="FoxyOddRow,FoxyEvenRow"--%>
                    <t:column groupBy="true" width="6%">
                        <f:facet name="header">
                            <h:outputText value="Lot" />
                        </f:facet>
                        
                        <t:commandLink id="links" 
                                       action="#{foxyOrderInstruction.enquire}" value="#{orderDetail.lot}">
                            <f:param name="month" value="#{orderDetail.month}"/>
                            <f:param name="location" value="#{orderDetail.location}"/>
                            <f:param name="OrderId" value="#{orderDetail.orderId}"/>
                            <f:param name="refid" value="#{orderDetail.refIdS}"/>
                        </t:commandLink>
                        <h:outputText value="#{orderDetail.lot}" style="color: #ffffff; font-size: 1px;" />
                    </t:column>
                    <t:column width="10%">
                        <f:facet name="header">
                            <h:outputText value="No" />
                        </f:facet>
                        <h:outputText value="#{orderDetail.lotD}" />
                    </t:column>
                    <t:column groupBy="true" width="8%">
                        <f:facet name="header">
                            <h:outputText value="Category" />
                        </f:facet>
                        <h:outputText value="#{orderDetail.category}" />
                    </t:column>
                    <t:column groupBy="true" width="5%">
                        <f:facet name="header">
                            <h:outputText value="Main Factory" />
                        </f:facet>
                        <h:outputText value="#{orderDetail.mainFactoryShortName}" />
                    </t:column>
                    <t:column width="10%">
                        <f:facet name="header">
                            <h:outputText value="PO No" />
                        </f:facet>
                        <h:outputText value="#{orderDetail.poNumber}" />
                    </t:column>
                    <t:column width="10%">
                        <f:facet name="header">
                            <h:outputText value="PO Date" />
                        </f:facet>
                        <h:outputText value="#{orderDetail.poDate}">
                            <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                        </h:outputText>
                    </t:column>
                    <t:column width="10%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">                            
                                <h:outputText value="Quantity (DZN)" />
                            </h:panelGrid>
                        </f:facet>                        
                        <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                     cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">                        
                            <h:outputText value="#{orderDetail.quantityDzn}">
                                <f:convertNumber pattern="#.00"/>
                            </h:outputText>
                        </h:panelGrid>
                    </t:column>
                    <t:column width="10%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">                            
                                <h:outputText value="Quantity (PCS)" />
                            </h:panelGrid>
                        </f:facet>
                        <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                     cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">                        
                            <h:outputText value="#{orderDetail.quantityPcs}">
                                <f:convertNumber pattern="#.00"/>
                            </h:outputText>
                        </h:panelGrid>
                    </t:column>
                    <t:column width="2%">
                        <f:facet name="header">
                            <h:outputText value="Unit" />
                        </f:facet>
                        <h:outputText value="#{orderDetail.unit}" />
                    </t:column>
                    <t:column width="10%">
                        <f:facet name="header">
                            <h:outputText value="Fabric Date" />
                        </f:facet>
                        <h:outputText value="#{orderDetail.fabricDate}">
                            <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                        </h:outputText>
                    </t:column>
                    <t:column groupBy="true" width="8%">
                        <f:facet name="header">
                            <h:outputText value="Delivery" />
                        </f:facet>
                        <h:outputText value="#{orderDetail.delivery}">
                            <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                        </h:outputText>
                    </t:column>                    
                    <t:column width="8%">
                        <f:facet name="header">
                            <h:outputText value="Vessel Date" />
                        </f:facet>
                        <h:outputText value="#{orderDetail.vesselDate}">
                            <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                        </h:outputText>
                    </t:column>
                    <t:column groupBy="true" width="18%">
                        <f:facet name="header">
                            <h:outputText value="Destination" />
                        </f:facet>
                        <h:outputText value="#{orderDetail.destName} #{orderDetail.orderMethodD}"/>
                    </t:column>
                </t:dataTable>
            </h:panelGrid>
        </h:form>
        
    </h:panelGrid>            
    <%-- End of Enquiry --%>
    <%@ include file="foxyFooter.jsp"%>
</f:view>
