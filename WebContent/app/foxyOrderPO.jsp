<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<%@taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@taglib prefix="h" uri="http://java.sun.com/jsf/html"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<f:view>
    <%@ include file="foxyHeader.jsp" %>
    
    <%-- Panel for Update & Add --%>
    <h:panelGrid id="UpdAddGrid" styleClass="tablebg" rendered="#{foxyOrderPO.updAdd}" width="100%">
        <h:panelGroup>
            <%-- Title for Update --%>
            <h:outputText value="Update M.R." styleClass="smalltitle" rendered="#{foxyOrderPO.update}"/>
            <%-- Title for Add --%>
            <h:outputText value="Add M.R." styleClass="smalltitle" rendered="#{foxyOrderPO.add}"/>
            
            <h:messages errorClass="FOX_ERROR" />
        </h:panelGroup>
        
        <h:form id="UpdAddForm" rendered="true">
            <h:inputHidden id="month" value="#{foxyOrderPO.month}"/>
            <h:inputHidden id="location" value="#{foxyOrderPO.location}"/>
            <h:inputHidden id="subLocation" value="#{foxyOrderPO.subLocation}"/>
            <h:inputHidden id="refIdS" value="#{foxyOrderPO.refIdS}"/>
            <h:inputHidden id="refIdC" value="#{foxyOrderPO.refIdC}"/>
            
            <h:panelGrid columns="2" columnClasses="FOXY_SCREEN_2COL,FOXY_SCREEN_2COL" width="100%" cellpadding="0" cellspacing="0" border="0" frame="none" rules="none">
                <%-- START column 1 --%>
                <h:panelGrid id="UpdInputcol1" columns="2" columnClasses="FOX_LABEL_COL_2, FOX_INPUT_COL_2" width="100%">
                    <t:outputLabel for="OrderIdD" value="Ref. Number:" />
                    <h:panelGroup>
                        <h:inputText id="OrderIdD" styleClass="FOX_INPUT_RO_KEY" readonly="true" size="10" required="true" value="#{foxyOrderPO.orderId}"/>
                        <h:inputHidden id="OrderId" value="#{foxyOrderPO.orderId}"/>                    
                    </h:panelGroup>
                    
                    
                    <t:outputLabel for="SubCode" value="Lot ID:" />
                    <h:panelGroup>
                        <h:inputText id="LotID" styleClass="FOX_INPUT_RO_KEY" readonly="true" size="10"  value="#{foxyOrderPO.lotId}"/> <%--rendered="#{foxyOrderPO.update}"/--%>
                        <%--h:selectOneMenu id="LotIDs" styleClass="FOX_INPUT" required="true" value="#{foxyOrderPO.lotId}" rendered="#{foxyOrderPO.add}">
                        <f:selectItems value="#{foxyOrderPO.lotIdList}"/>
                    </h:selectOneMenu--%>
                        <h:outputText value=" " />
                        <%--h:inputText id="SubLocationD" styleClass="FOX_INPUT_RO_KEY" readonly="true" size="8" required="true" value="#{foxyOrderPO.subLocation}" rendered="#{foxyOrderPO.update}"/--%>
                        <%--h:inputHidden id="subLocationH" value="#{foxyOrderPO.subLocation}" rendered="#{foxyOrderPO.update}"/--%>
                        <h:inputText id="SubCode" styleClass="FOX_INPUT" maxlength="10" size="15" required="false" value="#{foxyOrderPO.subLocation}" rendered="true"/> <%--rendered="#{foxyOrderPO.add}"/--%>

                        <h:message errorClass="FOX_ERROR" for="LotID" showDetail="true" showSummary="true"/>
                        <h:message errorClass="FOX_ERROR" for="SubCode" showDetail="true" showSummary="true"/>
                    </h:panelGroup>                       
                    
                    <t:outputLabel for="FabricDate" value="Fabric Date:" />
                    <h:panelGroup>
                        <t:inputCalendar id="FabricDate" styleClass="FOX_INPUT" value="#{foxyOrderPO.fabricDate}"  
                                         helpText="YYYYMMDD" popupDateFormat="yyyyMMdd" renderAsPopup="true"/>    
                        <h:message errorClass="FOX_ERROR" for="FabricDate" showDetail="true" showSummary="true"/>
                    </h:panelGroup>                                            
                    
                    <t:outputLabel for="VesselDate" value="Vessel Date:" />
                    <h:panelGroup>
                        <t:inputCalendar id="VesselDate" styleClass="FOX_INPUT" value="#{foxyOrderPO.vesselDate}"  
                                         helpText="YYYYMMDD" popupDateFormat="yyyyMMdd" renderAsPopup="true"/>    
                        <h:message errorClass="FOX_ERROR" for="VesselDate" showDetail="true" showSummary="true"/>
                    </h:panelGroup>                        
                    
                    <t:outputLabel for="CloseDate" value="Close Date:" />
                    <h:panelGroup>
                        <t:inputCalendar id="CloseDate" styleClass="FOX_INPUT" value="#{foxyOrderPO.closeDate}"  
                                         helpText="YYYYMMDD" popupDateFormat="yyyyMMdd" renderAsPopup="true"/>    
                        <h:message errorClass="FOX_ERROR" for="CloseDate" showDetail="true" showSummary="true"/>
                    </h:panelGroup>                                        
                    
                    <t:outputLabel for="ShipmentType" value="Shipment Type:" />
                    <h:panelGroup>
                        <h:selectOneMenu id="ShipmentType" styleClass="FOX_INPUT" required="true" value="#{foxyOrderPO.ship}">
                            <f:selectItems value="#{listData.shipTypeList}"/>
                        </h:selectOneMenu>
                        <h:message errorClass="FOX_ERROR" for="ShipmentType" showDetail="true" showSummary="true"/>
                    </h:panelGroup>
                    
                    <%-- Local Merchindaser field --%>
                    <t:outputLabel for="LocalMR" value="Local M.R:" />
                    <h:panelGroup>
                        <h:selectOneMenu id="LocalMR" styleClass="FOX_INPUT" required="false" value="#{foxyOrderPO.lmerchandiser}">
                            <f:selectItems value="#{listData.merchandiserList}"/>
                        </h:selectOneMenu>
                        <h:message errorClass="FOX_ERROR" for="LocalMR" showDetail="true" showSummary="true"/>
                    </h:panelGroup>                                              
                    
                    <t:outputLabel for="MRForCust" value="MR for Cust:" />
                    <h:panelGroup>
                        <h:inputText id="MRForCust" styleClass="FOX_INPUT" maxlength="20" size="20" required="false" value="#{foxyOrderPO.mrForCust}"/>
                        <h:message errorClass="FOX_ERROR" for="MRForCust" showDetail="true" showSummary="true"/>
                    </h:panelGroup>   
                    
                </h:panelGrid>
                <%-- END column 1 --%>
                
                <%-- START column 2 --%>
                <h:panelGrid id="UpdInputcol2" columns="2" columnClasses="FOX_LABEL_COL_2, FOX_INPUT_COL_2" width="100%">
                    
                    <t:outputLabel for="PONumber" value="P.O. Number:" />
                    <h:panelGroup>
                        <h:inputText id="PONumber" styleClass="FOX_INPUT" size="10" maxlength="10" required="true" value="#{foxyOrderPO.poNumber}"/>
                        <t:outputText value="(TBA = not received)" />
                        <h:message errorClass="FOX_ERROR" for="PONumber" showDetail="true" showSummary="true"/>
                    </h:panelGroup>                                                             
                    
                    <t:outputLabel for="PODate" value="PO Date:" />
                    <h:panelGroup>
                        <t:inputCalendar id="PODate" styleClass="FOX_INPUT" value="#{foxyOrderPO.poDate}"  
                                         helpText="YYYYMMDD" popupDateFormat="yyyyMMdd" renderAsPopup="true"/>
                        <h:message errorClass="FOX_ERROR" for="PODate" showDetail="true" showSummary="true"/>
                    </h:panelGroup>                                        

                    <t:outputLabel for="Quantity" value="Quantity:" />
                    <h:panelGroup>
                        <h:inputText id="Quantity" styleClass="FOX_INPUT" maxlength="11" size="11" required="true" value="#{foxyOrderPO.quantity}"/>
                        <h:outputText value=" " />
                        <h:selectOneMenu id="Unit" styleClass="FOX_INPUT" required="true" value="#{foxyOrderPO.unitc}">
                            <f:selectItems value="#{listData.unitList}"/>
                        </h:selectOneMenu>
                        <h:message errorClass="FOX_ERROR" for="Quantity" showDetail="true" showSummary="true"/>
                        <h:message errorClass="FOX_ERROR" for="Unit" showDetail="true" showSummary="true"/>                                        
                    </h:panelGroup>                                
                    
                    <t:outputLabel for="Emb" value="Emb:" />
                    <h:panelGroup>
                        <h:inputText id="Emb" styleClass="FOX_INPUT" maxlength="10" size="10" required="false" value="#{foxyOrderPO.emb}"/>
                        <h:message errorClass="FOX_ERROR" for="Emb" showDetail="true" showSummary="true"/>
                    </h:panelGroup>                               
                    
                    <t:outputLabel for="Remark" value="Remark:" />
                    <h:panelGroup>
                        <h:inputTextarea rows="3" cols="30" id="Remark" styleClass="FOX_INPUT" required="false" value="#{foxyOrderPO.remark}">
                        </h:inputTextarea>
                        <h:message errorClass="FOX_ERROR" for="Remark" showDetail="true" showSummary="true"/>
                    </h:panelGroup>
                    
                </h:panelGrid>
                <%-- END column 2 --%>                
            </h:panelGrid>
            
            
            <h:panelGrid id="AddButton" columns="1" columnClasses="FOX_BUTTON" width="50%">
                <h:panelGroup>
                    <h:commandButton id="Save" value="Save" action="#{foxyOrderPO.save}" rendered="#{foxyOrderPO.add}"/>
                    <h:commandButton id="Update" value="Save" action="#{foxyOrderPO.save}" rendered="#{foxyOrderPO.update}" />
                    <h:outputText value=" " />
                    <h:commandButton id="Reset" value="Reset" type="reset"/>
                </h:panelGroup>
            </h:panelGrid>
        </h:form>
        
        <h:form id="OrderDetailForm">
            <h:panelGrid id="ListDisplay" columns="1" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="100%">
                <t:dataTable value="#{foxyOrderPO.orderDetail}" var="orderDetail"
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
                        <%--h:outputText value="#{orderDetail.lotS}"/--%>
                        
                        <t:commandLink id="links" style="color: #ff00ff; font-weight: bold; font-size: 11px"
                                       action="#{foxyOrderPO.add}" value="#{orderDetail.lot}">
                            <f:param name="orderid" value="#{foxyOrderPO.orderId}"/>
                            <f:param name="refIdS" value="#{orderDetail.refIdS}"/>
                            <f:param name="month" value="#{orderDetail.month}"/>
                            <f:param name="location" value="#{orderDetail.location}"/>                        
                        </t:commandLink>
                        <h:outputText value="#{orderDetail.lot}" style="color: #ffffff; font-size: 1px" />
                    </t:column>
                    <t:column width="10%">
                        <f:facet name="header">
                            <h:outputText value="No" />
                        </f:facet>
                        <%--h:outputText value="#{orderDetail.lotD}" /--%>
                        <h:commandLink id="lotD" 
                                       action="#{foxyOrderPO.enquire}" value="#{orderDetail.lotD}">
                            <f:param name="orderid" value="#{foxyOrderPO.orderId}"/>
                            <f:param name="refIdS" value="#{orderDetail.refIdS}"/>
                            <f:param name="refIdC" value="#{orderDetail.refIdC}"/>
                            <f:param name="month" value="#{orderDetail.month}"/>
                            <f:param name="location" value="#{orderDetail.location}"/>
                            <f:param name="subLocation" value="#{orderDetail.subLocation}"/>
                            
                        </h:commandLink>
                        
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
                            <h:outputText value="Vessel Date"/>                                
                        </f:facet>
                        <h:outputText value="#{orderDetail.vesselDate}">
                            <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                        </h:outputText>
                    </t:column>
                    <t:column width="8%">
                        <f:facet name="header">
                            <h:outputText value="Close Date"/>                                
                        </f:facet>
                        <h:outputText value="#{orderDetail.closeDate}">
                            <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                        </h:outputText>
                    </t:column>                      
                    <%-- Destination --%>
                    <t:column groupBy="true" width="26%">
                        <f:facet name="header">
                            <h:outputText value="Destinationa" />
                        </f:facet>
                        <h:outputText value="#{orderDetail.destName} #{orderDetail.orderMethodD}">
                        </h:outputText>
                    </t:column>
                    
                </t:dataTable>
            </h:panelGrid>
        </h:form>
    </h:panelGrid>            
    <%-- End of Update & Add --%>

    <%-- Panel for Enquiry --%>
    <h:panelGrid id="EnqGrid" styleClass="tablebg" rendered="#{foxyOrderPO.enquiry}" width="100%">
        <%-- Title for Enquiry --%>
        <h:outputText value="Enquire M.R." styleClass="smalltitle"/>
        <h:form id="EnqForm" rendered="true">
            <h:inputHidden id="month" value="#{foxyOrderPO.month}"/>
            <h:inputHidden id="location" value="#{foxyOrderPO.location}"/>
            <h:inputHidden id="subLocation" value="#{foxyOrderPO.subLocation}"/>
            <h:inputHidden id="refIdS" value="#{foxyOrderPO.refIdS}"/>
            <h:inputHidden id="refIdC" value="#{foxyOrderPO.refIdC}"/>
            
            <h:panelGrid columns="2" columnClasses="FOXY_SCREEN_2COL,FOXY_SCREEN_2COL" width="100%" cellpadding="0" cellspacing="0" border="0" frame="none" rules="none">
                <%-- START column 1 --%>
                <h:panelGrid id="EnqInputcol1" columns="2" columnClasses="FOX_LABEL_COL_2, FOX_INPUT_COL_2" width="100%">
                    
                    <h:outputText value="Ref. Number:" />
                    <h:panelGroup>
                        <h:inputText id="OrderIdD" styleClass="FOX_INPUT_RO_KEY" readonly="true" size="10" required="true" value="#{foxyOrderPO.orderId}"/>
                        <h:inputHidden id="OrderId" value="#{foxyOrderPO.orderId}"/>
                    </h:panelGroup>
                    
                    <h:outputText value="Lot ID:" />
                    <h:panelGroup>
                        <h:inputText id="LotID" styleClass="FOX_INPUT_RO_KEY" readonly="true" size="10" value="#{foxyOrderPO.lotId}"/>
                        <h:outputText value=" " />
                        <h:inputText id="SubCode" styleClass="FOX_INPUT_RO_KEY" readonly="true" size="15" value="#{foxyOrderPO.subLocation}"/>
                    </h:panelGroup>
                    
                    <h:outputText value="Fabric Date:" />
                    <h:inputText id="FabricDate" styleClass="FOX_INPUT_RO" readonly="true" size="30" value="#{foxyOrderPO.fabricDate}">
                        <f:convertDateTime type="date" pattern="yyyy-MM-dd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                    </h:inputText>                    
                    
                    <h:outputText value="Vessel Date:" />
                    <h:inputText id="VesselDate" styleClass="FOX_INPUT_RO" readonly="true" size="30" value="#{foxyOrderPO.vesselDate}">
                        <f:convertDateTime type="date" pattern="yyyy-MM-dd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                    </h:inputText>
                    
                    <h:outputText value="Close Date:" />
                    <h:inputText id="CloseDate" styleClass="FOX_INPUT_RO" readonly="true" size="30" value="#{foxyOrderPO.closeDate}">
                        <f:convertDateTime type="date" pattern="yyyy-MM-dd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                    </h:inputText>
                    
                    <h:outputText value="Shipment Type:" />
                    <h:inputText id="ShipType" styleClass="FOX_INPUT_RO" readonly="true" size="30" value="#{foxyOrderPO.ship}"/>
                    
                    <%-- Local Merchindaser field --%>
                    <t:outputLabel for="LocalMR" value="Local M.R:" />
                    <h:inputText id="LocalMR" styleClass="FOX_INPUT_RO" readonly="true" size="10" value="#{foxyOrderPO.lmerchandiser}"/>
                                        
                    <t:outputLabel for="MRForCust" value="MR for Cust:" />
                    <h:panelGroup>
                        <h:inputText id="MRForCust" styleClass="FOX_INPUT_RO" maxlength="20" size="20" required="false" value="#{foxyOrderPO.mrForCust}"/>
                        <h:message errorClass="FOX_ERROR" for="MRForCust" showDetail="true" showSummary="true"/>
                    </h:panelGroup>   
                                        
                </h:panelGrid>
                <%-- END column 1 --%>
                
                <%-- START column 2 --%>
                <h:panelGrid id="EnqInputcol2" columns="2" columnClasses="FOX_LABEL_COL_2, FOX_INPUT_COL_2" width="100%">
                    <h:outputText value="P.O. Number:" />
                    <h:inputText id="PONumber" styleClass="FOX_INPUT_RO" readonly="true" size="10" value="#{foxyOrderPO.poNumber}"/>        
                    
                    <h:outputText value="PO Date:" />
                    <h:inputText id="PODate" styleClass="FOX_INPUT_RO" readonly="true" size="30" value="#{foxyOrderPO.poDate}">
                        <f:convertDateTime type="date" pattern="yyyy-MM-dd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                    </h:inputText>
                    
                    <h:outputText value="Quantity:" />
                    <h:panelGroup>
                        <h:inputText id="QtyDzn" styleClass="FOX_INPUT_NUM_RO" readonly="true" size="15" value="#{foxyOrderPO.qtyDzn}"/>
                        <h:outputText value=" Dozens " />
                        <h:outputText value=" " />
                        <h:inputText id="QtyPcs" styleClass="FOX_INPUT_NUM_RO" readonly="true" size="15" value="#{foxyOrderPO.qtyPcs}"/>
                        <h:outputText value=" Pieces    " />
                    </h:panelGroup>
                    
                    <h:outputText value="Emb:" />
                    <h:inputText id="Emb2" styleClass="FOX_INPUT_RO" readonly="true" size="10" value="#{foxyOrderPO.emb}"/>                                
                    
                    <h:outputText value="Remark:" />
                    <h:inputTextarea rows="3" cols="30" id="Remark" styleClass="FOX_INPUT_RO" readonly="true" value="#{foxyOrderPO.remark}"/>                    
                </h:panelGrid>
                <%-- END column 2 --%>
            </h:panelGrid>
            
            <h:panelGrid id="AddButton" columns="1" columnClasses="FOX_BUTTON" width="50%">
                <h:panelGroup>
                    <h:commandButton id="Edit" value="Edit" action="#{foxyOrderPO.edit}"/>
                    <h:outputText value=" " />
                    <%--h:commandButton id="Add" value="Add" action="#{foxyOrderPO.add}"/>
                    <h:outputText value=" " /--%>
                    <h:commandButton id="Delete" value="Delete" action="#{foxyOrderPO.delete}" disabled="false"
                                     onclick="if(!confirm('Are you sure want to delete this record?')) return false"/>
                </h:panelGroup>
            </h:panelGrid>
        </h:form>
        
        <h:form id="EnqDetailForm">
            <h:panelGrid id="ListDisplay" columns="1" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="100%">
                <t:dataTable value="#{foxyOrderPO.orderDetail}" var="orderDetail"
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
                        <%--h:outputText value="#{orderDetail.lotS}"/--%>
                        
                        <t:commandLink id="links" style="color: #ff00ff; font-weight: bold; font-size: 11px"
                                       action="#{foxyOrderPO.add}" value="#{orderDetail.lot}">
                            <f:param name="orderid" value="#{foxyOrderPO.orderId}"/>
                            <f:param name="refIdS" value="#{orderDetail.refIdS}"/>
                            <f:param name="refIdC" value="#{orderDetail.refIdC}"/>
                            <f:param name="month" value="#{orderDetail.month}"/>
                            <f:param name="location" value="#{orderDetail.location}"/>
                        </t:commandLink>
                        <h:outputText value="#{orderDetail.lot}" style="color: #ffffff; font-size: 1px" />
                    </t:column>
                    <t:column width="10%">
                        <f:facet name="header">
                            <h:outputText value="No" />
                        </f:facet>
                        <%--h:outputText value="#{orderDetail.lotD}" /--%>
                        <h:commandLink id="lotD" 
                                       action="#{foxyOrderPO.enquire}" value="#{orderDetail.lotD}">
                            <f:param name="orderid" value="#{foxyOrderPO.orderId}"/>
                            <f:param name="refIdS" value="#{orderDetail.refIdS}"/>
                            <f:param name="refIdC" value="#{orderDetail.refIdC}"/>
                            <f:param name="month" value="#{orderDetail.month}"/>
                            <f:param name="location" value="#{orderDetail.location}"/>
                            <f:param name="subLocation" value="#{orderDetail.subLocation}"/>
                        </h:commandLink>
                        
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
                            <h:outputText value="Vessel Date"/>                                
                        </f:facet>
                        <h:outputText value="#{orderDetail.vesselDate}">
                            <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                        </h:outputText>
                    </t:column>
                    <t:column width="8%">
                        <f:facet name="header">
                            <h:outputText value="Close Date"/>                                
                        </f:facet>
                        <h:outputText value="#{orderDetail.closeDate}">
                            <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                        </h:outputText>
                    </t:column>                   
                    <%-- Destination --%>
                    <t:column groupBy="true" width="26%">                       
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="Destination" />
                            </h:panelGrid>
                        </f:facet>
                        <h:outputText value="#{orderDetail.destName} #{orderDetail.orderMethodD}">
                        </h:outputText>
                    </t:column>
                    
                </t:dataTable>
            </h:panelGrid>
        </h:form>
    </h:panelGrid>            
    <%-- End of Enquiry --%>    
            
    <%-- Begin of Search--%>
    <%-- End of Search--%>
            
    <%-- Begin of Listing--%>
    <%-- End of Listing--%>

    <%@ include file="foxyFooter.jsp" %>
</f:view>
