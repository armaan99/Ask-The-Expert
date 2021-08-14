<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="java.io.OutputStream"%>
<%@page import="dto.Questioner_dto"%>
<%@page import="dao.Questioner_dao"%>
<%@page import="dto.Expert_dto"%>
<%@page import="dao.Expert_dao"%>
<%@page import="dto.Admin_dto" %>

<html>
    <head>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <style type="text/css">
            *{
                box-sizing: border-box;
            }
            body{
                overflow: hidden;
                background-image: url('Images\\background.jpg');
                background-position: center;
                background-repeat: no-repeat;
                background-size: cover;
                position: relative;
                background-attachment: fixed;
            }
            .header{
                height: 10%;
                position: fixed;
                z-index: 1;
            }
            .main{
                height: 85%;
            }
            .left{
                float: left;
                height: 100%;
                margin-top: -4%;
                padding: 2%;
                width: 65%;
            }
            .center{
                float: left;
                width: 0%;
                height: 100%;
                padding: 1%;
                top: 2%;
                left: 30%;
                transform: translate(700%,-40%);
            }
            .myTitle{
                color: #ffffff;
                font-size: 60px;
                text-align: center;
                font-weight: bold;
                font-style: italic;
                font-family: monospace;
            }
            .right{
                float: left;
                padding: 1%;
                height: 100%;
                width: 30%;
                top: 2%;
                left: 70%;
                transform: translate(320%,20%);
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
                font-size: 20px;
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
                width: 100%;
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
            .box{
                border: 1px outset #000000;
                background-color: #000000;
                opacity: 0.7;
                width: 80%;
                height: 70%;
                position: absolute;
                left: 50%;
                top: 50%;
                transform: translate(-50%, -45%);
                overflow-y: scroll;
            }
            span{
                color: #ffffff;
                font-size: 20px;
                margin-left: 25%;
                cursor: pointer;
            }
            th{
                font-size: 20px;
                text-align: left;
            }
            td{
                
            }
            .reportCountColumn{
                text-align: center;
            }
            .expertsTable{
               color: #ffffff;
               border-spacing: 25px;
               border: #ffffff solid;
               margin: 40px 80px;
            }
            .questionersTable{
               color: #ffffff;
               border-spacing: 25px;
               border: #ffffff solid;
               margin: 40px 210px;
            }
            .block{
                background-color: #FF0000;
                color: #ffffff;
                width: 100%;
                text-align: center;
                height: 5%;
            }
            .unblock{
                background-color: #000000;
                color: #ffffff;
                width: 100%;
                text-align: center;
                height: 5%;
            }
            .hiddenInputs{
                display: none;
            }
            .footer{
                height: 5%;
                background-color: #000000;
                color: #ffffff;
                text-align: center;
                padding-bottom: 3%;
                opacity: 0.3;
                width: 100%;
                position: fixed;
                left: 50%;
                top: 94%;
                transform: translate(-50%, 0%);
            }
            .copyright{
                margin-bottom: 50px;
            }
        </style>
        <script type="text/javascript">
            $(document).ready(function(){
                
                var box = $(".box");
                var eclick = 1;
                var qclick = 0;
                
                $(box).append('<br><div>'+
                    '<span class="experts">View all Experts</span>'+
                    '<span class="questioners">View all Questioners</span>'+
                    '</div>'+
                    '<div class="tableContents"></div>');
                $(".experts").css("font-weight","bold");
                $(".questioners").css("font-weight","normal");
                <%
                ArrayList<Expert_dto> initialExpertList = Expert_dao.getAllExpert();
                %>
                $(box).append('<table class="expertsTable">'+
                    '<tr>'+
                        '<th>First Name</th>'+
                        '<th>Last Name</th>'+
                        '<th>Mail ID</th>'+
                        '<th>Category</th>'+
                        '<th>Report Count</th>'+
                        '<th></th>'+
                    '</tr>'+
                    <%
                    Iterator initialEIterator = initialExpertList.iterator();
                    while(initialEIterator.hasNext()){
                        Expert_dto expert_dto = (Expert_dto)initialEIterator.next();
                        %>
                        '<tr>'+
                            '<td> <% out.print(expert_dto.getFirstName()); %> </td>'+
                            '<td> <% out.print(expert_dto.getLastName()); %> </td>'+
                            '<td> <% out.print(expert_dto.getEmailID()); %> </td>'+
                            '<td> <% out.print(expert_dto.getCategory()); %> </td>'+
                            '<td class="reportCountColumn"> <%out.print(expert_dto.getReportCount());%> </td>'+
                            <% if(!expert_dto.getBlock()){ %>
                            '<td> <form action="ProcessExpertBlock.jsp" method="POST">'+
                                    '<input class="hiddenInputs" name="expertMailID" value="<% out.print(expert_dto.getEmailID()); %>" />'+
                                    '<button type="submit" class="block">Block</button>'+
                                    '</form> </td>'+
                            <%}else{%>
                            '<td> <form action="ProcessExpertUnblock.jsp" method="POST">'+
                                    '<input class="hiddenInputs" name="expertMailID" value="<% out.print(expert_dto.getEmailID()); %>" />'+
                                    '<button type="submit" class="unblock">Unblock</button>'+
                                    '</form> </td>'+
                            <%}%>
                        '</tr>'+
                        <%
                    }
                    %>
                '</table>');
            
                $(document).on("click",".experts",function(){
                    $(".questionersTable").remove();
                    $(".experts").css("font-weight","bold");
                    $(".questioners").css("font-weight","normal");
                    if(eclick === 0){
                        qclick = 0;
                    <%
                    ArrayList<Expert_dto> expertList = Expert_dao.getAllExpert();
                    %>
                    $(box).append('<table class="expertsTable">'+
                        '<tr>'+
                            '<th>First Name</th>'+
                            '<th>Last Name</th>'+
                            '<th>Mail ID</th>'+
                            '<th>Category</th>'+
                            '<th>Reports Count</th>'+
                            '<th></th>'+
                        '</tr>'+
                        <%
                        Iterator eIterator = expertList.iterator();
                        while(eIterator.hasNext()){
                            Expert_dto expert_dto = (Expert_dto)eIterator.next();
                            %>
                            '<tr>'+
                                '<td> <% out.print(expert_dto.getFirstName()); %> </td>'+
                                '<td> <% out.print(expert_dto.getLastName()); %> </td>'+
                                '<td> <% out.print(expert_dto.getEmailID()); %> </td>'+
                                '<td> <% out.print(expert_dto.getCategory()); %> </td>'+
                                '<td class="reportCountColumn"> <%out.print(expert_dto.getReportCount());%> </td>'+
                                <% if(!expert_dto.getBlock()){ %>
                                '<td> <form action="ProcessExpertBlock.jsp" method="POST">'+
                                        '<input class="hiddenInputs" name="expertMailID" value="<% out.print(expert_dto.getEmailID()); %>" />'+
                                        '<button type="submit" class="block">Block</button>'+
                                        '</form> </td>'+
                                <%}else{%>
                                '<td> <form action="ProcessExpertUnblock.jsp" method="POST">'+
                                        '<input class="hiddenInputs" name="expertMailID" value="<% out.print(expert_dto.getEmailID()); %>" />'+
                                        '<button type="submit" class="unblock">Unblock</button>'+
                                        '</form> </td>'+
                                <%}%>
                            '</tr>'+
                            <%
                        }
                        %>
                    '</table>');
                    eclick = 1;
                }
                });
                
                $(document).on("click",".questioners",function(){
                    $(".expertsTable").remove();
                    $(".experts").css("font-weight","normal");
                    $(".questioners").css("font-weight","bold");
                    if(qclick === 0){
                        eclick = 0;
                    <%
                    ArrayList<Questioner_dto> questionerList = Questioner_dao.getAllQuestioner();
                    %>
                    $(box).append('<table class="questionersTable">'+
                        '<tr>'+
                            '<th>First Name</th>'+
                            '<th>Last Name</th>'+
                            '<th>Mail ID</th>'+
                            '<th>Report Count</th>'+
                            '<th></th>'+
                        '</tr>'+
                        <%
                        Iterator qIterator = questionerList.iterator();
                        while(qIterator.hasNext()){
                            Questioner_dto questioner_dto = (Questioner_dto)qIterator.next();
                            %>
                            '<tr>'+
                                '<td> <% out.print(questioner_dto.getFirstName()); %> </td>'+
                                '<td> <% out.print(questioner_dto.getLastName()); %> </td>'+
                                '<td> <% out.print(questioner_dto.getEmailID()); %> </td>'+
                                '<td class="reportCountColumn"> <%out.print(questioner_dto.getReportCount());%> </td>'+
                                <% if(!questioner_dto.getBlock()){ %>
                                '<td> <form action="ProcessQuestionerBlock.jsp" method="POST">'+
                                        '<input class="hiddenInputs" name="questionerMailID" value="<% out.print(questioner_dto.getEmailID()); %>" />'+
                                        '<button type="submit" class="block">Block</button>'+
                                        '</form> </td>'+
                                <%}else{%>
                                '<td> <form action="ProcessQuestionerUnblock.jsp" method="POST">'+
                                        '<input class="hiddenInputs" name="questionerMailID" value="<% out.print(questioner_dto.getEmailID()); %>" />'+
                                        '<button type="submit" class="unblock">Unblock</button>'+
                                        '</form> </td>'+
                                <%}%>
                            '</tr>'+
                            <%
                        }
                        %>
                    '</table>');
                    qclick = 1;
                }
                });
            });
        </script>
    </head>
    <body>
        <%
        session.setAttribute("AdminLoginFailed", 0);
        session.setAttribute("AdminTemporaryPasswordSentOnMail", 0);
        session.setAttribute("AdminInvalidMailID", 0);
        session.setAttribute("AdminPasswordChangedSuccessfully", 0);
        session.setAttribute("AdminChangePasswordMissmatched", 0);
        %>
        <div class="header">
            <div class="left">
                <a href="Home.jsp" class="logo" ><img src='Images\logo.png' width="220" height="220"/></a>
            </div>
            <div class="center">
                <p class="myTitle">ASKtheEXPERT</p>
            </div>
            <div class="right">
                <div class="navigator">
                    <div class="dropdown">
			<button class="dropdownList"><i class="fa fa-user-circle-o" aria-hidden="true" style="color: #ffffff; margin-right: 10px; font-size: 20px;"></i>
                            <%
                            out.print(((Admin_dto)session.getAttribute("Admin")).getFirstName());
                            %>
                        </button>
                        <div class="dropdownContent">
                            <a href="AdminHome.jsp">Home</a>
                            <a href="AdminProfile.jsp">Profile</a>
                            <a href="AdminLogin.jsp">Logout</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="main">
            <div class="box">
            </div>
        </div>
        <div class="footer">
            <p class="copyright">Copyright 2020 © Theme Created By Aashi Gupta, Harshita Lashkari, Armaan Agrawal All Rights Reserved</p>
        </div>
    </body>
</html>