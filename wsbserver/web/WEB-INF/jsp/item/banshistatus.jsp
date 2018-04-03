<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>办件状态</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
    <link href="${pageContext.request.contextPath}/css/fileinput.css" media="all" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <script src="${pageContext.request.contextPath}/js/jquery-1.11.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/fileinput.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/zh.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
    <style>
        .yijian{padding:8px 0 !important;text-align: center}
        .bszn,.yijian{font-size: 12px;}
    </style>
</head>
<body>
<div class="container">
    <div class="row">
        <div class="header_top">
            <a href="javascript:;" onclick="javascript:history.go(-1);"><img src="${pageContext.request.contextPath}/images/back.png" alt=""></a>
            <h3>事件状态展示</h3>
        </div>

        <div class="col-xs-12" style="margin-top:10px;">
            <div class="table-responsive">
                <table class="table table-bordered">

                    <thead>
                    <tr>
                        <th width=10% style="padding:8px 0">序号</th>
                        <th width=33% style="text-align: center">状态</th>
                        <th width=14%>意见</th>
                        <th width=43% style="text-align: center">时间</th>
                    </tr>
                    </thead>
                    <tbody class="lists">
                    <!--ajax加载项-->
                    <c:forEach var="itemState" items="${stateList}" varStatus="id">
                        <tr>
                            <th width="10%" scope="row">
                                ${id.count}
                            </th>
                            <td width="33%" class="yijian">
                                ${itemState.CURRENT_NODE_NAME}
                            </td>
                            <td width="14%" class="bszn" style="padding:8px 0;text-align: center">
                                <a class="yijianzhanshi" href="javascript:;">${itemState.OPINION}</a>
                        </td>
                            <td width="43%" class="bszn">
                                ${itemState.RECEIVE_TIME}
                            </td>
                        </tr>
                        </c:forEach>

                    </tbody>
                </table>
            </div>
        </div>
        <div class="col-xs-12" style="margin-top:20px;">
            <span style="color:#f00">*友情提示：点击意见可看到意见反馈</span>
        </div>
    </div>
</div>
<div class="niubi" style="opacity: 1;top: 100px;visibility: hidden;">
    <p><span class="liyou">驳回</span></p>
    <a class="close-reveal-modal">×</a>
</div>

<div class="fiem" style="display: none; cursor: pointer;">

</div>

<script type="text/javascript">

    $(function(){
        var screenWidth = $(window).width();
        screenHeight = $(window).height(); //当前浏览器窗口的 宽高
        var scrolltop = $(document).scrollTop();//获取当前窗口距离页面顶部高度
        $(".yijianzhanshi").click(function(){
            var niubiClass=$(".niubi");
            var yijian = $(this).text();

            var objLeft = (screenWidth - niubiClass.width())*2 ;
            var objTop = (screenHeight - niubiClass.height())/2 + scrolltop;
            $(".niubi").css({"visibility":"visible","top":objLeft + 'px',"overflow": "hidden"});
            $(".niubi").find(".liyou").html(yijian);
            $("body").height(screenHeight).css({"overflow": "hidden"});
            $(".fiem").height(screenHeight).css({"overflow": "hidden"}).fadeIn(300);

        })
        $(".fiem").click(function(){
            $(".niubi").css("visibility","hidden");
            $("body").css({"overflow": "auto","height":"auto"});
            $(this).fadeOut(300);
        })
        $(".close-reveal-modal").click(function(){
            $(".niubi").css("visibility","hidden");
            $("body").css({"overflow": "hidden","height":"auto"});
            $('.fiem').fadeOut(300);
        })

    })

</script>

</body>
</html>