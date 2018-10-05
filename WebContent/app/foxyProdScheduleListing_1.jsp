<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<%@taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@taglib prefix="h" uri="http://java.sun.com/jsf/html"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<style type="text/css">    
    .columnTop {
    white-space: nowrap;
    vertical-align: top;
    }    
    
    .columnTopBorder {
    white-space: nowrap;
    vertical-align: top;
    border-width: 1px;
    border-top-color: #FFFFFF;
    border-bottom-color: #C1C1C1;
    border-left-color: #C1C1C1;
    border-right-color: #C1C1C1;
    border-style: solid;
    padding: 0px;    
    }        
</style>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/reportStyle.css" />

<f:view>
    <%@ include file="foxyHeader.jsp" %>
    <table class="box" width="100%">
        <tr><td>           
            <h:messages errorClass="FOX_ERROR" showDetail="true" showSummary="true" />
            <%-- Panel for List --%>
            <h:panelGrid id="ListGrid" styleClass="tablebg"  width="100%">
                <h:outputText value="Production Schedule List" styleClass="smalltitle" />                
                <h:form id="ListForm">
                    <h:outputText value="Please key in partial or full search key to search record(s)" styleClass="FOX_HELPMSG" rendered="#{not foxyProdScheduleListing.list}"/>
                    <h:panelGrid id="SearchInputGrid" columns="1" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="100%"> 
                        <h:panelGroup>
                            <t:outputLabel for="Location" value="Country:" />
                            <h:panelGroup>
                                <h:selectOneMenu id="Location" styleClass="FOX_INPUT" required="true" value="#{foxyProdScheduleListing.prodSchBean.ccode}">
                                    <f:selectItems value="#{listData.countryList}"/>
                                </h:selectOneMenu>
                            </h:panelGroup>
                        
                            <t:outputLabel for="SewStart" value="Sewing Start:" />                        
                            <h:panelGroup>
                                <t:inputCalendar  id="SewStart" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                                    helpText="YYYYMMDD" value="#{foxyProdScheduleListing.prodSchBean.sewStart}"
                                    required = "false" styleClass="FOX_INPUT">
                                </t:inputCalendar>
                            </h:panelGroup>
                        
                            <t:outputLabel for="SewEnd" value="Sewing End:" />                        
                            <h:panelGroup>
                                <t:inputCalendar  id="SewEnd" size="12" popupGotoString="go to today date" popupDateFormat="yyyyMMdd" renderAsPopup="true"
                                    helpText="YYYYMMDD" value="#{foxyProdScheduleListing.prodSchBean.sewEnd}"
                                    required = "false" styleClass="FOX_INPUT">
                                </t:inputCalendar>
                                <h:commandButton id="Search" value="Search" action="#{foxyProdScheduleListing.search}"/>
                            </h:panelGroup>
                        </h:panelGroup>
                    </h:panelGrid>

                    <h:panelGrid id="ListDisplay" columns="1" rendered="#{foxyProdScheduleListing.list}" columnClasses="FOX_LABEL_COL, FOX_INPUT_COL" width="70%">
                        <t:dataTable id="ListDataDisplayOuter"
                            styleClass="columnTopBorder"
                            headerClass="standardTable_Header"
                            footerClass="standardTable_Header"
                            rowClasses="standardTable_Row1,standardTable_Row2"
                            columnClasses="columnTopBorder"
                            var="outerRowBean"
                            value="#{foxyProdScheduleListing.outerRowBeanModel}">
                            
                            <%-- Col 0 --%>
                            <h:column>
                                <t:dataTable var="prodSch" value="#{outerRowBean.col0}" 
                                    styleClass="dataTable" 
                                    columnClasses="columnTop"
                                    border="1" width="100%"
                                    rendered="#{outerRowBean.lineNo0 != null}">
                                    
                                    <f:facet name="header">
                                        <h:outputText value="Line No [#{outerRowBean.lineNo0}]"/>
                                    </f:facet>
                                    <f:facet name="footer">
                                        <h:outputText value="End of Record(s)"/>
                                    </f:facet>                                     
                                    
                                    <h:column>
                                        <h:panelGrid columns="3" columnClasses="columnTop,columnTop,columnTop" width="100%" bgcolor="red" border="0"  cellpadding="0" cellspacing="0">
                                            <h:panelGrid columns="1" width="100%" bgcolor="red" border="0"  cellpadding="0" cellspacing="0">
                                                <h:panelGrid columns="2" width="100%" border="0" cellpadding="0" cellspacing="0" >
                                                    <h:outputText value="Ref#:" style="color: #0000FF"/>
                                                    <h:outputText value="#{prodSch.refNo}" style="color: #0000FF"/>
                                                </h:panelGrid>                                       

                                                <h:graphicImage url="/app/DisplayPicture?imageid=#{prodSch.refNo}" height="70" width="62" />
                                            </h:panelGrid>
                                        
                                            <h:panelGrid columns="2" width="100%" border="0"  cellpadding="0" cellspacing="0">
                                                <h:outputText value="BySubCon:"/>
                                                <h:outputText value="#{prodSch.subConDesc}"/>
                                                                                
                                                <h:outputText value="SewStart:" />
                                                <h:outputText value="#{prodSch.sewStart}">
                                                    <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                                                </h:outputText>

                                                <h:outputText value="Sew End:" />
                                                <h:outputText value="#{prodSch.sewEnd}">
                                                    <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                                                </h:outputText>                                                                                        

                                                <h:outputText value="Ord Qty:"/>
                                                <h:outputText value="#{prodSch.ordQty}"/>

                                                <h:outputText value="Days:"/>
                                                <h:outputText value="#{prodSch.numOfDay}"/>

                                                <h:outputText value="Daily Qty:"/>
                                                <h:outputText value="#{prodSch.dailyProdQty}"/>

                                                <h:outputText value="Groups:"/>
                                                <h:outputText value="#{prodSch.groups}"/>
                                            </h:panelGrid>

                                            <t:dataTable id="ListLots"
                                                var="lots"
                                                value="#{prodSch.lotBeanList}"
                                                width="100%">
                                            
                                                <f:facet name="header">
                                                    <h:outputText value="Lots/Vessel Date" style="color: #0000FF"/>
                                                </f:facet>
                                            

                                                <h:column>
                                                    <h:outputText value="#{lots.lot}"/>
                                                </h:column>

                                                <h:column>
                                                    <h:outputText value="#{lots.vesselDate}">
                                                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                                                    </h:outputText>
                                                </h:column>
                                            </t:dataTable>                                         
                                        </h:panelGrid>

                                        <h:panelGroup>
                                            <h:outputText value="Remark:" />
                                            <h:outputText value="#{prodSch.remark}"/>
                                        </h:panelGroup>
                                        
                                    </h:column>
                                </t:dataTable>                            
                            </h:column>

                            <%-- Col 1 --%>
                            <h:column>
                                <t:dataTable var="prodSch" value="#{outerRowBean.col1}" 
                                    styleClass="dataTable" 
                                    columnClasses="columnTop"
                                    border="1" width="100%"
                                    rendered="#{outerRowBean.lineNo1 != null}">
                                    
                                    <f:facet name="header">
                                        <h:outputText value="Line No [#{outerRowBean.lineNo1}]"/>
                                    </f:facet>
                                    <f:facet name="footer">
                                        <h:outputText value="End of Record(s)"/>
                                    </f:facet>                                     
                                    
                                    <h:column>
                                        <h:panelGrid columns="3" columnClasses="columnTop,columnTop,columnTop" width="100%" bgcolor="red" border="0"  cellpadding="0" cellspacing="0">
                                            <h:panelGrid columns="1" width="100%" bgcolor="red" border="0"  cellpadding="0" cellspacing="0">
                                                <h:panelGrid columns="2" width="100%" border="0" cellpadding="0" cellspacing="0" >
                                                    <h:outputText value="Ref#:" style="color: #0000FF"/>
                                                    <h:outputText value="#{prodSch.refNo}" style="color: #0000FF"/>
                                                </h:panelGrid>                                       

                                                <h:graphicImage url="/app/DisplayPicture?imageid=#{prodSch.refNo}" height="70" width="62" />                                        
                                            </h:panelGrid>
                                        
                                            <h:panelGrid columns="2" width="100%" border="0"  cellpadding="0" cellspacing="0">
                                                <h:outputText value="Country:"/>
                                                <h:outputText value="#{prodSch.ccode}"/>
                                                                                
                                                <h:outputText value="SewStart:" />
                                                <h:outputText value="#{prodSch.sewStart}">
                                                    <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                                                </h:outputText>

                                                <h:outputText value="Sew End:" />
                                                <h:outputText value="#{prodSch.sewEnd}">
                                                    <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                                                </h:outputText>                                                                                        

                                                <h:outputText value="Ord Qty:"/>
                                                <h:outputText value="#{prodSch.ordQty}"/>

                                                <h:outputText value="Days:"/>
                                                <h:outputText value="#{prodSch.numOfDay}"/>

                                                <h:outputText value="Daily Qty:"/>
                                                <h:outputText value="#{prodSch.dailyProdQty}"/>

                                                <h:outputText value="Groups:"/>
                                                <h:outputText value="#{prodSch.groups}"/>
                                            </h:panelGrid>

                                            <t:dataTable id="ListLots"
                                                var="lots"
                                                value="#{prodSch.lotBeanList}"
                                                width="100%">
                                            
                                                <f:facet name="header">
                                                    <h:outputText value="Lots/Vessel Date" style="color: #0000FF"/>
                                                </f:facet>
                                            

                                                <h:column>
                                                    <h:outputText value="#{lots.lot}"/>
                                                </h:column>

                                                <h:column>
                                                    <h:outputText value="#{lots.vesselDate}">
                                                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                                                    </h:outputText>
                                                </h:column>
                                            </t:dataTable>                                         
                                        </h:panelGrid>

                                        <h:panelGroup>
                                            <h:outputText value="Remark:" />
                                            <h:outputText value="#{prodSch.remark}"/>
                                        </h:panelGroup>
                                        
                                    </h:column>
                                </t:dataTable>                            
                            </h:column>

                            <%-- Col 2 --%>
                            <h:column>
                                <t:dataTable var="prodSch" value="#{outerRowBean.col2}" 
                                    styleClass="dataTable" 
                                    columnClasses="columnTop"
                                    border="1" width="100%"
                                    rendered="#{outerRowBean.lineNo2 != null}">
                                    
                                    <f:facet name="header">
                                        <h:outputText value="Line No [#{outerRowBean.lineNo2}]"/>
                                    </f:facet>
                                    <f:facet name="footer">
                                        <h:outputText value="End of Record(s)"/>
                                    </f:facet>                                     
                                    
                                    <h:column>
                                        <h:panelGrid columns="3" columnClasses="columnTop,columnTop,columnTop" width="100%" bgcolor="red" border="0"  cellpadding="0" cellspacing="0">
                                            <h:panelGrid columns="1" width="100%" bgcolor="red" border="0"  cellpadding="0" cellspacing="0">
                                                <h:panelGrid columns="2" width="100%" border="0" cellpadding="0" cellspacing="0" >
                                                    <h:outputText value="Ref#:" style="color: #0000FF"/>
                                                    <h:outputText value="#{prodSch.refNo}" style="color: #0000FF"/>
                                                </h:panelGrid>                                       

                                                <h:graphicImage url="/app/DisplayPicture?imageid=#{prodSch.refNo}" height="70" width="62" />                                        
                                            </h:panelGrid>
                                        
                                            <h:panelGrid columns="2" width="100%" border="0"  cellpadding="0" cellspacing="0">
                                                <h:outputText value="Country:"/>
                                                <h:outputText value="#{prodSch.ccode}"/>
                                                                                
                                                <h:outputText value="SewStart:" />
                                                <h:outputText value="#{prodSch.sewStart}">
                                                    <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                                                </h:outputText>

                                                <h:outputText value="Sew End:" />
                                                <h:outputText value="#{prodSch.sewEnd}">
                                                    <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                                                </h:outputText>                                                                                        

                                                <h:outputText value="Ord Qty:"/>
                                                <h:outputText value="#{prodSch.ordQty}"/>

                                                <h:outputText value="Days:"/>
                                                <h:outputText value="#{prodSch.numOfDay}"/>

                                                <h:outputText value="Daily Qty:"/>
                                                <h:outputText value="#{prodSch.dailyProdQty}"/>

                                                <h:outputText value="Groups:"/>
                                                <h:outputText value="#{prodSch.groups}"/>
                                            </h:panelGrid>

                                            <t:dataTable id="ListLots"
                                                var="lots"
                                                value="#{prodSch.lotBeanList}"
                                                width="100%">
                                            
                                                <f:facet name="header">
                                                    <h:outputText value="Lots/Vessel Date" style="color: #0000FF"/>
                                                </f:facet>
                                            

                                                <h:column>
                                                    <h:outputText value="#{lots.lot}"/>
                                                </h:column>

                                                <h:column>
                                                    <h:outputText value="#{lots.vesselDate}">
                                                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                                                    </h:outputText>
                                                </h:column>
                                            </t:dataTable>                                         
                                        </h:panelGrid>

                                        <h:panelGroup>
                                            <h:outputText value="Remark:" />
                                            <h:outputText value="#{prodSch.remark}"/>
                                        </h:panelGroup>
                                        
                                    </h:column>
                                </t:dataTable>                            
                            </h:column>

                            <%-- Col 3 --%>
                            <h:column>
                                <t:dataTable var="prodSch" value="#{outerRowBean.col3}" 
                                    styleClass="dataTable" 
                                    columnClasses="columnTop"
                                    border="1" width="100%"
                                    rendered="#{outerRowBean.lineNo3 != null}">
                                    
                                    <f:facet name="header">
                                        <h:outputText value="Line No [#{outerRowBean.lineNo3}]"/>
                                    </f:facet>
                                    <f:facet name="footer">
                                        <h:outputText value="End of Record(s)"/>
                                    </f:facet>                                     
                                    
                                    <h:column>
                                        <h:panelGrid columns="3" columnClasses="columnTop,columnTop,columnTop" width="100%" bgcolor="red" border="0"  cellpadding="0" cellspacing="0">
                                            <h:panelGrid columns="1" width="100%" bgcolor="red" border="0"  cellpadding="0" cellspacing="0">
                                                <h:panelGrid columns="2" width="100%" border="0" cellpadding="0" cellspacing="0" >
                                                    <h:outputText value="Ref#:" style="color: #0000FF"/>
                                                    <h:outputText value="#{prodSch.refNo}" style="color: #0000FF"/>
                                                </h:panelGrid>                                       

                                                <h:graphicImage url="/app/DisplayPicture?imageid=#{prodSch.refNo}" height="70" width="62" />                                        
                                            </h:panelGrid>
                                        
                                            <h:panelGrid columns="2" width="100%" border="0"  cellpadding="0" cellspacing="0">
                                                <h:outputText value="Country:"/>
                                                <h:outputText value="#{prodSch.ccode}"/>
                                                                                
                                                <h:outputText value="SewStart:" />
                                                <h:outputText value="#{prodSch.sewStart}">
                                                    <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                                                </h:outputText>

                                                <h:outputText value="Sew End:" />
                                                <h:outputText value="#{prodSch.sewEnd}">
                                                    <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                                                </h:outputText>                                                                                        

                                                <h:outputText value="Ord Qty:"/>
                                                <h:outputText value="#{prodSch.ordQty}"/>

                                                <h:outputText value="Days:"/>
                                                <h:outputText value="#{prodSch.numOfDay}"/>

                                                <h:outputText value="Daily Qty:"/>
                                                <h:outputText value="#{prodSch.dailyProdQty}"/>

                                                <h:outputText value="Groups:"/>
                                                <h:outputText value="#{prodSch.groups}"/>
                                            </h:panelGrid>

                                            <t:dataTable id="ListLots"
                                                var="lots"
                                                value="#{prodSch.lotBeanList}"
                                                width="100%">
                                            
                                                <f:facet name="header">
                                                    <h:outputText value="Lots/Vessel Date" style="color: #0000FF"/>
                                                </f:facet>
                                            

                                                <h:column>
                                                    <h:outputText value="#{lots.lot}"/>
                                                </h:column>

                                                <h:column>
                                                    <h:outputText value="#{lots.vesselDate}">
                                                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                                                    </h:outputText>
                                                </h:column>
                                            </t:dataTable>                                         
                                        </h:panelGrid>

                                        <h:panelGroup>
                                            <h:outputText value="Remark:" />
                                            <h:outputText value="#{prodSch.remark}"/>
                                        </h:panelGroup>
                                        
                                    </h:column>
                                </t:dataTable>                            
                            </h:column>

                            <%-- Col 4 --%>
                            <h:column>
                                <t:dataTable var="prodSch" value="#{outerRowBean.col4}" 
                                    styleClass="dataTable" 
                                    columnClasses="columnTop"
                                    border="1" width="100%"
                                    rendered="#{outerRowBean.lineNo4 != null}">
                                    
                                    <f:facet name="header">
                                        <h:outputText value="Line No [#{outerRowBean.lineNo4}]"/>
                                    </f:facet>
                                    <f:facet name="footer">
                                        <h:outputText value="End of Record(s)"/>
                                    </f:facet>                                     
                                    
                                    <h:column>
                                        <h:panelGrid columns="3" columnClasses="columnTop,columnTop,columnTop" width="100%" bgcolor="red" border="0"  cellpadding="0" cellspacing="0">
                                            <h:panelGrid columns="1" width="100%" bgcolor="red" border="0"  cellpadding="0" cellspacing="0">
                                                <h:panelGrid columns="2" width="100%" border="0" cellpadding="0" cellspacing="0" >
                                                    <h:outputText value="Ref#:" style="color: #0000FF"/>
                                                    <h:outputText value="#{prodSch.refNo}" style="color: #0000FF"/>
                                                </h:panelGrid>                                       

                                                <h:graphicImage url="/app/DisplayPicture?imageid=#{prodSch.refNo}" height="70" width="62" />                                        
                                            </h:panelGrid>
                                        
                                            <h:panelGrid columns="2" width="100%" border="0"  cellpadding="0" cellspacing="0">
                                                <h:outputText value="Country:"/>
                                                <h:outputText value="#{prodSch.ccode}"/>
                                                                                
                                                <h:outputText value="SewStart:" />
                                                <h:outputText value="#{prodSch.sewStart}">
                                                    <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                                                </h:outputText>

                                                <h:outputText value="Sew End:" />
                                                <h:outputText value="#{prodSch.sewEnd}">
                                                    <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                                                </h:outputText>                                                                                        

                                                <h:outputText value="Ord Qty:"/>
                                                <h:outputText value="#{prodSch.ordQty}"/>

                                                <h:outputText value="Days:"/>
                                                <h:outputText value="#{prodSch.numOfDay}"/>

                                                <h:outputText value="Daily Qty:"/>
                                                <h:outputText value="#{prodSch.dailyProdQty}"/>

                                                <h:outputText value="Groups:"/>
                                                <h:outputText value="#{prodSch.groups}"/>
                                            </h:panelGrid>

                                            <t:dataTable id="ListLots"
                                                var="lots"
                                                value="#{prodSch.lotBeanList}"
                                                width="100%">
                                            
                                                <f:facet name="header">
                                                    <h:outputText value="Lots/Vessel Date" style="color: #0000FF"/>
                                                </f:facet>
                                            

                                                <h:column>
                                                    <h:outputText value="#{lots.lot}"/>
                                                </h:column>

                                                <h:column>
                                                    <h:outputText value="#{lots.vesselDate}">
                                                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                                                    </h:outputText>
                                                </h:column>
                                            </t:dataTable>                                         
                                        </h:panelGrid>

                                        <h:panelGroup>
                                            <h:outputText value="Remark:" />
                                            <h:outputText value="#{prodSch.remark}"/>
                                        </h:panelGroup>
                                        
                                    </h:column>
                                </t:dataTable>                            
                            </h:column>

                            <%-- Col 5 --%>
                            <h:column>
                                <t:dataTable var="prodSch" value="#{outerRowBean.col5}" 
                                    styleClass="dataTable" 
                                    columnClasses="columnTop"
                                    border="1" width="100%"
                                    rendered="#{outerRowBean.lineNo5 != null}">
                                    
                                    <f:facet name="header">
                                        <h:outputText value="Line No [#{outerRowBean.lineNo5}]"/>
                                    </f:facet>
                                    <f:facet name="footer">
                                        <h:outputText value="End of Record(s)"/>
                                    </f:facet>                                     
                                    
                                    <h:column>
                                        <h:panelGrid columns="3" columnClasses="columnTop,columnTop,columnTop" width="100%" bgcolor="red" border="0"  cellpadding="0" cellspacing="0">
                                            <h:panelGrid columns="1" width="100%" bgcolor="red" border="0"  cellpadding="0" cellspacing="0">
                                                <h:panelGrid columns="2" width="100%" border="0" cellpadding="0" cellspacing="0" >
                                                    <h:outputText value="Ref#:" style="color: #0000FF"/>
                                                    <h:outputText value="#{prodSch.refNo}" style="color: #0000FF"/>
                                                </h:panelGrid>                                       

                                                <h:graphicImage url="/app/DisplayPicture?imageid=#{prodSch.refNo}" height="70" width="62" />                                        
                                            </h:panelGrid>
                                        
                                            <h:panelGrid columns="2" width="100%" border="0"  cellpadding="0" cellspacing="0">
                                                <h:outputText value="Country:"/>
                                                <h:outputText value="#{prodSch.ccode}"/>
                                                                                
                                                <h:outputText value="SewStart:" />
                                                <h:outputText value="#{prodSch.sewStart}">
                                                    <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                                                </h:outputText>

                                                <h:outputText value="Sew End:" />
                                                <h:outputText value="#{prodSch.sewEnd}">
                                                    <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                                                </h:outputText>                                                                                        

                                                <h:outputText value="Ord Qty:"/>
                                                <h:outputText value="#{prodSch.ordQty}"/>

                                                <h:outputText value="Days:"/>
                                                <h:outputText value="#{prodSch.numOfDay}"/>

                                                <h:outputText value="Daily Qty:"/>
                                                <h:outputText value="#{prodSch.dailyProdQty}"/>

                                                <h:outputText value="Groups:"/>
                                                <h:outputText value="#{prodSch.groups}"/>
                                            </h:panelGrid>

                                            <t:dataTable id="ListLots"
                                                var="lots"
                                                value="#{prodSch.lotBeanList}"
                                                width="100%">
                                            
                                                <f:facet name="header">
                                                    <h:outputText value="Lots/Vessel Date" style="color: #0000FF"/>
                                                </f:facet>
                                            

                                                <h:column>
                                                    <h:outputText value="#{lots.lot}"/>
                                                </h:column>

                                                <h:column>
                                                    <h:outputText value="#{lots.vesselDate}">
                                                        <f:convertDateTime type="date" pattern="yyMMdd" timeZone="#{foxyTimeZone.myTimeZone}"/>
                                                    </h:outputText>
                                                </h:column>
                                            </t:dataTable>                                         
                                        </h:panelGrid>

                                        <h:panelGroup>
                                            <h:outputText value="Remark:" />
                                            <h:outputText value="#{prodSch.remark}"/>
                                        </h:panelGroup>
                                        
                                    </h:column>
                                </t:dataTable>                            
                            </h:column>
                        </t:dataTable>
                        <!-- Report List -->
                    </h:panelGrid>
                </h:form>
            </h:panelGrid>
            <%-- End of List --%>            
        </td></tr>
        <tr>
            <td>
                <!-- Report List -->
            </td>
        </tr>
    </table>
    <%@ include file="foxyFooter.jsp" %>
</f:view>