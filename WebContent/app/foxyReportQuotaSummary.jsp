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
    <%-- h:panelGrid id="SearchGrid" styleClass="tablebg" width="100%" rendered="#{foxyQuotaReports.search}" --%>
    <h:panelGrid id="SearchGrid" styleClass="tablebg" width="100%"  rendered="#{not foxyQuotaSummaryReports.list}">
        <h:outputText value="Quota Summary Report" styleClass="smalltitle" />
        <%--h:form id="SearchForm" rendered="#{foxyQuotaReports.search}" --%>
        <h:form id="SearchForm">
            <t:saveState value="#{foxyQuotaSummaryReports.country}"/>
            <t:saveState value="#{foxyQuotaSummaryReports.fromDate}"/>
            <t:saveState value="#{foxyQuotaSummaryReports.toDate}"/>
            
            <h:panelGrid id="SearchInput" columns="2" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="50%">                                        
                <t:outputLabel value="Country Origin:" for="Country"/>
                <h:panelGroup>
                    <a4j:region id="ajaxregion1" renderRegionOnly="false" selfRendered="true">
                        <h:selectOneMenu id="Country" styleClass="FOX_INPUT" 
                                         required="true" 
                                         immediate="true"
                                         value="#{foxyQuotaSummaryReports.country}">
                            <f:selectItems value="#{listData.countryList}"/>
                            <a4j:support event="onchange"  
                                         reRender="QuotaMast_Code" ajaxSingle="true">
                            </a4j:support>                                    
                        </h:selectOneMenu>
                    </a4j:region>
                    <h:message errorClass="FOX_ERROR" for="Country" showDetail="true" showSummary="true"/>
                </h:panelGroup>                                                                                              
                
                <t:outputLabel for="FromDate" value="Delivery Date From:" />
                <h:panelGroup>
                    <t:inputCalendar id="FromDate" styleClass="FOX_INPUT" value="#{foxyQuotaSummaryReports.fromDate}"  
                                     required="true" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                                     helpText="YYYYMMDD" />    
                    <h:message errorClass="FOX_ERROR" for="FromDate" showDetail="true" showSummary="true"/>
                </h:panelGroup>                        
                
                <t:outputLabel for="ToDate" value="To:" />
                <h:panelGroup>
                    <t:inputCalendar id="ToDate" styleClass="FOX_INPUT" value="#{foxyQuotaSummaryReports.toDate}"  
                                     required="true" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                                     helpText="YYYYMMDD" />
                    <h:message errorClass="FOX_ERROR" for="ToDate" showDetail="true" showSummary="true"/>
                </h:panelGroup>
                
                <h:commandButton id="Submit"  value="Submit" action="#{foxyQuotaSummaryReports.search}"/>
            </h:panelGrid>
        </h:form>
    </h:panelGrid>
    <%-- End of Search--%>
            
    <%-- Panel for Listing --%>
    <h:panelGrid id="ListOrderGrid" styleClass="tablebg" rendered="#{foxyQuotaSummaryReports.list}" width="100%">        
        <h:form id="ListReportForm">
            <h:panelGrid id="Top" columns="1" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="100%">
                
                <h:outputText value="Quota Summary Report for #{foxyQuotaSummaryReports.title}" styleClass="smalltitle" />
            </h:panelGrid>
            <h:panelGrid id="ListDisplay" columns="1" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="100%">
                <t:dataTable value="#{foxyQuotaSummaryReports.quotaSummaryReport}" var="listdata"
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
                    
                    <%--
                    <f:facet name="header">
                        <h:outputText value="aa" styleClass="FOX_HELPMSG"/>
                    </f:facet>                      
                    --%>
                    
                    <t:column width="8%">
                        <f:facet name="header">
                            <h:outputText value="quota" />
                        </f:facet>
                        <h:outputText value="#{listdata.quota}" />
                    </t:column>
                    
                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="[1] Tot Quota for"/>
                                <h:panelGroup>
                                    <h:outputText value="01/01-"/>
                                    <h:outputText value="#{foxyQuotaSummaryReports.fromDate}">
                                        <f:convertDateTime type="date" pattern="dd/MM" timeZone="#{foxyTimeZone.myTimeZone}"/>
                                    </h:outputText>
                                </h:panelGroup>                                
                            </h:panelGrid>
                        </f:facet>
                        <h:outputText value="#{listdata.avlQty}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>
                    </t:column>
                    
                    
                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGroup>
                                <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                             cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">                                                            
                                    <h:outputText value="[2]"/>
                                </h:panelGrid>
                                <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                             cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">                            
                                    <h:outputText value="BIQty"/>
                                </h:panelGrid>
                            </h:panelGroup>
                        </f:facet>
                        <h:outputText value="#{listdata.BIQty}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>
                    </t:column>
                    
                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGroup>
                                <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                             cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">                                                            
                                    <h:outputText value="[3]"/>
                                </h:panelGrid>
                                
                                <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                             cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                    <h:outputText value="TIQty"/>
                                </h:panelGrid>
                            </h:panelGroup>
                        </f:facet>
                        <h:outputText value="#{listdata.TIQty}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>
                    </t:column>
                    
                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGroup>
                                <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                             cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">                                                            
                                    <h:outputText value="[4]"/>
                                </h:panelGrid>
                                
                                <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                             cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                    <h:outputText value="TOQty"/>
                                </h:panelGrid>
                            </h:panelGroup>
                        </f:facet>
                        <h:outputText value="#{listdata.TOQty}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>
                    </t:column>                    
                    
                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGroup>
                                <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                             cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">                                                            
                                    <h:outputText value="[5]"/>
                                </h:panelGrid>
                                
                                <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                             cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                    <h:outputText value="Ostd Qty"/>
                                </h:panelGrid>
                            </h:panelGroup>
                        </f:facet>
                        <h:outputText value="#{listdata.oustQty}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>
                    </t:column>
                    
                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGroup>
                                <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                             cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">                                                            
                                    <h:outputText value="[6]=[1]+[2]+[3]-[4]-[5]"/>
                                </h:panelGrid>
                                
                                <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                             cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                    <h:outputText value="Ostd Bal"/>
                                </h:panelGrid>
                            </h:panelGroup>
                        </f:facet>
                        <h:outputText value="#{listdata.oustBalQty}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>
                    </t:column>
                    
                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGroup>
                                <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                             cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">                                                            
                                    <h:outputText value="[7]"/>
                                </h:panelGrid>
                                
                                <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                             cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                    <h:outputText value="Used Qty"/>
                                </h:panelGrid>
                            </h:panelGroup>
                        </f:facet>
                        <h:outputText value="#{listdata.usedQty}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>
                    </t:column>
                    
                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGroup>
                                <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                             cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">                                                            
                                    <h:outputText value="[8]=[1]+[2]+[3]-[4]-[7]"/>
                                </h:panelGrid>
                                
                                <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                             cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                    <h:outputText value="Used Bal"/>
                                </h:panelGrid>
                            </h:panelGroup>
                        </f:facet>
                        <h:outputText value="#{listdata.usedBalQty}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>
                    </t:column>
                    
                    
                </t:dataTable>
            </h:panelGrid>
        </h:form>
    </h:panelGrid>            
    <%-- End of Listing--%>

    <%@ include file="foxyFooter.jsp" %>
</f:view>
