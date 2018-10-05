<%@taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@taglib prefix="h" uri="http://java.sun.com/jsf/html"%>

<f:view>
    <h:form id="order">
        <h:panelGrid columns="1">
            <h:commandButton id="saveButton1" value="User   Listing PDF report" action="#{jasperReport.actionGetUserPdfReport}"/>       
            <h:commandButton id="saveButton3" value="User Listing Html report" action="#{jasperReport.actionGetUserHtmlReport}"/>
        
            <h:commandButton id="saveButton2" value="Orders Listing PDF report" action="#{jasperReport.actionGetOrdersPdfReport}"/>
            <h:commandButton id="saveButton4" value="Order Listing Xls" action="#{jasperReport.actionGetOrdersXlsReport}"/>
        </h:panelGrid>
    </h:form>
</f:view>
 