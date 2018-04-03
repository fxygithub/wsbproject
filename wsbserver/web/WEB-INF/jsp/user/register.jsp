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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pwd.css">
    <script src="${pageContext.request.contextPath}/js/jquery-1.11.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
    <script src="${pageContext.request.contextPath}/js/register.js"></script>
    <script src="${pageContext.request.contextPath}/js/checkIdentity.js"></script>
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
                <a href="javascript:;" onclick="javascript:history.go(-1);">
                    <img src="${pageContext.request.contextPath}/images/back.png" alt=""></a>
            <h3>注册——填写用户信息</h3>
        </div>
        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="margin-top:10%">

            <form class="form-horizontal" id="form_disabled" id="fName" action="${pageContext.request.contextPath}/user/register.html" method="post">
            <div class="form-group">
                <label class="col-xs-12 col-sm-12 col-md-12 col-lg-12"><b class="ftx04">*</b>用户名：</label>
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                    <input type="text" name="username" id="username" value="${sessionScope.userName}" class="form-control seetext" placeholder="请填写18位有效的身份证号码"  onblur="check()"  required> <%--onkeyup="check()"--%>
                </div>

            </div>
            <div class="form-group">
                <label class="col-xs-12 col-sm-12 col-md-12 col-lg-12"><b class="ftx04">*</b>手机号：</label>
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                    <input type="text" name="tel" id="phone" class="form-control seetext" placeholder="请填写11位有效的手机号码" required>
                </div>
            </div>
            <div class="form-group">
               <label class="col-xs-12 col-sm-12 col-md-12 col-lg-12"><b class="ftx04">*</b>密码：</label>
               <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
               <input type="password" name="password" class="form-control seetext" id="password" placeholder="6-20位英文（区分大小写）、数字、字符的组合" onkeyup="CheckIntensity(this.value.trim())" required>

                   <table border="0" cellpadding="0" cellspacing="0">
                       <tr align="center">
                           <td id="pwd_Weak" class="pwd pwd_c"> </td>
                           <td id="pwd_Medium" class="pwd pwd_c pwd_f">无</td>
                           <td id="pwd_Strong" class="pwd pwd_c pwd_c_r"> </td>
                       </tr>
                   </table>
               </div>
            </div>
            <div class="form-group">
                <label class="col-xs-12 col-sm-12 col-md-12 col-lg-12"><b class="ftx04">*</b>确认密码：</label>
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                        <input type="password" name="repassword" id="passwords" class="form-control seetext" placeholder="请再输入一遍上面的密码" required/>
                </div>
            </div>
            <div class="form-group">
                <label class="col-xs-12 col-sm-12 col-md-12 col-lg-12"><b class="ftx04">*</b>验证码：</label>
                <div class="input-group">
               <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="padding-right:0;">
                   <input type="text" class="form-control seetext" placeholder="验证码" name="smsCode" required>
               </div>
                <div class="input-group-addon" style="padding-top:0;padding-bottom:0;">
                    <input type="button" value="获取验证码" onclick="settime(this)" onmouseup="getCode()"  onmouseleave="" style="border:none;"/> </div>
                </div>

            </div>

                <div class="form-group" id="savebt">
                    <div class="col-xs-12 sbsxbtn">
                        <button class="btn btn-primary" id="savebtn" onclick="nextStep()">下一步</button>
                    </div>
                </div>

        </form>
        </div>
    </div>
</div>
<script>
    function nextStep() {
        $("#fName").submit();
        console.log("提交表单");
    }
</script>

<script>
    function getCode() {
        var telNum = $("#phone").val();
        if(telNum!=null){
            $.ajax({
                url:"${pageContext.request.contextPath}/user/getCode.html?phone="+telNum,
                success:function (data) {
                    console.log(data);
                }
            });
        }else {
            alert("请在上方输入框中输入电话号码")
        }
    }
</script>

<script>
    var countdown=60;
    function settime(obj) {
        if (countdown == 0) {
            obj.removeAttribute("disabled");
            obj.value="获取验证码";
            countdown = 60;
            return;
        } else {
            obj.setAttribute("disabled","true");
            obj.value="重新发送(" + countdown + ")";
            countdown--;
        }
        setTimeout(function() {
                settime(obj) }
            ,1000)
    }
</script>

<script>
    //检验用户是否注册过
    function check() {
        var userName  = $("input[name='username']").val().trim().toUpperCase();
        console.log("userName::"+userName);
        console.log("长度::"+userName.length);
        $("input[name='username']").val(userName);

        var c = IdentityCodeValid(userName);
        console.log("flag:"+c);
        if(c){
            if($("#username").parent().find("span") != null){
                $("#username").parent().find("span").remove();
            }
            $.ajax({
                type:'get',
                url:'${pageContext.request.contextPath}/user/checkUserIfRegister.html?userName='+userName,
                success: function (data) {
                    console.log("data="+data)
                    if(data == "isExist"){
                        $("#username").parent().append("<span class='a2 error' style='color:#f00'>用户名已经注册过！</span>");
                    }else{
                        var hdw1 = $("<span class='a2 righta'></span>");
                        $("#username").parent().append(hdw1);
                    }
                }
            })
        }else{
            if($("#username").parent().find("span") != null){
                $("#username").parent().find("span").remove();
            }
            $("#username").parent().append("<span class='sfzhm' style='color:#f00'>请输入正确的18位身份证号</span>");
        }

    }
</script>

<script>
    //检查密码强度
    function CheckIntensity(pwd){
        var Mcolor,Wcolor,Scolor,Color_Html;
        var m=0;
        var Modes=0;
        for(var i=0; i<pwd.length; i++){
            var charType=0;
            var t=pwd.charCodeAt(i);//返回字符的Unicode编码值
            if(t>=48 && t <=57){charType=1;}
            else if(t>=65 && t <=90){charType=2;}
            else if(t>=97 && t <=122){charType=4;}
            else{charType=4;}
            Modes |= charType;
            console.log(Modes);
        }
        for(i=0;i<4;i++){
            if(Modes & 1){m++;}
            Modes>>>=1;
        }
        if(pwd.length<=4){m=1;}//长度小于等于4或0都是弱
        if(pwd.length<=0){m=0;}

        switch(m){
            case 1 :
                Wcolor="pwd pwd_Weak_c";
                Mcolor="pwd pwd_c";
                Scolor="pwd pwd_c pwd_c_r";
                Color_Html="弱";
                break;
            case 2 :
                Wcolor="pwd pwd_Medium_c";
                Mcolor="pwd pwd_Medium_c";
                Scolor="pwd pwd_c pwd_c_r";
                Color_Html="中";
                break;
            case 3 :
                Wcolor="pwd pwd_Strong_c";
                Mcolor="pwd pwd_Strong_c";
                Scolor="pwd pwd_Strong_c pwd_Strong_c_r";
                Color_Html="强";
                break;
            default :
                Wcolor="pwd pwd_c";
                Mcolor="pwd pwd_c pwd_f";
                Scolor="pwd pwd_c pwd_c_r";
                Color_Html="无";
                break;
        }
        document.getElementById('pwd_Weak').className=Wcolor;
        document.getElementById('pwd_Medium').className=Mcolor;
        document.getElementById('pwd_Strong').className=Scolor;
        document.getElementById('pwd_Medium').innerHTML=Color_Html;
    }
</script>

</body>
</html>