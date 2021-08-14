<%@page contentType="text/html" pageEncoding="UTF-8"%>

<html>
    <head>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
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
                left: 80%;
                top: 60%;
                transform: translate(-50%, -50%);
            }
            .subHead{
                color: #ffffff;
                font-weight: bold;
                font-size: 40px;
                text-align: center;
                transform: translate(0%, 120%);
            }
            input[type=text]{
                width: 70%;
                height: 35px;
                align-self: center;
                padding: 10px;
                margin:70px 48px;
                display: inline-block;
                border: none;
                background: #f1f1f1;
                float: left;
                font-size: 15px
            }
            input[type=text]:focus{
                background-color: #ddd;
                outline: none;
                font-size: 15px;
            }
            .search_icon{
                width: 10%;
                height: 35px;
                align-self: center;
                padding: 10px;
                margin:70px -50px;
                display: inline-block;
                border: none;
                background: #FF0000;
                float: left;
                cursor: pointer;
                color: #ffffff;
            }
            .search_icon:hover{
                background-color: #8B0000;
            }
            .footer{
                background-color: #000000;
                color: #ffffff;
                text-align: center;
                padding-bottom: 3%;
                opacity: 0.3;
                width: 100%;
                height: 5%;
                position: fixed;
                left: 50%;
                top: 94%;
                transform: translate(-50%, 0%);
            }
            .copyright{
                margin-bottom: 50px;
            }
	</style>
    </head>
    <body>
        <%
        session.setAttribute("QuestionerExists", 0);
        session.setAttribute("QuestionerPasswordMissmatched", 0);
        session.setAttribute("QuestionerBlocked", 0);
        session.setAttribute("QuestionerLoginFailed", 0);
        session.setAttribute("QuestionerPasswordChangedSuccessfully", 0);
        session.setAttribute("QuestionerTemporaryPasswordSentOnMail", 0);
        session.setAttribute("QuestionerInvalidMailID", 0);
        
        session.setAttribute("ExpertExists", 0);
        session.setAttribute("ExpertBlocked", 0);
        session.setAttribute("ExpertLoginFailed", 0);
        session.setAttribute("ExpertInvalidMailID", 0);
        session.setAttribute("ExpertTemporaryPasswordSentOnMail",0);
        session.setAttribute("ExpertAccountDeletedSuccessfully", 0);
        session.setAttribute("ExpertPasswordChangedSuccessfully", 0);
        
        session.setAttribute("AdminLoginFailed", 0);
        session.setAttribute("AdminTemporaryPasswordSentOnMail", 0);
        session.setAttribute("AdminInvalidMailID", 0);
        session.setAttribute("AdminPasswordChangedSuccessfully", 0);
        %>
        <div>
            <div class="left">
		<a href="AdminLogin.jsp" class="logo" ><img src='Images\logo.png' width="220" height="220"/></a>
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
                    <p class="subHead">Look for your Query</p>
                    <form class="search" action="SearchResult.jsp" method="POST">
                        <input type="text" name="search" placeholder="Type here to search" align="center" required>
                        <button type="submit" class="search_icon">
                            <i class="fa fa-search" aria-hidden="true"></i>
                        </button>
                    </form>
		</div>
            </div>
	</div>
	<div class="footer">
            <p class="copyright">Copyright 2020 © Theme Created By Aashi Gupta, Harshita Lashkari, Armaan Agrawal All Rights Reserved</p>
	</div>
    </body>
</html>