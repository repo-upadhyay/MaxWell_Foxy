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
    
    <%-- Panel for Search --%>
    <h:panelGrid id="SearchGrid" styleClass="tablebg" rendered="#{foxySalesInvoice.search}" width="100%">
        <h:outputText value="Search Sales Invoice" styleClass="smalltitle" />
        <h:form id="SearchForm">
            <h:outputText value="Please key in partial or full search key to search record(s)" styleClass="FOX_HELPMSG" rendered="#{not foxySalesInvoice.list}"/>
            <h:panelGrid id="SearchInput" columns="2" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="50%">
                
                <t:outputLabel for="SearchKey" value="Sales Invoice:" />               
                <h:panelGroup>
                    <h:inputHidden id="action" value="SEARCH"/>
                    <h:inputText id="SearchKey" styleClass="FOX_INPUT" 
                                 maxlength="20" size="20" required="true" 
                                 value="#{foxySalesInvoice.searchKey}">
                    </h:inputText>
                    <h:outputText value=" " />
                    <%--h:commandButton id="action"  value="#{foxyOrder.action}" action="#{foxyOrder.search}"/--%>
                    <h:commandButton id="Search"  value="Search" action="#{foxySalesInvoice.search}"/>
                </h:panelGroup>
                
                <h:outputText value=" " />
                <%--h:selectOneRadio id="searchType" value="#{foxyInventory.searchType}">
                    <f:selectItems value="#{foxyInventory.searchTypes}"/>
                </h:selectOneRadio--%>
            </h:panelGrid>
        </h:form>
    </h:panelGrid>
    <%-- End of Search--%>
            
    <%-- Panel for List --%>
    <h:panelGrid id="ListOrderGrid" styleClass="tablebg" rendered="#{foxySalesInvoice.list}" width="100%">
        <h:outputText value="List Sales Invoice" styleClass="smalltitle" />                
        <h:form id="ListOrderForm" >  
            <h:outputText value="Please click on invoice number to view/edit detail" styleClass="FOX_HELPMSG"/>           
            <h:panelGrid id="SearchInput" columns="2" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="50%">
                <h:outputText value="Sales Invoice:" />               
                <h:panelGroup>
                    <h:inputText id="SearchKey" styleClass="FOX_INPUT_RO" 
                                 maxlength="20" size="20" required="true" 
                                 value="#{foxySalesInvoice.searchKey}" readonly="true">
                    </h:inputText>
                    
                    <h:outputText value=" " />
                    <h:commandButton id="Search" value="Search" action="#{foxySalesInvoice.search}" disabled="true"/>
                </h:panelGroup>
                
            </h:panelGrid>
            
            <!-- Report List -->            
            <%--h:panelGroup id="body"--%>
            <h:panelGrid id="ListDisplay" columns="1" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="100%">    
                <h:inputHidden id="action" value="LIST"/>
                <t:dataTable id="SearchList"
                             binding="#{foxySalesInvoice.foxyTable}"
                             styleClass="scrollerTable"
                             headerClass="FOXY_ORDER_DETAIL_HEADER"
                             footerClass="FOXY_ORDER_DETAIL_HEADER"
                             rowClasses="standardTable_Row1,standardTable_Row2"
                             columnClasses="standardTable_Column,standardTable_ColumnCentered,standardTable_Column"
                             var="salesInv"
                             value="#{foxySalesInvoice.salesInvoiceList}"
                             preserveDataModel="true"
                             rows="20">
                    
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="Invoice Number" />
                        </f:facet>
                        <h:commandLink id="linkCosting" 
                                       value="#{salesInv.invno}"   
                                       action="#{foxySalesInvoice.editSalesInvoiceDetail}" immediate="true">
                            <t:updateActionListener property="#{foxySessionData.pageParameterLong}" value="#{salesInv.saleinvid}"/>                                           
                        </h:commandLink>
                    </h:column>                    
                    
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="Edit" />
                        </f:facet>
                        <h:commandLink id="linkeditinvoice" 
                                       value="Edit"   
                                       action="#{foxySalesInvoice.editSalesInvoice}" immediate="true">
                            <t:updateActionListener property="#{foxySessionData.pageParameterLong}" value="#{salesInv.saleinvid}"/>                                           
                        </h:commandLink>
                    </h:column>                    
                    
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="Delete" />
                        </f:facet>
                        <h:commandLink id="linkdelinvoice" 
                                       value="Delete"   
                                       action="#{foxySalesInvoice.delete}" immediate="true"
                                       onclick="if(!confirm('Are you sure want to delete?')) return false">
                            <t:updateActionListener property="#{foxySessionData.pageParameterLong}" value="#{salesInv.saleinvid}"/>                                           
                        </h:commandLink>
                    </h:column>                    
                    
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="Invoice Date"/>
                        </f:facet>
                        <h:outputText value="#{salesInv.invdate}">
                            <f:convertDateTime type="date" pattern="yyyy-MM-dd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                        </h:outputText>
                    </h:column>
                    
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="Key-In Date"/>
                        </f:facet>
                        <h:outputText value="#{salesInv.insTime}">
                            <f:convertDateTime type="date" pattern="yyyy-MM-dd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                        </h:outputText>
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
