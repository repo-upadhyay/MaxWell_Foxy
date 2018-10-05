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
        <tr><td align="center">  
                <%--
                <%
                // Find out the names of all the parameters.
                java.util.Enumeration params = request.getParameterNames();
                
                while (params.hasMoreElements()) {
                    // Get the next parameter name.
                    String paramName = (String) params.nextElement();
                    
                    // Use getParameterValues in case there are multiple values.
                    String paramValues[] =
                            request.getParameterValues(paramName);
                    
                    // If there is only one value, print it out.
                    if (paramValues.length == 1) {
                        out.println(paramName+"="+paramValues[0]);
                    } else {
                        // For multiple values, loop through them.
                        out.print(paramName+"=");
                        
                        for (int i=0; i < paramValues.length; i++) {
                            // If this isn't the first value, print a comma to separate values.
                            if (i > 0) out.print(',');
                            
                            out.print(paramValues[i]);
                        }
                        out.println();
                    }
                }
                %>            
                --%>
                <h:panelGrid columns="1" >
                    <h:outputText value="#{foxySuccess.msg}" styleClass="smalltitle" rendered="#{foxySuccess.msg != null}" />
                    <h:outputText value="SUCCESS" styleClass="smalltitle" />
                </h:panelGrid>
        </td></tr>
        <tr><td>
        </td></tr>
        <tr>
            <td>
                <!-- Report List -->
            </td>
        </tr>
    </table>
    
    
    <%@ include file="foxyFooter.jsp" %>
</f:view>