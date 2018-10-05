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
            <h:panelGrid id="search" styleClass="tablebg" width="100%">
                <h:outputText value="Search Category" styleClass="smalltitle" rendered="#{not foxyCategory.list}"/>
                <h:outputText value="List Category" styleClass="smalltitle" rendered="#{foxyCategory.list}"/>
                <h:form id="SearchCategoryForm">
                    <h:outputText value="Please key in partial or full search key to search record(s)" styleClass="FOX_HELPMSG" rendered="#{not foxyCategory.list}"/>
                    <h:panelGrid id="enq" columns="2" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="50%">

                        <t:outputLabel for="CustCode" value="Cust Code:" />
                        <h:panelGroup>
                            <h:inputText id="CustCode" styleClass="FOX_INPUT" 
                                maxlength="15" size="20" required="true" 
                                value="#{foxyCategory.searchKey}">
                            </h:inputText> 
                            <h:commandButton id="action" value="SEARCH" action="#{foxyCategory.search}"/>
                        </h:panelGroup>
                                              
                    </h:panelGrid>
                </h:form>
            </h:panelGrid>

            <h:panelGrid id="ListCatGrid" styleClass="tablebg" rendered="#{foxyCategory.list}" width="100%" >
                <h:form id="ListCategoryForm">
                    <h:panelGrid id="ListDisplay" columns="1" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="80%">
                        <t:dataTable 
                            binding="#{foxyCategory.foxyTable}"
                            value="#{foxyCategory.categoryListModel}" var="cat1"
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
                                    <h:outputText value="Category code" />
                                </f:facet>

                                <h:commandLink id="editCurRecLink" action="#{foxyCategory.editCategory}"
                                    value="#{cat1.category}" immediate="true">
                                    <t:updateActionListener property="#{foxySessionData.pageParameterLong}" value="#{cat1.catId}"/>
                                </h:commandLink>                            
                            </h:column>
                            
                            <h:column>
                                <f:facet name="header">
                                    <h:outputText value="Dest Country" />
                                </f:facet>
                                <h:outputText value="#{cat1.country}"/>
                            </h:column>
                            

                            <h:column>
                                <f:facet name="header">
                                    <h:outputText value="Category Desc" />
                                </f:facet>
                                <h:outputText value="#{cat1.desc}"/>
                            </h:column>

                            <h:column>
                                <f:facet name="header">
                                    <h:outputText value="Unit" />
                                </f:facet>
                                <h:outputText value="#{cat1.unit}"/>
                            </h:column>
                            
                            
                            <h:column>
                                <f:facet name="header">
                                    <h:outputText value="Status" />
                                </f:facet>
                                <h:outputText value="#{cat1.status}"/>
                            </h:column>
                            
                            
                            <h:column>
                                <f:facet name="header">
                                    <h:outputText value="Delete"/>
                                </f:facet>
                                <h:commandButton id="delCurRec" action="#{foxyCategory.delete}"
                                    value="Delete" immediate="true"
                                    onclick="if(!confirm('Are you sure want to delete?')) return false">
                                    <t:updateActionListener property="#{foxySessionData.pageParameterLong}" value="#{cat1.catId}"/>
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
