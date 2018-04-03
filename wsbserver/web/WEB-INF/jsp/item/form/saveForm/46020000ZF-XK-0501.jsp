<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@include file="/WEB-INF/jsp/item/common/common.jsp" %>
    <title>临时占用城市道路和城市道路设施审批（新建类）</title>
</head>
<body>

<div class="container">
    <div class="row">
        <div class="header_top">
                <a href="javascript:;" onclick="javascript:history.go(-1);">
                    <img src="${pageContext.request.contextPath}/images/back.png" alt=""></a>
            <h3>综合受理表单填写</h3>
        </div>
        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
            <div class="sx_title"><h3>临时占用城市道路设施审批申请表</h3></div>
            <form class="form-horizontal" name="三亚市执法局_临时占用城市道路设施审批申请表(综合)" id="SanYaShiZhiFaJu_LinShiZYCSDLZH" onsubmit="return false" action="http://199.224.253.9:8081/cform/view?formId=SanYaShiZhiFaJu_LinShiZYCSDLZH" method="post" cf_modelname="三亚市执法局_临时占用城市道路设施审批申请表（综合）" cf_modelid="SanYaShiZhiFaJu_LinShiZYCSDLZH" cf_iscreateid="1" cf_appcode="INSPUR-DZZW-YSL" cf_fieldcounter="46" cf_iscreatetable="1" cf_themeid="default" cf_elementtype="form">
            <div class="form-group">
                <label class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label item">当前时间：</label>
                <div class="col-xs-8 col-sm-10 col-md-11 col-lg-11">
                    <input id="DangQianShiJian" name="DangQianShiJian" type="text" value="" class="form-control" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_text" cf_modelitemid="DangQianShiJian" cf_modelitemname="当前时间" cf_databindtype="curDateForTxt" readonly="readonly">


                </div>
            </div>
                <div class="form-group">
                    <label class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label item">证&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;号：</label>
                    <div class="col-xs-8 col-sm-10 col-md-11 col-lg-11">
                        <input id="ZhengHao" name="ZhengHao" type="text" value="" class="form-control" placeholder="证号"  cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_text" cf_modelitemid="ZhengHao" cf_modelitemname="证号">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label item">申请单位(个人)：</label>
                    <div class="col-xs-8 col-sm-10 col-md-11 col-lg-11">
                        <input name="ShenQingDanWeiGeRen" id="ShenQingDanWeiGeRen" class="form-control" placeholder="申请单位(个人)" type="text" cf_iscreateid="1" cf_elementtype="field" cf_modelitemname="申请单位（个人）" cf_modelitemid="ShenQingDanWeiGeRen" cf_widgetid="cf_text" cf_fieldlength="100" value="${company.enterpriseName}"/>

                    </div>
                </div>
                <div class="form-group">
                    <label class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label item">联&nbsp;系&nbsp;人：</label>
                    <div class="col-xs-8 col-sm-10 col-md-11 col-lg-11">
                        <input id="LianXiRen" name="LianXiRen" type="text" value="${company.legalPersonName}" class="form-control" placeholder="联系人" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_text" cf_modelitemid="LianXiRen" cf_modelitemname="联系人">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label item">联系人电话：</label>
                    <div class="col-xs-8 col-sm-10 col-md-11 col-lg-11">
                        <input id="LianXiRenDianHua" name="LianXiRenDianHua" type="text" value="${company.legalPersonPhone}" class="form-control frlxdh" placeholder="联系人电话" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_text" cf_modelitemid="LianXiRenDianHua" cf_modelitemname="联系人电话">

                    </div>
                </div>
                <div class="form-group">
                    <label class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label item">身份证号：</label>
                    <div class="col-xs-8 col-sm-10 col-md-11 col-lg-11">
                        <input id="ShenFenZhengHao" name="ShenFenZhengHao" type="text" value="${company.legalPersonId}" class="form-control sfzhm" placeholder="身份证号" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_text" cf_modelitemid="ShenFenZhengHao" cf_modelitemname="身份证号">
                    </div>
                </div>

            <div class="form-group">
               <label class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label item">占用地点：</label>
               <div class="col-xs-8 col-sm-10 col-md-11 col-lg-11">
               <input id="ZhanYongDiDian" name="ZhanYongDiDian" type="text" value="" class="form-control" placeholder="占用地点" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_text" cf_modelitemid="ZhanYongDiDian" cf_modelitemname="占用地点">
               </div>
            </div>
                <div class="form-group">
                    <label class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label item">占用期限：</label>
                    <div class="col-xs-8 col-sm-10 col-md-11 col-lg-11">
                        <div class="input-group"><span class="input-group-addon" style="font-size: 12px;">自</span> <input type="text" class="form-control" value="" id="dpd1" name="ZhanYongQiXianYi" readonly="readonly" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_date" cf_modelitemid="ZhanYongQiXianYi" cf_modelitemname="占用期限一" style="background:#ffffff;"></div>
                        <div class="input-group"><span class="input-group-addon" style="font-size: 12px;">至</span><input type="text" class="form-control" value="" id="dpd2" name="ZhanYongQiXianEr" readonly="readonly" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_date" cf_modelitemid="ZhanYongQiXianEr" cf_modelitemname="占用期限二" style="background:#ffffff;">
                        </div>
                        <div class="input-group">
                            <span class="input-group-addon" style="font-size: 12px;">共</span> <input type="text" readonly="readonly" class="form-control" id="dpd3" value="" style="background:#ffffff;" name="ZhanYongQiXianTian" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_text" cf_modelitemid="ZhanYongQiXianTian" cf_modelitemname="占用期限天" ><span class="input-group-addon" style="font-size: 12px;" >天</span>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label item">使用性质：</label>
                    <div class="col-xs-8 col-sm-10 col-md-11 col-lg-11" style="padding-top:8px;">
                        <input name="ShiYongXingZhi" type="checkbox" value="非经营占道" class="cfCheckBox" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_checkbox" cf_modelitemid="ShiYongXingZhi" cf_modelitemname="使用性质" checked="checked">非经营占道
                        <input name="ShiYongXingZhi" type="checkbox" value="经营占道   " class="cfCheckBox" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_checkbox" cf_modelitemid="ShiYongXingZhi" cf_modelitemname="使用性质">经营占道

                    </div>
                </div>
                <div class="form-group">
                    <label class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label item">占用类别：</label>
                    <div class="col-xs-8 col-sm-10 col-md-11 col-lg-11" style="padding-top:8px;">
                        <input name="ZhanYongLeiBie" type="checkbox" value="施工搭棚" class="cfCheckBox" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_checkbox" cf_modelitemid="ZhanYongLeiBie" cf_modelitemname="占用类别" checked="checked">施工搭棚
                        <input name="ZhanYongLeiBie" type="checkbox" value="施工围栏" class="cfCheckBox" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_checkbox" cf_modelitemid="ZhanYongLeiBie" cf_modelitemname="占用类别">施工围栏
                        <input name="ZhanYongLeiBie" type="checkbox" value="堆物堆料" class="cfCheckBox" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_checkbox" cf_modelitemid="ZhanYongLeiBie" cf_modelitemname="占用类别">堆物堆料
                        <input name="ZhanYongLeiBie" type="checkbox" value="其它" class="cfCheckBox" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_checkbox" cf_modelitemid="ZhanYongLeiBie" cf_modelitemname="占用类别">其它

                    </div>
                </div>
                <div class="form-group">
                    <label class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label item">占用面积：</label>
                    <div class="col-xs-8 col-sm-10 col-md-11 col-lg-11">
                        <div class="input-group">
                            <div class="input-group-addon">长</div>
                            <input id="ZhanYongMianJiChangMi" name="ZhanYongMianJiChangMi" type="text" value="" class="form-control CustomWidth"  cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_text" cf_modelitemid="ZhanYongMianJiChangMi" cf_modelitemname="占用面积长米">
                            <div class="input-group-addon">米</div>
                        </div>
                        <div class="input-group">
                            <div class="input-group-addon">宽</div>
                            <input id="ZhanYongMianJiKuanMi" name="ZhanYongMianJiKuanMi" type="text" value="" class="form-control CustomWidth" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_text" cf_modelitemid="ZhanYongMianJiKuanMi" cf_modelitemname="占用面积宽米">
                            <div class="input-group-addon">米</div>
                        </div>
                        <div class="input-group">
                            <div class="input-group-addon">计</div>
                            <input id="ZhanYongMianJiJiKuai" name="ZhanYongMianJiJiKuai" type="text" value="" class="form-control CustomWidth" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_text" cf_modelitemid="ZhanYongMianJiJiKuai" cf_modelitemname="占用面积计块">
                            <div class="input-group-addon">块</div>
                        </div>
                        <div class="input-group">
                            <div class="input-group-addon">共</div>
                            <input id="ZhanYongMianJiPingFangMi" name="ZhanYongMianJiPingFangMi" type="text" value="" class="form-control CustomWidth" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_text" cf_modelitemid="ZhanYongMianJiPingFangMi" cf_modelitemname="占用面积平方米" onfocus="countArea()">
                            <div class="input-group-addon">平方米</div>
                        </div>
                    </div>
                </div>
<%--服务清单--%>
                <%@include file="/WEB-INF/jsp/item/common/serviceListSave.jsp"%>
                <div class="form-group">
                    <label class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label item">是否收费：</label>
                    <div class="col-xs-8 col-sm-10 col-md-11 col-lg-11">
                        <textarea id="ShiFuShouFeiBeiZhu" name="ShiFuShouFeiBeiZhu" value="" class="form-control" cf_fieldlength="500" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_textarea" cf_modelitemid="ShiFuShouFeiBeiZhu" cf_modelitemname="是否收费备注" minheight="80" maxheight="200"></textarea></td>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label item">备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：</label>
                    <div class="col-xs-8 col-sm-10 col-md-11 col-lg-11">
                        <textarea id="BeiZhu" name="BeiZhu" value="" class="form-control" cf_fieldlength="500" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_textarea" cf_modelitemid="BeiZhu" cf_modelitemname="备注" minheight="80" maxheight="200"></textarea>
                    </div>
                </div>

        </form>
            <div class="form-group">
            <button id="btnSave" type="button" onclick="submit()" class="btn btn-primary">保存</button>
            </div>
        </div>
    </div>
</div>

<div id="somedialog" class="dialog">

    <div class="dialog__overlay"></div>

    <div class="dialog__content">

        <form action="#" method="post" class="file_form">
            <a href="javascript:void(0);" class="btn_addPic"><span><em>+</em>添加图片</span> <input id="UploadFile" type="file" name="UploadFile" value="" class="filePrew cfText" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_text" cf_modelitemid="UploadFile" cf_modelitemname="文件上传"></a>
            <input type="submit" value="提交" class="submitbtn">
            <input type="reset" value="重置" id="reset" class="submitbtn">

        </form>
        <a class="close-reveal-modal">×</a>
    </div>

</div>
<script>
    function  countArea() {
        var length = $("#ZhanYongMianJiChangMi").val();
        var width = $("#ZhanYongMianJiKuanMi").val();
        var sum = length*width;
        $("#ZhanYongMianJiPingFangMi").val(sum);
    }
</script>
<script>
    function getDate(){
        var today = new Date();
        var date;
        date = (today.getFullYear()) +"-" + (today.getMonth() + 1 ) + "-" + today.getDate();
        return date;
    }
    window.onload = function(){
        var input = document.getElementById("DangQianShiJian");
        setInterval(function(){
            input.value = getDate();
        });
    }
</script>
<script>
    var nowTemp = new Date();
    var now = new Date(nowTemp.getFullYear(), nowTemp.getMonth(), nowTemp.getDate(), 0, 0, 0, 0);
    var checkin = $('#dpd1').fdatepicker({
        format: 'yyyy-mm-dd',
        onRender: function (date) {
            return date.valueOf() < now.valueOf() ? '' : '';
        }
    }).on('changeDate', function (ev) {
        if (ev.date.valueOf() > checkout.date.valueOf()) {
            var newDate = new Date(ev.date)
            newDate.setDate(newDate.getDate() + 1);
            checkout.update(newDate);
        }
        checkin.hide();
        $('#dpd2')[0].focus();
    }).data('datepicker');
    var checkout = $('#dpd2').fdatepicker({
        format: 'yyyy-mm-dd',
        onRender: function (date) {

            return date.valueOf() < checkin.date.valueOf() ? 'disabled' : '';
        }
    }).on('changeDate', function (ev) {
	var checkinandcheckout =$("#dpd3");

	var checkinandcheckout = checkout.date.valueOf()-checkin.date.valueOf();
	 var daysss =Math.floor(checkinandcheckout/86400000);
		$("#dpd3").val(daysss+1);
        checkout.hide();
    }).data('datepicker');


	

</script>
<%@include file="/WEB-INF/jsp/item/common/submit.jsp"%>
</body>
</html>