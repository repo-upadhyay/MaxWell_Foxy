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


    <%-- Panel for Update & Add --%>
    <h:panelGrid id="UpdAddGrid" styleClass="tablebg" width="100%">
        <%-- Title for Update --%>
        <h:panelGroup rendered="#{foxyOrder.update}">
            <h:outputText value="Update Order" styleClass="smalltitle"/>
            <h:outputText value="#{foxyOrder.recordStamp}" styleClass="FOX_RECSTAMP"/>
        </h:panelGroup>
        <%-- Title for Add --%>
        <h:outputText value="Add Order #{foxyOrder.duplicatefrom}" styleClass="smalltitle" rendered="#{foxyOrder.add}"/>
        <%-- Update & Add Form --%>
        <h:form id="UpdAddForm" rendered="true">

            <h:panelGrid columns="1" style="vertical-align: top;" width="100%" cellpadding="0" cellspacing="0" border="0" frame="none" rules="none">
                <%-- START of column 1 --%>
                <h:panelGrid columns="2" columnClasses="FOXY_SCREEN_2COL,FOXY_SCREEN_2COL" width="100%" cellpadding="0" cellspacing="0" border="0" frame="none" rules="none">
                    <h:panelGrid id="UpdAddInput1_1" columns="2" columnClasses="FOX_LABEL_COL_2, FOX_INPUT_COL_2" width="100%">

                        <t:outputLabel for="year" value="Year:" rendered="#{foxyOrder.add}"/>                       
                        <h:panelGroup rendered="#{foxyOrder.add}">
                            <a4j:region id="ajaxregion_year" renderRegionOnly="false" selfRendered="true">
                                <h:selectOneMenu id="year" styleClass="FOX_INPUT" required="true" value="#{foxyOrder.orderIdYear}"
                                                 >
                                    <f:selectItems value="#{listData.orderIdYear}"/>
                                    <a4j:support id="ajOrderIdYear" event="onchange"  action="#{foxyOrder.onYearOrFactoryChange}" 
                                                 reRender="OrderId" ajaxSingle="false" 
                                                 oncomplete="if(!alert('Please make sure the year selected correctly, Ref. number will be generated based on year selected')) return false">
                                    </a4j:support>  

                                </h:selectOneMenu>
                            </a4j:region>
                            <h:message errorClass="FOX_ERROR" for="year" showDetail="true" showSummary="true"/>
                        </h:panelGroup>                                            

                        <t:outputLabel for="Country" value="Main Factory:" rendered="#{foxyOrder.add}"/>
                        <h:panelGroup rendered="#{foxyOrder.add}">
                            <a4j:region id="ajaxregion_MainFactory" renderRegionOnly="false" selfRendered="true">
                                <h:selectOneMenu id="Country" styleClass="FOX_INPUT" required="true" value="#{foxyOrder.mainFactoryCode}">
                                    <f:selectItems value="#{listData.factoryList}"/>
                                    <a4j:support id="ajMainFactory" event="onchange"  action="#{foxyOrder.onYearOrFactoryChange}" 
                                                 reRender="OrderId" ajaxSingle="false">
                                    </a4j:support>  
                                </h:selectOneMenu>
                            </a4j:region>
                            <h:message errorClass="FOX_ERROR" for="Country" showDetail="true" showSummary="true"/>
                        </h:panelGroup>

                        <t:outputLabel for="OrderId" value="Ref. Number:" />                
                        <h:panelGroup rendered="#{foxyOrder.add}">
                            <h:selectOneMenu id="OrderId" styleClass="FOX_INPUT" required="true" value="#{foxyOrder.orderId}">
                                <f:selectItems value="#{foxyOrder.ordNoReservedList}"/>
                            </h:selectOneMenu>
                            <a4j:status for="ajaxregion_MainFactory">
                                <f:facet name="start">
                                    <h:graphicImage value="/images/ajaxstart.gif" height="12" width="12"/>
                                </f:facet>
                                <f:facet name="stop">
                                    <%-- h:graphicImage value="/images/ajax_stoped.gif" / --%>
                                </f:facet>
                            </a4j:status>      
                            <h:message errorClass="FOX_ERROR" for="OrderId" showDetail="true" showSummary="true"/>
                        </h:panelGroup>

                        <h:panelGroup rendered="#{foxyOrder.update}">
                            <h:inputText id="OrderIdD" styleClass="FOX_INPUT_RO_KEY" style="color: #FF0000;" readonly="true" maxlength="6" 
                                         size="10" required="true" value="#{foxyOrder.orderId}">
                            </h:inputText>                    
                        </h:panelGroup>

                        <!-- ==================== Input Filed for [Company Name] --START-- ========================= -->
                        <t:outputLabel for="CName" value="Company Name:" />
                        <h:panelGroup >
                            <h:selectOneMenu id="CName" value="#{foxyOrder.cnameCode}" styleClass="FOX_INPUT" required="true" immediate="false">
                                <f:selectItems value="#{listData.companyNameList}"/>                                  
                            </h:selectOneMenu>
                            <h:message errorClass="FOX_ERROR" for="CName" showDetail="true" showSummary="true"/>
                        </h:panelGroup>
                        <!-- ==================== Input Filed for [Company Name] --END  -- ========================= -->

                        <t:outputLabel for="Date" value="Order Date:" />
                        <h:panelGroup>
                            <t:inputCalendar id="Date" styleClass="FOX_INPUT" value="#{foxyOrder.date}"  popupDateFormat="yyyy-MM-dd" renderAsPopup="true" />    
                            <h:message errorClass="FOX_ERROR" for="Date" showDetail="true" showSummary="true"/>
                        </h:panelGroup>

                        <t:outputLabel for="Merchandiser" value="Merchandiser:" />
                        <h:panelGroup>
                            <h:selectOneMenu id="Merchandiser" styleClass="FOX_INPUT" required="true" value="#{foxyOrder.merchandiser}">
                                <f:selectItems value="#{listData.merchandiserList}"/>
                            </h:selectOneMenu>
                            <h:message errorClass="FOX_ERROR" for="Merchandiser" showDetail="true" showSummary="true"/>
                        </h:panelGroup>  

                        <t:outputLabel for="Season" value="Season:" />
                        <h:panelGroup>
                            <h:selectOneMenu id="Season" styleClass="FOX_INPUT" required="true" value="#{foxyOrder.season}">
                                <f:selectItems value="#{listData.seasonList}"/>
                            </h:selectOneMenu>
                            <h:message errorClass="FOX_ERROR" for="Season" showDetail="true" showSummary="true"/>
                        </h:panelGroup>                                                                  

                        <t:outputLabel for="Style" value="Style:" />
                        <h:panelGroup>
                            <h:inputText id="Style" styleClass="FOX_INPUT" size="30" required="true" value="#{foxyOrder.style}">
                            </h:inputText>
                            <h:message errorClass="FOX_ERROR" for="Style" showDetail="true" showSummary="true"/>
                        </h:panelGroup>              

                        <t:outputLabel for="UnitPrice" value="Unit Price (USD):" />
                        <h:panelGroup>
                            <h:panelGroup id="UnitPrices">
                                <h:inputText id="UnitPrice" styleClass="FOX_INPUT" maxlength="12" size="15" required="true" value="#{foxyOrder.unitPrice}"
                                             onchange="if ( this.value > 10 )
                                             { 
                                             alert(\"Unusual Unit Price [\" + this.value + \"] > 10, Please make sure it is accurate before save \");
                                             }" />
                            </h:panelGroup>
                            <h:outputText value=" per pcs" />
                            <h:message errorClass="FOX_ERROR" for="UnitPrice" showDetail="true" showSummary="true"/>
                        </h:panelGroup>                                          

                        <t:outputLabel for="PriceTerm" value="Price Term:" />                    
                        <h:panelGroup>
                            <h:selectOneMenu id="PriceTerm" styleClass="FOX_INPUT" required="true" value="#{foxyOrder.priceTerm}">
                                <f:selectItems value="#{listData.priceTermList}"/>
                            </h:selectOneMenu>
                            <h:message errorClass="FOX_ERROR" for="PriceTerm" showDetail="true" showSummary="true"/>
                        </h:panelGroup>                          

                        <!-- ==================== Input Filed for [Customer Code] --START-- ========================= -->
                        <t:outputLabel for="Customer_Code" value="Customer Name:" />
                        <h:panelGroup >
                            <a4j:region id="ajaxregion1" renderRegionOnly="false" selfRendered="true">
                                <h:selectOneMenu id="Customer_Code" value="#{foxyOrder.customer}" style="width:200px; height:25px "
                                                 styleClass="FOX_INPUT" required="true" immediate="false">
                                    <f:selectItems value="#{listData.customerList}"/>
                                    <a4j:support id="ajcustcode" event="onchange" action="#{foxyOrder.onCustCodeChange}" 
                                                 reRender="BrandCode,divcode" ajaxSingle="true">
                                    </a4j:support>                                    
                                </h:selectOneMenu>
                            </a4j:region>
                            <h:message errorClass="FOX_ERROR" for="Customer_Code" showDetail="true" showSummary="true"/>
                        </h:panelGroup>
                        <!-- ==================== Input Filed for [Customer Code] --END  -- ========================= -->

                        <!-- ==================== Input Filed for [Brand Code] --START-- ========================= -->
                        <t:outputLabel for="BrandCode" value="Brand Name:" />
                        <h:panelGroup >
                            <a4j:region id="ajaxregion2" renderRegionOnly="false" selfRendered="true">
                                <h:selectOneMenu id="BrandCode" value="#{foxyOrder.custBrandCode}" style="width:200px; height:25px "
                                                 styleClass="FOX_INPUT" required="true" immediate="false">
                                    <f:selectItems value="#{foxyOrder.brandItemsList}"/>
                                    <a4j:support id="ajcustdiv" event="onchange" action="#{foxyOrder.onCustBrandChange}" 
                                                 reRender="divcode" ajaxSingle="false">
                                    </a4j:support>                                                                        
                                </h:selectOneMenu>
                                <a4j:status for="ajaxregion1">
                                    <f:facet name="start">
                                        <h:graphicImage value="/images/ajaxstart.gif" height="12" width="12"/>
                                    </f:facet>
                                    <f:facet name="stop">
                                        <%-- h:graphicImage value="/images/ajax_stoped.gif" / --%>
                                    </f:facet>
                                </a4j:status>
                            </a4j:region>
                            <h:message errorClass="FOX_ERROR" for="BrandCode" showDetail="true" showSummary="true"/>
                        </h:panelGroup>
                        <!-- ==================== Input Filed for [Brand code] --END  -- ========================= -->


                        <!-- ==================== Input Filed for [Division Code] --START-- ========================= -->
                        <t:outputLabel for="divcode" value="Division Name:" />
                        <h:panelGroup >
                            <h:selectOneMenu id="divcode" value="#{foxyOrder.custDivisionCode}" style="width:200px; height:25px "
                                             styleClass="FOX_INPUT" required="true" immediate="false">
                                <f:selectItems value="#{foxyOrder.divisionItemsList}"/>
                            </h:selectOneMenu>
                            <a4j:status for="ajaxregion2">
                                <f:facet name="start">
                                    <h:graphicImage value="/images/ajaxstart.gif" height="12" width="12"/>
                                </f:facet>
                                <f:facet name="stop">
                                    <%-- h:graphicImage value="/images/ajax_stoped.gif" / --%>
                                </f:facet>
                            </a4j:status>                                

                            <h:message errorClass="FOX_ERROR" for="divcode" showDetail="true" showSummary="true"/>
                        </h:panelGroup>
                        <!-- ==================== Input Filed for [Division Code] --END  -- ========================= -->                      

                        <t:outputLabel for="Graphics" value="Graphics:" />
                        <h:panelGroup>
                            <h:selectOneMenu id="Graphics" styleClass="FOX_INPUT" required="false" value="#{foxyOrder.graphicTypeCode}">
                                <f:selectItems value="#{listData.graphicTypeList}"/>
                            </h:selectOneMenu>
                            <h:message errorClass="FOX_ERROR" for="Graphics" showDetail="true" showSummary="true"/>
                        </h:panelGroup>                         

                        <t:outputLabel for="Colouring" value="Colouring:" />
                        <h:panelGroup>
                            <h:selectOneMenu id="Colouring" styleClass="FOX_INPUT" required="false" value="#{foxyOrder.colourTypeCode}">
                                <f:selectItems value="#{listData.colourTypeList}"/>
                            </h:selectOneMenu>
                            <h:message errorClass="FOX_ERROR" for="Colouring" showDetail="true" showSummary="true"/>
                        </h:panelGroup> 


                        <t:outputLabel for="DailyCap" value="DailyCap/worker(dz/cm):" />                    
                        <h:panelGroup>
                            <h:inputText id="DailyCap" styleClass="FOX_INPUT" size="10" required="false" value="#{foxyOrder.dailyCap}">
                            </h:inputText>
                            <h:message errorClass="FOX_ERROR" for="DailyCap" showDetail="true" showSummary="true"/>
                        </h:panelGroup>

                        <t:outputLabel for="Horizontal" value="Horizontal(cm):" />
                        <h:panelGroup>
                            <h:panelGroup>
                                <h:inputText id="Horizontal" styleClass="FOX_INPUT" size="10" required="false" value="#{foxyOrder.horizontal}">
                                </h:inputText>
                                <h:message errorClass="FOX_ERROR" for="Horizontal" showDetail="true" showSummary="true"/>
                            </h:panelGroup>
                        </h:panelGroup>  

                        <t:outputLabel for="Vertical" value="Vertical(cm):" />
                        <h:panelGroup>
                            <h:panelGroup>
                                <h:inputText id="Vertical" styleClass="FOX_INPUT" size="10" required="false" value="#{foxyOrder.vertical}">
                                </h:inputText>
                                <h:message errorClass="FOX_ERROR" for="Vertical" showDetail="true" showSummary="true"/>
                            </h:panelGroup>
                        </h:panelGroup>  

                        <t:outputLabel for="QuotaUom" value="Quota UOM:" />                    
                        <h:panelGroup>
                            <h:selectOneMenu id="QuotaUom" styleClass="FOX_INPUT" required="false" value="#{foxyOrder.quotaUom}">
                                <f:selectItems value="#{listData.unitList}"/>
                            </h:selectOneMenu>
                            <h:message errorClass="FOX_ERROR" for="QuotaUom" showDetail="true" showSummary="true"/>
                        </h:panelGroup>  

                        <t:outputLabel for="QuantityUom" value="Quantity UOM:" />                    
                        <h:panelGroup>
                            <h:selectOneMenu id="QuantityUom" styleClass="FOX_INPUT" required="false" value="#{foxyOrder.uom}">
                                <f:selectItems value="#{listData.unitList}"/>
                            </h:selectOneMenu>
                            <h:message errorClass="FOX_ERROR" for="QuantityUom" showDetail="true" showSummary="true"/>
                        </h:panelGroup>  

                        <t:outputLabel for="costBasicTrim" value="Cost Basic Trim:" />
                        <h:panelGroup>
                            <h:panelGroup>
                                <h:inputText id="costBasicTrim" styleClass="FOX_INPUT" size="10" required="false" value="#{foxyOrder.costBasicTrim}">
                                </h:inputText>
                                <h:message errorClass="FOX_ERROR" for="costBasicTrim" showDetail="true" showSummary="true"/>
                            </h:panelGroup>
                        </h:panelGroup>  

                        <t:outputLabel for="costAddTrim" value="Cost Add Trim:" />
                        <h:panelGroup>
                            <h:panelGroup>
                                <h:inputText id="costAddTrim" styleClass="FOX_INPUT" size="10" required="false" value="#{foxyOrder.costAddTrim}">
                                </h:inputText>
                                <h:message errorClass="FOX_ERROR" for="costAddTrim" showDetail="true" showSummary="true"/>
                            </h:panelGroup>
                        </h:panelGroup>  

                        <t:outputLabel for="ftyTrim" value="Factory Trim:" />
                        <h:panelGroup>
                            <h:panelGroup>
                                <h:inputText id="ftyTrim" styleClass="FOX_INPUT" size="10" required="false" value="#{foxyOrder.ftyTrim}">
                                </h:inputText>
                                <h:message errorClass="FOX_ERROR" for="ftyTrim" showDetail="true" showSummary="true"/>
                            </h:panelGroup>
                        </h:panelGroup>  

                        <t:outputLabel for="actualOutput" value="Actual Output(/dz):" />
                        <h:panelGroup>
                            <h:panelGroup>
                                <h:inputText id="actualOutput" styleClass="FOX_INPUT" size="10" required="false" value="#{foxyOrder.actualOutput}">
                                </h:inputText>
                                <h:message errorClass="FOX_ERROR" for="actualOutput" showDetail="true" showSummary="true"/>
                            </h:panelGroup>
                        </h:panelGroup>  

                        <t:outputLabel for="actualCm" value="Actual CMT:" />
                        <h:panelGroup>
                            <h:panelGroup>
                                <h:inputText id="actualCm" styleClass="FOX_INPUT" size="10" required="false" value="#{foxyOrder.actualCm}">
                                </h:inputText>
                                <h:message errorClass="FOX_ERROR" for="actualCm" showDetail="true" showSummary="true"/>
                            </h:panelGroup>
                        </h:panelGroup>  

                        <t:outputLabel for="actualTrim" value="Actual Trim:" />
                        <h:panelGroup>
                            <h:panelGroup>
                                <h:inputText id="actualTrim" styleClass="FOX_INPUT" size="10" required="false" value="#{foxyOrder.actualTrim}">
                                </h:inputText>
                                <h:message errorClass="FOX_ERROR" for="actualTrim" showDetail="true" showSummary="true"/>
                            </h:panelGroup>
                        </h:panelGroup>  

                        <t:outputLabel for="SpecialWash" value="Special Wash Cost:" />
                        <h:panelGroup>
                            <h:inputTextarea id="SpecialWash" rows="3" cols="30" styleClass="FOX_INPUT" required="false" value="#{foxyOrder.swash}"/>
                            <h:message errorClass="FOX_ERROR" for="SpecialWash" showDetail="true" showSummary="true"/>
                        </h:panelGroup>                                                                                                        

                        <t:outputLabel for="Wash" value="Wash:" />
                        <h:panelGroup>
                            <h:inputTextarea id="Wash" rows="3" cols="30" styleClass="FOX_INPUT" required="false" value="#{foxyOrder.wash}"/>
                            <h:message errorClass="FOX_ERROR" for="Wash" showDetail="true" showSummary="true"/>
                        </h:panelGroup>                            

                    </h:panelGrid>
                    <%-- End of column 1 --%>

                    <%-- START of column 2 --%>
                    <h:panelGrid id="UpdAddInput1_2" columns="2" columnClasses="FOX_LABEL_COL_2, FOX_INPUT_COL_2" width="100%">

                        <t:outputLabel for="FabricPrice" value="Fabric Price:" />
                        <h:panelGroup>
                            <h:inputTextarea id="FabricPrice" rows="3" cols="30" styleClass="FOX_INPUT" required="false" value="#{foxyOrder.fabricPrice}"/>
                            <h:message errorClass="FOX_ERROR" for="FabricPrice" showDetail="true" showSummary="true"/>
                        </h:panelGroup>  

                        <t:outputLabel for="Fabrication" value="Fabrication:" />
                        <h:panelGroup>
                            <h:inputTextarea id="Fabrication" rows="3" cols="30" styleClass="FOX_INPUT" required="false" value="#{foxyOrder.fabrication}"/>
                            <h:message errorClass="FOX_ERROR" for="Fabrication" showDetail="true" showSummary="true"/>
                        </h:panelGroup>                                                                              

                        <t:outputLabel for="FabricType" value="FabricType:" />
                        <h:panelGroup>
                            <h:inputTextarea id="FabricType" rows="1" cols="30" styleClass="FOX_INPUT" required="true" value="#{foxyOrder.fabricType}"/>
                            <h:message errorClass="FOX_ERROR" for="FabricType" showDetail="true" showSummary="true"/>
                        </h:panelGroup>                                                                              

                        <t:outputLabel for="FabricMill" value="Fabric Mill:" />
                        <h:panelGroup>
                            <h:inputTextarea id="FabricMill" rows="3" cols="30" styleClass="FOX_INPUT" required="false" value="#{foxyOrder.fabricMill}"/>
                            <h:message errorClass="FOX_ERROR" for="FabricMill" showDetail="true" showSummary="true"/>
                        </h:panelGroup>                        


                        <t:outputLabel for="FabricYYDZ" value="Fabric YY/DZ:" />
                        <h:panelGroup>
                            <h:inputTextarea id="FabricYYDZ" rows="3" cols="30" styleClass="FOX_INPUT" required="true" value="#{foxyOrder.fabricYyDz}"/>
                            <h:message errorClass="FOX_ERROR" for="FabricYYDZ" showDetail="true" showSummary="true"/>
                        </h:panelGroup>                        

                        <t:outputLabel for="GraphicCost" value="Graphic Cost:" />
                        <h:panelGroup>
                            <h:inputTextarea id="GraphicCost" rows="3" cols="30" styleClass="FOX_INPUT" required="false" value="#{foxyOrder.gcost}"/>
                            <h:message errorClass="FOX_ERROR" for="GraphicCost" showDetail="true" showSummary="true"/>
                        </h:panelGroup>                                                                

                        <t:outputLabel for="Description" value="Description:" />
                        <h:panelGroup>
                            <h:inputTextarea rows="10" cols="30" id="Description" styleClass="FOX_INPUT" required="false" value="#{foxyOrder.description}">
                            </h:inputTextarea>
                            <h:message errorClass="FOX_ERROR" for="Description" showDetail="true" showSummary="true"/>
                        </h:panelGroup>                                                

                        <t:outputLabel for="Cost_CM" value="Costing CMT:" />
                        <h:panelGroup>
                            <h:inputText id="Cost_CM" styleClass="FOX_INPUT" size="10" required="false" value="#{foxyOrder.costCm}"/>
                            <h:message errorClass="FOX_ERROR" for="Cost_CM" showDetail="true" showSummary="true"/>
                        </h:panelGroup>    

                        <t:outputLabel for="Fty_CM" value="Factory CMT:" />
                        <h:panelGroup>
                            <h:inputText id="Fty_CM" styleClass="FOX_INPUT"  size="10" required="false" value="#{foxyOrder.ftyCm}"/>
                            <h:message errorClass="FOX_ERROR" for="Fty_CM" showDetail="true" showSummary="true"/>
                        </h:panelGroup>  

                        <t:outputLabel for="Fty_CMT_Remark" value="FTY CMT Remark:" />
                        <h:panelGroup>
                            <h:inputTextarea rows="10" cols="30" id="Fty_CMT_Remark" styleClass="FOX_INPUT" required="false" value="#{foxyOrder.ftyRemark}">
                            </h:inputTextarea>
                            <h:message errorClass="FOX_ERROR" for="Fty_CMT_Remark" showDetail="true" showSummary="true"/>
                        </h:panelGroup>                        

                        <t:outputLabel for="Remark_Factory" value="Remark (Factory):" />
                        <h:panelGroup>
                            <h:inputTextarea rows="10" cols="30" id="Remark_Factory" styleClass="FOX_INPUT" required="false" value="#{foxyOrder.remark}">
                            </h:inputTextarea>
                            <h:message errorClass="FOX_ERROR" for="Remark_Factory" showDetail="true" showSummary="true"/>
                        </h:panelGroup>
                        <t:outputLabel for="Remark_Marketing" value="Remark (Marketing):" />
                        <h:panelGroup>
                            <h:inputTextarea rows="10" cols="30" id="Remark_Marketing" styleClass="FOX_INPUT" required="false" value="#{foxyOrder.remarkMarketing}">
                            </h:inputTextarea>
                            <h:message errorClass="FOX_ERROR" for="Remark_Marketing" showDetail="true" showSummary="true"/>
                        </h:panelGroup>

                    </h:panelGrid>
                    <%-- End of column 2 --%>                    
                </h:panelGrid>


                <h:panelGrid id="AddButton" columns="1" columnClasses="FOX_BUTTON" width="50%">
                    <h:panelGroup>
                        <h:commandButton id="Save" value="Save" action="#{foxyOrder.save}" rendered="#{foxyOrder.add}"
                                         onclick="if(!confirm('Please double check to ensure you have selected year and Main Factory correctly')) return false"/>
                        <h:commandButton id="Update" value="Save" action="#{foxyOrder.save}" rendered="#{foxyOrder.update}"/>
                        <h:outputText value=" " />                    
                        <h:commandButton id="Reset" value="Reset" type="reset">
                        </h:commandButton>
                    </h:panelGroup>
                </h:panelGrid>
            </h:panelGrid>
        </h:form>
    </h:panelGrid>            
    <%-- End of Update & Add --%>

    <%@ include file="foxyFooter.jsp" %>
</f:view>
