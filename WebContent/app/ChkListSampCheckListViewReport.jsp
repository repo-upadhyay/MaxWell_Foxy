<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%@taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<%@taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@taglib prefix="h" uri="http://java.sun.com/jsf/html"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/reportStyle.css" />  


<f:view>
    <%@ include file="foxyHeader.jsp" %>
    <h:panelGrid id="MainGrid" styleClass="tablebg" width="100%">
        <h:outputText value="View Sample Check List Report" styleClass="smalltitle" />
        <h:outputText value=" Please key in partial or full refno to search record(s)" style="color: #FE0000; font-weight: bold;" />
        <h:messages id="msgs"/>
        
        <h:form id="sampCheckListsrchbyref">
            <h:outputLabel value="Ref No:" for="refNo"/>
            <h:inputText id="refNo" value="#{foxySessionData.orderId}" />
            <h:outputLabel value="Show Remark:" for="showremarkbyref"/>
            <h:selectBooleanCheckbox id="showremarkbyref" value="#{foxySampCheckListView.showRmkByRefSrch}"/>
            <h:commandButton action="#{foxySampCheckListView.searchRec}" value="Search By Ref" />
            <h:outputText id="q11ref" value="Sorry no record(s) found" 
                          style="color: #FF0F00; font-weight: bold;" 
                          rendered="#{foxySampCheckListView.searchNotFound}"/>
        </h:form>
        
        <h:outputText value=" Leave Date field default/blank to include all dates" style="color: #FE0000; font-weight: bold;" />
        <h:form id="sampCheckListsrch">
            <table class="box" width="100%">
                <tr>
                    <td width='120px' align='left'>Country:</td>
                    <td width='220px' align='left'>Del Start Date:</td>
                    <td width='220px' align='left'>Del End   Date:</td>
                    <td width='90px' align='left'>Show Remark</td>
                    <td align='left' > </td>
                </tr>                    
                <tr>
                    <td align='left'>
                        <h:selectOneMenu id="country" styleClass="FOX_INPUT" value="#{foxySessionData.pageParameter}">
                            <f:selectItems id="countrycodelist" value="#{listData.countryList}" />
                        </h:selectOneMenu>
                        <h:message errorClass="FOX_ERROR" for="country"  showDetail="true" showSummary="true"/>
                    </td>
                    <td align='left'>
                        <t:inputCalendar  id="startDate1" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                                          popupButtonString="Select Date" helpText="YYYYMMDD" value="#{foxySessionData.fromDate}"
                                          required = "false" styleClass="FOX_INPUT" />
                        <h:message errorClass="FOX_ERROR" for="startDate1" showDetail="true" showSummary="true"/>                        
                    </td>
                    <td align='left'>
                        <t:inputCalendar  id="endDate1" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                                          popupButtonString="Select Date" helpText="YYYYMMDD" value="#{foxySessionData.toDate}"
                                          required = "false" styleClass="FOX_INPUT" />
                        <h:message errorClass="FOX_ERROR" for="endDate1" showDetail="true" showSummary="true"/>
                    </td>
                    <td align="left">
                        <h:selectBooleanCheckbox id="showremark" value="#{foxySampCheckListView.showRmkByDate}"/>
                    </td>                        
                    <td align='left'>
                        <h:commandButton action="#{foxySampCheckListView.searchRecByDate}" value="Search By Date" />
                        <h:outputText value="Sorry no record(s) found"  
                                      style="color: #FF0F00; font-weight: bold;" 
                                      rendered="#{foxySampCheckListView.searchNotFound}"/>
                    </td>
                </tr>
            </table>
        </h:form>
        
        
        <h:outputText value="#{foxySampCheckListView.rptTitleStr}" styleClass="smalltitle" rendered="#{foxySampCheckListView.rptTitle}" />
        <h:form id="sampCheckList" rendered="#{foxySampCheckListView.objFound}" style="col1">
            <t:dataTable  value="#{foxySampCheckListView.objModel}" var="sampCheckList" 
                          styleClass="dataTable">
                
                <f:facet name="header">
                    <!-- h:outputText value="Record Start" style="color: #ff0000; text-align: center;"/ -->
                </f:facet>
                <f:facet name="footer">
                    <h:outputText value="End of Record(s)      Note:All dates in YYMMDD format" style="color: #ff0000; text-align: center;" />
                </f:facet>
                
                <h:column>                    
                    <f:facet name="header" >
                        <h:outputText value="CO"/>
                    </f:facet>
                    <h:outputText value="#{sampCheckList.ccode}"/>                        
                </h:column>                       
                
                <h:column>                    
                    <f:facet name="header" >
                        <h:outputText value="Ref"/>
                    </f:facet>
                    <h:outputText value="#{sampCheckList.refNo}"/>                        
                </h:column>              
                
                <h:column >                    
                    <f:facet name="header" >
                        <h:outputText value="Qty"/>
                    </f:facet>
                    <h:outputText value="#{sampCheckList.qty}"/>                        
                </h:column>              
                
                <h:column >                    
                    <f:facet name="header" >
                        <h:outputText value="Style"/>
                    </f:facet>
                    <h:outputText value="#{sampCheckList.style}"/>                        
                </h:column>              
                
                
                <h:column >                    
                    <f:facet name="header" >
                        <h:outputText value="Buyer"/>
                    </f:facet>
                    <h:outputText value="#{sampCheckList.buyer}"/>                        
                </h:column>              
                
                <h:column >                    
                    <f:facet name="header" >
                        <h:outputText value="MR"/>
                    </f:facet>
                    <h:outputText value="#{sampCheckList.merchant}"/>                        
                </h:column>              
                
                <h:column >                    
                    <f:facet name="header" >
                        <h:outputText value="PO"/>
                    </f:facet>
                    <h:outputText value="#{sampCheckList.poNo}"/>                        
                </h:column>              
                
                <h:column >                    
                    <f:facet name="header" >
                        <h:outputText value="Color"/>
                    </f:facet>
                    <h:outputText value="#{sampCheckList.color}"/>                        
                </h:column>              
                
                
                <h:column>
                    <f:facet name="header" >
                        <h:outputText value="Del"/>
                    </f:facet>
                    <h:outputText style="color: #ff0000;" value="TBA"
                                  rendered="#{sampCheckList.del == null}" />
                    <h:outputText value="#{sampCheckList.del}"  rendered="#{sampCheckList.del != null}">
                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{myTimeZone.myTimeZone}"/>
                    </h:outputText>
                </h:column>
                
                <h:column>
                    <f:facet name="header" >
                        <h:outputText value="Fab Del"/>
                    </f:facet>
                    <h:outputText style="color: #ff0000;" value="TBA"
                                  rendered="#{sampCheckList.fabricDel == null && sampCheckList.fabricDelReq}" />
                    <h:outputText value="#{sampCheckList.fabricDel}"  rendered="#{sampCheckList.fabricDel != null}">
                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{myTimeZone.myTimeZone}"/>
                    </h:outputText>
                </h:column>
                
                <h:column>
                    <f:facet name="header" >
                        <h:outputText value="Fit Sub2"/>
                    </f:facet>
                    <h:outputText style="color: #ff0000;" value="TBA"
                                  rendered="#{sampCheckList.fitSub1 == null && sampCheckList.fitSub1Req}" />
                    <h:outputText value="#{sampCheckList.fitSub1}"  rendered="#{sampCheckList.fitSub1 != null}">
                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{myTimeZone.myTimeZone}"/>
                    </h:outputText>
                </h:column>
                
                <h:column>
                    <f:facet name="header" >
                        <h:outputText value="Cmmt"/>
                    </f:facet>
                    <h:outputText style="color: #ff0000;" value="TBA"
                                  rendered="#{sampCheckList.comments == null && sampCheckList.commentsReq}" />
                    <h:outputText value="#{sampCheckList.comments}"  rendered="#{sampCheckList.comments != null}">
                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{myTimeZone.myTimeZone}"/>
                    </h:outputText>
                </h:column>
                
                <h:column>
                    <f:facet name="header" >
                        <h:outputText value="Fit Sub2"/>
                    </f:facet>
                    <h:outputText style="color: #ff0000;" value="TBA"
                                  rendered="#{sampCheckList.fitSub2 == null && sampCheckList.fitSub2Req}" />
                    <h:outputText value="#{sampCheckList.fitSub2}"  rendered="#{sampCheckList.fitSub2 != null}">
                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{myTimeZone.myTimeZone}"/>
                    </h:outputText>
                </h:column>
                
                <h:column>
                    <f:facet name="header" >
                        <h:outputText value="Final AP"/>
                    </f:facet>
                    <h:outputText style="color: #ff0000;" value="TBA"
                                  rendered="#{sampCheckList.finalAp == null && sampCheckList.finalApReq}" />
                    <h:outputText value="#{sampCheckList.finalAp}"  rendered="#{sampCheckList.finalAp != null}">
                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{myTimeZone.myTimeZone}"/>
                    </h:outputText>
                </h:column>
                
                <h:column>
                    <f:facet name="header" >
                        <h:outputText value="SO Sub1"/>
                    </f:facet>
                    <h:outputText style="color: #ff0000;" value="TBA"
                                  rendered="#{sampCheckList.soSub1 == null && sampCheckList.soSub1Req}" />
                    <h:outputText value="#{sampCheckList.soSub1}"  rendered="#{sampCheckList.soSub1 != null}">
                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{myTimeZone.myTimeZone}"/>
                    </h:outputText>
                </h:column>
                
                <h:column>
                    <f:facet name="header" >
                        <h:outputText value="SO Cmmt"/>
                    </f:facet>
                    <h:outputText style="color: #ff0000;" value="TBA"
                                  rendered="#{sampCheckList.soComment1 == null && sampCheckList.soComment1Req}" />
                    <h:outputText value="#{sampCheckList.soComment1}"  rendered="#{sampCheckList.soComment1 != null}">
                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{myTimeZone.myTimeZone}"/>
                    </h:outputText>
                </h:column>
                
                <h:column>
                    <f:facet name="header" >
                        <h:outputText value="SO Sub2"/>
                    </f:facet>
                    <h:outputText style="color: #ff0000;" value="TBA"
                                  rendered="#{sampCheckList.soSub2 == null && sampCheckList.soSub2Req}" />
                    <h:outputText value="#{sampCheckList.soSub2}"  rendered="#{sampCheckList.soSub2 != null}">
                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{myTimeZone.myTimeZone}"/>
                    </h:outputText>
                </h:column>
                
                <h:column>
                    <f:facet name="header" >
                        <h:outputText value="SO App"/>
                    </f:facet>
                    <h:outputText style="color: #ff0000;" value="TBA"
                                  rendered="#{sampCheckList.soApp == null && sampCheckList.soAppReq}" />
                    <h:outputText value="#{sampCheckList.soApp}"  rendered="#{sampCheckList.soApp != null}">
                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{myTimeZone.myTimeZone}"/>
                    </h:outputText>
                </h:column>
                
                <h:column>
                    <f:facet name="header" >
                        <h:outputText value="AP SPL"/>
                    </f:facet>
                    <h:outputText style="color: #ff0000;" value="TBA"
                                  rendered="#{sampCheckList.apSPL == null && sampCheckList.apSPLReq}" />
                    <h:outputText value="#{sampCheckList.apSPL}"  rendered="#{sampCheckList.apSPL != null}">
                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{myTimeZone.myTimeZone}"/>
                    </h:outputText>
                </h:column>
                
                <h:column>
                    <f:facet name="header" >
                        <h:outputText value="PP SPL"/>
                    </f:facet>
                    <h:outputText style="color: #ff0000;" value="TBA"
                                  rendered="#{sampCheckList.ppSpl == null && sampCheckList.ppSplReq}" />
                    <h:outputText value="#{sampCheckList.ppSpl}"  rendered="#{sampCheckList.ppSpl != null}">
                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{myTimeZone.myTimeZone}"/>
                    </h:outputText>
                </h:column>
                
                <h:column>
                    <f:facet name="header" >
                        <h:outputText value="AD SPL"/>
                    </f:facet>
                    <h:outputText style="color: #ff0000;" value="TBA"
                                  rendered="#{sampCheckList.adSpl == null && sampCheckList.adSplReq}" />
                    <h:outputText value="#{sampCheckList.adSpl}"  rendered="#{sampCheckList.adSpl != null}">
                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{myTimeZone.myTimeZone}"/>
                    </h:outputText>
                </h:column>
                
                <h:column>
                    <f:facet name="header" >
                        <h:outputText value="Top SPL"/>
                    </f:facet>
                    <h:outputText style="color: #ff0000;" value="TBA"
                                  rendered="#{sampCheckList.topSamp == null && sampCheckList.topSampReq}" />
                    <h:outputText value="#{sampCheckList.topSamp}"  rendered="#{sampCheckList.topSamp != null}">
                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{myTimeZone.myTimeZone}"/>
                    </h:outputText>
                </h:column>
                
                <h:column>
                    <f:facet name="header" >
                        <h:outputText value="TOP Cmmt"/>
                    </f:facet>
                    <h:outputText style="color: #ff0000;" value="TBA"
                                  rendered="#{sampCheckList.topSampComment == null && sampCheckList.topSampCommentReq}" />
                    <h:outputText value="#{sampCheckList.topSampComment}"  rendered="#{sampCheckList.topSampComment != null}">
                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{myTimeZone.myTimeZone}"/>
                    </h:outputText>
                </h:column>
                
                <h:column>
                    <f:facet name="header" >
                        <h:outputText value="Test SPL"/>
                    </f:facet>
                    <h:outputText style="color: #ff0000;" value="TBA"
                                  rendered="#{sampCheckList.testSamp == null && sampCheckList.testSampReq}" />
                    <h:outputText value="#{sampCheckList.testSamp}"  rendered="#{sampCheckList.testSamp != null}">
                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{myTimeZone.myTimeZone}"/>
                    </h:outputText>
                </h:column>
                
                <h:column>
                    <f:facet name="header" >
                        <h:outputText value="Test Rpt"/>
                    </f:facet>
                    <h:outputText style="color: #ff0000;" value="TBA"
                                  rendered="#{sampCheckList.testRpt == null && sampCheckList.testRptReq}" />
                    <h:outputText value="#{sampCheckList.testRpt}"  rendered="#{sampCheckList.testRpt != null}">
                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{myTimeZone.myTimeZone}"/>
                    </h:outputText>
                </h:column>
                
                <h:column>
                    <f:facet name="header" >
                        <h:outputText value="F.Test SPL"/>
                    </f:facet>
                    <h:outputText style="color: #ff0000;" value="TBA"
                                  rendered="#{sampCheckList.finalTestSamp == null && sampCheckList.finalTestSampReq}" />
                    <h:outputText value="#{sampCheckList.finalTestSamp}"  rendered="#{sampCheckList.finalTestSamp != null}">
                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{myTimeZone.myTimeZone}"/>
                    </h:outputText>
                </h:column>
                
                <h:column>
                    <f:facet name="header" >
                        <h:outputText value="F.GMT Rpt"/>
                    </f:facet>
                    <h:outputText style="color: #ff0000;" value="TBA"
                                  rendered="#{sampCheckList.finalGmtTestRpt == null && sampCheckList.finalGmtTestRptReq}" />
                    <h:outputText value="#{sampCheckList.finalGmtTestRpt}"  rendered="#{sampCheckList.finalGmtTestRpt != null}">
                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{myTimeZone.myTimeZone}"/>
                    </h:outputText>
                </h:column>
                
                <h:column>
                    <f:facet name="header" >
                        <h:outputText value="Ship SPL"/>
                    </f:facet>
                    <h:outputText style="color: #ff0000;" value="TBA"
                                  rendered="#{sampCheckList.shipSpl == null && sampCheckList.shipSplReq}" />
                    <h:outputText value="#{sampCheckList.shipSpl}"  rendered="#{sampCheckList.shipSpl != null}">
                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{myTimeZone.myTimeZone}"/>
                    </h:outputText>
                </h:column>
            </t:dataTable>
            
            
            <t:dataTable  value="#{foxySampCheckListView.objModel}" var="sampCheckList" styleClass="dataTable" 
                          rendered="#{(foxySampCheckListView.rptTitle && foxySampCheckListView.showRmkByDate) || (not foxySampCheckListView.rptTitle && foxySampCheckListView.showRmkByRefSrch)}">
                
                <f:facet name="header">
                    <!-- h:outputText value="Record Start" style="color: #ff0000; text-align: center;"/ -->
                </f:facet>
                <f:facet name="footer">
                    <h:outputText value="End of Record(s)      Note:All dates in YYMMDD format" style="color: #ff0000; text-align: center;" />
                </f:facet>
                
                <h:column>                    
                    <f:facet name="header" >
                        <h:outputText value="CO"/>
                    </f:facet>
                    <h:outputText value="#{sampCheckList.ccode}"/>                        
                </h:column>                       
                
                <h:column>                    
                    <f:facet name="header" >
                        <h:outputText value="Ref"/>
                    </f:facet>
                    <h:outputText value="#{sampCheckList.refNo}"/>                        
                </h:column>              
                
                <h:column >                    
                    <f:facet name="header" >
                        <h:outputText value="Store Remark"/>
                    </f:facet>
                    <h:outputText value="#{sampCheckList.srmk1}"/>                        
                </h:column>              
                
                <h:column>
                    <f:facet name="header" >
                        <h:outputText value="Date1"/>
                    </f:facet>
                    <h:outputText value="#{sampCheckList.rmk1Date}"  rendered="#{sampCheckList.rmk1Req}">
                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{myTimeZone.myTimeZone}"/>
                    </h:outputText>
                </h:column>
                
                
                <h:column >                    
                    <f:facet name="header" >
                        <h:outputText value="Remark1"/>
                    </f:facet>                        
                    <h:outputText value="#{sampCheckList.rmk1}"  rendered="#{sampCheckList.rmk1Req}" />
                </h:column>              
                
                <h:column>
                    <f:facet name="header" >
                        <h:outputText value="Date2"/>
                    </f:facet>
                    <h:outputText value="#{sampCheckList.rmk2Date}"  rendered="#{sampCheckList.rmk2Req}">
                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{myTimeZone.myTimeZone}"/>
                    </h:outputText>
                </h:column>
                
                
                <h:column >                    
                    <f:facet name="header" >
                        <h:outputText value="Remark2"/>
                    </f:facet>
                    <h:outputText value="#{sampCheckList.rmk2}"  rendered="#{sampCheckList.rmk2Req}" />                        
                </h:column>              
                
                <h:column>
                    <f:facet name="header" >
                        <h:outputText value="Date3"/>
                    </f:facet>
                    <h:outputText value="#{sampCheckList.rmk3Date}"  rendered="#{sampCheckList.rmk3Req}">
                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{myTimeZone.myTimeZone}"/>
                    </h:outputText>
                </h:column>
                
                
                <h:column >                    
                    <f:facet name="header" >
                        <h:outputText value="Remark3"/>
                    </f:facet>
                    <h:outputText value="#{sampCheckList.rmk3}"  rendered="#{sampCheckList.rmk3Req}" />
                </h:column>              
                
                <h:column>
                    <f:facet name="header" >
                        <h:outputText value="Date4"/>
                    </f:facet>
                    <h:outputText value="#{sampCheckList.rmk4Date}"  rendered="#{sampCheckList.rmk4Req}">
                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{myTimeZone.myTimeZone}"/>
                    </h:outputText>
                </h:column>
                
                
                <h:column >                    
                    <f:facet name="header" >
                        <h:outputText value="Remark4"/>
                    </f:facet>
                    <h:outputText value="#{sampCheckList.rmk4}"   rendered="#{sampCheckList.rmk4Req}" />
                </h:column>              
                
                <h:column>
                    <f:facet name="header" >
                        <h:outputText value="Date5"/>
                    </f:facet>
                    <h:outputText value="#{sampCheckList.rmk5Date}"  rendered="#{sampCheckList.rmk5Req}">
                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{myTimeZone.myTimeZone}"/>
                    </h:outputText>
                </h:column>                    
                
                
                <h:column >                    
                    <f:facet name="header" >
                        <h:outputText value="Remark5"/>
                    </f:facet>
                    <h:outputText value="#{sampCheckList.rmk5}"   rendered="#{sampCheckList.rmk5Req}" />
                </h:column>                                  
            </t:dataTable>                        
        </h:form>
    </h:panelGrid>
    <%@ include file="foxyFooter.jsp" %>
</f:view>