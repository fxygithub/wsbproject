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
    <style>
        .lists td{font-size:12px;padding:4px !important;}
        .table-bordered th{padding:5px !important;font-size:12px;}
        .btn-xs{padding: 1px 4px;}
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
                    <input type="text" id="search" name="search" value="" placeholder="搜索（事项名称/编码/状态）" />
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
                <!--ajax加载项-->
                </tbody>
            </table>
            </div>
        </div>
</div>
</div>

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
//                 url: 'http://ons.me/tools/dropload/json.php?page='+page+'&size='+size,
              //  url: 'json/more.json',
                url:'${pageContext.request.contextPath}/item/dynloadItem.html?userId=${sessionScope.userId}'+'&size='+size+'&page='+page,
                dataType: 'json',
                success: function(data){
                    var arrLen = data.length;
                    if(arrLen > 0){
                        for(var i=0; i<arrLen; i++){
                            id++;

                            var receiveNum= "";
                            var dataId=data[i].dataId;
                            var state=data[i].state;
                            var code = data[i].code;
//                            备注：程序字符串截取七个字数最佳，样式无法控制
                            if(state=="保存"){
                                result +=   '<tr>'
                                    +'<th width=12% scope="row">'+id+'</th>'
                                    +'<td width=30% class="content_tt">'
                                    +'<a href="javascript:void(0);">'+data[i].name+'</a>'+'</td>'
                                    +'<td width=20%>'
                                    +'<a href="${pageContext.request.contextPath}/item/lookStatus.html?receiveNum='+receiveNum+'&&dataId='+dataId+'">查看状态'+'</a>'+'</td>'

                                    +'<td width=38%>'
                                    +'<a href="${pageContext.request.contextPath}/item/lookItem.html?code='+code+'&&dataId='+dataId
                                + '" class="btn btn-success btn-xs" >'+'查看'+'</a>'
                                    +'<a href="${pageContext.request.contextPath}/item/editItem.html?code='+code+'&&dataId='+dataId
                                    +'" class="sbsx_linka btn btn-danger btn-xs" >'+'编辑'+'</a>'

                                    +'<a href="${pageContext.request.contextPath}/item/webapply.html?dataId='+dataId
                                    +'" class="sbsx_linka btn btn-primary btn-xs" >'+'申报'+'</a>'+'</td>'
                                    +'</tr>';
                            }else if(state=="申报"){//申报，则编辑和申报功能不可用
                                result +=   '<tr>'
                                    +'<th width=12% scope="row">'+id+'</th>'
                                    +'<td width=30% class="content_tt">'
                                    +'<a href="javascript:void(0);">'+data[i].name+'</a>'+'</td>'
                                    +'<td width=20%>'
                                    +'<a href="${pageContext.request.contextPath}/item/lookStatus.html?receiveNum='+data[i].receiveNum+'&&dataId='+dataId
                                    +'">查看状态'+'</a>'+'</td>'
                                    +'<td width=38%>'
                                    +'<a href="${pageContext.request.contextPath}/item/lookItem.html?code='+code+'&&dataId='+dataId+'"'
                                    +' class="btn btn-success btn-xs" >'+'查看'+'</a>'
                                    +'</tr>';

                            }
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