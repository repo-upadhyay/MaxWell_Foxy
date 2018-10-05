<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%@taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<%@taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@taglib uri="https://ajax4jsf.dev.java.net/ajax" prefix="a4j"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<f:view>
    <%@ include file="foxyHeader.jsp" %>

    <%-- This save state required to ensure variable value available for rebuild list during  
    Without save state, list will be empty and will get "Value is not a valid option" error message when submit form--%> 
    <t:saveState value="#{foxyOrder.orderIdYear}"/>
    <t:saveState value="#{foxyOrder.mainFactoryCode}"/>
    <t:saveState value="#{foxyOrder.customer}"/>
    <t:saveState value="#{foxyOrder.custBrandCode}"/>

    
    <%-- Panel for Enquiry --%>
    <h:panelGrid id="EnqOrderGrid" styleClass="tablebg" rendered="#{foxyOrder.enquiry}" width="100%">
        <h:panelGrid id="EnqInput1" columns="2" columnClasses="FOX_LABEL_COL_2, FOX_INPUT_COL_2" width="100%">
            <h:panelGroup>
                <h:outputText value="Enquire Order" styleClass="smalltitle" />
            </h:panelGroup>
            <t:div styleClass="FOX_ERROR"><h:messages layout="table"/></t:div> 
        </h:panelGrid>
        <h:form id="EnqForm" rendered="true">
            <%-- First, Slipt the screen into two equal size column --%>
            <h:panelGrid columns="2" columnClasses="FOXY_SCREEN_2COL,FOXY_SCREEN_2COL" width="100%" cellpadding="0" cellspacing="0" border="0" frame="none" rules="none">

                <%-- START column 1 --%>
                <h:panelGrid id="EnqInputcol1" columns="2" columnClasses="FOX_LABEL_COL_2, FOX_INPUT_COL_2" width="100%">
                    <h:outputText value="Ref. Number:" />
                    <h:panelGroup>
                        <h:inputText id="OrderIdD" styleClass="FOX_INPUT_RO_KEY" readonly="true" size="10" value="#{foxyOrder.orderId}"/>
                        <h:inputHidden id="OrderID" value="#{foxyOrder.orderId}"/>
                    </h:panelGroup>

                    <h:outputText value="Customer:" />
                    <h:inputText id="Customer" styleClass="FOX_INPUT_RO" readonly="true" size="30" value="#{foxyOrder.customer}"/>

                    <t:outputLabel for="BrandCode" value="Brand Name:" />
                    <h:inputText id="BrandCode" styleClass="FOX_INPUT_RO" readonly="true" size="30" value="#{foxyOrder.custBrandCode}"/>

                    <t:outputLabel for="divcode" value="Division Name:" />
                    <h:inputText id="divcode" styleClass="FOX_INPUT_RO" readonly="true" size="30" value="#{foxyOrder.custDivisionCode}"/>                

                    <h:outputText value="Unit Price (USD):" />
                    <h:panelGroup>
                        <h:inputText id="UnitPrice" styleClass="FOX_INPUT_NUM_RO" readonly="true" size="15" value="#{foxyOrder.unitPrice}"/>
                    </h:panelGroup>

                    <h:outputText value="Remark:" />
                    <h:inputTextarea rows="3" cols="50" id="Remark" styleClass="FOX_INPUT_RO" value="#{foxyOrder.remark}" readonly="true"/>


                </h:panelGrid>
                <%-- END column 1 --%>


                <%-- START column 2 --%>
                <h:panelGrid id="EnqInputcol2" columns="2" columnClasses="FOX_LABEL_COL_2, FOX_INPUT_COL_2" width="100%">
                    <h:outputText value="Order Date:" />
                    <h:inputText id="OrderDate" styleClass="FOX_INPUT_RO" readonly="true" size="30" value="#{foxyOrder.date}">
                        <f:convertDateTime type="date" pattern="yyyy-MM-dd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                    </h:inputText>

                    <h:outputText value="Merchandiser:" />
                    <h:inputText id="Merchandiser" styleClass="FOX_INPUT_RO" readonly="true" size="30" value="#{foxyOrder.merchandiser}"/>

                    <h:outputText value="Style:" />
                    <h:inputText id="Style" styleClass="FOX_INPUT_RO" readonly="true" size="30" value="#{foxyOrder.style}"/>

                    <h:outputText value="Season:" />
                    <h:inputText id="Season" styleClass="FOX_INPUT_RO" readonly="true" size="30" value="#{foxyOrder.season}"/>

                    <h:outputText value="Description:" />
                    <h:inputTextarea rows="3" cols="50" id="Description" styleClass="FOX_INPUT_RO" value="#{foxyOrder.description}" readonly="true"/>


                </h:panelGrid>
                <%-- END column 2 --%>
            </h:panelGrid>


            <h:panelGrid id="AddButton" columns="1" columnClasses="FOX_BUTTON" width="100%">
                <h:panelGroup>
                    <h:commandButton id="Edit" value="Edit" action="#{foxyOrder.edit}"/>
                    <h:outputText value=" " />
                    <h:commandButton id="Delete" value="Delete" action="#{foxyOrder.delete}" disabled="false"
                                     onclick="if(!confirm('Are you sure want to delete this record?')) return false"/>              
                </h:panelGroup>
            </h:panelGrid>
        </h:form>
        <h:form id="OrderDetailForm">
            <h:panelGrid id="ListDisplay" columns="1" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="100%">
                <t:dataTable value="#{foxyOrder.orderDetail}" var="orderDetail"
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
                        <h:outputText value="#{orderDetail.lot}" />
                    </t:column>

                    <t:column width="10%">
                        <f:facet name="header">
                            <h:outputText value="No" />
                        </f:facet>
                        <h:outputText value="#{orderDetail.lotD}" />
                    </t:column>

                    <t:column groupBy="true" width="5%">
                        <f:facet name="header">
                            <h:outputText value="Country" />
                        </f:facet>
                        <h:outputText value="#{orderDetail.destShortName}" />
                    </t:column>

                    <t:column groupBy="true" width="5%">
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

                    <t:column width="3%">
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
                    <t:column width="8%" >
                        <f:facet name="header">
                            <h:outputText value="Vessel Date"/>                                
                        </f:facet>
                        <h:outputText value="#{orderDetail.vesselDate}">
                            <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                        </h:outputText>
                    </t:column>

                    <t:column groupBy="true" width="24%">
                        <f:facet name="header">
                            <h:outputText value="Destination" />
                        </f:facet>
                        <h:outputText value="#{orderDetail.destName}  #{orderDetail.orderMethodD}" />
                    </t:column>


                </t:dataTable>
            </h:panelGrid>
        </h:form>
    </h:panelGrid>            
    <%-- End of Enquiry--%>

    <%@ include file="foxyFooter.jsp" %>
</f:view>
