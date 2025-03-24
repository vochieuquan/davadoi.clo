<%@ page import="jakarta.servlet.http.HttpSession" %>
<%
    HttpSession sessionObj = request.getSession(false);
    if (sessionObj != null) {
        sessionObj.invalidate();
    }
    response.sendRedirect("index.jsp");
%>
