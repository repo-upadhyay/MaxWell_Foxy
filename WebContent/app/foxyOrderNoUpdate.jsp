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
                <h:panelGrid id="UpdAddGrid" styleClass="tablebg" width="100%">
                    <%-- Title for Add --%>
                    <h:outputText value="Update Reserved Ref No For User [#{foxyOrderNoUpdate.userId}]" styleClass="smalltitle"/>

                    <h:form id="UpdAddForm">
                        <h:panelGrid id="ListDisplay" columns="1" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="100%">
                            <t:dataTable id="ListDataDisplay"
                                         binding="#{foxyOrderNoUpdate.foxyTable}"
                                         styleClass="scrollerTable"
                                         headerClass="standardTable_Header"
                                         footerClass="standardTable_Header"
                                         rowClasses="standardTable_Row1,standardTable_Row2"
                                         columnClasses="standardTable_Column,standardTable_ColumnCentered,standardTable_Column"
                                         var="ordNoBean"
                                         value="#{foxyOrderNoUpdate.ordNoReservedList}"
                                         preserveDataModel="true"
                                         rows="30">

                                <f:facet name="header">
                                    <h:outputText value="Please NOTE, once reserved RefNo returned back to system, it will be put back into autogenerate queue and user can not claim back" style="color: #00FFEE; text-align: center;" />
                                </f:facet>
                                <f:facet name="footer">
                                    <h:outputText value="End of Record(s)" style="color: #00FF00; text-align: center;" />
                                </f:facet>                                 

                                <h:column>
                                    <f:facet name="header">
                                        <h:outputText value="Ref No" />
                                    </f:facet>
                                    <h:outputText value="#{ordNoBean.reservedNo}" 
                                                  rendered="#{ordNoBean.expired}"
                                                  style="color: #FF0000; font-weight:bold; text-align: center;"/>

                                    <h:outputText value="#{ordNoBean.reservedNo}" 
                                                  rendered="#{not ordNoBean.expired}"
                                                  style="color: #000000; font-weight:bold; text-align: center;"/>
                                </h:column>

                                <h:column>
                                    <f:facet name="header">
                                        <h:outputText value="Main Factory" />
                                    </f:facet>
                                    <h:selectOneMenu id="Country" styleClass="FOX_INPUT" required="false"  disabled="true" 
                                                     value="#{ordNoBean.mainFactory}">
                                        <f:selectItems value="#{listData.factoryList}"/>
                                    </h:selectOneMenu>
                                </h:column>

                                <h:column>
                                    <f:facet name="header">
                                        <h:outputText value="Reserved On" />
                                    </f:facet>
                                    <h:outputText value="#{ordNoBean.reservedOn}" >
                                        <f:convertDateTime type="date" pattern="dd MMM yyyy" timeZone="#{foxyTimeZone.myTimeZone}"/>
                                    </h:outputText>
                                </h:column>

                                <h:column>
                                    <f:facet name="header">
                                        <h:outputText value="Expire On" />
                                    </f:facet>
                                    <h:outputText value="#{ordNoBean.expiredOn}" >
                                        <f:convertDateTime type="date" pattern="dd MMM yyyy" timeZone="#{foxyTimeZone.myTimeZone}"/>
                                    </h:outputText>
                                </h:column>                            

                                <h:column>
                                    <f:facet name="header">
                                        <h:outputText value="Remaining Days To Expiry" />
                                    </f:facet>
                                    <h:outputText value="#{ordNoBean.daysToExpiry}" />
                                </h:column>

                                <h:column>
                                    <f:facet name="header">
                                        <h:outputText value="Return Back To System"/>
                                    </f:facet>
                                    <h:commandButton id="delCurRec" action="#{foxyOrderNoUpdate.forceExpired}"
                                                     disabled="#{ordNoBean.expired}"
                                                     value="Return Back" immediate="true"
                                                     onclick="if(!confirm('Once returned back to system, you would not be able to reserve this Ref No again!!!')) return false">
                                        <t:updateActionListener property="#{foxySessionData.pageParameterLong}" value="#{ordNoBean.resvNoId}"/>
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
                <%-- End of Update & Add --%>

            </td></tr>
        <tr>
            <td>
                <!-- Report List -->
            </td>
        </tr>
    </table>
    <%@ include file="foxyFooter.jsp" %>
</f:view>