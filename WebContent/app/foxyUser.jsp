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
            <h:messages errorClass="FOX_ERROR" showDetail="true" showSummary="true" />
            <!-- Code segment for Adding in new user --START-- -->
            <h:panelGrid id="AddUserGrid" styleClass="tablebg" rendered="#{foxyUser.add}" width="100%">
                <h:outputText value="New User" styleClass="smalltitle" />
                <h:form id="AddUserForm" rendered="#{foxyUser.add}">
                    <h:inputHidden id="action" value="ADD"/>
                    <h:panelGrid id="AddInput" columns="2" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="50%">
                        

                        <!-- ==================== Input Filed for [User Id] --START-- ========================= -->
                        <t:outputLabel for="User_Id" value="User Id:" />
                        <h:panelGroup>
                            <t:inputTextHelp id="User_Id" styleClass="FOX_INPUT"
                                helpText="Text"
                                maxlength="10" size="10" required="true"
                                value="#{foxyUser.dbUser.userId}">
                            </t:inputTextHelp>
                            <h:message errorClass="FOX_ERROR" for="User_Id" showDetail="true" showSummary="true"/>
                        </h:panelGroup>
                        <!-- ==================== Input Filed for [User Id] --END  -- ========================= -->


                        <!-- ==================== Input Filed for [Full Name] --START-- ========================= -->
                        <t:outputLabel for="Full_Name" value="Full Name:" />
                        <h:panelGroup>
                            <t:inputTextHelp id="Full_Name" styleClass="FOX_INPUT"
                                helpText="Text"
                                maxlength="50" size="50" required="true"
                                value="#{foxyUser.dbUser.fullName}">
                            </t:inputTextHelp>
                            <h:message errorClass="FOX_ERROR" for="Full_Name" showDetail="true" showSummary="true"/>
                        </h:panelGroup>
                        <!-- ==================== Input Filed for [Full Name] --END  -- ========================= -->


                        <!-- ==================== Input Filed for [Password] --START-- ========================= -->
                        <t:outputLabel for="Password" value="Password:" />
                        <h:panelGroup>
                            <t:inputSecret id="Password" styleClass="FOX_INPUT"
                                maxlength="20" size="20" required="true" redisplay="true"
                                value="#{foxyUser.dbUser.password}">
                            </t:inputSecret>
                            <h:message errorClass="FOX_ERROR" for="Password" showDetail="true" showSummary="true"/>
                        </h:panelGroup>
                        <!-- ==================== Input Filed for [Password] --END  -- ========================= -->


                        <!-- ==================== Input Filed for [Re-Type Password] --START-- ========================= -->
                        <t:outputLabel for="Re-Type_Password" value="Re-Type Password:" />
                        <h:panelGroup>
                            <t:inputSecret id="Re-Type_Password" styleClass="FOX_INPUT"
                                maxlength="20" size="20" required="true" redisplay="true"
                                value="#{foxyUser.rePassword}">
                            </t:inputSecret>
                            <h:message errorClass="FOX_ERROR" for="Re-Type_Password" showDetail="true" showSummary="true"/>
                        </h:panelGroup>
                        <!-- ==================== Input Filed for [Re-Type Password] --END  -- ========================= -->


                        <!-- ==================== Input Filed for [Location] --START-- ========================= -->
                        <t:outputLabel for="Location" value="Location:" />
                        <h:panelGroup>
                            <h:selectOneMenu id="Location" styleClass="FOX_INPUT" required="true" value="#{foxyUser.dbUser.location}">
                                <f:selectItems value="#{listData.countryList}"/>
                            </h:selectOneMenu>
                            <h:message errorClass="FOX_ERROR" for="Location" showDetail="true" showSummary="true"/>                            
                        </h:panelGroup>
                        <!-- ==================== Input Filed for [Location] --END  -- ========================= -->


                        <!-- ==================== Input Filed for [User Group] --START-- ========================= -->
                        <t:outputLabel for="UserGroup" value="User Group:" />
                        <h:panelGroup>
                            <h:selectOneMenu id="UserGroup" styleClass="FOX_INPUT" required="true" value="#{foxyUser.dbUser.userGroup}">
                                <f:selectItems value="#{listData.userGroupList}"/>
                            </h:selectOneMenu>
                            <h:message errorClass="FOX_ERROR" for="UserGroup" showDetail="true" showSummary="true"/>
                        </h:panelGroup>
                        <!-- ==================== Input Filed for [User Group] --END  -- ========================= -->


                        <!-- ==================== Input Filed for [User Status] --START-- ========================= -->
                        <%--
                        <t:outputLabel for="Status" value="User Status:" />
                        <h:panelGroup>
                        <h:selectOneMenu id="Status" styleClass="FOX_INPUT" required="true" value="#{foxyUser.dbUser.status}">
                        <f:selectItems value="#{listData.statList}"/>
                        </h:selectOneMenu>
                        <h:message errorClass="FOX_ERROR" for="Status" showDetail="true" showSummary="true"/>
                        </h:panelGroup>
                        --%>
                        <!-- ==================== Input Filed for [User Status] --END  -- ========================= -->

                    </h:panelGrid>                                                            
                    
                    <h:panelGrid id="AddButton" columns="1" columnClasses="FOX_BUTTON" width="50%">
                        <h:panelGroup>
                            <h:commandButton id="Save"  value="Save" action="#{foxyUser.saveAdd}">
                            </h:commandButton>
                        </h:panelGroup>
                    </h:panelGrid>
                                        
                </h:form>
            </h:panelGrid>
            <!-- Code segment for Adding in new user --END -- -->
            

            <!-- Code segment for search function --START-- -->
            <h:panelGrid id="SearchUserGrid" styleClass="tablebg" rendered="#{foxyUser.search or foxyUser.list}"  width="100%">
                <h:outputText value="Search User" styleClass="smalltitle" rendered="#{foxyUser.search}"/>
                <h:outputText value="List User" styleClass="smalltitle" rendered="#{foxyUser.list}"/>
                <h:outputText value="Please key in partial or full search key to search record(s), Leave country blank for all countries" styleClass="FOX_HELPMSG" rendered="#{not foxyUser.list}"/>
                <h:form id="SearchUserForm" rendered="#{foxyUser.search or foxyUser.list}">
                    <h:inputHidden id="action" value="SEARCH"/>
                    <h:panelGrid id="SearchInput" columns="2" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="50%">
                        
                        <t:outputLabel for="SearchKeyLoc" value="Country:" />
                        <h:panelGroup>
                            <h:selectOneMenu id="SearchKeyLoc" styleClass="FOX_INPUT" required="false" value="#{foxyUser.sessUserBean.location}">
                                <f:selectItems value="#{listData.countryList}"/>
                            </h:selectOneMenu>
                                                
                            <t:outputLabel for="SearchKey" value="User ID:" />                                      
                            <h:inputText id="SearchKey" styleClass="FOX_INPUT" 
                                maxlength="10" size="10" required="true" 
                                value="#{foxyUser.sessUserBean.userId}">
                            </h:inputText>
                            <h:outputText value=" " />
                            <h:commandButton id="Search"  value="Search" action="#{foxyUser.search}"/>
                        </h:panelGroup>
                    </h:panelGrid>
                </h:form>
            </h:panelGrid>                                                          
            <!-- Code segment for search function --End -- -->
            
            <!-- Code segment for User detail listing --START-- -->
            <h:panelGrid id="ListUserGrid" styleClass="tablebg" rendered="#{foxyUser.list}" width="100%">
                <h:form id="ListUserForm" rendered="#{foxyUser.list}">                
                    <h:panelGrid id="ListDisplay" columns="1" rendered="#{foxyUser.list}" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="80%">
                        <h:inputHidden id="action" value="LIST"/>
                        <t:dataTable 
                            id="ListData"
                            binding="#{foxyUser.foxyTable}"
                            value="#{foxyUser.userListModel}" var="user"
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
                                    <h:outputText value="User Id" />
                                </f:facet>
                            
                                <h:commandLink id="editCurRecLink" action="#{foxyUser.updateDetail}"
                                    value="#{user.userId}" immediate="true">
                                    <t:updateActionListener property="#{foxySessionData.pageParameter}" value="#{user.userId}"/>
                                </h:commandLink>                            
                            </h:column>
                            
                            
                            <h:column>
                                <f:facet name="header">
                                    <h:outputText value="Full Name" />
                                </f:facet>
                                <h:outputText value="#{user.fullName}" />
                            </h:column>
                            
                            <h:column>
                                <f:facet name="header">
                                    <h:outputText value="User Group" />
                                </f:facet>
                                <h:outputText value="#{user.userGroup}" />
                            </h:column>

                            
                            <h:column>
                                <f:facet name="header">
                                    <h:outputText value="Location" />
                                </f:facet>
                                <h:outputText value="#{user.countryDesc}" />
                            </h:column>

                            
                            <h:column>
                                <f:facet name="header">
                                    <h:outputText value="Status" />
                                </f:facet>
                                <h:outputText value="#{user.status}" />
                            </h:column>
                            
                            <h:column>
                                <f:facet name="header">
                                    <h:outputText value="Reset Password" />
                                </f:facet>
                            
                                <h:commandLink id="resetPassLink" action="#{foxyUser.resetPassword}"
                                    value="#{user.userId}" immediate="true">
                                    <t:updateActionListener property="#{foxySessionData.pageParameter}" value="#{user.userId}"/>
                                </h:commandLink>
                            </h:column>
                            
                            <h:column>
                                <f:facet name="header">
                                    <h:outputText value="Edit User Role" />
                                </f:facet>
                            
                                <h:commandLink id="EditRoleLink" action="#{foxyUser.editUserRole}"
                                    value="#{user.userId}" immediate="true">
                                    <t:updateActionListener property="#{foxySessionData.pageParameter}" value="#{user.userId}"/>
                                </h:commandLink>
                            </h:column>
                            

                            <h:column>
                                <f:facet name="header">
                                    <h:outputText value="Delete"/>
                                </f:facet>
                                <h:commandButton id="delCurRec" action="#{foxyUser.deleteUser}"
                                    value="Delete" immediate="true"
                                    onclick="if(!confirm('Are you sure want to delete?')) return false">
                                    <t:updateActionListener property="#{foxySessionData.pageParameter}" value="#{user.userId}"/>
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
            <!-- Code segment for User detail listing --End -- -->
            
        </td></tr>
        <tr>
            <td>
                <!-- Report List -->
            </td>
        </tr>
    </table>
    <%@ include file="foxyFooter.jsp" %>
</f:view>
