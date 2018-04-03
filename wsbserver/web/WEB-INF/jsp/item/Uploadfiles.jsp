<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>文件上传</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
    <link href="${pageContext.request.contextPath}/css/fileinput.css" media="all" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <script src="${pageContext.request.contextPath}/js/jquery-1.11.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/fileinput.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/zh.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.js"></script>

</head>
<body>
<div class="container">
    <div class="row">
        <div class="header_top">
            <a href="javascript:;" onclick="javascript:history.go(-1);">
                <img src="${pageContext.request.contextPath}/images/back.png" alt=""></a>
            <h3>事项名申报表</h3>
        </div>
        <div class="col-xs-12" style="margin-top:20px;">
        <form class="form-horizontal" enctype="multipart/form-data"
              action="${pageContext.request.contextPath}/item/upload.html" method="post" name="fileInfo">
            <c:forEach items="${fileInfoArr}" var="fileInfo">
            <div class="form-group">
               <input type="text" id="nn" value="${fileInfo.CODE}" hidden/>
                <label class="col-xs-9 col-sm-9 col-md-9 col-lg-9">${fileInfo.NAME}：</label>
                <div class="col-xs-3 col-md-3 col-lg-3" style="padding-left:0;">
                    <span class="spanbb">文件上传</span>
                </div>
            </div>
            </c:forEach>
        </form>
        </div>

    </div>
</div>
<c:if test="${sessionScope.filesList!=null}">
    <span>刚上传的文件有：</span>
</c:if>
<c:forEach items="${sessionScope.filesList}" var="fielItem" >
    <span>${fielItem.fileName}，</span>
</c:forEach>

<div class="niubi" style="opacity: 1;top: 100px;visibility: hidden;">
    <form action="${pageContext.request.contextPath}/item/upload.html" method="post"
          class="file_form" enctype="multipart/form-data" name="formName">
        <a href="javascript:void(0);" class="btn_addPic">
            <span><em>+</em>添加图片</span>
            <input id="UploadFile" type="file" name="UploadFile" value="" multiple="multiple" class="filePrew cfText"
                   cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1"
                   cf_widgetid="cf_text" cf_modelitemid="UploadFile" cf_modelitemname="文件上传"/>
        </a>
            <input type="hidden" name="otherParam" class="otherParam" value="" />
        <div class="savebntbox" style="width:50%;margin:0 auto;">
            <button value="提交" name="btn" onclick="up()" class="submitbtn">提交</button>
            <input type="reset" value="重置" id="reset" class="submitbtn">
        </div>
    </form>

    <a class="close-reveal-modal">×</a>
</div>
<div class="fiem" style="display: none; cursor: pointer;">

</div>

<script>
    function up() {
        var cont=document.getElementById("nn");
        var contVal=cont.value;
        //alert("材料CODE和名称："+contVal);
        var cont1= document.getElementById("mm");
        cont1.value=contVal;
       $("#formName").submit();
    }

</script>

<style>
    .form-group{position: relative;margin-bottom:20px;}
</style>
<script type="text/javascript">
    $(function(){
        //alert("您可以在这里进行文件上传");首次进入时提示
        var screenWidth = $(window).width();
        screenHeight = $(window).height(); //当前浏览器窗口的 宽高
        var scrolltop = $(document).scrollTop();//获取当前窗口距离页面顶部高度
        $(".spanbb").click(function(){
            var sss = $(this).attr('id');
            var bbb = $(this).parents(".form-group").find("#nn").val();//隐藏要用的参数值
            var niubiClass=$(".niubi");
            var otherParam = $(".otherParam").attr("value",bbb)
            var objLeft = (screenWidth - niubiClass.width())*2 ;
            var objTop = (screenHeight - niubiClass.height())/2 + scrolltop;
            var nameId = $('.filePrew').attr('name',sss)
            $(".niubi").css({"visibility":"visible","top":objTop + 'px',"overflow": "hidden"});
            $("body").height(screenHeight).css({"overflow": "hidden"});
            $(".fiem").height(screenHeight).css({"overflow": "hidden"}).fadeIn(300);

        })
        $("#reset").click(function(){
            $(this).parents('.niubi').find('.btn_addPic span').html("<em>+</em>添加图片");
        })
        $(".fiem").click(function(){
            var reg = /[^\\\/]*[\\\/]+/g;
            var name = $(this).siblings(".niubi").find('.file_form .btn_addPic .filePrew').val().replace(reg, '');
            if(name != ''){
                var text =name.substr();//获取没有后缀的名称
                var mbmb = $(this).siblings(".niubi").find('.file_form .btn_addPic .filePrew').val('');
                $(this).siblings('.niubi').find('.btn_addPic span').html("<em>+</em>添加文件");
                alert(mbmb);

            }else{



            }

            $(".niubi").css("visibility","hidden");

            $("body").css({"overflow": "auto","height":"auto"});
            $(this).fadeOut(300);
        })
        $(".close-reveal-modal").click(function(){
            var reg = /[^\\\/]*[\\\/]+/g;
            var name = $(this).parents(".niubi").find('.file_form .btn_addPic .filePrew').val().replace(reg, '');
            if(name != ''){
                var text =name.substr();//获取没有后缀的名称
                var mbmb = $(this).parents(".niubi").find('.file_form .btn_addPic .filePrew').val('');
                $(this).parents('.niubi').find('.btn_addPic span').html("<em>+</em>添加图片");
                alert(mbmb);

            }
            $(".niubi").css("visibility","hidden");
            $("body").css({"overflow": "hidden","height":"auto"});
            $('.fiem').fadeOut(300);
        })

    })

</script>
<script>
    $('.filePrew').on('change', function() {
        var reg = /[^\\\/]*[\\\/]+/g; //匹配文件的名称和后缀的正则表达式
        var name = $(this).val().replace(reg, '');
        var text =name.substr();//获取没有后缀的名称
        $(this).parents('.btn_addPic ').find('span').html(text);
    });

</script>
<script>
//    $(function(){
//        var divbtn ='<div class="col-xs-3 col-md-1 col-lg-1" style="position:absolute;right:-22px;bottom:0;padding-left:10px;padding-right:0;">\n' +
//            '                    <a href="http://www.baidu.com" class="btn btn-primary">证照库</a>\n' +
//            '                </div>'
//        $("#addBtn .file-caption-main .input-group-btn").append(divbtn);
//    })
</script>
</body>
</html>