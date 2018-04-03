<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
    .form-group{position: relative;margin-bottom:20px;}
</style>
<script type="text/javascript">
    $(function(){
        var screenWidth = $(window).width();
        screenHeight = $(window).height(); //当前浏览器窗口的 宽高
        var scrolltop = $(document).scrollTop();//获取当前窗口距离页面顶部高度
        $(".spanbb").click(function(){
            var sss = $(this).attr('id');
            var bbb = $(this).parents(".form-group").find("#nn").val();
           // alert("隐藏："+bbb);
            var niubiClass=$(".niubi");
            var otherParam = $(".otherParam").attr("value",bbb)
           // alert("获得："+otherParam);
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
                $(this).siblings('.niubi').find('.btn_addPic span').html("<em>+</em>添加图片");
                alert(mbmb);

            }else{

            }

            $(".niubi").css("visibility","hidden");

            $("body").css({"overflow": "auto","height":"auto"});
            $(this).fadeOut(300);
        })

    })
</script>
<script>
    $(".close-reveal-modal").click(function(){//关闭提交框
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
    $('.filePrew').on('change', function() {
        var reg = /[^\\\/]*[\\\/]+/g; //匹配文件的名称和后缀的正则表达式
        var name = $(this).val().replace(reg, '');
        var text =name.substr();//获取没有后缀的名称
        $(this).parents('.btn_addPic ').find('span').html(text);
    });

</script>

<script>
 /*   提交表单的数据*/
    function submit(){
        var formID = $('form').attr('id');
        var json = $("#"+formID).serializeJson();//数据序列化
        var param= JSON.stringify(json);//转成字符串
        //        alert("值："+param);
        //        console.log(param);
        $.ajax({
            type:"POST",
            url:"${pageContext.request.contextPath}/item/saveItem.html",
            contentType:'application/json;charset=utf-8',
            data:param,
            dataType:"text",
            success:function(data) {
                if(data=="success"){
                    alert("成功保存表单数据，点击确定按钮，为您跳转到上传材料页面！");
                    window.location.href="${pageContext.request.contextPath}/item/uploadPage.html?code=${sessionScope.code}";
                }else{
                    alert("保存失败！请重新申报数据");
                }
            },
            error:function () {
                alert("发送保存请求失败");
            }
        })
    }

</script>