<%@page import="dao.Expert_dao" %>
<%
if(Expert_dao.blockExpert(request.getParameter("expertMailID")))
    response.sendRedirect("AdminHome.jsp");
else
    response.sendRedirect("AdminHome.jsp");
%>