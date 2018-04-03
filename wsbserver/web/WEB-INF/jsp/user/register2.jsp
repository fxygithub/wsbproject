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
    <script src="${pageContext.request.contextPath}/js/bootstrap-datetimepicker.js"></script>
    <script src="${pageContext.request.contextPath}/js/register.js"></script>
    <script src="${pageContext.request.contextPath}/js/checkIdentity.js"></script>
    <script src="${pageContext.request.contextPath}/js/fileinput.js"></script>
    <script src="${pageContext.request.contextPath}/js/zh.js"></script>

    <style>
         .form-group b {

            margin-right: 5px;
            font-weight: normal;
            color: red;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="row">
        <div class="header_top">
                <a href="javascript:;" onclick="javascript:history.go(-1);"><img src="${pageContext.request.contextPath}/images/back.png" alt=""></a>
            <h3>注册——企业认证</h3>
        </div>
        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="margin-top:10%">

            <form class="form-horizontal" id="form_disabled" method="post" enctype="multipart/form-data" name="companyF" action="${pageContext.request.contextPath}/user/verifyCompany.html">
            <div class="form-group">
                <label class="col-xs-12 col-sm-12 col-md-12 col-lg-12"><b class="ftx04">*</b>企业名称：</label>
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                    <input type="text" name="qymc" id="qymc" class="form-control seetext" placeholder="请输入企业名称" required>
                </div>
            </div>
            <div class="form-group">
                <label class="col-xs-12 col-sm-12 col-md-12 col-lg-12"><b class="ftx04">*</b>法定代表人：</label>
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                    <input type="text" name="frxm" id="frxm" class="form-control seetext" placeholder="请填写法定代表人" required>
                </div>
            </div>
			 <div class="form-group">
                <label class="col-xs-12 col-sm-12 col-md-12 col-lg-12"><b class="ftx04">*</b>法人联系电话:</label>
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                    <input type="text" name="frlxdh" class="form-control seetext frlxdh" placeholder="法人联系电话" required>
                </div>
            </div>
			 <div class="form-group">
                <label class="col-xs-12 col-sm-12 col-md-12 col-lg-12"><b class="ftx04">*</b>法人身份证号码:</label>
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                    <input type="text" name="frsfz" class="form-control seetext sfzhm" placeholder="法人身份证号码"
                           onblur="checkFR()"  required>
                </div>
            </div>
            <div class="form-group">
               <label class="col-xs-12 col-sm-12 col-md-12 col-lg-12"><b class="ftx04">*</b>请输入统一社会信用代码：</label>
               <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
               <input type="text" name="shtydm" class="form-control seetext" id="shtydm" placeholder="请填写统一社会信用代码" required>
               </div>
            </div>

                <div class="form-group">
                    <label class="col-xs-12 col-sm-12 col-md-12 col-lg-12"><b class="ftx04">*</b>注册地址：</label>
                    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                        <input type="text" name="zcdz" id="zcdz" class="form-control seetext" placeholder="请输入公司注册地址" required>
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-md-1 col-lg-1 control-label label_file"><b class="ftx04">*</b>上传营业执照：</label>
                    <div class="col-sm-10 col-md-11 col-lg-11">
                        <input id="file-1" class="file" type="file" data-min-file-count="1" name="licence">
                    </div>
                </div>

                <div class="form-group" id="savebt">
                    <div class="col-xs-12 sbsxbtn">
                        <button class="btn btn-primary" id="savebtn" onclick="sumCompanyInof()">下一步</button>
                    </div>
                </div>
        </form>
        </div>
    </div>
</div>
<script>
    function checkFR() {
        var frIdcard  = $("input[name='frsfz']").val().trim().toUpperCase();
        console.log("frIdcard::"+frIdcard);
        $("input[name='frsfz']").val(frIdcard);


        if($("#frsfz").parent().find("span") != null){
            $("#frsfz").parent().find("span").remove();
        }
        var flag = IdentityCodeValid(frIdcard);
        if(flag){
            var hdw1 = $("<span class='a2 righta'></span>");
            $("#frsfz").parent().append(hdw1);
        }else{
            $("#frsfz").parent().append("<span class='sfzhm' style='color:#f00'>请输入正确的18位身份证号</span>");
        }
    }
</script>
<script>
    $("#file-1").fileinput({
        language: 'zh',
        //uploadUrl: "/FileUpload/Upload", //上传的地址
        showUpload : false,
        showRemove : false,
        indicatorNew:false


    });
    $(function () {
        $('#datetimepicker1').datetimepicker({
            language: 'cn',
            autoclose: true,
            todayHighlight: true,
            minView: "month",
            format: 'yyyy-mm-dd'
        });

    });
    $(function () {
        $('#datetimepicker2').datetimepicker({
            language: 'cn',
            autoclose: true,
            todayHighlight: true,
            minView: "month",
            format: 'yyyy-mm-dd'
        });

    });
    $(function () {
        $('#datetimepicker3').datetimepicker({
            language: 'cn',
            autoclose: true,
            todayHighlight: true,
            minView: "month",
            format: 'yyyy-mm-dd'
        });

    });
    $(function () {
        $('#datetimepicker4').datetimepicker({
            language: 'cn',
            autoclose: true,
            todayHighlight: true,
            minView: "month",
            format: 'yyyy-mm-dd'
        });

    });
</script>
<script>
    function sumCompanyInof() {
        $("#companyF").submit();
        console.log("提交公司认证信息");
    }
</script>
</body>
</html>