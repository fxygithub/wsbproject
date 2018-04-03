<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div id="somedialog" class="dialog">
    <div class="dialog__overlay"></div>
    <div class="dialog__content">
        <form action="${pageContext.request.contextPath}/item/updateFiles.html" method="post"
              class="file_form" enctype="multipart/form-data">
            <a href="javascript:void(0);" class="btn_addPic"><span><em>+</em>上传文件</span>
                <input id="UploadFile" type="file" name="UploadFile" value="" multiple="multiple" class="filePrew cfText" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_text" cf_modelitemid="UploadFile" cf_modelitemname="文件上传"></a>
            <input type="hidden" name="otherParam" class="otherParam" value="" />
            <input type="submit" value="提交" class="submitbtn">
            <input type="reset" value="重置" id="reset" class="submitbtn">
        </form>
        <a class="close-reveal-modal">×</a>
    </div>
</div>
<script>
    $(function(){
        $(".spanbb").click(function(){
            var bbb = $(this).next(".form-group").find(".nn").val();//隐藏要用的参数值
          //  alert("metail CODE::"+bbb);//TODO 弹出来的 材料CODE一直都是第一个材料的CODE，没有对应上
            var otherParam = $(".otherParam").attr("value",bbb)
            $(this).DialogShow({
                'id': 'somedialog',  //传入id，可以控制样式
                'dialogFx': '1',     //传入显示和隐藏的参数
            });
        });
        $(".dialog__overlay").click(function(){
            $(this).DialogShow({
                'id': 'somedialog',
                'dialogFx': '0',
            });
            var reg = /[^\\\/]*[\\\/]+/g;
            var name = $(this).parents("#somedialog").find('.dialog__content .btn_addPic .filePrew').val().replace(reg, '');
            if(name != ''){
                var text =name.substr();//获取没有后缀的名称
                var mbmb = $(this).parents("#somedialog").find('.dialog__content .btn_addPic .filePrew').val('');
                $(this).parents('#somedialog').find('.btn_addPic span').html("<em>+</em>添加文件");
            }

        });

        $(".close-reveal-modal").click(function(){

            $(this).DialogShow({

                'id': 'somedialog',

                'dialogFx': '0',

            });
            var reg = /[^\\\/]*[\\\/]+/g;
            var name = $(this).parents("#somedialog").find('.dialog__content .btn_addPic .filePrew').val().replace(reg, '');
            if(name != ''){
                var text =name.substr();//获取没有后缀的名称
                var mbmb = $(this).parents("#somedialog").find('.dialog__content .btn_addPic .filePrew').val('');
                $(this).parents('#somedialog').find('.btn_addPic span').html("<em>+</em>添加图片");
            }
        });

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
    /*   提交表单的数据*/
    function submit(){
        var formID = $('form').attr('id');
        var json = $("#"+formID).serializeJson();//数据序列化
        var param= JSON.stringify(json);//转成字符串
        //        alert("值："+param);
        //        console.log(param);
        $.ajax({
            type:"POST",
            url:"${pageContext.request.contextPath}/item/editItemAction.html",
            contentType:'application/json;charset=utf-8',
            data:param,
            dataType:"text",
            success:function(data) {
                if(data=="success"){
                    //成功与否都跳到编辑页面，查看效果
                  //  window.location.href="${pageContext.request.contextPath}/item/myItem.html?userId=${sessionScope.userId}";
                    window.location.href="${pageContext.request.contextPath}/item/editItem.html?code=${sessionScope.code}&&dataId=${sessionScope.dataId}";
                }else{
                    window.location.href="${pageContext.request.contextPath}/item/editItem.html?code=${sessionScope.code}&&dataId=${sessionScope.dataId}";
                }
            },
            error:function () {
                alert("发送修改数据请求失败！");
            }
        })
    }

</script>