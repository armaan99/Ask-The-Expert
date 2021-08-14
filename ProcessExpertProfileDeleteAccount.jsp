<%@page import="dao.Expert_dao"%>
<%@page import="dto.Expert_dto"%>

<%
String expertMailId = ((Expert_dto)session.getAttribute("Expert")).getEmailID();
String password = request.getParameter("password");

if(Expert_dao.deleteAccount(expertMailId, password)){
    session.setAttribute("ExpertAccountDeletedSuccessfully", 1);
    response.sendRedirect("Home.jsp");
}
else{
    session.setAttribute("ExpertAccountDeletedSuccessfully", -1);
    response.sendRedirect("ExpertProfile.jsp");
}
%>