<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%@taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<%@taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@taglib prefix="h" uri="http://java.sun.com/jsf/html"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<f:view>
    <%@ include file="foxyHeader.jsp" %>
    <h:messages errorClass="FOX_ERROR"  showDetail="false" showSummary="true"/>
    
    <table class="box" width="100%">
        <tr><td align="center">
            <h:outputText value="Edit SampleCheck List Record" styleClass="smalltitle" />
        </td></tr>
        <tr><td align="center">
            <h:outputText value="Please check/tick all required items" style="color: #FE0000; font-weight: bold;" />
        </td></tr>        
        <tr><td>

            <h:panelGrid id="norec" rendered="#{not foxySampCheckListEdit.recSelected}" columns="1">
                <h:outputText id="q11" value="Sorry no record(s) found" />
            </h:panelGrid>        
        
        
            <h:form id="sampchecklist" rendered="#{foxySampCheckListEdit.recSelected}">
                <table class="tablebg" width="100%">
                    <tr><td width='20%' align='right' >Country:</td>
                        <td align='left'>
                            <h:outputText id="countryCode" styleClass="FOX_INPUT" value="#{foxySampCheckListEdit.sclBean.ccode}" />
                        </td>                        
                    </tr>
                    
                    <tr><td width='20%' align='right' >Ref No:</td>
                        <td align='left'>
                            <h:outputText id="refNo" styleClass="FOX_INPUT" value="#{foxySampCheckListEdit.sclBean.refNo}" />                        
                        </td>
                    </tr>

                    <tr><td width='20%' align='right' >Qty:</td>
                        <td align='left'>
                            <h:inputText id="qty" styleClass="FOX_INPUT" maxlength="11" size="11" required="false" value="#{foxySampCheckListEdit.sclBean.qty}">
                            </h:inputText>
                            <h:outputText value="pcs"/>
                            <h:message errorClass="FOX_ERROR" for="qty" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>                    

                    <tr><td width='20%' align='right' >Style:</td>
                        <td align='left'>
                            <h:inputText id="style" styleClass="FOX_INPUT" maxlength="32" size="32" required="false" value="#{foxySampCheckListEdit.sclBean.style}">
                            </h:inputText>
                            <h:message errorClass="FOX_ERROR" for="style" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>

                    <tr><td width='20%' align='right' >Buyer:</td>
                        <td align='left'>
                            <h:inputText id="buyer" styleClass="FOX_INPUT" maxlength="32" size="32"  required="false" value="#{foxySampCheckListEdit.sclBean.buyer}">
                            </h:inputText>
                            <h:message errorClass="FOX_ERROR" for="buyer" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>

                    <tr><td width='20%' align='right' >Merchant:</td>
                        <td align='left'>
                            <h:inputText id="merchant" styleClass="FOX_INPUT" maxlength="32" size="32"  required="false" value="#{foxySampCheckListEdit.sclBean.merchant}">
                            </h:inputText>
                            <h:message errorClass="FOX_ERROR" for="merchant" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>

                    <tr><td width='20%' align='right' >PO No:</td>
                        <td align='left'>
                            <h:inputText id="poNo" styleClass="FOX_INPUT" maxlength="32" size="32"  required="false" value="#{foxySampCheckListEdit.sclBean.poNo}">
                            </h:inputText>
                            <h:message errorClass="FOX_ERROR" for="poNo" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>
                    
                    
                    <tr><td width='20%' align='right'>Color:</td>
                        <td align='left'>
                            <h:inputText id="color" styleClass="FOX_INPUT" maxlength="32" size="32"  required="false" value="#{foxySampCheckListEdit.sclBean.color}">
                            </h:inputText>
                            <h:message errorClass="FOX_ERROR" for="color" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>

                    

                    <tr><td width='20%' align='right'>Delivery:</td>
                        <td align='left'>
                            <t:inputCalendar  id="del" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                            popupButtonString="Select Date" helpText="YYYYMMDD" value="#{foxySampCheckListEdit.sclBean.del}"
                            required = "false" styleClass="FOX_INPUT" />
                            <h:message errorClass="FOX_ERROR" for="del" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>

                    <tr><td width='20%' align='right'>1. Fabric Delivery:</td>
                        <td align='left'>
                            <h:selectBooleanCheckbox value="#{foxySampCheckListEdit.sclBean.fabricDelReq}"/>
                            <t:inputCalendar  id="fabricDel" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                            popupButtonString="Select Date" helpText="YYYYMMDD" value="#{foxySampCheckListEdit.sclBean.fabricDel}"
                            required = "false" styleClass="FOX_INPUT" />
                            <h:message errorClass="FOX_ERROR" for="fabricDel" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>

                    <tr><td width='20%' align='right'>2. Fit Sub1:</td>
                        <td align='left'>
                            <h:selectBooleanCheckbox value="#{foxySampCheckListEdit.sclBean.fitSub1Req}"/>
                            <t:inputCalendar  id="fitSub1" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                            popupButtonString="Select Date" helpText="YYYYMMDD" value="#{foxySampCheckListEdit.sclBean.fitSub1}"
                            required = "false" styleClass="FOX_INPUT" />
                            <h:message errorClass="FOX_ERROR" for="fitSub1" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>

                    <tr><td width='20%' align='right'>3. Comments:</td>
                        <td align='left'>
                            <h:selectBooleanCheckbox value="#{foxySampCheckListEdit.sclBean.commentsReq}"/>
                            <t:inputCalendar  id="comments" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                            popupButtonString="Select Date" helpText="YYYYMMDD" value="#{foxySampCheckListEdit.sclBean.comments}"
                            required = "false" styleClass="FOX_INPUT" />
                            <h:message errorClass="FOX_ERROR" for="comments" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>

                    <tr><td width='20%' align='right'>4. Fit Sub2:</td>
                        <td align='left'>
                            <h:selectBooleanCheckbox value="#{foxySampCheckListEdit.sclBean.fitSub2Req}"/>
                            <t:inputCalendar  id="fitSub2" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                            popupButtonString="Select Date" helpText="YYYYMMDD" value="#{foxySampCheckListEdit.sclBean.fitSub2}"
                            required = "false" styleClass="FOX_INPUT" />
                            <h:message errorClass="FOX_ERROR" for="fitSub2" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>

                    <tr><td width='20%' align='right'>5. Final AP:</td>
                        <td align='left'>
                            <h:selectBooleanCheckbox value="#{foxySampCheckListEdit.sclBean.finalApReq}"/>
                            <t:inputCalendar  id="finalAp" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                            popupButtonString="Select Date" helpText="YYYYMMDD" value="#{foxySampCheckListEdit.sclBean.finalAp}"
                            required = "false" styleClass="FOX_INPUT" />
                            <h:message errorClass="FOX_ERROR" for="finalAp" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>

                    <tr><td width='20%' align='right'>6. SO Sub1:</td>
                        <td align='left'>
                            <h:selectBooleanCheckbox value="#{foxySampCheckListEdit.sclBean.soSub1Req}"/>
                            <t:inputCalendar  id="soSub1" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                            popupButtonString="Select Date" helpText="YYYYMMDD" value="#{foxySampCheckListEdit.sclBean.soSub1}"
                            required = "false" styleClass="FOX_INPUT" />
                            <h:message errorClass="FOX_ERROR" for="soSub1" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>

                    <tr><td width='20%' align='right'>7. SO Comment1:</td>
                        <td align='left'>
                            <h:selectBooleanCheckbox value="#{foxySampCheckListEdit.sclBean.soComment1Req}"/>
                            <t:inputCalendar  id="soComment1" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                            popupButtonString="Select Date" helpText="YYYYMMDD" value="#{foxySampCheckListEdit.sclBean.soComment1}"
                            required = "false" styleClass="FOX_INPUT" />
                            <h:message errorClass="FOX_ERROR" for="soComment1" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>

                    <tr><td width='20%' align='right'>8. SO Sub2:</td>
                        <td align='left'>
                            <h:selectBooleanCheckbox value="#{foxySampCheckListEdit.sclBean.soSub2Req}"/>
                            <t:inputCalendar  id="soSub2" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                            popupButtonString="Select Date" helpText="YYYYMMDD" value="#{foxySampCheckListEdit.sclBean.soSub2}"
                            required = "false" styleClass="FOX_INPUT" />
                            <h:message errorClass="FOX_ERROR" for="soSub2" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>

                    <tr><td width='20%' align='right'>9. SO App:</td>
                        <td align='left'>
                            <h:selectBooleanCheckbox value="#{foxySampCheckListEdit.sclBean.soAppReq}"/>
                            <t:inputCalendar  id="soApp" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                            popupButtonString="Select Date" helpText="YYYYMMDD" value="#{foxySampCheckListEdit.sclBean.soApp}"
                            required = "false" styleClass="FOX_INPUT" />
                            <h:message errorClass="FOX_ERROR" for="soApp" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>

                    <tr><td width='20%' align='right'>10. AP SPL:</td>
                        <td align='left'>
                            <h:selectBooleanCheckbox value="#{foxySampCheckListEdit.sclBean.apSPLReq}"/>
                            <t:inputCalendar  id="apSPL" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                            popupButtonString="Select Date" helpText="YYYYMMDD" value="#{foxySampCheckListEdit.sclBean.apSPL}"
                            required = "false" styleClass="FOX_INPUT" />
                            <h:message errorClass="FOX_ERROR" for="apSPL" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>

                    <tr><td width='20%' align='right'>11. PP SPL:</td>
                        <td align='left'>
                            <h:selectBooleanCheckbox value="#{foxySampCheckListEdit.sclBean.ppSplReq}"/>
                            <t:inputCalendar  id="ppSpl" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                            popupButtonString="Select Date" helpText="YYYYMMDD" value="#{foxySampCheckListEdit.sclBean.ppSpl}"
                            required = "false" styleClass="FOX_INPUT" />
                            <h:message errorClass="FOX_ERROR" for="ppSpl" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>

                    <tr><td width='20%' align='right'>12. AD SPL:</td>
                        <td align='left'>
                            <h:selectBooleanCheckbox value="#{foxySampCheckListEdit.sclBean.adSplReq}"/>
                            <t:inputCalendar  id="adSpl" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                            popupButtonString="Select Date" helpText="YYYYMMDD" value="#{foxySampCheckListEdit.sclBean.adSpl}"
                            required = "false" styleClass="FOX_INPUT" />
                            <h:message errorClass="FOX_ERROR" for="adSpl" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>

                    <tr><td width='20%' align='right'>13. TOP Samp:</td>
                        <td align='left'>
                            <h:selectBooleanCheckbox value="#{foxySampCheckListEdit.sclBean.topSampReq}"/>
                            <t:inputCalendar  id="topSamp" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                            popupButtonString="Select Date" helpText="YYYYMMDD" value="#{foxySampCheckListEdit.sclBean.topSamp}"
                            required = "false" styleClass="FOX_INPUT" />
                            <h:message errorClass="FOX_ERROR" for="topSamp" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>

                    <tr><td width='20%' align='right'>14. TOP Samp Comment:</td>
                        <td align='left'>
                            <h:selectBooleanCheckbox value="#{foxySampCheckListEdit.sclBean.topSampCommentReq}"/>
                            <t:inputCalendar  id="topSampComment" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                            popupButtonString="Select Date" helpText="YYYYMMDD" value="#{foxySampCheckListEdit.sclBean.topSampComment}"
                            required = "false" styleClass="FOX_INPUT" />
                            <h:message errorClass="FOX_ERROR" for="topSampComment" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>

                    <tr><td width='20%' align='right'>15. Test Samp:</td>
                        <td align='left'>
                            <h:selectBooleanCheckbox value="#{foxySampCheckListEdit.sclBean.testSampReq}"/>
                            <t:inputCalendar  id="testSamp" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                            popupButtonString="Select Date" helpText="YYYYMMDD" value="#{foxySampCheckListEdit.sclBean.testSamp}"
                            required = "false" styleClass="FOX_INPUT" />
                            <h:message errorClass="FOX_ERROR" for="testSamp" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>

                    <tr><td width='20%' align='right'>16. Test Rpt:</td>
                        <td align='left'>
                            <h:selectBooleanCheckbox value="#{foxySampCheckListEdit.sclBean.testRptReq}"/>
                            <t:inputCalendar  id="testRpt" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                            popupButtonString="Select Date" helpText="YYYYMMDD" value="#{foxySampCheckListEdit.sclBean.testRpt}"
                            required = "false" styleClass="FOX_INPUT" />
                            <h:message errorClass="FOX_ERROR" for="testRpt" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>

                    <tr><td width='20%' align='right'>17. Final Test Samp:</td>
                        <td align='left'>
                            <h:selectBooleanCheckbox value="#{foxySampCheckListEdit.sclBean.finalTestSampReq}"/>
                            <t:inputCalendar  id="fTestSamp" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                            popupButtonString="Select Date" helpText="YYYYMMDD" value="#{foxySampCheckListEdit.sclBean.finalTestSamp}"
                            required = "false" styleClass="FOX_INPUT" />
                            <h:message errorClass="FOX_ERROR" for="fTestSamp" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>

                    <tr><td width='20%' align='right'>18. Final Gmt Test Rpt:</td>
                        <td align='left'>
                            <h:selectBooleanCheckbox value="#{foxySampCheckListEdit.sclBean.finalGmtTestRptReq}"/>
                            <t:inputCalendar  id="fGmtTestRpt" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                            popupButtonString="Select Date" helpText="YYYYMMDD" value="#{foxySampCheckListEdit.sclBean.finalGmtTestRpt}"
                            required = "false" styleClass="FOX_INPUT" />
                            <h:message errorClass="FOX_ERROR" for="fGmtTestRpt" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>

                    <tr><td width='20%' align='right'>19. Ship SPL:</td>
                        <td align='left'>
                            <h:selectBooleanCheckbox value="#{foxySampCheckListEdit.sclBean.shipSplReq}"/>
                            <t:inputCalendar  id="shipSpl" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                            popupButtonString="Select Date" helpText="YYYYMMDD" value="#{foxySampCheckListEdit.sclBean.shipSpl}"
                            required = "false" styleClass="FOX_INPUT" />
                            <h:message errorClass="FOX_ERROR" for="shipSpl" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>

                    <tr><td width='20%'  valign="top" align='right'>Store Remark:</td>
                        <td align='left'>
                            <h:inputText id="SRemark1" styleClass="FOX_INPUT" maxlength="128" size="128"  required="false" value="#{foxySampCheckListEdit.sclBean.srmk1}">
                            </h:inputText>
                            <h:message errorClass="FOX_ERROR" for="SRemark1" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>
                    

                    <tr><td width='20%'  valign="top" align='right'>20. Remark 1:</td>
                        <td align='left'>
                            <h:selectBooleanCheckbox value="#{foxySampCheckListEdit.sclBean.rmk1Req}"/>
                            <t:inputCalendar  id="rmk1date" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                            popupButtonString="Select Date" helpText="YYYYMMDD" value="#{foxySampCheckListEdit.sclBean.rmk1Date}"
                            required = "false" styleClass="FOX_INPUT" />
                            <h:inputText id="Remark1" styleClass="FOX_INPUT" maxlength="128" size="128"  required="false" value="#{foxySampCheckListEdit.sclBean.rmk1}">
                            </h:inputText>
                            <h:message errorClass="FOX_ERROR" for="Remark1" showDetail="true" showSummary="true"/>
                            
                        </td>
                    </tr>

                    <tr></tr>
                    <tr><td width='20%'  valign="top" align='right'>21. Remark 2:</td>
                        <td align='left'>
                            <h:selectBooleanCheckbox value="#{foxySampCheckListEdit.sclBean.rmk2Req}"/>
                            <t:inputCalendar  id="rmk2date" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                            popupButtonString="Select Date" helpText="YYYYMMDD" value="#{foxySampCheckListEdit.sclBean.rmk2Date}"
                            required = "false" styleClass="FOX_INPUT" />
                            <h:inputText id="Remark2" styleClass="FOX_INPUT" maxlength="128" size="128"  required="false" value="#{foxySampCheckListEdit.sclBean.rmk2}">
                            </h:inputText>

                            <h:message errorClass="FOX_ERROR" for="Remark2" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>

                    <tr></tr>
                    <tr><td width='20%' valign="top"  align='right'>22. Remark 3:</td>
                        <td align='left' >
                            <h:selectBooleanCheckbox value="#{foxySampCheckListEdit.sclBean.rmk3Req}"/>
                            <t:inputCalendar  id="rmk3date" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                            popupButtonString="Select Date" helpText="YYYYMMDD" value="#{foxySampCheckListEdit.sclBean.rmk3Date}"
                            required = "false" styleClass="FOX_INPUT" />
                            <h:inputText id="Remark3" styleClass="FOX_INPUT" maxlength="128" size="128"  required="false" value="#{foxySampCheckListEdit.sclBean.rmk3}">
                            </h:inputText>

                            <h:message errorClass="FOX_ERROR" for="Remark3" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>

                    <tr></tr>
                    <tr><td width='20%' valign="top" align='right'>23. Remark 4:</td>
                        <td align='left'>
                            <h:selectBooleanCheckbox value="#{foxySampCheckListEdit.sclBean.rmk4Req}"/>
                            <t:inputCalendar  id="rmk4date" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                            popupButtonString="Select Date" helpText="YYYYMMDD" value="#{foxySampCheckListEdit.sclBean.rmk4Date}"
                            required = "false" styleClass="FOX_INPUT" />
                            <h:inputText id="Remark4" styleClass="FOX_INPUT" maxlength="128" size="128"  required="false" value="#{foxySampCheckListEdit.sclBean.rmk4}">
                            </h:inputText>

                            <h:message errorClass="FOX_ERROR" for="Remark4" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>

                    <tr></tr>
                    <tr><td width='20%' valign="top" align='right'>24. Remark 5:</td>
                        <td align='left'>
                            <h:selectBooleanCheckbox value="#{foxySampCheckListEdit.sclBean.rmk5Req}"/>
                            <t:inputCalendar  id="rmk5date" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                            popupButtonString="Select Date" helpText="YYYYMMDD" value="#{foxySampCheckListEdit.sclBean.rmk5Date}"
                            required = "false" styleClass="FOX_INPUT" />
                            <h:inputText id="Remark5" styleClass="FOX_INPUT" maxlength="128" size="128"  required="false" value="#{foxySampCheckListEdit.sclBean.rmk5}">
                            </h:inputText>
                            
                            <h:message errorClass="FOX_ERROR" for="Remark5" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>
                    
                    
                    <tr>
                        <td colspan='2' align="center"><h:commandButton id="Save" value="Save" action="#{foxySampCheckListEdit.save}"/></td>
                    </tr>

                </table>
            </h:form>
        </td></tr>
        <tr>
            <td>
                <!-- Report List -->
            </td>
        </tr>
    </table>
    
    
    <%@ include file="foxyFooter.jsp" %>
</f:view>