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
    <%-- Panel for Search --%>
    <h:panelGrid id="SearchGrid" styleClass="tablebg" rendered="#{foxyOrderSearch.search}" width="100%">
        <h:outputText value="Search Order" styleClass="smalltitle" />
        <h:form id="SearchForm" rendered="#{foxyOrderSearch.search}">
            <h:outputText value="Please key in partial or full search key to search record(s)" styleClass="FOX_HELPMSG" rendered="#{not foxyOrder.list}"/>
            <h:panelGrid id="SearchInput" columns="2" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="50%">

                <t:outputLabel for="SearchKey" value="Search Key:" />               
                <h:panelGroup>
                    <h:inputHidden id="action" value="SEARCH"/>
                    <h:inputText id="SearchKey" styleClass="FOX_INPUT" 
                                 maxlength="9" size="20" required="true" 
                                 value="#{foxyOrderSearch.searchKey}">
                    </h:inputText>
                    <h:outputText value=" " />
                    <h:commandButton id="Search"  value="Search" action="#{foxyOrderSearch.search}"/>
                </h:panelGroup>
                <h:outputText value="Type " />
                <h:selectOneRadio id="searchType1" value="#{foxyOrderSearch.searchType}">
                    <f:selectItems value="#{foxyOrderSearch.searchTypes}"/>
                </h:selectOneRadio>                
            </h:panelGrid>
        </h:form>
    </h:panelGrid>
    <%-- End of Search--%>

    <%-- Panel for List --%>
    <h:panelGrid id="ListOrderGrid" styleClass="tablebg" rendered="#{foxyOrderSearch.list}" width="100%">
        <h:outputText value="List Order" styleClass="smalltitle" />                
        <h:form id="ListOrderForm" rendered="#{foxyOrderSearch.list}">        
            <h:panelGrid id="SearchInput" columns="2" rendered="#{foxyOrderSearch.list}" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="50%">                       
                <h:outputText value="Search Key:" />               
                <h:panelGroup>
                    <h:inputText id="SearchKey" styleClass="FOX_INPUT_RO" 
                                 maxlength="9" size="20" required="true" 
                                 value="#{foxyOrderSearch.searchKey}" readonly="true">
                    </h:inputText>
                    <h:outputText value=" " />
                    <h:commandButton id="Search" value="Search" action="#{foxyOrderSearch.search}" disabled="true"/>
                </h:panelGroup>
                <h:outputText value="Type " />
                <h:selectOneRadio id="searchType2" required="true" value="#{foxyOrderSearch.searchType}"  readonly="true">
                    <f:selectItems value="#{foxyOrderSearch.searchTypes}"/>
                </h:selectOneRadio>            
            </h:panelGrid>

            <!-- Report List -->            
            <%--h:panelGroup id="body"--%>
            <h:panelGrid id="ListDisplay" columns="1" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="100%">    
                <h:inputHidden id="action" value="LIST"/>
                <t:dataTable id="SearchList"
                             binding="#{foxyOrderSearch.foxyTable}"
                             styleClass="scrollerTable"
                             headerClass="FOXY_ORDER_DETAIL_HEADER"
                             footerClass="FOXY_ORDER_DETAIL_HEADER"
                             rowClasses="standardTable_Row1,standardTable_Row2"
                             columnClasses="standardTable_Column,standardTable_ColumnCentered,standardTable_Column"
                             var="order"
                             value="#{foxyOrderSearch.orderList}"
                             preserveDataModel="true"
                             rows="20"
                             rendered="#{foxyOrderSearch.list}">
                    <h:column >
                        <f:facet name="header">
                            <h:outputText value="Order Id" />
                        </f:facet>
                        <h:commandLink id="links" 
                                       value="#{order.orderId}"
                                       action="#{foxyOrder.enquire}"
                                       immediate="true" >
                            <t:updateActionListener property="#{foxySessionData.pageParameter}" value="#{order.orderId}"/>
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
                    <h:column rendered="#{not foxySessionData.invShortCut}">
                        <f:facet name="header">
                            <h:outputText value="Transfer RefNo" />
                        </f:facet>
                        <h:commandLink id="transferRefNoForm" action="#{foxyOrderSearch.orderIdTransferForm}"
                                       onclick="if(!confirm('WARNING!!! Once transferred to new RefNo, old RefNo no longer available and not reversible!!!')) return false"
                                       value="TRANS-#{order.orderId}" immediate="true">
                            <t:updateActionListener property="#{foxySessionData.pageParameter}" value="#{order.orderId}"/>
                        </h:commandLink>                         
                    </h:column>
                    <h:column rendered="#{not foxySessionData.invShortCut}">
                        <f:facet name="header">
                            <h:outputText value="Create New Ord" />
                        </f:facet>

                        <h:commandLink id="duplicateNewOrderForm" action="#{foxyOrderSearch.duplicateNewOrderForm}"
                                       value="DUP-#{order.orderId}" immediate="true">
                            <t:updateActionListener property="#{foxySessionData.pageParameter}" value="#{order.orderId}"/>
                        </h:commandLink>                         
                    </h:column>

                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="Download OCF" />
                        </f:facet>

                        <h:commandLink id="downloadOCFLink" action="#{foxyOrderSearch.downloadOrderConfirmationForm}"
                                       value="OCF-#{order.orderId}" immediate="true">
                            <t:updateActionListener property="#{foxySessionData.pageParameter}" value="#{order.orderId}"/>
                        </h:commandLink>                         
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="Image File" />
                        </f:facet>

                        <h:commandLink id="editImageLink" action="#{foxyOrderSearch.uploadImage}"
                                       value="#{order.imgFileLink}" immediate="true">
                            <t:updateActionListener property="#{foxySessionData.pageParameter}" value="#{order.orderId}"/>
                        </h:commandLink>                         
                    </h:column>

                </t:dataTable>

                <h:panelGrid columns="1" styleClass="scrollerTable2" columnClasses="standardTable_ColumnCentered" >
                    <t:dataScroller id="scroll_1"
                                    for="SearchList"
                                    fastStep="20"
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
