
$(document).ready(function(){
    //创建一个*
    //end
    $("form :input").blur(function(){
        $(this).parent().find(".a2").remove();
        //判断
        /*if ($(this).is("#username")){
            if (this.value=="" || this.value.length < 6){
                var hdw1 = $("<span class='a2 error' style='color:#f00'>用户名不得小于6位</span>");
                $(this).parent().append(hdw1);
            }else{
                var hdw1 = $("<span class='a2 righta'></span>");
                $(this).parent().append(hdw1);
            }
        }*/
        //end


        //判断
        if ($(this).is("#password")){
            if (this.value==""){
                var hdw1 = $("<span class='a2 error' style='color:#f00'>密码不得为空</span>");
                $(this).parent().append(hdw1);
            }else{
                var hdw1 = $("<span class='a2 righta'></span>");
                $(this).parent().append(hdw1);
            }
        }
        //end

        //判断
        if ($(this).is("#passwords")){
            if (this.value=="" || this.value!= $("#password").val()){
                var hdw1 = $("<span class='a2 error' style='color:#f00'>两次密码不一样</span>");
                $(this).parent().append(hdw1);
            }else{
                var hdw1 = $("<span class='a2 righta'></span>");
                $(this).parent().append(hdw1);
            }
        }
        //end


        //判断
        if ($(this).is("#email")){
            if (this.value=="" || ( this.value!="" && !/.+@.+\.[a-zA-Z]{2,4}$/.test(this.value) )){
                var hdw1 = $("<span class='a2 error'>邮件的格式不正确</span>");
                $(this).parent().append(hdw1);
            }else{
                var hdw1 = $("<span class='a2 righta'></span>");
                $(this).parent().append(hdw1);
            }

        }
        //end

        //判断
        if ($(this).is("#phone")){
            if (this.value=="" || this.value != "" &&! /^1[34578]\d{9}$/.test(this.value)){
                var hdw1 = $("<span class='a2 error' style='color:#f00'>必须是11位数字</span>");
                $(this).parent().append(hdw1);
                return false;
            }else{
                var hdw1 = $("<span class='a2 righta'></span>");
                $(this).parent().append(hdw1);
            }

        }
        if ($(this).is(".jbrdh")|| $(this).is(".frlxdh") || $(this).is(".fddbrdh")){
            if (this.value=="" || this.value != "" &&! /^1[34578]\d{9}$/.test(this.value)){
                var hdw1 = $("<span class='a2 error' style='color:#f00'>必须是11位数字</span>");
                $(this).parent().append(hdw1);
                return false;
            }else{
                var hdw1 = $("<span class='a2 righta'></span>");
                $(this).parent().append(hdw1);
            }
        }

        if ($(this).is("#xingming")){
            if (this.value=="" || this.value!="" && !/^[\u4E00-\u9FFF]+$/.test(this.value)){
                var hdw1 = $("<span class='a2 error' style='color:#f00'>请输入身份证上的姓名</span>");
                $(this).parent().append(hdw1);
            }else{
                var hdw1 = $("<span class='a2 righta'></span>");
                $(this).parent().append(hdw1);
            }
        }

        if ($(this).is(".sfzhm") || $(this).is(".wtrsfzhm") || $(this).is(".grsfzhm")){
            if (this.value=="" || this.value!="" && !/(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/.test(this.value) || this.value.length < 18 ){
                var hdw1 = $("<span class='a2 error' style='color:#f00'>请输入身份证上号码18位数</span>");

                $(this).parent().append(hdw1);
                return false;

            }else{

                var hdw1 = $("<span class='a2 righta'></span>");

                $(this).parent().append(hdw1);
            }

        }
        if ($(this).is("#sex")){

            if (this.value=="" || this.value!="" && !/^[\u4E00-\u9FFF]{0,1}$/.test(this.value) || this.value.length < 1){

                        var hdw1 = $("<span class='a2 error' style='color:#f00'>请填写男或女</span>");


                $(this).parent().append(hdw1);

            }else{

                var hdw1 = $("<span class='a2 righta'></span>");

                $(this).parent().append(hdw1);
            }

        }
        if ($(this).is("#nation")){

            if (this.value=="" || this.value!="" && !/^[\u4E00-\u9FFF]{0,10}$/.test(this.value) || this.value.length < 1){

                var hdw1 = $("<span class='a2 error' style='color:#f00'>请填写民族</span>");


                $(this).parent().append(hdw1);

            }else{

                var hdw1 = $("<span class='a2 righta'></span>");

                $(this).parent().append(hdw1);
            }

        }

        if ($(this).is("#qymc")){

            if (this.value==""){

                var hdw1 = $("<span class='a2 error' style='color:#f00'>企业名称不能为空</span>");

                $(this).parent().append(hdw1);

            }else{

                var hdw1 = $("<span class='a2 righta'></span>");

                $(this).parent().append(hdw1);
            }

        }
        if ($(this).is("#frxm")){

            if (this.value=="" || this.value!="" && !/^[\u4E00-\u9FFF]{0,10}$/.test(this.value)){

                var hdw1 = $("<span class='a2 error' style='color:#f00'>法定代表人不能为空</span>");

                $(this).parent().append(hdw1);

            }else{

                var hdw1 = $("<span class='a2 righta'></span>");

                $(this).parent().append(hdw1);
            }

        }
        if ($(this).is("#shtydm")){

            if (this.value=="" || this.value!="" && !/^[0-9]*$/.test(this.value)){

                var hdw1 = $("<span class='a2 error' style='color:#f00'>只能输入社会统一代码</span>");

                $(this).parent().append(hdw1);

            }else{

                var hdw1 = $("<span class='a2 righta'></span>");

                $(this).parent().append(hdw1);
            }

        }
        if ($(this).is("#type")){

            if (this.value=="" || this.value!="" && !/^[\u4E00-\u9FFF]{0,10}$/.test(this.value)){

                var hdw1 = $("<span class='a2 error' style='color:#f00'>请输入投资类型</span>");

                $(this).parent().append(hdw1);

            }else{

                var hdw1 = $("<span class='a2 righta'></span>");

                $(this).parent().append(hdw1);
            }

        }
        if ($(this).is("#zczb")){

            if (this.value==""){

                var hdw1 = $("<span class='a2 error' style='color:#f00'>注册资本不能为空</span>");

                $(this).parent().append(hdw1);

            }else{

                var hdw1 = $("<span class='a2 righta'></span>");

                $(this).parent().append(hdw1);
            }

        }
        if ($(this).is("#zcbz")){

            if (this.value==""|| this.value!="" && !/^[\u4E00-\u9FFF]{0,10}$/.test(this.value)){

                var hdw1 = $("<span class='a2 error' style='color:#f00'>请填写注册币种</span>");

                $(this).parent().append(hdw1);

            }else{

                var hdw1 = $("<span class='a2 righta'></span>");

                $(this).parent().append(hdw1);
            }

        }
        if ($(this).is("#status")){

            if (this.value==""|| this.value!="" && !/^[\u4E00-\u9FFF]{0,1}$/.test(this.value)){

                var hdw1 = $("<span class='a2 error' style='color:#f00'>请填是或否</span>");

                $(this).parent().append(hdw1);

            }else{

                var hdw1 = $("<span class='a2 righta'></span>");

                $(this).parent().append(hdw1);
            }

        }
        if ($(this).is("#djjg")){

            if (this.value==""|| this.value!="" && !/^[\u4E00-\u9FFF]{0,10}$/.test(this.value)){

                var hdw1 = $("<span class='a2 error' style='color:#f00'>请填写登记机关</span>");

                $(this).parent().append(hdw1);

            }else{

                var hdw1 = $("<span class='a2 righta'></span>");

                $(this).parent().append(hdw1);
            }

        }
        if ($(this).is("#zcdz")){

            if (this.value==""|| this.value!="" && !/^[\u4E00-\u9FFF]{0,10}$/.test(this.value)){

                var hdw1 = $("<span class='a2 error' style='color:#f00'>请填写注册地址</span>");

                $(this).parent().append(hdw1);

            }else{

                var hdw1 = $("<span class='a2 righta'></span>");

                $(this).parent().append(hdw1);
            }

        }
        if ($(this).is("#yzbm")){

            if (this.value==""|| this.value!="" && !/^[1-9][0-9]{5}$/.test(this.value)){

                var hdw1 = $("<span class='a2 error' style='color:#f00'>请输入正确的邮政编码</span>");

                $(this).parent().append(hdw1);

            }else{

                var hdw1 = $("<span class='a2 righta'></span>");

                $(this).parent().append(hdw1);
            }

        }
        if ($(this).is("#jyfw")){

            if (this.value==""){

                var hdw1 = $("<span class='a2 error' style='color:#f00'>经营范围不能为空</span>");

                $(this).parent().append(hdw1);

            }else{

                var hdw1 = $("<span class='a2 righta'></span>");

                $(this).parent().append(hdw1);
            }

        }
        //end

    });

    $(".CustomWidth").keyup(function(){
        var tmptxt=$(this).val();
        $(this).val(tmptxt.replace(/\D|^0/g,''));
    }).bind("paste",function(){
        var tmptxt=$(this).val();
        $(this).val(tmptxt.replace(/\D|^0/g,''));
    });
});




