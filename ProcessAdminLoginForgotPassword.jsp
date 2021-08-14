<%@page import="dao.Admin_dao" %>

<%
if(Admin_dao.forgotPassword(request.getParameter("mailID"))){
    session.setAttribute("AdminTemporaryPasswordSentOnMail", 1);
    response.sendRedirect("AdminLogin.jsp");
}
else{
    session.setAttribute("AdminInvalidMailID", 1);
    response.sendRedirect("AdminLogin.jsp");
}
%>