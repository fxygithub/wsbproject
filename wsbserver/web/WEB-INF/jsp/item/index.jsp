<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width,user-scalable=no,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>微申报系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <script src="${pageContext.request.contextPath}/js/jquery-1.11.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.js"></script>

</head>
<body>
<div class="bg"></div>
<!--<div class="header">-->
<!--<div class="logo"><h3>微申报系统</h3></div>-->
<!--</div>-->
<div class="container">

    <div class="row">
        <div class="col-md-4 col-md-offset-4">
            <div class="zongbnt">
                <a href="${pageContext.request.contextPath}/item/approveList.html" class="linka btn-primary">不见面审批</a>
                <a href="${pageContext.request.contextPath}/item/myItem.html" class="linka btn-info">我的办件</a>
                <a href="javascript:void(0)" class="linka btn-danger">我的证照</a>
            </div>
        </div>
    </div>
</div>
<script>
    $(function(){
        var windowHeight = $(window).height();
//            windowHeight=windowHeight - 50+'px';
        $('.bg').css('height',windowHeight);
    })
</script>
</body>
</html>