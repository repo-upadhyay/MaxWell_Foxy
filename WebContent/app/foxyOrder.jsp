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
    <h:panelGrid id="UpdAddGrid" styleClass="tablebg" rendered="#{foxyOrder.updAdd}" width="100%">
        <%-- Title for Update --%>
        <h:panelGroup rendered="#{foxyOrder.update}">
            <h:outputText value="Update Order " styleClass="smalltitle"/>
            <h:outputText value="#{foxyOrder.recordStamp}" styleClass="FOX_RECSTAMP"/>
        </h:panelGroup>
        <%-- Title for Add --%>
        <h:outputText value="Add Order" styleClass="smalltitle" rendered="#{foxyOrder.add}"/>
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
                            <h:inputTextarea rows="3" cols="30" id="Description" styleClass="FOX_INPUT" required="false" value="#{foxyOrder.description}">
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
                    <h:inputTextarea rows="10" cols="50" id="Description" styleClass="FOX_INPUT_RO" value="#{foxyOrder.description}" readonly="true"/>


                </h:panelGrid>
                <%-- END column 2 --%>
            </h:panelGrid>


            <h:panelGrid id="AddButton" columns="1" columnClasses="FOX_BUTTON" width="100%">
                <h:panelGroup>
                    <h:commandButton id="Edit" value="Edit" action="#{foxyOrder.edit}"/>
                    <h:outputText value=" " />
                    <h:commandButton id="Delete" value="Delete" action="#{foxyOrder.delete}" disabled="false"
                                     onclick="if(!confirm('Are you sure want to delete this record?')) return false"/>
                    <%--h:outputText value=" " />
                    <h:commandButton id="OrderInstruction" value="Lot Entry" action="#{foxyOrder.orderInstruction}"/>
                    <h:outputText value=" " />
                    <h:commandButton id="OrderPO" value="M.R. Entry" action="#{foxyOrder.poEntry}"/>                    
                    <h:outputText value=" " />
                    <h:commandButton id="Shipping" value="Shipping Entry" action="#{foxyOrder.shipEntry}"/--%>                    
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

    <%-- Panel for Search --%>
    <h:panelGrid id="SearchGrid" styleClass="tablebg" rendered="#{foxyOrder.search}" width="100%">
        <h:outputText value="Search Order" styleClass="smalltitle" />
        <h:form id="SearchForm" rendered="#{foxyOrder.search}">
            <h:outputText value="Please key in partial or full search key to search record(s)" styleClass="FOX_HELPMSG" rendered="#{not foxyOrder.list}"/>
            <h:panelGrid id="SearchInput" columns="2" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="50%">

                <t:outputLabel for="SearchKey" value="Search Key:" />               
                <h:panelGroup>
                    <h:inputHidden id="action" value="SEARCH"/>
                    <h:inputText id="SearchKey" styleClass="FOX_INPUT" 
                                 maxlength="9" size="20" required="true" 
                                 value="#{foxyOrder.searchKey}">
                    </h:inputText>
                    <h:outputText value=" " />
                    <%--h:commandButton id="action"  value="#{foxyOrder.action}" action="#{foxyOrder.search}"/--%>
                    <h:commandButton id="Search"  value="Search" action="#{foxyOrder.search}"/>
                </h:panelGroup>
                <h:outputText value="Type " />
                <h:selectOneRadio id="searchType" value="#{foxyOrder.searchType}">
                    <f:selectItems value="#{foxyOrder.searchTypes}"/>
                </h:selectOneRadio>                
            </h:panelGrid>
        </h:form>
    </h:panelGrid>
    <%-- End of Search--%>

    <%-- Panel for List --%>
    <h:panelGrid id="ListOrderGrid" styleClass="tablebg" rendered="#{foxyOrder.list}" width="100%">
        <h:outputText value="List Order" styleClass="smalltitle" />                
        <h:form id="ListOrderForm" rendered="#{foxyOrder.list}">        
            <h:panelGrid id="SearchInput" columns="2" rendered="#{foxyOrder.list}" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="50%">                       
                <h:outputText value="Search Key:" />               
                <h:panelGroup>
                    <h:inputText id="SearchKey" styleClass="FOX_INPUT_RO" 
                                 maxlength="9" size="20" required="true" 
                                 value="#{foxyOrder.searchKey}" readonly="true">
                    </h:inputText>
                    <h:outputText value=" " />
                    <h:commandButton id="Search" value="Search" action="#{foxyOrder.search}" disabled="true"/>
                </h:panelGroup>
                <h:outputText value="Type " />
                <h:selectOneRadio id="searchType" required="true" value="#{foxyOrder.searchType}"  readonly="true">
                    <f:selectItems value="#{foxyOrder.searchTypes}"/>
                </h:selectOneRadio>            
            </h:panelGrid>

            <!-- Report List -->            
            <%--h:panelGroup id="body"--%>
            <h:panelGrid id="ListDisplay" columns="1" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="100%">    
                <h:inputHidden id="action" value="LIST"/>
                <t:dataTable id="SearchList"
                             binding="#{foxyOrder.foxyTable}"
                             styleClass="scrollerTable"
                             headerClass="FOXY_ORDER_DETAIL_HEADER"
                             footerClass="FOXY_ORDER_DETAIL_HEADER"
                             rowClasses="standardTable_Row1,standardTable_Row2"
                             columnClasses="standardTable_Column,standardTable_ColumnCentered,standardTable_Column"
                             var="order"
                             value="#{foxyOrder.orderList}"
                             preserveDataModel="true"
                             rows="20"
                             rendered="#{foxyOrder.list}">
                    <h:column rendered="#{not foxySessionData.invShortCut}">
                        <f:facet name="header">
                            <h:outputText value="Order Id" />
                        </f:facet>
                        <h:commandLink id="links" 
                                       value="#{order.orderId}"
                                       action="#{foxyOrder.enquire}">
                            <f:param name="recordid" value="#{order.orderId}"/>
                        </h:commandLink>
                    </h:column>

                    <h:column rendered="#{foxySessionData.invShortCut}">
                        <f:facet name="header">
                            <h:outputText value="Order Id" />
                        </f:facet>
                        <h:commandLink id="links" 
                                       value="#{order.orderId}"
                                       action="#{foxyOrder.costingInfo}">
                            <f:param name="recordid" value="#{order.orderId}"/>
                        </h:commandLink>
                    </h:column>                    

                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="Company Name Short" />
                        </f:facet>
                        <h:outputText value="#{order.companyNameShort}" />
                    </h:column>

                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="Order Date"/>
                        </f:facet>
                        <h:outputText value="#{order.orderDate}">
                            <f:convertDateTime type="date" pattern="yyyy-MM-dd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                        </h:outputText>
                    </h:column>

                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="Style Code" />
                        </f:facet>
                        <h:outputText value="#{order.styleCode}" />
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="Season" />
                        </f:facet>
                        <h:outputText value="#{order.season}" />
                    </h:column>

                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="Cust Name" />
                        </f:facet>
                        <h:outputText value="#{order.custName}" />
                    </h:column>                    

                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="Brand Code" />
                        </f:facet>
                        <h:outputText value="#{order.custBrand}" />
                    </h:column>

                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="Division Code" />
                        </f:facet>
                        <h:outputText value="#{order.custDivision}" />
                    </h:column>

                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="Download OCF" />
                        </f:facet>

                        <h:commandLink id="downloadOCFLink" action="#{foxyOrder.downloadOrderConfirmationForm}"
                                       value="OCF-#{order.orderId}" immediate="true">
                            <t:updateActionListener property="#{foxySessionData.pageParameter}" value="#{order.orderId}"/>
                        </h:commandLink>                         
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="Image File" />
                        </f:facet>

                        <h:commandLink id="editImageLink" action="#{foxyOrder.uploadImage}"
                                       value="#{order.imgFileLink}" immediate="true">
                            <t:updateActionListener property="#{foxySessionData.pageParameter}" value="#{order.orderId}"/>
                        </h:commandLink>                         
                    </h:column>

                </t:dataTable>

                <h:panelGrid columns="1" styleClass="scrollerTable2" columnClasses="standardTable_ColumnCentered" >
                    <t:dataScroller id="scroll_1"
                                    for="SearchList"
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
                                    for="SearchList"
                                    rowsCountVar="rowsCount"
                                    displayedRowsCountVar="displayedRowsCountVar"
                                    firstRowIndexVar="firstRowIndex"
                                    lastRowIndexVar="lastRowIndex"
                                    pageCountVar="pageCount"
                                    immediate="true"
                                    pageIndexVar="pageIndex"
                                    >
                        <h:outputFormat value="Total Rec {0}, DispayRowCount {1}, First row index {2}, last row index {3} pageindex {4}, pagecount {5}" styleClass="standard" >
                            <f:param value="#{rowsCount}" />
                            <f:param value="#{displayedRowsCountVar}" />
                            <f:param value="#{firstRowIndex}" />
                            <f:param value="#{lastRowIndex}" />
                            <f:param value="#{pageIndex}" />
                            <f:param value="#{pageCount}" />
                        </h:outputFormat>
                    </t:dataScroller>
                </h:panelGrid>

            </h:panelGrid>
        </h:form>
        <%-- End of Listing--%>

    </h:panelGrid>
    <%-- End of List --%>

    <%@ include file="foxyFooter.jsp" %>
</f:view>
