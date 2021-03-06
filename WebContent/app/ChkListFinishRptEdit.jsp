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
            <h:outputText value="Edit Finish Report Record" styleClass="smalltitle" />
        </td></tr>
        <tr><td>
        
            <h:panelGrid id="norec" rendered="#{not foxyFinishRptEdit.recSelected}" columns="1">
                <h:outputText id="q11" value="Sorry no record(s) found" />
            </h:panelGrid>             
        
            <h:form id="FinishRpt" rendered="#{foxyFinishRptEdit.recSelected}">
                <table class="tablebg" width="100%">
                    <tr><td width='20%' align='right' >Country:</td>
                        <td align='left'>
                            <h:outputText id="countryCode" styleClass="FOX_INPUT" value="#{foxyFinishRptEdit.frptBean.ccode}" />
                        </td>                        
                    </tr>
                    
                    <tr><td width='20%' align='right' >Ref No:</td>
                        <td align='left'>
                            <h:outputText id="refNo" styleClass="FOX_INPUT" value="#{foxyFinishRptEdit.frptBean.refNo}" />                        
                        </td>
                    </tr>
                    

                    <tr><td width='20%' align='right' >Buyer:</td>
                        <td align='left'>
                            <h:inputText id="buyer" styleClass="FOX_INPUT" maxlength="32" size="32"  required="false" value="#{foxyFinishRptEdit.frptBean.buyer}">
                            </h:inputText>
                            <h:message errorClass="FOX_ERROR" for="buyer" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>
                    
                    
                    <tr><td width='20%' align='right' >Merchant:</td>
                        <td align='left'>
                            <h:inputText id="merchant" styleClass="FOX_INPUT" maxlength="32" size="32"  required="false" value="#{foxyFinishRptEdit.frptBean.merchant}">
                            </h:inputText>
                            <h:message errorClass="FOX_ERROR" for="merchant" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>
                    
                                        
                    <tr><td width='20%' align='right' >Cut Qty:</td>
                        <td align='left'>
                            <h:inputText id="cutQty" styleClass="FOX_INPUT" maxlength="11" size="11" required="false" value="#{foxyFinishRptEdit.frptBean.cutQty}">
                            </h:inputText>
                            <h:outputText value="pcs"/>
                            <h:message errorClass="FOX_ERROR" for="cutQty" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>                    

                    
                    <tr><td width='20%' align='right' >Sew Qty:</td>
                        <td align='left'>
                            <h:inputText id="sewQty" styleClass="FOX_INPUT" maxlength="11" size="11" required="false" value="#{foxyFinishRptEdit.frptBean.sewQty}">
                            </h:inputText>
                            <h:outputText value="pcs"/>
                            <h:message errorClass="FOX_ERROR" for="sewQty" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>                    

                    
                    <tr><td width='20%' align='right' >Wash Qty:</td>
                        <td align='left'>
                            <h:inputText id="washQtotqty" styleClass="FOX_INPUT" maxlength="11" size="11" required="false" value="#{foxyFinishRptEdit.frptBean.washQty}">
                            </h:inputText>
                            <h:outputText value="pcs"/>
                            <h:message errorClass="FOX_ERROR" for="washQty" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>                    

                    
                    <tr><td width='20%' align='right' >Pack Qty:</td>
                        <td align='left'>
                            <h:inputText id="packQty" styleClass="FOX_INPUT" maxlength="11" size="11" required="false" value="#{foxyFinishRptEdit.frptBean.packQty}">
                            </h:inputText>
                            <h:outputText value="pcs"/>
                            <h:message errorClass="FOX_ERROR" for="packQty" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>                    

                    <tr><td width='20%' align='right' >Sample Qty:</td>
                        <td align='left'>
                            <h:inputText id="sampQty" styleClass="FOX_INPUT" maxlength="11" size="11" required="false" value="#{foxyFinishRptEdit.frptBean.sampQty}">
                            </h:inputText>
                            <h:outputText value="pcs"/>
                            <h:message errorClass="FOX_ERROR" for="sampQty" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>                    

                    <tr><td width='20%' align='right' >L.O Grd A Qty:</td>
                        <td align='left'>
                            <h:inputText id="logaQty" styleClass="FOX_INPUT" maxlength="11" size="11" required="false" value="#{foxyFinishRptEdit.frptBean.logaQty}">
                            </h:inputText>
                            <h:outputText value="pcs"/>
                            <h:message errorClass="FOX_ERROR" for="logaQty" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>                    

                    <tr><td width='20%' align='right' >L.O Grd B Qty:</td>
                        <td align='left'>
                            <h:inputText id="logbQty" styleClass="FOX_INPUT" maxlength="11" size="11" required="false" value="#{foxyFinishRptEdit.frptBean.logbQty}">
                            </h:inputText>
                            <h:outputText value="pcs"/>
                            <h:message errorClass="FOX_ERROR" for="logbQty" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>                    
                    
                    
                    <tr><td width='20%' align='right' >Export Qty:</td>
                        <td align='left'>
                            <h:inputText id="exportQty" styleClass="FOX_INPUT" maxlength="11" size="11" required="false" value="#{foxyFinishRptEdit.frptBean.exportQty}">
                            </h:inputText>
                            <h:outputText value="pcs"/>
                            <h:message errorClass="FOX_ERROR" for="exportQty" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>                    

                    <tr><td width='20%' align='right' >Total Qty:</td>
                        <td align='left'>
                            <h:inputText id="totQty" styleClass="FOX_INPUT" maxlength="11" size="11" required="false" value="#{foxyFinishRptEdit.frptBean.totQty}">
                            </h:inputText>
                            <h:outputText value="pcs"/>
                            <h:message errorClass="FOX_ERROR" for="totQty" showDetail="true" showSummary="true"/>
                        </td>
                    </tr>                    

                    
                    <tr>
                        <td colspan='2' align="center" ><h:commandButton id="Save" value="Save" action="#{foxyFinishRptEdit.save}"/></td>
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