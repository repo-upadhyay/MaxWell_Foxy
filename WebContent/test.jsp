<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<%@taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@taglib prefix="h" uri="http://java.sun.com/jsf/html"%>

<%--
The taglib directive below imports the JSTL library. If you uncomment it,
you must also add the JSTL library to the project. The Add Library... action
on Libraries node in Projects view can be used to add the JSTL 1.1 library.
--%>
<%--
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
--%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>

        <h1>JSP Page</h1>
    
        <%--
        This example uses JSTL, uncomment the taglib directive above.
        To test, display the page like this: index.jsp?sayHello=true&name=Murphy
        --%>
        <%--
        <c:if test="${param.sayHello}">
        <!-- Let's welcome the user ${param.name} -->
        Hello ${param.name}!
        </c:if>
        --%>
    
        <h:form>
            <h:panelGroup id="body">

                <h:panelGrid columns="1">
                    <h:commandLink rendered="#{!crossDataTable.editValues}" action="#{crossDataTable.editValues}"
                        immediate="true">
                        <h:outputText value="#{example_messages['country_edit_table']}"
                        styleClass="standard" />
                    </h:commandLink>
                    <h:panelGrid rendered="#{!crossDataTable.editValues}" columns="3">
                        <h:outputLabel for="columnLabel" value="#{example_messages['crosstable_field_column']}"/>
                        <h:inputText id="columnLabel" value="#{crossDataTable.columnLabel}" />
                        <h:commandLink action="#{crossDataTable.addColumn}">
                            <h:outputText value="#{example_messages['crosstable_add_column']}"
                            styleClass="standard" />
                        </h:commandLink>
                    </h:panelGrid>
                    <h:commandLink rendered="#{crossDataTable.editValues}" action="#{crossDataTable.saveValues}">
                        <h:outputText value="#{example_messages['crosstable_save_values']}"
                        styleClass="standard" />
                    </h:commandLink>
                </h:panelGrid>
                <f:verbatim>
                    <br>
                </f:verbatim>

                <t:dataTable id="data" styleClass="standardTable"
                    headerClass="standardTable_Header"
                    footerClass="standardTable_Header"
                    rowClasses="standardTable_Row1,standardTable_Row2"
                    columnClasses="standardTable_Column" var="country"
                    value="#{crossDataTable.countryDataModel}" preserveDataModel="false">
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="#{example_messages['label_country_name']}" />
                        </f:facet>
                        <h:outputText value="#{country.name}" />
                    </h:column>

                    <t:columns value="#{crossDataTable.columnDataModel}" var="column">
                        <f:facet name="header">
                            <h:panelGroup>
                                <h:outputText value="#{column} " />
                                <h:commandLink action="#{crossDataTable.removeColumn}">
                                    <h:outputText value="-" title="#{example_messages['crosstable_remove_column']}" />
                                </h:commandLink>
                            </h:panelGroup>
                        </f:facet>
                        <h:outputText rendered="#{!crossDataTable.editValues}"
                        value="#{crossDataTable.columnValue}" />
                        <h:inputText rendered="#{crossDataTable.editValues}"
                        value="#{crossDataTable.columnValue}" />
                    </t:columns>

                </t:dataTable>

                <f:verbatim>
                    <br>
                </f:verbatim>

            </h:panelGroup>
        </h:form>    
    
    
    
    
    </body>
</html>
