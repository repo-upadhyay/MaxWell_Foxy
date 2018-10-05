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
            <h:panelGrid id="FileUploadGridNotFound" styleClass="tablebg" width="100%" rendered="#{not foxyFileUpload.ordIdSet}">
                <t:outputText value="No Reference number been set"  styleClass="FOX_ERROR" />
            </h:panelGrid>
            <h:panelGrid id="FileUploadGrid" columns="1" styleClass="tablebg" width="100%" rendered="#{foxyFileUpload.ordIdSet}">
                <h:outputText value="Order [#{foxyFileUpload.ordId}] Sample Photo Upload" styleClass="smalltitle" />
                <h:form id="FileUploadForm"  enctype="multipart/form-data">                     
                    
                    <h:panelGrid id="enq" columns="1" width="100%">
                        <!-- ==================== Input Filed for [Category Code] --START-- ========================= -->
                        <h:panelGroup>
                            <t:outputLabel for="fileupload" value="File name" />                        
                            <t:inputFileUpload id="fileupload"
                                accept="image/*"
                                value="#{foxyFileUpload.upFile}"
                                storage="file"
                                styleClass="fileUploadInput"
                                required="true" size="35">
                            </t:inputFileUpload>
                            <h:commandButton value="Upload" action="#{foxyFileUpload.upload}" style="horizontal-align: left;">
                                <t:updateActionListener property="#{foxySessionData.pageParameter}" value="#{foxyFileUpload.ordId}"/>
                            </h:commandButton>                            
                        </h:panelGroup>
                        <!-- ==================== Input Filed for [Category Code] --END  -- ========================= -->
                    </h:panelGrid>
                </h:form>                
                <t:graphicImage  url="/app/DisplayPicture?imageid=#{foxyFileUpload.ordId}"/>
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
