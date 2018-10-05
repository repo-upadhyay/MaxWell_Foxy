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
    <h:panelGrid id="SearchGrid" styleClass="tablebg" width="100%"  rendered="#{not foxyQuotaReports.list}">
        <h:outputText value="Quota Used Report" styleClass="smalltitle" />
        <%--h:form id="SearchForm" rendered="#{foxyQuotaReports.search}" --%>
        <h:form id="SearchForm">
            <h:panelGrid id="SearchInput" columns="2" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="50%">                        
                <t:saveState value="#{foxyQuotaReports.country}"/>
                <t:saveState value="#{foxyQuotaReports.quota}"/>
                <t:saveState value="#{foxyQuotaReports.fromDate}"/>
                <t:saveState value="#{foxyQuotaReports.toDate}"/>
                
                <t:outputLabel value="Country Origin:" for="Country"/>
                <h:panelGroup>
                    <a4j:region id="ajaxregion1" renderRegionOnly="false" selfRendered="true">
                        <h:selectOneMenu id="Country" styleClass="FOX_INPUT" 
                                         required="true" 
                                         immediate="true"
                                         value="#{foxyQuotaReports.country}">
                            <f:selectItems value="#{listData.countryList}"/>
                            <a4j:support event="onchange"  
                                         reRender="QuotaMast_Code" ajaxSingle="true">
                            </a4j:support>                                    
                        </h:selectOneMenu>
                    </a4j:region>
                    <h:message errorClass="FOX_ERROR" for="Country" showDetail="true" showSummary="true"/>
                </h:panelGroup>                                                                                              
                
                <t:outputLabel value="Quota Code:" for="QuotaMast_Code"/>
                <h:panelGroup>
                    <h:selectOneMenu id="QuotaMast_Code" styleClass="FOX_INPUT" value="#{foxyQuotaReports.quota}"
                                     style="width:220px; " required="true" immediate="true"> 
                        <f:selectItems value="#{foxyQuotaReports.qtaByCountryList}"/>
                    </h:selectOneMenu>
                    <a4j:status for="ajaxregion1">
                        <f:facet name="start">
                            <h:graphicImage value="/images/ajaxstart.gif" height="12" width="12"/>
                        </f:facet>
                        <f:facet name="stop">
                            <%-- h:graphicImage value="/images/ajax_stoped.gif" / --%>
                        </f:facet>
                    </a4j:status>                                                                
                    <h:message errorClass="FOX_ERROR" for="QuotaMast_Code" showDetail="true" showSummary="true"/>
                </h:panelGroup>
                
                
                <t:outputLabel for="FromDate" value="ETD Date From:" />
                <h:panelGroup>
                    <t:inputCalendar id="FromDate" styleClass="FOX_INPUT" value="#{foxyQuotaReports.fromDate}"  
                                     required="true" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                                     helpText="YYYYMMDD" />    
                    <h:message errorClass="FOX_ERROR" for="FromDate" showDetail="true" showSummary="true"/>
                </h:panelGroup>                        
                
                <t:outputLabel for="ToDate" value="To:" />
                <h:panelGroup>
                    <t:inputCalendar id="ToDate" styleClass="FOX_INPUT" value="#{foxyQuotaReports.toDate}"  
                                     required="true" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                                     helpText="YYYYMMDD" />
                    <h:message errorClass="FOX_ERROR" for="ToDate" showDetail="true" showSummary="true"/>
                </h:panelGroup>
                
                <h:commandButton id="Submit"  value="Submit" action="#{foxyQuotaReports.search}"/>
            </h:panelGrid>
        </h:form>
    </h:panelGrid>
    <%-- End of Search--%>
            
    <%-- Panel for Listing --%>
    <h:panelGrid id="ListOrderGrid" styleClass="tablebg" rendered="#{foxyQuotaReports.list}" width="100%">        
        <h:form id="ListReportForm">
            <h:panelGrid id="Top" columns="1" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="100%">
                
                <h:outputText value="Quota Used Report for #{foxyQuotaReports.title}" styleClass="smalltitle" />
            </h:panelGrid>
            <h:panelGrid id="ListDisplay" columns="1" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="100%">
                <t:dataTable value="#{foxyQuotaReports.quotaUsagesReport}" var="quotaOutstdRpt"
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
                    
                    <f:facet name="header">
                        <h:outputText value="All Quantity taken from Shipping records" styleClass="FOX_HELPMSG"/>
                    </f:facet>                      
                    
                    
                    <t:column  width="8%">
                        <f:facet name="header">
                            <h:outputText value="Ref No" />
                        </f:facet>
                        <h:outputText value="#{quotaOutstdRpt.orderId}#{quotaOutstdRpt.month}#{quotaOutstdRpt.location}#{quotaOutstdRpt.subLocation}" rendered="#{quotaOutstdRpt.quota != null}"/>
                        <h:outputText styleClass="FOXY_REPORT_GRAND_TOTAL" value="#{quotaOutstdRpt.orderId}" rendered="#{quotaOutstdRpt.quota == null}"/>
                    </t:column>
                    
                    <t:column width="8%">
                        <f:facet name="header">
                            <h:outputText value="quota" />
                        </f:facet>
                        <h:outputText value="#{quotaOutstdRpt.quota}" />
                    </t:column>
                    
                    <t:column width="8%">
                        <f:facet name="header">
                            <h:outputText value="Category/Dest" />
                        </f:facet>
                        <h:outputText value="#{quotaOutstdRpt.category}/#{quotaOutstdRpt.destination}" rendered="#{quotaOutstdRpt.quota != null}" />
                    </t:column>
                    
                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">
                                <h:outputText value="Qty pcs" />
                            </h:panelGrid>
                        </f:facet>
                        <h:outputText value="#{quotaOutstdRpt.qtyPcs}" rendered="#{quotaOutstdRpt.quota != null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>
                        <h:outputText styleClass="FOXY_REPORT_GRAND_TOTAL" value="#{quotaOutstdRpt.qtyPcs}" rendered="#{quotaOutstdRpt.quota == null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>                         
                    </t:column>
                                        
                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">                            
                                <h:outputText value="Multiplier" />
                            </h:panelGrid>
                        </f:facet>
                        <h:outputText value="#{quotaOutstdRpt.multiplier}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>                        
                    </t:column>
                    
                    <t:column width="8%" styleClass="FOXY_ORDER_DETAIL_COL_R">
                        <f:facet name="header">
                            <h:panelGrid columns="1" styleClass="FOXY_ORDER_DETAIL_HDR_R_NOPAD" width="100%"
                                         cellpadding="0" cellspacing="0" frame="0" border="0" rules="0">                            
                                <h:outputText value="Quota Used" />
                            </h:panelGrid>
                        </f:facet>
                        <h:outputText value="#{quotaOutstdRpt.qused}" rendered="#{quotaOutstdRpt.quota != null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>
                        <h:outputText styleClass="FOXY_REPORT_GRAND_TOTAL" value="#{quotaOutstdRpt.qused}" rendered="#{quotaOutstdRpt.quota == null}">
                            <f:convertNumber minFractionDigits="2" maxFractionDigits="2"/>
                        </h:outputText>                        
                    </t:column>
                    
                    <t:column width="10%">
                        <f:facet name="header">
                            <h:outputText value="ETD Date"/>
                        </f:facet>
                        <h:outputText value="#{quotaOutstdRpt.delivery}">
                            <f:convertDateTime type="date" pattern="yyyy-MM-dd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                        </h:outputText>
                    </t:column>
                    
                </t:dataTable>
            </h:panelGrid>
        </h:form>
    </h:panelGrid>            
    <%-- End of Listing--%>

    <%@ include file="foxyFooter.jsp" %>
</f:view>
