<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.hn.sanya.bov.util.exceptions.Exceptions" %>
<%@ page import="com.hn.sanya.bov.util.exceptions.ServletsController" %>
<%@ page import="com.hn.sanya.bov.util.exceptions.ExceptinsUtil" %>
<html>

<%
    response.setStatus(500);
// 获取异常类
    Throwable ex = Exceptions.getThrowable(request);

// 编译错误信息
    StringBuilder sb = new StringBuilder("错误信息：\n");
    if (ex != null) {
        sb.append(Exceptions.getStackTraceAsString(ex));
    } else {
        sb.append("未知错误.\n\n");
    }

// 如果是异步请求，则直接返回信息
    if (ServletsController.isAjaxRequest(request)) {
        out.print(sb);
    }

// 输出异常信息页面
    else {
%>
<!DOCTYPE html>
<html>
<head>
    <title>500 - 系统内部错误</title>
    <script src="${pageContext.request.contextPath}/js/jquery.js"></script>
    <link href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/bootstrap/css/bootstrap-theme.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.js"></script>
    <script language="javascript">if(typeof jQuery == 'undefined'){ window.alert("没有jquery");}</script>
    <script type="text/javascript">
        function change(value){
            if(value == '1'){
                $(".errorMessage").css("display", "none");
                $(".errorMessage2").css("display", "block");
            }else{
                $(".errorMessage").css("display", "block");
                $(".errorMessage2").css("display", "none");
            }
        };
    </script>
</head>
<body>
<div class="container-fluid">
    <div class="page-header"><h1>系统内部错误.</h1></div>
    <div class="errorMessage">
        错误信息：<%=ex==null?"未知错误.": ExceptinsUtil.toHtml(ex.getMessage())%> <br/> <br/>
        请点击“查看详细信息”按钮，将详细错误信息发送给系统管理员，谢谢！<br/> <br/>
        <a href="javascript:" onclick="history.go(-1);" class="btn">返回上一页</a> &nbsp;
        <a href="javascript:" onclick="change('1');" class="btn">查看详细信息</a>
    </div>
    <div class="errorMessage2" style="display: none;">
        <%=ExceptinsUtil.toHtml(sb.toString())%> <br/>
        <a href="javascript:" onclick="history.go(-1);" class="btn">返回上一页</a> &nbsp;
        <a href="javascript:" onclick="change('2');" class="btn">隐藏详细信息</a>
        <br/> <br/>
    </div>
</div>
</body>
</html>
<%
    }
    out = pageContext.pushBody();
%>