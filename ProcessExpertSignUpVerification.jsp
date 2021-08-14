<%@page import="dao.Expert_dao"%>
<%@page import="dto.Expert_dto"%>
<%
String otp = request.getParameter("otp");
String otpOnMail = (String)session.getAttribute("otpOnMail");

if(otp.equals(otpOnMail)){
    Expert_dto dtoObj = (Expert_dto)session.getAttribute("Expert");
    
    if(Expert_dao.addExpert(dtoObj))
        response.sendRedirect("ExpertHome.jsp");
}
else{
    session.setAttribute("ExpertRegisterInvalidOTP", 1);
    response.sendRedirect("ExpertSignUpVerification.jsp");
}
%>