<%@ page language="java" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>微申报系统——申报项</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <script src="${pageContext.request.contextPath}/js/jquery-1.11.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
    <script src="${pageContext.request.contextPath}/js/register.js"></script>
    <style>
         .form-group b {

            margin-right: 5px;
            font-weight: normal;
            color: red;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="row">
        <div class="header_top">
                <a href="javascript:;" onclick="javascript:history.go(-1);"><${pageContext.request.contextPath}/img src="images/back.png" alt=""></a>
            <h3>注册——完成注册</h3>
        </div>
        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="margin-top:10%">
            <p>恭喜cz82465，您已注册成功，现在开始您的投资之旅吧！</p>
            <p>页面将在 <span id='div1'></span> 秒钟后，跳转到 用户中心</p>

        </div>
    </div>
</div>
<script>
    //设定倒数秒数
    var t = 5;
    //显示倒数秒数
    function showTime(){
        t -= 1;
        document.getElementById('div1').innerHTML= t;
        if(t==0){
            location.href='${pageContext.request.contextPath}/item/index.html';
        }
        //每秒执行一次,showTime()
        setTimeout("showTime()",1000);
    }
    //执行showTime()
    showTime();

</script>

</body>
</html>