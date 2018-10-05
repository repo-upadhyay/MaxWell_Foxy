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
                <h:outputText value="Quota Type Search" styleClass="smalltitle" />                
                <h:form id="ListForm">
                    <h:outputText value="Please key in partial or full search key to search record(s)" styleClass="FOX_HELPMSG" rendered="#{not foxyQuotaMastEdit.list}"/>
                    <h:panelGrid id="SearchInputGrid" columns="1" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="100%"> 
                        <h:panelGroup>
                            <t:outputLabel for="Location" value="Country:" />
                            <h:panelGroup>
                                <h:selectOneMenu id="Location" styleClass="FOX_INPUT" required="true" value="#{foxyQuotaMastEdit.sessQuotaMastBean.country}">
                                    <f:selectItems value="#{listData.countryList}"/>
                                </h:selectOneMenu>
                            </h:panelGroup>
                        
                            <!-- ==================== Input Filed for [QuotaMast Code] --START-- ========================= -->
                            <t:outputLabel value="Quota Code:" for="QuotaMast_Code"/>
                            <h:panelGroup>
                                <t:inputTextHelp id="QuotaMast_Code" styleClass="FOX_INPUT" readonly="false"
                                    helpText="Text"
                                    maxlength="10" size="10" required="true"
                                    value="#{foxyQuotaMastEdit.sessQuotaMastBean.quota}">
                                </t:inputTextHelp>                                
                            </h:panelGroup>
                            <h:commandButton id="Search" value="Search" action="#{foxyQuotaMastEdit.search}"/>
                            <h:message errorClass="FOX_ERROR" for="QuotaMast_Code" showDetail="true" showSummary="true"/>
                        </h:panelGroup>
                    </h:panelGrid>
                </h:form>
                    
                    
                <h:panelGrid id="ListDataModelGrid" styleClass="tablebg" rendered="#{foxyQuotaMastEdit.list}" width="100%" >
                    <h:form id="ListDataModelForm">
                        <h:panelGrid id="ListDisplay" columns="1" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="99%">
                            <t:dataTable 
                                binding="#{foxyQuotaMastEdit.foxyTable}"
                                value="#{foxyQuotaMastEdit.qtaListModel}" var="quotaMast"
                                id="ListData"
                                styleClass="scrollerTable"
                                headerClass="standardTable_Header"
                                footerClass="standardTable_Header"
                                rowClasses="FoxyOddRow,FoxyEvenRow"                                
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
                                        <h:outputText value="Edit" />
                                    </f:facet>

                                    <h:commandLink id="editCurRecLink" action="#{foxyQuotaMastEdit.editQtaMast}"
                                        value="Edit" immediate="true">
                                        <t:updateActionListener property="#{foxySessionData.pageParameterLong}" value="#{quotaMast.qtaId}"/>
                                    </h:commandLink>                            
                                </h:column>
                                
                                <h:column>
                                    <f:facet name="header">
                                        <h:outputText value="Country Origin" />
                                    </f:facet>
                                    <h:outputText value="#{quotaMast.countryDesc}"/>
                                </h:column>
                                
                                <h:column>
                                    <f:facet name="header">
                                        <h:outputText value="Quota Code" />
                                    </f:facet>
                                                                                                                                                
                                    <h:outputText value="#{quotaMast.quota}"/>
                                </h:column>
                                <h:column>
                                    <f:facet name="header">
                                        <h:outputText value="Quota Desc" />
                                    </f:facet>
                                                                                                                                                
                                    <h:outputText value="#{quotaMast.qname}"/>
                                </h:column>                                      
                                                                
                                <h:column>                                    
                                    <f:facet name="header">
                                        <h:outputText value="[Category] = [multiplier] pcs" />
                                    </f:facet>
                                    
                                    <t:dataList value="#{quotaMast.catBeanList}" 
                                        var="catBean"
                                        layout="orderedList"
                                        rowCountVar="rowCount"
                                        rowIndexVar="rowIndex">
                                        <h:outputText value="#{catBean.listDisplay}"/>
                                    </t:dataList>
                                </h:column>      
                                
                                <h:column>
                                    <f:facet name="header">
                                        <h:outputText value="Delete"/>
                                    </f:facet>
                                    <h:commandButton id="delCurRec" action="#{foxyQuotaMastEdit.delete}"
                                        value="Delete" immediate="true"
                                        onclick="if(!confirm('Are you sure want to delete?')) return false">
                                        <t:updateActionListener property="#{foxySessionData.pageParameterLong}" value="#{quotaMast.qtaId}"/>
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