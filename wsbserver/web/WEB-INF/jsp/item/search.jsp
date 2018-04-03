<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>微申报系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">

    <script src="${pageContext.request.contextPath}/js/jquery-1.11.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
    <script src="${pageContext.request.contextPath}/js/dropload.js"></script>
    <script src="${pageContext.request.contextPath}/js/guide.js"></script>
    <style>
        #city_5 .select_box{height: 30px;
            line-height: 30px;
            margin-top: 10px;
            color: #666666;
            font-size: 12px;
            padding: 0 5px;}
        .ys{
           /* color: white;
            background:royalblue;*/
        }
    </style>
</head>
<body>
<div class="container">
    <div class="row">
        <div class="header_top">
            <a href="javascript:;" onclick="javascript:history.go(-1);">
                <img src="${pageContext.request.contextPath}/images/back.png" alt=""></a>
            <h3>事项名申报表</h3>
        </div>
        <div class="col-xs-12 col-md-12">
            <form action="${pageContext.request.contextPath}/item/search.html" id="search_box" method="post">
                <div class="wrapper">
                    <input type="text" id="search"
                           name="search" value="${search}"
                           placeholder="请输入您要搜索的事项名称或编码"
                           onblur="javascript:getvalue();"/>
                    <button type="submit" class="search_btn">
                        <img src="${pageContext.request.contextPath}/images/search_icon.png" title="Search" /></button>
                </div>
            </form>

            <form class="form-inline">
                <div id="city_5">
                    <select id="loc_province" class="col-xs-4 select_box">
                    </select>
                    <select id="loc_city" class="col-xs-4 select_box">
                    </select>
                    <select id="loc_town" class="col-xs-4 select_box">
                    </select>
                </div>

            </form>

        </div>

        <div class="col-xs-12" style="margin-top:10px;">
            <div class="table-responsive">
                <table class="table table-bordered">
                    <thead>
                    <tr>
                        <th width="15%">序号</th>
                        <th width="52%">事项名称</th>
                        <th style="width:33%;text-align: center;">办事指南/申报</th>
                    </tr>
                    </thead>
                    <tbody class="listsP">
                    <c:forEach items="${list}" var="item" varStatus="id">
                        <tr>
                            <th width="15%" scope="row">${id.count}</th>
                            <td width="52%" class="content_tt">${item.name}</td>
                            <td width="33%" class="bszn">
                                <a href="${item.guide}" class="btn btn-primary btn-xs" title="undefined">查看</a>
                                <a href="${pageContext.request.contextPath}/item/shenbao.html?code=${item.code}"
                                   class="sbsx_linka btn btn-success btn-xs" title="undefined">申报</a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                    <tbody class="lists">
                    <!--ajax 三级联动加载项-->
                    </tbody>
                </table>
            </div>
        </div>
</div>
</div>
<jsp:include page="common/sanjiliandong.jsp"></jsp:include>
</body>
</html>