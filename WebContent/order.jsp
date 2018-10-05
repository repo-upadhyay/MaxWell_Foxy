<%@taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@taglib prefix="h" uri="http://java.sun.com/jsf/html"%>

<f:view>
    <f:subview id="header">
        <jsp:include page="foxyHeader.jsp" flush="true">
            <jsp:param name="pageName" value="Order Form"/>
        </jsp:include>
    </f:subview>                    
        
        <h:form id="order">
            <table class="forumline" cellspacing="0" width="97%">
                <tbody>
                    <tr>
                        <td class="row-header"><span>Incident Register</span></td>
                    </tr>
                    <tr> 
                        <td class="row1" style="padding: 10px 10px 10px;" align="center">
                            <table cellpadding="3" cellspacing="1" width = "100%">
                                <tbody>
                                    <tr> 
                                        <td class="row1" nowrap="nowrap" width="28%"><span class="fontgen">Reference Number:</span></td>
                                        <td class="row2" ><h:inputText id="orderid" styleClass="post" value="#{orderPage.orderid}"/> </td>
                                    </tr>
                                    <tr> 
                                        <td class="row1" nowrap="nowrap" width="28%"><span class="fontgen">Date:</span></td>
                                        <td class="row2" >
                                            <h:inputText id="date" styleClass="post" value="#{orderPage.date}">                                                 
                                                <f:validateDoubleRange minimum="100" maximum="1000"/>
                                            </h:inputText>
                                            
                                        </td>
                                    </tr>

                                    <tr> 
                                        <td class="row1" nowrap="nowrap" width="28%"><span class="fontgen">Customer:</span></td>
                                        <td class="row2" ><h:inputText id="customer" styleClass="post" value="#{orderPage.customer}"/> </td>
                                    </tr>
                                    <tr> 
                                        <td class="row1" nowrap="nowrap" width="28%"><span class="fontgen">Style:</span></td>
                                        <td class="row2" ><h:inputText id="style" styleClass="post" value="#{orderPage.style}"/> </td>
                                    </tr>
                                    <tr> 
                                        <td class="row1" nowrap="nowrap" width="28%"><span class="fontgen">Season:</span></td>
                                        <td class="row2" ><h:inputText id="season" styleClass="post" value="#{orderPage.season}"/> </td>
                                    </tr>
                                    <tr> 
                                        <td class="row1" nowrap="nowrap" width="28%"><span class="fontgen">Type:</span></td>
                                        <td class="row2" ><h:inputText id="type" styleClass="post" value="#{orderPage.type}"/> </td>
                                    </tr>
                                        
                                    <tr> 
                                        <td class="row1" nowrap="nowrap" width="28%"><span class="fontgen">Merchandiser:</span></td>
                                        <td class="row2" ><h:inputText id="merchandiser" styleClass="post" value="#{orderPage.merchandiser}"/> </td>
                                    </tr>
                                    <tr> 
                                        <td class="row1" nowrap="nowrap" width="28%" valign="top"><span class="fontgen">Description:</span></td>
                                        <td class="row2" ><h:inputTextarea rows="3" cols="60" id="description" styleClass="post" value="#{orderPage.description}"/> </td>
                                    </tr>
                                    <tr> 
                                        <td class="row1" nowrap="nowrap" width="28%" valign="top"><span class="fontgen">Fabric:</span></td>
                                        <td class="row2" ><h:inputTextarea rows="3" cols="60" id="fabric" styleClass="post" value="#{orderPage.fabric}"/> </td>
                                    </tr>

			
                                    <tr><td>&nbsp;</td></tr>
                                    <tr align="center"> 
                                        <td colspan="2">
                                            <h:commandButton id="saveButton" type="submit" value="Save" action="#{orderPage.save}"/>&nbsp;&nbsp;
                                            <h:commandButton id="resetButton" type="reset" value="Clear"/>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                </tbody>
            </table>
        </h:form>
    <f:subview id="footer">
        <jsp:include page="foxyFooter.jsp" flush="true"/>
    </f:subview>                    
</f:view>
 