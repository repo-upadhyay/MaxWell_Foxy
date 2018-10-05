<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%@taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<%@taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@taglib uri="http://java.sun.com/jsf/html" prefix="h" %>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
    <title>FoxyApp</title>
    <f:loadBundle basename="com.foxy.foxMessage" var="foxMsg"/>
    <meta HTTP-EQUIV="Content-Type" CONTENT="text/html;charset=UTF-8" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/foxyStyle.css" />
    <script language=JavaScript src="${pageContext.request.contextPath}/style/foxyScript.js"></script>
    
</head>
<body>

<div id="foxyConfirmLogoutBox">
    <table height='100%' width='100%'>
        <tr height='70%'><td>
                <center>Do you want to exit now?</center>
        </td></tr>
        <tr><td>
                <center>
                    <a href="../logout.jsp"> Logout </a>&nbsp;&nbsp;
                    <a href="#" onclick="foxyHide('foxyConfirmLogoutBox')"> Cancel </a>
                </center>
        </td></tr>
    </table>
</div>
<div id="foxyProcessing" class="global-font">
    <!--IMG ALT="Pricessing ..." SRC="../images/processing.gif"></IMG-->
    <table height='100%' width='100%'>
        <tr>
            <td align='center' width='100%'>
                <b> &nbsp;&nbsp;&nbsp;Loading ... </b>
            </td>
        </tr>
    </table>
</div>

<center>
<table id='global' width='99%' cellspacing='0' height='80%' align='center' border="0">        
<tr>
    <td class='global-header' align='left' width='80%'><img src='../images/logo.png' alt='logo'/></td>
    <td valign='bottom' align='left' width='20%'><span style="color: #0060A0; font-size: 18px; text-align: right;"><b>~ Foxy System ~</b></span></td>
</tr>	                
<tr height='0%'>
    <td colspan="2">    
        <h:form style="margin-bottom: 0">
            <t:panelGrid columns="3" width="100%"  border="0" cellpadding="0" cellspacing="0"                 
                         columnClasses="global-menu-left, global-menu-center, global-menu-right" >
                <h:panelGroup>
                    <t:jscookMenu id="foxyMenu" layout="hbr" theme="ThemeOffice" styleLocation="/style">
                        <t:navigationMenuItems id="foxyMenu_1" value="#{foxyMenu.navItems}"/>
                    </t:jscookMenu>
                </h:panelGroup>
                <%-- Display for order --%>
                <h:panelGroup rendered="#{not foxySessionData.invShortCut}" >
                    <h:panelGroup style="width='100%'">
                        <t:graphicImage url="../images/space.gif" height="15" width="5" border="0" align="top"/>
                        <h:commandLink id="NewSearch" style="vertical-align:center;" action="#{foxyOrderSearch.newSearch}" onmousedown="foxyShow('foxyProcessing')">
                            <t:graphicImage url="../images/search.png" height="18" border="0" align="top" onclick="foxyShow('foxyProcessing')"/>
                            <h:outputText value="  New Search" styleClass="global-menu-link"/>
                            <f:param name="jscook_action" value="xxxxxxxxxxxxxxxxxxxxxx*go_schOrder"/>
                        </h:commandLink>
                        <t:graphicImage url="../images/space.gif" height="15" width="10" border="0" align="top"/>
                        <h:panelGroup rendered="#{foxySessionData.list}">
                            <h:commandLink id="BackToList" action="#{foxyOrderSearch.backToList}" onmousedown="foxyShow('foxyProcessing')">
                                <t:graphicImage url="../images/list1.png" height="18" border="0" align="top" onclick="foxyShow('foxyProcessing')"/>
                                <h:outputText value="  Back To List" styleClass="global-menu-link"/>
                                <f:param name="jscook_action" value="xxxxxxxxxxxxxxxxxxxxxx*go_lstOrder"/>
                            </h:commandLink>
                        </h:panelGroup>
                        <t:graphicImage url="../images/space.gif" height="15" width="86" border="0" align="top" rendered="#{not foxySessionData.list}"/>                                                
                        
                        <h:panelGroup rendered="#{foxySessionData.displayOrderId}">
                            <t:graphicImage url="../images/space.gif" height="15" width="10" border="0" align="top"/>   
                            <h:outputText value=" Ref #: #{foxySessionData.orderId}" styleClass="global-font"/>
                            <t:graphicImage url="../images/space.gif" height="15" width="10" border="0" align="top"/>   
                            <h:outputText value=" "/>
                            <h:commandLink id="getPdf" action="#{foxyReport.OrderEntryForm}" immediate="true">
                                <t:graphicImage url="../images/oef1.gif" 
                                                onmousedown="this.src='../images/oef2.gif'" 
                                                onmouseover="this.src='../images/oef1.gif'" 
                                                onmouseout="this.src='../images/oef1.gif'"
                                                height="18" border="0" align="top"/>                                
                                <f:param name="jscook_action" value="xxxxxxxxxxxxxxxxxxxxxx*go_enqOrder"/>
                            </h:commandLink>
                            
                            <h:outputText value=" "/>
                            <h:commandLink id="getOcfPdf" action="#{foxyOrderSearch.shortCut}" onmousedown="foxyShow('foxyProcessing')">
                                <t:graphicImage url="../images/ocf1.gif" 
                                                onmousedown="this.src='../images/ocf2.gif'" 
                                                onmouseover="this.src='../images/ocf1.gif'" 
                                                onmouseout="this.src='../images/ocf1.gif'"
                                                height="18" border="0" align="top"/>                                 
                                <f:param name="jscook_action" value="xxxxxxxxxxxxxxxxxxxxxx*go_downloadOCF"/>
                            </h:commandLink>                            
                            <h:outputText value=" "/>
                            <h:commandLink id="OrderEnq" action="#{foxyOrder.shortCut}">
                                <t:graphicImage url="../images/order1.gif" 
                                                onclick="foxyShow('foxyProcessing')"
                                                onmousedown="src='../images/order2.gif'" 
                                                onmouseup="src='../images/order1.gif'" 
                                                onmouseout="src='../images/order1.gif'"
                                                height="18" border="0" align="top"/>                                
                                <f:param name="jscook_action" value="xxxxxxxxxxxxxxxxxxxxxx*go_enqOrder"/>
                            </h:commandLink>                        
                            <h:outputText value=" "/>
                            <h:commandLink id="OrderInstruction" action="#{foxyOrderInstruction.shortCut}">
                                <t:graphicImage url="../images/lot1.gif" 
                                                onclick="foxyShow('foxyProcessing')"
                                                onmousedown="src='../images/lot2.gif'" 
                                                onmouseup="src='../images/lot1.gif'" 
                                                onmouseout="src='../images/lot1.gif'"
                                                height="18" border="0" align="top"/>
                                
                                <f:param name="jscook_action" value="xxxxxxxxxxxxxxxxxxxxxx*go_newOrderInstruction"/>
                            </h:commandLink>                        
                            <h:outputText value=" "/>
                            <h:commandLink id="OrderPO" action="#{foxyOrderPO.shortCut}">
                                <t:graphicImage url="../images/mr1.gif" 
                                                onclick="foxyShow('foxyProcessing')"
                                                onmousedown="src='../images/mr2.gif'" 
                                                onmouseup="src='../images/mr1.gif'" 
                                                onmouseout="src='../images/mr1.gif'"
                                                height="18" border="0" align="top"/>                                
                                <f:param name="jscook_action" value="xxxxxxxxxxxxxxxxxxxxxx*go_enqOrderPO"/>
                            </h:commandLink>                        
                            <h:outputText value=" "/>
                            <h:commandLink id="Shipping" action="#{foxyShipping.shortCut}">
                                <t:graphicImage url="../images/shipping1.gif" 
                                                onclick="foxyShow('foxyProcessing')"
                                                onmousedown="src='../images/shipping2.gif'" 
                                                onmouseup="src='../images/shipping1.gif'" 
                                                onmouseout="src='../images/shipping1.gif'"
                                                height="18" border="0" align="top"/>
                                <f:param name="jscook_action" value="xxxxxxxxxxxxxxxxxxxxxx*go_enqShipping"/>
                            </h:commandLink>                                                
                            <h:outputText value=" "/>
                        </h:panelGroup>                     
                    </h:panelGroup>
                </h:panelGroup>
                
                
                <%-- Display for Inventory --%>
                
                <h:panelGroup rendered="#{foxySessionData.invShortCut}">
                    <h:panelGroup style="width='100%';">
                        <t:graphicImage url="../images/space.gif" height="15" width="5" border="0" align="top"/>
                        
                        <h:commandLink id="NewInvSearch" style="vertical-align:center;" action="#{foxyInventory.searchs}" onmousedown="foxyShow('foxyProcessing')">
                            <t:graphicImage url="../images/search.png" height="18" border="0" align="top" onclick="foxyShow('foxyProcessing')"/>
                            <h:outputText value="  New Search" styleClass="global-menu-link"/>
                            <f:param name="jscook_action" value="xxxxxxxxxxxxxxxxxxxxxx*go_schInventory"/>
                        </h:commandLink>
                        
                        <t:graphicImage url="../images/space.gif" height="15" width="10" border="0" align="top"/>
                        <h:panelGroup rendered="#{foxySessionData.list}">
                            <h:commandLink id="BackToInvList" action="#{foxyInventory.shortCut}" onmousedown="foxyShow('foxyProcessing')">
                                <t:graphicImage url="../images/list1.png" height="18" border="0" align="top" onclick="foxyShow('foxyProcessing')"/>
                                <h:outputText value="  Back To List" styleClass="global-menu-link"/>
                                <f:param name="jscook_action" value="xxxxxxxxxxxxxxxxxxxxxx*go_lstInventory"/>
                            </h:commandLink>
                        </h:panelGroup>
                        <t:graphicImage url="../images/space.gif" height="15" width="86" border="0" align="top" rendered="#{not foxySessionData.list}"/>                                                
                        
                        <h:panelGroup rendered="#{foxySessionData.displayInvId}">
                            <t:graphicImage url="../images/space.gif" height="15" width="10" border="0" align="top"/>   
                            <h:outputText value=" Invoice #: #{foxySessionData.orderId}" styleClass="global-font"/>
                            <t:graphicImage url="../images/space.gif" height="15" width="10" border="0" align="top"/>   
                            <h:outputText value=" "/>
                        </h:panelGroup> 
                        <h:panelGroup rendered="#{not foxySessionData.displayInvId}">
                            <t:graphicImage url="../images/space.gif" height="15" width="130" border="0" align="top"/>   
                            <h:outputText value=" "/>
                        </h:panelGroup> 
                        
                        <t:graphicImage url="../images/space.gif" height="15" width="5" border="0" align="top"/>
                        <h:commandLink id="NewSearchInv" style="vertical-align:center;" action="#{foxyOrderSearch.newSearch}" onmousedown="foxyShow('foxyProcessing')">
                            <t:graphicImage url="../images/costinfo1.gif" 
                                            onmousedown="this.src='../images/costinfo2.gif'" 
                                            onmouseover="this.src='../images/costinfo1.gif'" 
                                            onmouseout="this.src='../images/costinfo1.gif'"
                                            height="18" border="0" align="top" onclick="foxyShow('foxyProcessing')"/>                           
                            <f:param name="jscook_action" value="xxxxxxxxxxxxxxxxxxxxxx*go_schOrder"/>
                        </h:commandLink>                        
                        
                    </h:panelGroup>
                </h:panelGroup>
                
                
                <h:panelGroup>
                    <h:outputText value="#{foxyMain.userId} "/>
                    <h:outputLink value="#" onclick="foxyShow('foxyConfirmLogoutBox')">
                        <h:outputText value="[Logout]" />
                    </h:outputLink>
                    <t:graphicImage url="../images/space.gif" height="15" width="5" border="0" align="top"/>
                </h:panelGroup>                
            </t:panelGrid>            
        </h:form>
    </td>
</tr>
<tr height='588'>
<td colspan='3' valign='top'>
