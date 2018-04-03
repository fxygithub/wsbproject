<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

    <title>服务器出现异常，请稍后再进行操作！</title>
    <style type="text/css">
        .attention {
            background: #FFFBCC;
            border: 1px #E6DB55 solid;
            color: #333;
            margin: 10px;
            padding: 8px 8px 8px 35px;
            line-height: 22px;
            font-size: 12px;
        }
    </style>
</head>

<body>
<div class="attention">
    服务器出现异常，请稍后再进行操作！
    <br><a href="${pageContext.request.contextPath}/item/index.html">返回首页</a>
</div>
</body>
</html>
