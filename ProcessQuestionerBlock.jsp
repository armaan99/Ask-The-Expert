<%@page import="dao.Questioner_dao" %>
<%
if(Questioner_dao.blockQuestioner(request.getParameter("questionerMailID")))
    response.sendRedirect("AdminHome.jsp");
else
    response.sendRedirect("AdminHome.jsp");
%>