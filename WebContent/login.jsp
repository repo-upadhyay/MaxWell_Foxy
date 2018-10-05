<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<%@taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@taglib prefix="h" uri="http://java.sun.com/jsf/html"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
    <head>
        <title>FoxyApp</title>
        <meta HTTP-EQUIV="Content-Type" CONTENT="text/html;charset=UTF-8" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/foxyStyle.css" />
    </head>
    <body>
        <center>

            <table id='global' width='99%' border='1' cellspacing='0' height='80%'>
                <tr height='660'>
                    <td>
                        <center>
                        <div class="title">Please Login</div>
                        <p>
                            The page you requested is only available to registered users.
                            Please enter your username and password and click Login.
                        </p>
                        <form action="j_security_check" method="post">
                            <table class="tablebg" border='1'>
                                <tr>
                                    <td align="right">Username:</td>
                                    <td><input name="j_username"></td>
                                </tr>
                                <tr>
                                    <td align="right">Password:</td>
                                    <td>
                                        <input type="password" name="j_password">
                                    </td>
                                </tr>
                            </table>
                            <br>
                            <input type="submit" value="Login">&nbsp;
                            <input type="reset" value="Reset">
                        </form>
                        </center>
                    </td>
                </tr>
            </table>
        </center>
    </body>
</html>