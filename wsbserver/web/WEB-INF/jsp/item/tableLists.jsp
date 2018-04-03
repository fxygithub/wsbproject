<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
                           name="search" value=""
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
                        <th width=15%>序号</th>
                        <th width=52%>事项名称</th>
                        <th style="width:33%;text-align: center;">办事指南/申报</th>
                    </tr>
                </thead>
                <tbody class="listsP">
                <!--ajax 三级联动加载项-->
                </tbody>
                <tbody class="lists">
                <!--ajax加载项-->
                </tbody>

            </table>
            </div>
        </div>

</div>
</div>
<jsp:include page="common/sanjiliandong.jsp"></jsp:include>

<%--动态加载事项--%>
<script>
    $(function(){
        // 页数
        var page =0;
        // 每页展示5个
        var size = 5;
        var id=0;
        // dropload
        $('.table-bordered').dropload({
            scrollArea : window,
            loadDownFn : function(me){
                page++;
                // 拼接HTML
                var result = '';
                $.ajax({
                    type: 'GET',
                    url:'${pageContext.request.contextPath}/item/data.html?page='+page+'&size='+size,
                    dataType: 'json',
                    success: function(data){
                        var arrLen = data.length;
                        if(arrLen > 0){
                            for(var i=0;i<arrLen; i++){
                                id++;
                                var code=data[i].code;
                                var banshiGuide=lookItem(code);//办事指南
//                            备注：程序字符串截取十个字数最佳，样式无法控制
                                result +=   '<tr>'
                                    +'<th width=15% scope="row">'+id+'</th>'
                                    +'<td width=52% class="content_tt">'+data[i].name+'</td>'
                                    +'<td width=33% class="bszn">'+'<a href='+banshiGuide
                                    +' class="btn btn-primary btn-xs" title='+data[i].title+'>'+'查看'+'</a>'
                                    +'<a href='+'${pageContext.request.contextPath}/item/shenbao.html?code='+code
                                    +' class="sbsx_linka btn btn-success btn-xs" title='+data[i].title+'>'+'申报'+'</a>'+'</td>'
                                    +'</tr>';
                            }
                            // 如果没有数据
                        }else{
                            // 锁定
                            me.lock();
                            // 无数据
                            me.noData();
                        }
                        // 为了测试，延迟1秒加载
                        setTimeout(function(){
                            // 插入数据到页面，放到最后面
                            $('.lists').append(result);
                            // 每次数据插入，必须重置
                            me.resetload();
                        },1000);
                    },
                    error: function(xhr, type){
                        alert('Ajax error!');
                        // 即使加载出错，也得重置
                        me.resetload();
                    }
                });
            }
        });
    });
</script>

</body>
</html>