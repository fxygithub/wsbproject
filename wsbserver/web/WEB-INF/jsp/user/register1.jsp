<%@ page language="java" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>微申报系统——申报项</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/fileinput.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <script src="${pageContext.request.contextPath}/js/jquery-1.11.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
    <script src="${pageContext.request.contextPath}/js/register.js"></script>
    <script src="${pageContext.request.contextPath}/js/fileinput.js"></script>
    <script src="${pageContext.request.contextPath}/js/zh.js"></script>

    <style>

    </style>
</head>
<body>
<div class="container">
    <div class="row">
        <div class="header_top">
                <a href="javascript:;" onclick="javascript:history.go(-1);"><img src="${pageContext.request.contextPath}/images/back.png" alt=""></a>
            <h3>注册——实名认证</h3>
        </div>
        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="margin-top:10%">

            <form class="form-horizontal" id="form_disabled" method="post" action="${pageContext.request.contextPath}/user/authenticate.html" enctype="multipart/form-data">
            <div class="form-group">
                <label class="col-xs-12 col-sm-12 col-md-12 col-lg-12"><b class="ftx04">*</b>姓名：</label>
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                    <input type="text" name="xingming" id="xingming" class="form-control seetext" placeholder="请输入身份证上姓名">
                </div>
            </div>
            <div class="form-group">
                <label class="col-xs-12 col-sm-12 col-md-12 col-lg-12"><b class="ftx04">*</b>身份证号码：</label>
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                    <input type="text" name="code" id="sfzhm" value="${sessionScope.userName}" class="form-control seetext" placeholder="请填写18位有效的身份证号码"  onblur="checkIdcard()"/>
                </div>
            </div>
            <%--<div class="form-group">
               <label class="col-xs-12 col-sm-12 col-md-12 col-lg-12"><b class="ftx04">*</b>性别：</label>
               <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
               <input type="text" name="sex" class="form-control seetext" id="sex" placeholder="填写性别" hidden>
               </div>
            </div>--%>
         <%--   <div class="form-group">
                <label class="col-xs-12 col-sm-12 col-md-12 col-lg-12"><b class="ftx04">*</b>民族：</label>
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                        <input type="text" name="nation" id="nation" class="form-control seetext" placeholder="填写民族" hidden>
                </div>
            </div>--%>
          <%--  <div class="form-group">
                <label class="col-xs-12 col-sm-12 col-md-12 col-lg-12"><b class="ftx04">*</b>地址：</label>
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                    <input type="text" name="address" id="address" class="form-control seetext" placeholder="请填写身份证上的地址" hidden>
                </div>
            </div>--%>
                <div class="form-group">
                    <label class="col-md-1 col-lg-1 control-label label_file"><b class="ftx04">*</b>身份证正面：</label>
                    <div class="col-sm-10 col-md-11 col-lg-11">
                        <input id="file-1" class="file" type="file"  data-min-file-count="1" name="before">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-1 col-lg-1 control-label label_file"><b class="ftx04">*</b>身份证反面：</label>
                    <div class="col-sm-10 col-md-11 col-lg-11">
                        <input id="file-2" class="file" type="file"  data-min-file-count="1" name="after">
                    </div>
                </div>
                <div class="form-group" id="savebt">
                    <div class="col-xs-12 sbsxbtn">
                        <button class="btn btn-primary" id="savebtn" onclick="subForm()">下一步</button>
                    </div>
                </div>
        </form>
        </div>
    </div>
</div>
<script>
    $("#file-1").fileinput({
        language: 'zh',
        //uploadUrl: "/FileUpload/Upload", //上传的地址
        showUpload : false,
        showRemove : false,
        indicatorNew:false


    });
    $("#file-2").fileinput({
        language: 'zh',
        //uploadUrl: "/FileUpload/Upload", //上传的地址
        showUpload : false,
        showRemove : false,
        indicatorNew:false


    });
</script>
<script>
    function subForm() {
        $("#form_disabled").submit();
        console.log("提交认证信息");

    }
</script>>

<script>
function checkIdcard() {
    var idCard  = $("input[name='sfzhm']").val().trim().toUpperCase();
    console.log("idCard::"+idCard);
    $("input[name='sfzhm']").val(idCard);

    if($("#sfzhm").parent().find("span") != null){
        $("#sfzhm").parent().find("span").remove();
    }
    if(IdentityCodeValid(idCard)){
        var hdw1 = $("<span class='a2 righta'></span>");
        $("#sfzhm").parent().append(hdw1);
    }else{
        $("#username").parent().append("<span class='sfzhm' style='color:#f00'>请输入正确的18位身份证号</span>");
    }
}
</script>
</body>
</html>