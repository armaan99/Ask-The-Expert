<%@page import="dao.Expert_dao"%>
<%@page import="dto.Expert_dto"%>
<%
Expert_dto dtoObj = new Expert_dto();
dtoObj.setFirstName(request.getParameter("first_name"));
dtoObj.setLastName(request.getParameter("last_name"));
dtoObj.setEmailID(request.getParameter("mailID"));
dtoObj.setPassword(request.getParameter("password"));
dtoObj.setCategory(request.getParameter("category"));

if(!Expert_dao.checkExpertExistance(dtoObj.getEmailID())){
    String otpOnMail = Expert_dao.sendVerificationMail(dtoObj.getEmailID());

    session.setAttribute("Expert", dtoObj);
    session.setAttribute("otpOnMail", otpOnMail);
    response.sendRedirect("ExpertSignUpVerification.jsp");
}
else{
    session.setAttribute("ExpertExists", 1);
    response.sendRedirect("ExpertSignUp.jsp");
}
%>