<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<%@taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@taglib uri="https://ajax4jsf.dev.java.net/ajax" prefix="a4j"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<f:view>
    <%@ include file="foxyHeader.jsp" %>

    <%-- Panel for Search --%>
    <%-- h:panelGrid id="SearchGrid" styleClass="tablebg" width="100%" rendered="#{foxyCMTRpt.search}" --%>
    <h:panelGrid id="SearchGrid" styleClass="tablebg" width="100%"  rendered="#{not foxyCMTRpt.list}">
        <h:outputText value="CMT Ad-Hoc Report" styleClass="smalltitle" />
        <%--h:form id="SearchForm" rendered="#{foxyCMTRpt.search}" --%>

        <h:form id="SearchForm">
            <t:saveState value="#{foxyCMTRpt.country}"/>
            <t:saveState value="#{foxyCMTRpt.mainfactory}"/>
            <t:saveState value="#{foxyCMTRpt.custCode}"/>
            <t:saveState value="#{foxyCMTRpt.custDivision}"/>
            <t:saveState value="#{foxyCMTRpt.brand}"/>
            <t:saveState value="#{foxyCMTRpt.cnameCode}"/>

            <h:outputText value="To ignore filter from search, leave it to blank/default value" styleClass="FOX_HELPMSG"/>            

            <h:panelGrid id="SearchInput" columns="2" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="50%">                        

                <!-- ==================== Input Filed for [Company Name] --START-- ========================= -->
                <t:outputLabel for="CName" value="Company Name:" />
                <h:panelGroup >
                    <h:selectOneMenu id="CName" value="#{foxyCMTRpt.cnameCode}" styleClass="FOX_INPUT" required="true" immediate="false">
                        <f:selectItems value="#{listData.companyNameListAll}"/>                                  
                    </h:selectOneMenu>
                    <h:message errorClass="FOX_ERROR" for="CName" showDetail="true" showSummary="true"/>
                </h:panelGroup>
                <!-- ==================== Input Filed for [Company Name] --END  -- ========================= -->                

                <t:outputLabel value="Country Origin:" for="Country"/>
                <h:panelGroup>
                    <a4j:region id="ajaxregioncountryfactory" renderRegionOnly="false" selfRendered="true">
                        <h:selectOneMenu id="Country" styleClass="FOX_INPUT" 
                                         required="true" 
                                         immediate="true"
                                         value="#{foxyCMTRpt.country}">
                            <f:selectItems value="#{listData.countryViewList}"/>
                            <a4j:support event="onchange"  
                                         reRender="factory" ajaxSingle="true">
                            </a4j:support>
                        </h:selectOneMenu>
                    </a4j:region>
                    <h:message errorClass="FOX_ERROR" for="Country" showDetail="true" showSummary="true"/>
                </h:panelGroup>      

                <t:outputLabel value="Main Factory:" for="factory"/>
                <h:panelGroup>
                    <h:selectOneMenu id="factory" styleClass="FOX_INPUT" 
                                     required="true" 
                                     immediate="true"
                                     value="#{foxyCMTRpt.mainfactory}">
                        <f:selectItems value="#{foxyCMTRpt.factoryByCountryList}"/>
                    </h:selectOneMenu>
                    <a4j:status for="ajaxregioncountryfactory">
                        <f:facet name="start">
                            <h:graphicImage value="/images/ajaxstart.gif"  height="12" width="12"/>
                        </f:facet>
                        <f:facet name="stop">
                            <%-- h:graphicImage value="/images/ajax_stoped.gif" / --%>
                        </f:facet>
                    </a4j:status>
                    <h:message errorClass="FOX_ERROR" for="factory" showDetail="true" showSummary="true"/>
                </h:panelGroup>                  

                <t:outputLabel value="Customer:" for="CustomerCode"/>
                <h:panelGroup>
                    <a4j:region id="ajaxregion1" renderRegionOnly="false" selfRendered="true">
                        <h:selectOneMenu id="CustomerCode" styleClass="FOX_INPUT" value="#{foxyCMTRpt.custCode}"
                                         style="width:220px; " required="false" immediate="true"> 
                            <f:selectItems value="#{listData.customerList}"/>                            
                            <a4j:support event="onchange"  
                                         reRender="BrandCode,CustomerDivision" ajaxSingle="true">
                            </a4j:support>
                        </h:selectOneMenu>
                    </a4j:region>
                    <h:message errorClass="FOX_ERROR" for="CustomerCode" showDetail="true" showSummary="true"/>
                </h:panelGroup>

                <t:outputLabel for="BrandCode" value="Customer's Brand:" />
                <h:panelGroup>
                    <a4j:region id="ajaxregion2" renderRegionOnly="false" selfRendered="true">
                        <h:selectOneMenu id="BrandCode" styleClass="FOX_INPUT" value="#{foxyCMTRpt.brand}"
                                         style="width:220px; "  required="false" immediate="true"> 
                            <f:selectItems value="#{foxyCMTRpt.brandItemsList}"/>
                            <a4j:support event="onchange"  
                                         reRender="CustomerDivision" ajaxSingle="true">
                            </a4j:support>                                                    
                        </h:selectOneMenu>
                    </a4j:region>
                    <a4j:status for="ajaxregion1">
                        <f:facet name="start">
                            <h:graphicImage value="/images/ajaxstart.gif"  height="12" width="12"/>
                        </f:facet>
                        <f:facet name="stop">
                            <%-- h:graphicImage value="/images/ajax_stoped.gif" / --%>
                        </f:facet>
                    </a4j:status>
                    <h:message errorClass="FOX_ERROR" for="BrandCode" showDetail="true" showSummary="true"/>
                </h:panelGroup>


                <t:outputLabel value="Customer Division:" for="CustomerDivision"/>
                <h:panelGroup>                              
                    <h:selectOneMenu id="CustomerDivision" styleClass="FOX_INPUT" value="#{foxyCMTRpt.custDivision}"
                                     style="width:220px; " required="false" immediate="true"> 
                        <f:selectItems value="#{foxyCMTRpt.divisionItemsList}"/>
                    </h:selectOneMenu>                    
                    <a4j:status for="ajaxregion2">
                        <f:facet name="start">
                            <h:graphicImage value="/images/ajaxstart.gif" height="12" width="12"/>
                        </f:facet>
                        <f:facet name="stop">
                            <%-- h:graphicImage value="/images/ajax_stoped.gif" / --%>
                        </f:facet>
                    </a4j:status>                    

                    <h:message errorClass="FOX_ERROR" for="CustomerDivision" showDetail="true" showSummary="true"/>
                </h:panelGroup>                                


                <t:outputLabel for="Season" value="Season:" />
                <h:panelGroup>
                    <h:selectOneMenu id="Season" styleClass="FOX_INPUT" required="false" value="#{foxyCMTRpt.season}">
                        <f:selectItems value="#{listData.seasonList}"/>
                    </h:selectOneMenu>
                    <h:message errorClass="FOX_ERROR" for="Season" showDetail="true" showSummary="true"/>
                </h:panelGroup>                  

                <t:outputLabel for="Graphics" value="Graphics:" />
                <h:panelGroup>
                    <h:selectOneMenu id="Graphics" styleClass="FOX_INPUT" required="false" value="#{foxyCMTRpt.graphicTypeCode}">
                        <f:selectItems value="#{listData.graphicTypeList}"/>
                    </h:selectOneMenu>
                    <h:message errorClass="FOX_ERROR" for="Graphics" showDetail="true" showSummary="true"/>
                </h:panelGroup> 

                <t:outputLabel for="Colouring" value="Colouring" />
                <h:panelGroup>
                    <h:selectOneMenu id="Colouring" styleClass="FOX_INPUT" required="false" value="#{foxyCMTRpt.colourTypeCode}">
                        <f:selectItems value="#{listData.colourTypeList}"/>
                    </h:selectOneMenu>
                    <h:message errorClass="FOX_ERROR" for="Colouring" showDetail="true" showSummary="true"/>
                </h:panelGroup> 

                <t:outputLabel for="FromDate" value="Delivery Date From:" />
                <h:panelGroup>
                    <t:inputCalendar id="FromDate" styleClass="FOX_INPUT" value="#{foxyCMTRpt.fromDate}"  
                                     required="true" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                                     helpText="YYYYMMDD"/>    
                    <h:message errorClass="FOX_ERROR" for="FromDate" showDetail="true" showSummary="true"/>
                </h:panelGroup>                        

                <t:outputLabel for="ToDate" value="To Date:" />
                <h:panelGroup>
                    <t:inputCalendar id="ToDate" styleClass="FOX_INPUT" value="#{foxyCMTRpt.toDate}"  
                                     required="true" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                                     helpText="YYYYMMDD" />    
                    <h:message errorClass="FOX_ERROR" for="ToDate" showDetail="true" showSummary="true"/>
                </h:panelGroup>

                <t:outputLabel value="Updated By:" for="UpdUserId"/>
                <h:panelGroup>                              
                    <h:selectOneMenu id="UpdUserId" styleClass="FOX_INPUT" value="#{foxyCMTRpt.userid}"
                                     style="width:220px; " required="false" immediate="true"> 
                        <f:selectItems value="#{foxyCMTRpt.userItemsList}"/>
                    </h:selectOneMenu>                    
                    <h:message errorClass="FOX_ERROR" for="UpdUserId" showDetail="true" showSummary="true"/>
                </h:panelGroup>                                

                <h:commandButton id="Submit"  value="Submit" action="#{foxyCMTRpt.search}"/>
                <h:commandButton id="getXLSX" value="Extract Excel XLSX" action="#{foxyCMTRpt.CustSalesListModelXLSX}">

                </h:commandButton>
            </h:panelGrid>
        </h:form>
    </h:panelGrid>
    <%-- End of Search--%>

    <%-- Panel for Listing --%>
    <h:panelGrid id="ListOrderGrid" styleClass="tablebg" rendered="#{foxyCMTRpt.list}" width="100%">        
        <h:form id="ListReportForm">
            <h:panelGrid id="Top" columns="1" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="100%">

                <h:outputText value="Ad-Hoc CMT Report #{foxyCMTRpt.title}" styleClass="smalltitle" />
            </h:panelGrid>
            <h:panelGrid id="ListDisplay" columns="1" width="100%">
                <t:dataTable value="#{foxyCMTRpt.custSalesListModel}" var="custOrder"
                             id="DetailData"
                             styleClass="FOXY_REPORT_1"
                             headerClass="FOXY_REPORT_HEADER_1"
                             footerClass="FOXY_REPORT_HEADER_1"                    
                             preserveDataModel="false"
                             cellspacing="0"
                             rowClasses="FOXY_REPORT_ROW_1,FOXY_REPORT_ROW_2">
                    <%--rowClasses="FoxyOddRow,FoxyEvenRow"--%>

                    <f:facet name="footer">
                        <h:outputText value="End of Record(s)" styleClass="FOX_HELPMSG"/>
                    </f:facet>                      

                    <t:column groupBy="true" width="8%">
                        <f:facet name="header">
                            <h:outputText value="Ref No" />
                        </f:facet>
                        <h:outputText value="#{custOrder.refNo}#{custOrder.month}#{custOrder.location}" />
                    </t:column>                   

                    <t:column width="10%">
                        <f:facet name="header">
                            <h:outputText value="Fabric Del"/>
                        </f:facet>
                        <h:outputText value="#{custOrder.fabricDeliveryDate}">
                            <f:convertDateTime type="date" pattern="yyyy-MM-dd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                        </h:outputText>
                    </t:column>                    

                    <t:column width="10%">
                        <f:facet name="header">
                            <h:outputText value="Company"/>
                        </f:facet>
                        <h:outputText value="#{custOrder.cnameshort}" />
                    </t:column> 

                    <t:column width="10%">
                        <f:facet name="header">
                            <h:outputText value="Customer" />
                        </f:facet>
                        <h:outputText styleClass="FOXY_REPORT_GRAND_TOTAL"  value="#{custOrder.customer}" rendered="#{custOrder.brand == null}" />
                        <h:outputText value="#{custOrder.customer}" rendered="#{custOrder.brand != null}" />
                    </t:column>                                                            

                    <t:column width="10%">
                        <f:facet name="header">
                            <h:outputText value="Brand" />
                        </f:facet>
                        <h:outputText value="#{custOrder.brand}" />
                    </t:column>                                        

                    <t:column width="8%">
                        <f:facet name="header">
                            <h:outputText value="Division" />
                        </f:facet>
                        <h:outputText value="#{custOrder.division}" />
                    </t:column>

                    <t:column width="8%">
                        <f:facet name="header">
                            <h:outputText value="Season" />
                        </f:facet>
                        <h:outputText value="#{custOrder.season}" />
                    </t:column>


                    <t:column width="10%">
                        <f:facet name="header">
                            <h:outputText value="Delivery Date"/>
                        </f:facet>
                        <h:outputText value="#{custOrder.deliveryDate}">
                            <f:convertDateTime type="date" pattern="yyyy-MM-dd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                        </h:outputText>
                    </t:column>                   


                    <t:column width="8%">
                        <f:facet name="header">
                            <h:outputText value="Style" />
                        </f:facet>
                        <h:outputText value="#{custOrder.style}" />
                    </t:column>    

                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="Unit Price" />
                            </h:panelGrid>
                        </f:facet>
                        <h:outputText value="#{custOrder.unitPrice}" rendered="#{custOrder.brand != null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>

                        <h:outputText styleClass="FOXY_REPORT_GRAND_TOTAL"  value="#{custOrder.unitPrice}" rendered="#{custOrder.brand == null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>                                                    

                    </t:column>

                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="Qty (Dzn)" />
                            </h:panelGrid>
                        </f:facet>
                        <h:outputText value="#{custOrder.qtyd}" rendered="#{custOrder.brand != null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>
                        <h:outputText styleClass="FOXY_REPORT_GRAND_TOTAL"  value="#{custOrder.qtyd}" rendered="#{custOrder.brand == null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>                                                    
                    </t:column>

                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="Qty (pcs)" />
                            </h:panelGrid>
                        </f:facet>
                        <h:outputText value="#{custOrder.qtyp}" rendered="#{custOrder.brand != null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>                            
                        <h:outputText styleClass="FOXY_REPORT_GRAND_TOTAL"  value="#{custOrder.qtyp}" rendered="#{custOrder.brand == null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>                            
                    </t:column>

                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="CostCMT" />
                            </h:panelGrid>
                        </f:facet>
                        <h:outputText value="#{custOrder.costcmt}" rendered="#{custOrder.brand != null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>                            
                        <h:outputText styleClass="FOXY_REPORT_GRAND_TOTAL"  value="#{custOrder.costcmt}" rendered="#{custOrder.brand == null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>                            
                    </t:column>

                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="CostCMT_Tot" />
                            </h:panelGrid>
                        </f:facet>
                        <h:outputText value="#{custOrder.costcmtTotalValue}" rendered="#{custOrder.brand != null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>                            
                        <h:outputText styleClass="FOXY_REPORT_GRAND_TOTAL"  value="#{custOrder.costcmtTotalValue}" rendered="#{custOrder.brand == null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>                            
                    </t:column>                    

                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="FtyCMT" />
                            </h:panelGrid>
                        </f:facet>
                        <h:outputText value="#{custOrder.ftycmt}" rendered="#{custOrder.brand != null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>                            
                        <h:outputText styleClass="FOXY_REPORT_GRAND_TOTAL"  value="#{custOrder.ftycmt}" rendered="#{custOrder.brand == null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>                            
                    </t:column>

                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="FtyCMT_Tot" />
                            </h:panelGrid>
                        </f:facet>
                        <h:outputText value="#{custOrder.ftycmtTotalValue}" rendered="#{custOrder.brand != null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>                            
                        <h:outputText styleClass="FOXY_REPORT_GRAND_TOTAL"  value="#{custOrder.ftycmtTotalValue}" rendered="#{custOrder.brand == null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>                            
                    </t:column>                    


                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="Total Value" />
                            </h:panelGrid>
                        </f:facet>
                        <h:outputText value="#{custOrder.totalValue}" rendered="#{custOrder.brand != null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>                            
                        <h:outputText styleClass="FOXY_REPORT_GRAND_TOTAL"  value="#{custOrder.totalValue}" rendered="#{custOrder.brand == null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>                            
                    </t:column>

                    <t:column width="12%">
                        <f:facet name="header">
                            <h:outputText value="Description" />
                        </f:facet>
                        <h:outputText value="#{custOrder.desc}" />
                    </t:column>

                    <t:column width="8%">
                        <f:facet name="header">
                            <h:outputText value="ColourType" />
                        </f:facet>
                        <h:outputText value="#{custOrder.colourType}" />
                    </t:column> 

                    <t:column width="8%">
                        <f:facet name="header">
                            <h:outputText value="GraphicType" />
                        </f:facet>
                        <h:outputText value="#{custOrder.graphicType}" />
                    </t:column>                     

                </t:dataTable>                           
            </h:panelGrid>
        </h:form>
    </h:panelGrid>            
    <%-- End of Listing--%>

    <%@ include file="foxyFooter.jsp" %>
</f:view>
