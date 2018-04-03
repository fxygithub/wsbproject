<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>404找不到页面</title>
    <link href="${pageContext.request.contextPath}/css/font-awesome.css" rel="stylesheet" type="text/css" media="all" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/404.css">
</head>
<body>
<div class="main">
    <h1>对不起，您要找的页面不存在</h1>
    <div class="w3layouts_main_grids">
        <div class="w3_main_grid_left">
            <div class="w3l_main_grid">
                <h2>404</h2>
            </div>
            <h3>没有当前页面</h3>
        </div>
        <div class="w3_main_grid_right w3_agileits_grid_right">
            <h3>Sorry..页面没有找到！</h3>
            <p>似乎你所寻找的网页已移动或丢失了。
                请不要担心，这没事。如果该资源对你很重要，请与管理员联系。
                火星不太安全，我可以免费送你回地球</p>
            <a href="${pageContext.request.contextPath}/user/index.html" title="返回首页" style="color:#0f6d84">
                返回首页
            </a>
        </div>
        <div class="clear"> </div>
    </div>
    <div class="agileits_copyright">
        <p> ©  <%
            java.text.SimpleDateFormat simpleDateFormat = new java.text.SimpleDateFormat(
                    "yyyy-MM-dd");
            java.util.Date currentTime = new java.util.Date();
            String time = simpleDateFormat.format(currentTime).toString();
            out.println(time);
        %>   Error Widget. All Rights Reserved | 技术支持：<a href="javascript:;">三亚市政务中心</a></p>
    </div>
</div>
</body>
</html>