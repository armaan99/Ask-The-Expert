<%@page contentType="text/html" pageEncoding="UTF-8"%>

<html>
    <head>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<style type="text/css">
            *{
		box-sizing: border-box;
            }
            body{
                overflow: hidden;
                background-image: url('Images//background.jpg');
                background-position: center;
                background-repeat: no-repeat;
                background-size: cover;
                position: relative;
            }
            .left{
                float: left;
                padding: 1%;
                margin-top: -2%;
                height: 100%;
                width: 65%;
            }
            .right{
                float: left;
                padding: 1%;
                height: 100%;
                width: 35%;
            }
            .navigator{
                text-align: right;
                text-decoration: none;
                margin: 0% 4% 5% 0%;
            }
            .dropdown{
                position: relative;
                display: inline-block;
                margin: 2% 5% 3% 0%;
            }
            .dropdownList{
                background-color: #B22222;
                border: none;
                font-weight: bold;
                color: #ffffff;
                font-size: 15px;
                padding: 10px;
                opacity: 0.8;
            }
            .dropdownList:hover{
                opacity: 1;
            }
            .dropdownContent a:hover{
                background-color: #f1f1f1;
                color: #000000;
                font-weight: bold;
            }
            .dropdownContent{
                position: absolute;
                display: none;
                background-color: #ffffff;
                opacity: 1;
                text-align: left;
                z-index: 1;
            }
            .dropdownContent a{
                color: #000000;
                padding: 5px 15px;
                display: block;
                text-decoration: none;
                opacity: 1;
            }
            .dropdown:hover .dropdownContent{
                display: block;
            }
            .myTitle{
                color: #ffffff;
                font-size: 60px;
                text-align: center;
                font-weight: bold;
                font-style: italic;
                font-family: monospace;
                line-height: 20px;
                margin-top: 18%;
                margin-right: 14%;
            }
            .box{
                border: 1px outset #808080;
                background-color: #000000;
                opacity: 0.6;
                width: 32%;
                height: 58%;
                position: absolute;
                padding-top: 8%;
                left: 80%;
                top: 60%;
                transform: translate(-50%, -50%);
            }
            input[type=text], input[type=password] {
                width: 80%;
                align-self: center;
                padding: 2.5%;
                margin: 6% 10%;
                display: inline-block;
                border: none;
                background: #f1f1f1;
                float: left;
            }

            input[type=text]:focus, input[type=password]:focus {
                background-color: #ddd;
                outline: none;
            }
            .registerBtn{
                background-color: #ff0000;
                color: white;
                font-size: 100%;
                font-weight: bold;
                text-align: center;
                margin: 4% 25%;
                border: none;
                cursor: pointer;
                width: 50%;
                height: 40px;
                opacity: 0.8;
            }
            .registerBtn:hover {
                opacity: 1;
            }
            .popup{
                position: fixed;
                z-index: 1;
                left: 69.8%;
                top: 80%;
                width: 20%;
                overflow: auto;
                background-color: transparent;
            }
            .popupText{
                color: #ffffff;
                font-size: 22px;
                text-align: center;
                margin: 2%;
                font-family: fantasy;
            }
            .footer{
                background-color: #000000;
                color: #ffffff;
                text-align: center;
                padding-bottom: 50px;
                opacity: 0.3;
                width: 100%;
                height: 60px;
                position: fixed;
                left: 63%;
                top: 95%;
                transform: translate(-63%, -20%);
            }
            .copyright{
                margin-bottom: 50px;
            }
	</style>
        <script type="text/javascript">
            $(document).ready(function(){
                
                var body = $("body");
                var box = $(".box");
                
                $(box).append('<form action="ProcessExpertSignUpVerification.jsp" method="POST">'+
                    '<input type="password" name="otp" id="otp" placeholder="OTP sent on Mail" required>'+
                    '<button type="submit" class="registerBtn">Register</button></form>');
            
                <%
                if((int)session.getAttribute("ExpertRegisterInvalidOTP") == 1){
                    %>
                    $(body).append('<div class="popup"><p class="popupText">Invalid OTP<p></div>');
                    var error = $(".popupText");
                    $(window).click(function(){
                        $(error).css("display","none");
                    });
                    <%
                }
                %>
            });
        </script>
    </head>
    <body>
        <%
        session.setAttribute("QuestionerExists", 0);
        session.setAttribute("QuestionerPasswordMissmatched", 0);
        session.setAttribute("QuestionerAccountDeletedSuccessfully", 0);
        session.setAttribute("QuestionerTemporaryPasswordSentOnMail", 0);
        session.setAttribute("QuestionerInvalidMailID", 0);
        
        session.setAttribute("ExpertExists", 0);
        session.setAttribute("ExpertBlocked", 0);
        session.setAttribute("ExpertLoginFailed", 0);
        session.setAttribute("ExpertInvalidMailID", 0);
        session.setAttribute("ExpertTemporaryPasswordSentOnMail",0);
        session.setAttribute("ExpertAccountDeletedSuccessfully", 0);
        session.setAttribute("ExpertPasswordChangedSuccessfully", 0);
        session.setAttribute("ExpertRegisterInvalidOTP", 0);
        %>
	<div>
            <div class="left">
		<a href="Home.jsp" class="logo" ><img src='Images\logo.png' width="220" height="220"/></a>
            </div>
            <div class="right">
		<div class="navigator">
                    <div class="dropdown">
			<button class="dropdownList">Login</button>
			<div class="dropdownContent">
                            <a href="ExpertLogin.jsp">Expert</a>
                            <a href="QuestionerLogin.jsp">Questioner</a>
			</div>
                    </div>
                    <div class="dropdown">
			<button class="dropdownList">SignUp</button>
                        <div class="dropdownContent">
                            <a href="ExpertSignUp.jsp">Expert</a>
                            <a href="QuestionerSignUp.jsp">Questioner</a>
                        </div>
                    </div>
		</div>
		<p class="myTitle">ASKtheEXPERT</p>
		<div class="box">
                </div>
            </div>
	</div>
	<div class="footer">
            <p class="copyright">Copyright 2020 © Theme Created By Aashi Gupta, Harshita Lashkari, Armaan Agrawal All Rights Reserved</p>
	</div>
    </body>
</html>