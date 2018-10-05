<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<%@taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@taglib prefix="h" uri="http://java.sun.com/jsf/html"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">


<f:view>
    <%@ include file="foxyHeader.jsp" %>
    <table class="box" width="100%">
        <tr><td>
            <h:messages errorClass="FOX_ERROR" showDetail="true" showSummary="true" />
            <%-- Panel for List --%>
            <h:panelGrid id="ListGrid" styleClass="tablebg"  width="100%">
                <h:outputText value="Parameter List" styleClass="smalltitle" />                
                <h:form id="ListForm">
                    <h:outputText value="Please key in partial or full search key to search record(s)" styleClass="FOX_HELPMSG" rendered="#{not foxyParameter.list}"/>                                        
                    <h:panelGrid id="SearchInput" columns="2" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="50%">                       
                        <t:outputLabel for="category" value="Parameter Category" />               
                        <h:panelGroup>
                            <h:selectOneMenu id="category" styleClass="FOX_INPUT" required="true" value="#{foxyParameter.searchType}">
                                <f:selectItems value="#{listData.paramCatList}"/>
                            </h:selectOneMenu>
                            <h:message errorClass="FOX_ERROR" for="category" showDetail="true" showSummary="true"/>
                        </h:panelGroup>                        
                        
                        
                        <t:outputLabel for="searchKey" value="Parameter Desc:" />               
                        <h:panelGroup>
                            <t:inputText id="searchKey" styleClass="FOX_INPUT" 
                                maxlength="20" size="20" required="true" 
                                value="#{foxyParameter.searchKey}">
                            </t:inputText>
                            <h:outputText value=" " />
                            <h:commandButton id="Search" value="Search" action="#{foxyParameter.search}"/>
                            <h:message errorClass="FOX_ERROR" for="searchKey" showDetail="true" showSummary="true"/>
                        </h:panelGroup>
                    </h:panelGrid>
                
                    <h:panelGrid id="ListDisplay" columns="1" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="70%" rendered="#{foxyParameter.list}">
                        <t:dataTable id="ListDataDisplay"
                            binding="#{foxyParameter.foxyTable}"
                            styleClass="scrollerTable"
                            headerClass="standardTable_Header"
                            footerClass="standardTable_Header"
                            rowClasses="standardTable_Row1,standardTable_Row2"
                            columnClasses="standardTable_Column,standardTable_ColumnCentered,standardTable_Column"
                            var="parameter"
                            value="#{foxyParameter.parameterList}"
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
                                    <h:outputText value="Code" />
                                </f:facet>
                                <h:commandLink id="links" 
                                    value="#{parameter.code}"
                                    action="#{foxyParameter.editParameter}">
                                    <t:updateActionListener property="#{foxySessionData.pageParameterLong}" value="#{parameter.id}"/>
                                </h:commandLink>

                                <%--h:outputText value="#{parameter.code}" /--%>
                            </h:column>
                                                                                                                
                            <h:column>
                                <f:facet name="header">
                                    <h:outputText value="Short Description" />
                                </f:facet>
                                <h:outputText value="#{parameter.shortDesc}" />
                            </h:column>

                            
                            <h:column>
                                <f:facet name="header">
                                    <h:outputText value="Description" />
                                </f:facet>
                                <h:outputText value="#{parameter.description}" />
                            </h:column>

                            
                            <h:column>
                                <f:facet name="header">
                                    <h:outputText value="Status" />
                                </f:facet>
                                <h:outputText value="#{parameter.status}" />
                            </h:column>
                            
                            <h:column>
                                <f:facet name="header">
                                    <h:outputText value="Display Sequence" />
                                </f:facet>
                                <h:outputText value="#{parameter.sequence}" />
                            </h:column>                            
                            
                            <h:column>
                                <f:facet name="header">
                                    <h:outputText value="Delete"/>
                                </f:facet>
                                <h:commandButton id="delCurRec" action="#{foxyParameter.delete}"
                                    value="Delete" immediate="true"
                                    onclick="if(!confirm('Are you sure want to delete?')) return false">
                                    <t:updateActionListener property="#{foxySessionData.pageParameterLong}" value="#{parameter.id}"/>
                                </h:commandButton>
                            </h:column>                             
                            
                            
                        </t:dataTable>
                        <t:dataScroller id="scroll_1"
                            for="ListDataDisplay"
                            fastStep="30"
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
                            for="ListDataDisplay"
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
            <%-- End of List --%>            
        </td></tr>
        <tr>
            <td>
                <!-- Report List -->
            </td>
        </tr>
    </table>
    <%@ include file="foxyFooter.jsp" %>
</f:view>