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
    <style>
        .lists td{font-size:12px;padding:4px !important;}
        .table-bordered th{padding:5px !important;font-size:12px;}
    </style>
</head>
<body>
<div class="container">
    <div class="row">
        <div class="header_top">
            <a href="javascript:;" onclick="javascript:history.go(-1);"><img src="${pageContext.request.contextPath}/images/back.png" alt=""></a>
            <h3>我的办件</h3>
        </div>
        <div class="col-xs-12" style="margin-top:20px;">
            <form action="${pageContext.request.contextPath}/item/searchMyItem.html?userId=${sessionScope.userId}" id="search_box" method="post">
                <div class="wrapper">
                    <input type="text" id="search" name="search" value="${search}" placeholder="搜索（事项名称/编码/状态）" />
                    <button type="submit" class="search_btn"><img src="${pageContext.request.contextPath}/images/search_icon.png" title="Search" /></button>
                </div>
            </form>
        </div>
        <div class="col-xs-12" style="margin-top:20px;">
            <div class="table-responsive">
                <table class="table table-bordered">

                    <thead>
                        <tr>
                            <th width=12%>序号</th>
                            <th width=30%>已办事项名称</th>
                            <th width=20%>查看状态</th>
                            <th width=38%>操作</th>
                        </tr>
                    </thead>

                    <tbody class="lists">
                    <c:forEach items="${listMyItems}" var="item" varStatus="id">
                        <tr>
                            <th width=12% scope="row">${id.count}</th>

                            <td width=30% class="content_tt">
                                <a href="${pageContext.request.contextPath}/item/lookMyItem?dataId=${item.dataId}"
                                   title='+data[i].name+'>${item.name}</a>
                            </td>

                            <td width=20%>
                                <a href="${pageContext.request.contextPath}/item/lookStatus.html?receiveNum=${item.receiveNum}&&dataId=${item.dataId}">
                                    查看状态</a>
                            </td>

                            <td width=38% >
                                <c:choose>
                                <c:when test="${item.state=='保存'}">
                                    <a href="${pageContext.request.contextPath}/item/lookItem.html?dataId=${item.dataId}&&code=${item.code}" class="btn btn-success btn-xs" title="" >查看</a>
                                    <a href="${pageContext.request.contextPath}/item/editItem.html?dataId=${item.dataId}&&code=${item.code}" class="sbsx_linka btn btn-danger btn-xs" title="编辑">编辑</a>
                                    <a href="${pageContext.request.contextPath}/item/webapply.html?dataId=${item.dataId}" class="sbsx_linka btn btn-primary btn-xs" title="申报">申报</a>
                                </c:when>
                                <c:when test="${item.state=='申报'}">
                                    <a href="${pageContext.request.contextPath}/item/lookItem.html?dataId=${item.dataId}&&code=${item.code}" class="btn btn-success btn-xs" title="" >查看</a>
                                </c:when>
                            </c:choose>
                            </td>
                        </tr>
                    </c:forEach>

                    </tbody>
                </table>
                </div>
            </div>
        </div>
</div>
</div>

</body>

</html>