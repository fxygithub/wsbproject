<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="${pageContext.request.contextPath}/js/checkIdentity.js"></script>
<div class="form-group">
    <label class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label item">服务清单：</label>
    <div class="col-xs-8 col-sm-10 col-md-11 col-lg-11">
        <div class="SendType">
            <input type="radio" class="moren xz_btn" name="moren" value="0" checked="checked">默认
            <input type="radio" class="zidingyi xz_btn" name="moren" value="1">自定义
        </div>
        <div class="morem_box" style="display: none;">
            <label for="ApplicantName">
                申请人名称
                <input id="ApplicantName" name="ApplicantName" value="" class="form-control" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_text" cf_modelitemid="ApplicantName" cf_modelitemname="申请人名称" type="text">
            </label>
            <label for="ApplicantID">申请人身份证号
                <input id="ApplicantID" name="ApplicantID" value="" class="form-control" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_text" cf_modelitemid="ApplicantID" cf_modelitemname="申请人身份证号" type="text" onblur="checkApplicationIdCard(this.value.trim().toUpperCase(),'请输入正确的身份证号')">
            </label>
            <label for="ApplicantMobile">申请人手机号
                <input id="ApplicantMobile" name="ApplicantMobile" value="" class="form-control" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_text" cf_modelitemid="ApplicantMobile" cf_modelitemname="申请人手机号" type="text">
            </label>
            <label for="ApplicantAddress">申请人地址
                <input id="ApplicantAddress" name="ApplicantAddress" value="" class="form-control" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_text" cf_modelitemid="ApplicantAddress" cf_modelitemname="申请人地址" type="text">
            </label>


        </div>
        <div class="SendType">
            邮寄方式：<input type="radio" class="ziqu" name="SendType" value="0" checked="checked">自取
            <input type="radio" class="toudi" name="SendType" value="1">投递
        </div>
        <div class="toidifangshi" style="display: none;">
            <label for="HallCode">邮政编码
                <input id="HallCode" name="HallCode" value="" class="form-control" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_text" cf_modelitemid="HallCode" cf_modelitemname="申请人地址" type="text" onblur="checkPostCard(this.value.trim(),'邮政编码不正确！')">
            </label>
            <label for="HallName">收件人姓名
                <input id="HallName" name="HallName" value="" class="form-control" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_text" cf_modelitemid="HallName" cf_modelitemname="申请人地址" type="text">
            </label>
            <label for="MailAddress">收件人地址
                <input id="MailAddress" name="MailAddress" value="" class="form-control" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_text" cf_modelitemid="MailAddress" cf_modelitemname="申请人地址" type="text">
            </label>
            <label for="receiverPhone">收件人电话
                <input id="receiverPhone" name="receiverPhone" value="" class="form-control" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_text" cf_modelitemid="MailAddress" cf_modelitemname="申请人地址" type="text" >
            </label>
        </div>
    </div>
</div>

