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
                <h:outputText value="Production Schedule Items Search" styleClass="smalltitle" />                
                <h:form id="ListForm">
                    <h:outputText value="Please key in partial or full search key to search record(s)" styleClass="FOX_HELPMSG" rendered="#{not foxyProdScheduleEdit.list}"/>
                    <h:panelGrid id="SearchInputGrid" columns="1" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="100%"> 
                        <h:panelGroup>
                            <t:outputLabel for="Location" value="Country:" />
                            <h:panelGroup>
                                <h:selectOneMenu id="Location" styleClass="FOX_INPUT" required="true" value="#{foxyProdScheduleEdit.sessProdSchBean.ccode}">
                                    <f:selectItems value="#{listData.countryList}"/>
                                </h:selectOneMenu>
                            </h:panelGroup>
                        
                            <t:outputLabel for="SewStart" value="Sewing Start:" />                        
                            <h:panelGroup>
                                <t:inputCalendar  id="SewStart" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                                    helpText="YYYYMMDD" value="#{foxyProdScheduleEdit.sessProdSchBean.sewStart}"
                                    required = "false" styleClass="FOX_INPUT">
                                </t:inputCalendar>
                            </h:panelGroup>
                        
                            <t:outputLabel for="SewEnd" value="Sewing End:" />                        
                            <h:panelGroup>
                                <t:inputCalendar  id="SewEnd" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                                    helpText="YYYYMMDD" value="#{foxyProdScheduleEdit.sessProdSchBean.sewEnd}"
                                    required = "false" styleClass="FOX_INPUT">
                                </t:inputCalendar>
                                <h:commandButton id="Search" value="Search" action="#{foxyProdScheduleEdit.search}"/>
                            </h:panelGroup>
                        </h:panelGroup>
                    </h:panelGrid>
                </h:form>
                    
                    
                <h:panelGrid id="ListDataModelGrid" styleClass="tablebg" rendered="#{foxyProdScheduleEdit.list}" width="100%" >
                    <h:form id="ListDataModelForm">
                        <h:panelGrid id="ListDisplay" columns="1" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="99%">
                            <t:dataTable 
                                binding="#{foxyProdScheduleEdit.foxyTable}"
                                value="#{foxyProdScheduleEdit.prodScheduleListModel}" var="prodSch"
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

                                    <h:commandLink id="editCurRecLink" action="#{foxyProdScheduleEdit.edit}"
                                        value="Edit" immediate="true">
                                        <t:updateActionListener property="#{foxySessionData.pageParameterLong}" value="#{prodSch.prodSchId}"/>
                                    </h:commandLink>                            
                                </h:column>
                                
                                <h:column>
                                    <f:facet name="header">
                                        <h:outputText value="Country Origin" />
                                    </f:facet>
                                    <h:outputText value="#{prodSch.countryDesc}"/>
                                </h:column>
                                
                                <h:column>
                                    <f:facet name="header">
                                        <h:outputText value="Line No" />
                                    </f:facet>
                                                                                                                                                
                                    <h:outputText value="#{prodSch.lineNo}"/>
                                </h:column>
                                <h:column>
                                    <f:facet name="header">
                                        <h:outputText value="Ref#" />
                                    </f:facet>
                                                                                                                                                
                                    <h:outputText value="#{prodSch.refNo}"/>
                                </h:column>                                      
                                
                                <h:column>
                                    <f:facet name="header">
                                        <h:outputText value="Sew Start" />
                                    </f:facet>
                                    
                                    <h:outputText value="#{prodSch.sewStart}">
                                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                                    </h:outputText>
                                </h:column>
                                <h:column>
                                    <f:facet name="header">
                                        <h:outputText value="Sew End" />
                                    </f:facet>

                                    <h:outputText value="#{prodSch.sewEnd}">
                                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                                    </h:outputText>
                                </h:column>
                                
                                <h:column>                                    
                                    <f:facet name="header">
                                        <h:outputText value="VesselDate/Lots" />
                                    </f:facet>
                                    
                                    <t:dataList value="#{prodSch.lotBeanList}" 
                                        var="lotBean"
                                        layout="orderedList"
                                        rowCountVar="rowCount"
                                        rowIndexVar="rowIndex">
                                        <h:outputText value="#{lotBean.listDisplayFormat}"/>
                                    </t:dataList>
                                </h:column>      
                                
                                <h:column>
                                    <f:facet name="header">
                                        <h:outputText value="Delete"/>
                                    </f:facet>
                                    <h:commandButton id="delCurRec" action="#{foxyProdScheduleEdit.delete}"
                                        value="Delete" immediate="true"
                                        onclick="if(!confirm('Are you sure want to delete?')) return false">
                                        <t:updateActionListener property="#{foxySessionData.pageParameterLong}" value="#{prodSch.prodSchId}"/>
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