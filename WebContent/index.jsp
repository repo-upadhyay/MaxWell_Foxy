<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%> 
<%--
The taglib directive below imports the JSTL library. If you uncomment it,
you must also add the JSTL library to the project. The Add Library... action
on Libraries node in Projects view can be used to add the JSTL 1.1 library.
--%>
<%--
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
--%>
<html>
    <head>
        <title><bean:message key="application.Title" scope="application" /></title>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
        <script language="JavaScript">
            var winwidth=window.screen.availWidth - 12;
            var winheight=window.screen.availHeight - 12;
            var msgWin = window.open("app/foxyMain.jsf","MainFoxy","toolbar=no, menubar=yes, location=yes, scrollbars=1, resizable=1, left=0, top=0, width=" + winwidth + ", height=" + winheight);
            window.opener = null;
            window.close();
        </script> 
    </head>
    <body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
    </body>
</html>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%-- response.sendRedirect("app/foxyMain.jsf"); --%>
