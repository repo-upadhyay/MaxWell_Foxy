<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%@taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<%@taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@taglib prefix="h" uri="http://java.sun.com/jsf/html"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">


<f:view>
    <%@ include file="foxyHeader.jsp" %>
    <table class="box" width="100%">
        <tr><td>
                
                <h:messages errorClass="FOX_ERROR" showDetail="true" showSummary="true"/>
                <h:outputText value="List Forex Rate" styleClass="smalltitle" rendered="#{foxyForexRate.list}"/>
                <h:panelGrid id="search" styleClass="tablebg" width="100%" rendered="#{not foxyForexRate.list}">
                    <h:outputText value="Search Forex Rate" styleClass="smalltitle"/>                    
                    <h:form id="SearchForexRateForm">
                        <h:outputText value="Please key in partial or full search key to search record(s)" styleClass="FOX_HELPMSG" rendered="#{not foxyForexRate.list}"/>
                        <h:panelGrid id="enq" columns="2" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="50%">
                            
                            <t:outputLabel for="ForexRate_Code" value="Forex Code:" />
                            <h:panelGroup>
                                <h:selectOneMenu id="ForexRate_Code" styleClass="FOX_INPUT" required="true" 
                                                 value="#{foxyForexRate.searchKey}" readonly="false"> 
                                    <f:selectItems value="#{listData.forexCurrencyList}"/>
                                </h:selectOneMenu>
                            </h:panelGroup>
                            
                            <t:outputLabel for="FromDate" value="From Date:" />
                            <h:panelGroup>
                                <t:inputCalendar id="FromDate" styleClass="FOX_INPUT" value="#{foxyForexRate.fromDate}"
                                                 popupDateFormat="yyyyMMdd" renderAsPopup="true"
                                                 helpText="YYYYMMDD" required="true"/>
                                <h:message errorClass="FOX_ERROR" for="FromDate" showDetail="true" showSummary="true"/>
                            </h:panelGroup>
                            
                            <t:outputLabel for="ToDate" value="To Date:" />
                            <h:panelGroup>
                                <t:inputCalendar id="ToDate" styleClass="FOX_INPUT" value="#{foxyForexRate.toDate}"  
                                                 popupDateFormat="yyyyMMdd" renderAsPopup="true"
                                                 helpText="YYYYMMDD" required="false"/>    
                                <h:message errorClass="FOX_ERROR" for="ToDate" showDetail="true" showSummary="true"/>
                            </h:panelGroup>
                            
                            <h:outputText value=" " />
                            <h:commandButton id="action" value="SEARCH" action="#{foxyForexRate.search}"/>                            
                            
                        </h:panelGrid>
                    </h:form>
                </h:panelGrid>
                
                <h:panelGrid id="ListUserGrid" styleClass="tablebg" rendered="#{foxyForexRate.list}" width="100%" >
                    <h:form id="ListSupplierForm">
                        <h:panelGrid id="ListDisplay" columns="1" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="80%">
                            <t:dataTable 
                                value="#{foxyForexRate.forexRateListModel}" var="forex"
                                binding="#{foxyForexRate.foxyTable}"
                                id="ListData"
                                styleClass="scrollerTable"
                                headerClass="standardTable_Header"
                                footerClass="standardTable_Header"
                                rowClasses="FoxyOddRow,FoxyEvenRow"
                                columnClasses="standardTable_Column,standardTable_ColumnCentered,standardTable_Column"
                                preserveDataModel="true"
                                rows="30">
                                
                                
                                <f:facet name="header">
                                    <h:outputText value="Please click on the links to update" style="color: #00FFEE; text-align: center;" />
                                </f:facet>
                                <f:facet name="footer">
                                    <h:outputText value="End of Record(s)" style="color: #00FF00; text-align: center;" />
                                </f:facet> 
                                
                                <h:column>
                                    <f:facet name="header">
                                        <h:outputText value="Forex Code" />
                                    </f:facet>
                                    
                                    <h:commandLink id="editCurRecLink" action="#{foxyForexRate.editForexRate}"
                                                   value="#{forex.curCode}" immediate="true">
                                        <t:updateActionListener property="#{foxySessionData.pageParameterLong}" value="#{forex.forexRateId}"/>
                                    </h:commandLink>                            
                                </h:column>
                                
                                <h:column>
                                    <f:facet name="header">
                                        <h:outputText value="Rate Date" />
                                    </f:facet>
                                    <h:outputText value="#{forex.rateDate}">
                                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                                    </h:outputText>
                                </h:column>
                                
                                <h:column>
                                    <f:facet name="header">
                                        <h:outputText value="Per USD Rate" />
                                    </f:facet>
                                    <h:outputText value="#{forex.perUsdRate}" />
                                </h:column>                                                                
                                
                                <h:column>
                                    <f:facet name="header">
                                        <h:outputText value="Insert Mode" />
                                    </f:facet>
                                    <h:outputText value="#{forex.recDesc}" />
                                </h:column>                                                                
                                
                                <h:column>
                                    <f:facet name="header">
                                        <h:outputText value="Delete"/>
                                    </f:facet>
                                    <h:commandButton id="delCurRec" action="#{foxyForexRate.delete}"
                                                     value="Delete" immediate="true"
                                                     onclick="if(!confirm('Are you sure want to delete?')) return false">
                                        <t:updateActionListener property="#{foxySessionData.pageParameterLong}" value="#{forex.forexRateId}"/>
                                    </h:commandButton>
                                </h:column>                             
                                
                            </t:dataTable>
                            
                            <t:dataScroller id="scroll_1"
                                            for="ListData"
                                            fastStep="10"
                                            pageCountVar="pageCount"
                                            pageIndexVar="pageIndex"
                                            styleClass="scroller"
                                            paginator="true"
                                            paginatorMaxPages="9"
                                            paginatorTableClass="paginator"
                                            paginatorActiveColumnStyle="font-weight:bold;"
                                            immediate="true">
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
                                            for="ListData"
                                            rowsCountVar="rowsCount"
                                            displayedRowsCountVar="displayedRowsCountVar"
                                            firstRowIndexVar="firstRowIndex"
                                            lastRowIndexVar="lastRowIndex"
                                            pageCountVar="pageCount"
                                            pageIndexVar="pageIndex"
                                            immediate="true">
                                <h:outputFormat value="Total Rec {0}, DispayRowCount {1}, First row index {2}, last row index {3} pageindex {4}, pagecount {5}" styleClass="standard" >
                                    <f:param value="#{rowsCount}" />
                                    <f:param value="#{displayedRowsCountVar}" />
                                    <f:param value="#{firstRowIndex}" />
                                    <f:param value="#{lastRowIndex}" />
                                    <f:param value="#{pageIndex}" />
                                    <f:param value="#{pageCount}" />
                                </h:outputFormat>
                            </t:dataScroller>
                            <!-- Report List -->
                        </h:panelGrid>
                    </h:form>
                </h:panelGrid>                                           
        </td></tr>
        <tr>
            <td>
                <!-- Report List -->
            </td>
        </tr>
    </table>
    
    <%@ include file="foxyFooter.jsp" %>
</f:view>
