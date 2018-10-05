<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>


<%@taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<%@taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@taglib prefix="h" uri="http://java.sun.com/jsf/html"%>



<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">


<f:view>
    <%@ include file="foxyHeader.jsp" %>
    <f:loadBundle basename="com.foxy.page.ValidatorMessages" var="ValidatorMsg"/>
    <table class="box" width="100%">
        <tr><td>
                <h:messages errorClass="FOX_ERROR" showDetail="true" showSummary="true"/>
                <h:panelGrid id="DownloadOCFGridNotFound" styleClass="tablebg" width="100%" rendered="#{not foxyDownloadOrderConfirmationForm.ordIdSet}">
                    <t:outputText value="No Reference number been set"  styleClass="FOX_ERROR" />
                </h:panelGrid>
                <h:panelGrid id="DownloadOCFGrid" columns="1" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="100%" rendered="#{foxyDownloadOrderConfirmationForm.ordIdSet}">
                    <h:outputText value="Order Confirmation Form for [#{foxyDownloadOrderConfirmationForm.ordId}] Filter by country (made in)" styleClass="smalltitle" />
                    <h:form id="DownloadOCF"  enctype="multipart/form-data">                     
                        <h:panelGrid id="enq" columns="2" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="100%">
                            <!-- ==================== Input Filed for [Country Code] --START-- ========================= -->
                            <t:outputLabel for="Country" value="Country [made in]:" />
                            <h:selectOneMenu id="Country" style="width:200px; height:25px" styleClass="FOX_INPUT" required="false" value="#{foxyDownloadOrderConfirmationForm.origin}">
                                <f:selectItems value="#{foxyDownloadOrderConfirmationForm.madeInList}"/>
                            </h:selectOneMenu>
                            <h:message errorClass="FOX_ERROR" for="Country" showDetail="true" showSummary="true"/>
                            <!-- ==================== Input Filed for [Country code] --END  -- ========================= -->
                        </h:panelGrid>
                        <t:commandButton value="Download OCF" action="#{foxyDownloadOrderConfirmationForm.OrderConfirmationFromByCountry}" immediate="false" size="20"/>
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
