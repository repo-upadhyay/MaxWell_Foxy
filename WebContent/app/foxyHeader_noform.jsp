<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-tiles" prefix="tiles" %>

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
    <div id="foxyConfirmBox">
        <center><a href="../logout.jsp"> Logout </a></center>
        <input type="button" value="Cancel" onclick="foxyHide('foxyConfirmBox')">
        <!--span class="ct"><span class="cl"></span></span>	
        <div>
        <h1>You have signed out of the Yahoo! network.</h1>
        <span id="yregsnlnks"><a href="http://rd.yahoo.com/reg/logout_rtrn/us/*http://mail.yahoo.com/">Return to Yahoo! Mail</a></span>
        </div>
        <span class="cb"><span class="cl"></span></span-->
    </div>

    <center>
    <table id='global' width='99%' cellspacing='0' height='80%' align='center' botder="1">
    <tr>
        <td class='global-header' align='left'><img src='../images/logo.jpg' alt=''></td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td class='global-menu-left' width="70%">   
            <t:jscookMenu id="foxyMenu" layout="hbr" theme="ThemeOffice" styleLocation="/style">
                <t:navigationMenuItems id="foxyMenu_1" value="#{foxyMenu.navItems}"/>
            </t:jscookMenu>
        </td>
        <td class='global-menu-right'> You're logged in as "<h:outputText value="#{foxyMain.userId}"/>"&nbsp;&nbsp;
            [<h:outputLink value="#" onclick="foxyShow('foxyConfirmBox')"><h:outputText value="Logout" />
            </h:outputLink>] &nbsp;&nbsp;
        </td>
    </tr>
    <tr height='530'>
        <td colspan='2' valign='top'>

        