<%@page import="dao.Expert_dao" %>
<%@page import="dto.Expert_dto" %>
<%
String emailID = request.getParameter("mailID");
String password = request.getParameter("password");

if(!Expert_dao.isBlocked(emailID)){
    Expert_dto dtoObj = Expert_dao.checkExpert(emailID, password);

    if( dtoObj != null){
        session.setAttribute("Expert", dtoObj);
        response.sendRedirect("ExpertHome.jsp");
    }
    else{
        session.setAttribute("ExpertLoginFailed", 1);
        response.sendRedirect("ExpertLogin.jsp");
    }
}
else{
    session.setAttribute("ExpertBlocked", 1);
    response.sendRedirect("ExpertLogin.jsp");
}
%>