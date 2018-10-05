<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%@taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<%@taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@taglib prefix="h" uri="http://java.sun.com/jsf/html"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<style type="text/css" >    
    .columnbottom {
    white-space: nowrap;
    vertical-align: bottom;
    }
    
    .FOX_DATA {
    font-size: 11px; 
    font-family: Verdana;
    border: #cccccc 1px solid;
    background-color: #fffcf9;
    padding-left: 1px;
    padding-right: 5px;
    }    
</style>


<f:view>
    <%@ include file="foxyHeader.jsp" %>
    <table class="box" width="100%">
        <tr><td>                    
            <%-- Panel for Enquiry --%>
            <h:panelGrid id="EnqOrderGrid" styleClass="tablebg" width="100%">                
                <h:form id="EnqForm" rendered="true">
                    <h:panelGrid id="MainPrintForm" columns="1"  width="100%">
                        <h:panelGrid id="MainPrintFormchild" columns="2" columnClasses="columnbottom,horizontal-align: right" width="100%">
                            <h:panelGroup>
                                <h:panelGrid columns="1" columnClasses="text-align: left;" width="100%">
                                    <h:outputText value="CHING HENG GARMENTS FACTORY PTE LTD" style="text-align: right;" styleClass="smalltitle" />            
                                    <h:outputText value="ORDER DATA ENTRY FORM" styleClass="smalltitle" />        
                                </h:panelGrid>
                            </h:panelGroup>
                            <t:graphicImage  url="/app/DisplayPicture?imageid=#{foxyOrder.orderId}"/>
                        </h:panelGrid>                        

                            
                        <h:panelGrid id="UpdAddInput1" columns="4" columnClasses="FOX_LABEL_COL_4, FOX_INPUT_COL_4, FOX_LABEL_COL_4, FOX_INPUT_COL_4" width="100%">
                            
                            <!-- ==================== [Customer Code] --START-- ========================= -->
                            <h:outputText value="Cust/Brand/Division:" />
                            <h:panelGroup >
                                <h:outputText id="Customer_Code" styleClass="FOX_DATA"
                                value="#{foxyOrder.customer}/#{foxyOrder.custBrandCode}/#{foxyOrder.custDivisionCode}"/>
                            </h:panelGroup>
                            <!-- ==================== [Customer Code] --END  -- ========================= -->
                            
                            <h:outputText value="Merchandiser:" />
                            <h:outputText id="Merchandiser" styleClass="FOX_DATA" value="#{foxyOrder.merchandiser}"/>

                            <h:outputText value="Style:" />
                            <h:outputText id="Style" styleClass="FOX_DATA" value="#{foxyOrder.style}"/>            
                            
                            <h:outputText value=" " />
                            <h:outputText id="mode1" styleClass="FOX_DATA" value="New Order / Amendment / Cancel"/>            
                            
                            
                            <t:outputLabel for="OrderIdD" value="Ref. Number:" />                
                            <h:panelGroup>
                                <h:inputText id="OrderIdD" styleClass="FOX_INPUT_RO_KEY" style="color: #FF0000;" readonly="true" maxlength="6" 
                                    size="10" required="true" value="#{foxyOrder.orderId}">
                                </h:inputText>                    
                            </h:panelGroup>

                            <t:outputLabel for="Date" value="Order Date:" />
                            <h:panelGroup>
                                <t:inputCalendar id="Date" styleClass="FOX_INPUT" value="#{foxyOrder.date}"  popupDateFormat="yyyy-MM-dd" renderAsPopup="true" readonly="true" disabled="true"/>    
                            </h:panelGroup>                                                                            
                        
                            <t:outputLabel for="Season" value="Season:" />
                            <h:panelGroup>
                                <h:selectOneMenu id="Season" styleClass="FOX_INPUT" required="true" readonly="true" value="#{foxyOrder.season}" disabled="true">
                                    <f:selectItems value="#{listData.seasonList}"/>
                                </h:selectOneMenu>
                            </h:panelGroup>                                          
                        
                            <t:outputLabel for="UnitPrice" value="Unit Price (USD):" />
                            <h:panelGroup>
                                <h:panelGroup id="UnitPrices">
                                    <h:inputText id="UnitPrice" readonly="true" styleClass="FOX_INPUT" maxlength="12" size="15" required="true" value="#{foxyOrder.unitPrice}"/>
                                </h:panelGroup>
                                <h:outputText value=" per pcs" />
                            </h:panelGroup>
                                          
                            <t:outputLabel for="PriceTerm" value="Price Term:" />                    
                            <h:panelGroup>
                                <h:selectOneMenu id="PriceTerm" styleClass="FOX_INPUT" required="true" value="#{foxyOrder.priceTerm}" disabled="true">
                                    <f:selectItems value="#{listData.priceTermList}"/>
                                </h:selectOneMenu>
                            </h:panelGroup>  
                                        
                            <t:outputLabel for="QuotaUom" value="Quota UOM:" />                    
                            <h:panelGroup>
                                <h:selectOneMenu id="QuotaUom" styleClass="FOX_INPUT" required="true" value="#{foxyOrder.quotaUom}" disabled="true">
                                    <f:selectItems value="#{listData.unitList}"/>
                                </h:selectOneMenu>
                            </h:panelGroup>  
                    
                            <t:outputLabel for="QuantityUom" value="Quantity UOM:" />                    
                            <h:panelGroup>
                                <h:selectOneMenu id="QuantityUom" styleClass="FOX_INPUT" required="true" value="#{foxyOrder.uom}" disabled="true">
                                    <f:selectItems value="#{listData.unitList}"/>
                                </h:selectOneMenu>
                            </h:panelGroup>                              
                          
         
                            <t:outputLabel for="Description" value="Description:" />
                            <h:panelGroup>
                                <h:inputTextarea rows="3" cols="30" id="Description" readonly="true" styleClass="FOX_INPUT" required="false" value="#{foxyOrder.description}">
                                </h:inputTextarea>
                            </h:panelGroup>


                            <t:outputLabel for="Remark" value="Remark:" />
                            <h:panelGroup>
                                <h:inputTextarea rows="3" cols="30" id="Remark" readonly="true" styleClass="FOX_INPUT" required="false" value="#{foxyOrder.remark}">
                                </h:inputTextarea>                                
                            </h:panelGroup>
                    
                            <t:outputLabel for="CM" value="CM:" />
                            <h:panelGroup>
                                <h:inputTextarea id="CM" rows="3" cols="30" readonly="true" styleClass="FOX_INPUT" required="false" value="#{foxyOrder.costCm}"/>
                            </h:panelGroup>                    
                    
                            <t:outputLabel for="Fabrication" value="Fabrication:" />
                            <h:panelGroup>
                                <h:inputTextarea id="Fabrication" rows="3" cols="30" readonly="true" styleClass="FOX_INPUT" required="false" value="#{foxyOrder.fabrication}"/>
                            </h:panelGroup>
                    
                            <t:outputLabel for="FabricMill" value="Fabric Mill:" />
                            <h:panelGroup>
                                <h:inputTextarea id="FabricMill" rows="3" cols="30" readonly="true" styleClass="FOX_INPUT" required="false" value="#{foxyOrder.fabricMill}"/>
                            </h:panelGroup>
                    
                            <t:outputLabel for="FabricPrice" value="Fabric Price:" />
                            <h:panelGroup>
                                <h:inputTextarea id="FabricPrice" rows="3" cols="30" readonly="true" styleClass="FOX_INPUT" required="false" value="#{foxyOrder.fabricPrice}"/>
                            </h:panelGroup>                                                            
                    
                            <t:outputLabel for="FabricYYDZ" value="Fabric YY/DZ:" />
                            <h:panelGroup>
                                <h:inputTextarea id="FabricYYDZ" rows="3" cols="30" readonly="true" styleClass="FOX_INPUT" required="false" value="#{foxyOrder.fabricYyDz}"/>
                            </h:panelGroup>
                    
                            <t:outputLabel for="GraphicCost" value="Graphic Cost:" />
                            <h:panelGroup>
                                <h:inputTextarea id="GraphicCost" rows="3" cols="30" readonly="true"  styleClass="FOX_INPUT" required="false" value="#{foxyOrder.gcost}"/>
                            </h:panelGroup>                    
                    
                            <t:outputLabel for="SpecialWash" value="Special Wash Cost:" />
                            <h:panelGroup>
                                <h:inputTextarea id="SpecialWash" rows="3" cols="30" readonly="true" styleClass="FOX_INPUT" required="false" value="#{foxyOrder.swash}"/>
                            </h:panelGroup>                                        
                    
                            <t:outputLabel for="Wash" value="Wash:" />
                            <h:panelGroup>
                                <h:inputTextarea id="Wash" rows="3" cols="30" readonly="true" styleClass="FOX_INPUT" required="false" value="#{foxyOrder.wash}"/>
                            </h:panelGroup>                                        
                    
                            <h:panelGrid id="AddButton" columns="1" columnClasses="FOX_BUTTON" width="50%">
                                <h:commandButton id="Save" value="Save" action="#{foxyOrder.save}" rendered="#{foxyOrder.add}"/>
                            </h:panelGrid>
                        </h:panelGrid>
                    </h:panelGrid>
                </h:form>                            
                            
            </h:panelGrid>                        
        </td>
        </tr>
    </table>
    <%@ include file="foxyFooter.jsp" %>
</f:view>
