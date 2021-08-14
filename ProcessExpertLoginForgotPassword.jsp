<%@page import="dao.Expert_dao" %>

<%
if(Expert_dao.forgotPassword(request.getParameter("mailID"))){
    session.setAttribute("ExpertTemporaryPasswordSentOnMail", 1);
    response.sendRedirect("ExpertLogin.jsp");
}
else{
    session.setAttribute("ExpertInvalidMailID", 1);
    response.sendRedirect("ExpertLogin.jsp");
}
%>