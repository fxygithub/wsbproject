<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@include file="/WEB-INF/jsp/item/common/common.jsp" %>
    <title>户外广告设施设置审批（新建类）</title>
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
            <div class="sx_title"><h3>三亚市户外广告设施设置审批申请</h3></div>
            <form class="form-horizontal" name="三亚市执法局_户外广告设施设置审批申请表(综合）" method="post" onsubmit="return false" action="http://199.224.253.9:8081/cform/view?formId=SanYaShiZhiFaJu_HWSZZH" cf_elementtype="form" cf_themeid="default" cf_iscreatetable="1" cf_fieldcounter="70" id="SanYaShiZhiFaJu_HWSZZH" cf_appcode="INSPUR-DZZW-YSL" cf_iscreateid="1" cf_modelid="SanYaShiZhiFaJu_HWSZZH" cf_modelname="三亚市执法局_户外广告设施设置审批申请表（综合）">
                <div class="form-group" style="display: none">
                    <label class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label item">当前时间：</label>
                    <div class="col-xs-8 col-sm-10 col-md-11 col-lg-11">
                        <input id="DangQianShiJian" name="DangQianShiJian" type="text" value="${banjianInof.data.DangQianShiJian}" class="form-control" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_text" cf_modelitemid="DangQianShiJian" cf_modelitemname="当前时间" cf_databindtype="curDateForTxt" readonly="readonly">


                    </div>
                </div>

                <div class="form-group">
                    <label class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label item">广告申请单位：</label>
                    <div class="col-xs-8 col-sm-10 col-md-11 col-lg-11">
                        <input id="GuangGaoShenQingDanWei" name="GuangGaoShenQingDanWei" type="text" value="${banjianInof.data.GuangGaoShenQingDanWei}" class="form-control" placeholder="广告申请单位" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_text" cf_modelitemid="GuangGaoShenQingDanWei" cf_modelitemname="广告申请单位">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label item">统一社会信用代码：</label>
                    <div class="col-xs-8 col-sm-10 col-md-11 col-lg-11">
                        <input id="TongYiSheHuiXinYongDaiMa" name="TongYiSheHuiXinYongDaiMa" type="text" value="${banjianInof.data.TongYiSheHuiXinYongDaiMa}" class="form-control" placeholder="统一社会信用代码" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_text" cf_modelitemid="TongYiSheHuiXinYongDaiMa" cf_modelitemname="统一社会信用代码">
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label item">经营场所：</label>
                    <div class="col-xs-8 col-sm-10 col-md-11 col-lg-11">
                        <input id="JingYingChangSuo" name="JingYingChangSuo" type="text" value="${banjianInof.data.JingYingChangSuo}" class="form-control" placeholder="经营场所" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_text" cf_modelitemid="JingYingChangSuo" cf_modelitemname="经营场所">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label item">设置地点：</label>
                    <div class="col-xs-8 col-sm-10 col-md-11 col-lg-11">
                        <input id="SheZhiDiDian" name="SheZhiDiDian" type="text" value="${banjianInof.data.SheZhiDiDian}" class="form-control" placeholder="设置地点" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_text" cf_modelitemid="SheZhiDiDian" cf_modelitemname="设置地点">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label item">法定代表人(经营者)：</label>
                    <div class="col-xs-8 col-sm-10 col-md-11 col-lg-11">
                        <input id="FaDingDaiBiaoRenJingYingZhe" name="FaDingDaiBiaoRenJingYingZhe" type="text" value="${banjianInof.data.FaDingDaiBiaoRenJingYingZhe}" class="form-control" placeholder="法定代表人(经营者)" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_text" cf_modelitemid="FaDingDaiBiaoRenJingYingZhe" cf_modelitemname="法定代表人(经营者)">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label item">电话：</label>
                    <div class="col-xs-8 col-sm-10 col-md-11 col-lg-11">
                        <input id="FaDingDaiBiaoRenDianHua" name="FaDingDaiBiaoRenDianHua" type="text" value="${banjianInof.data.FaDingDaiBiaoRenDianHua}" class="form-control frlxdh" placeholder="法定代表人电话" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_text" cf_modelitemid="FaDingDaiBiaoRenDianHua" cf_modelitemname="法定代表人电话">
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label item">法人身份证号：</label>
                    <div class="col-xs-8 col-sm-10 col-md-11 col-lg-11">
                        <input id="FaRenShenFenZhengHao" name="FaRenShenFenZhengHao" type="text" value="${banjianInof.data.FaRenShenFenZhengHao}" class="form-control sfzhm" placeholder="法人身份证号" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_text" cf_modelitemid="FaRenShenFenZhengHao" cf_modelitemname="法人身份证号">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label item">联系人：</label>
                    <div class="col-xs-8 col-sm-10 col-md-11 col-lg-11">
                        <input id="LianXiRen" name="LianXiRen" type="text" value="${banjianInof.data.LianXiRen}" class="form-control" placeholder="联系人" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_text" cf_modelitemid="LianXiRen" cf_modelitemname="联系人">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label item">联系人电话：</label>
                    <div class="col-xs-8 col-sm-10 col-md-11 col-lg-11">
                        <input id="LianXiRenDianHua" name="LianXiRenDianHua" type="text" value="${banjianInof.data.LianXiRenDianHua}" class="form-control jbrdh" placeholder="联系人电话" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_text" cf_modelitemid="LianXiRenDianHua" cf_modelitemname="联系人电话">

                    </div>
                </div>
                <div class="hiddenbox" style="display: none">
                    <div class="form-group">
                        <label class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label item">广告使用单位：</label>
                        <div class="col-xs-8 col-sm-10 col-md-11 col-lg-11">
                            <input id="GuangGaoShiYongDanWei" name="GuangGaoShiYongDanWei" type="text" value="${banjianInof.data.GuangGaoShiYongDanWei}" class="form-control" placeholder="广告使用单位" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_text" cf_modelitemid="GuangGaoShiYongDanWei" cf_modelitemname="广告使用单位">

                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label item">法定代表人(使用者)：</label>
                        <div class="col-xs-8 col-sm-10 col-md-11 col-lg-11">
                            <input id="FaDingDaiBiaoRenShiYongZhe" name="FaDingDaiBiaoRenShiYongZhe" type="text" value="${banjianInof.data.FaDingDaiBiaoRenShiYongZhe}" class="form-control" placeholder="法定代表人(使用者)" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_text" cf_modelitemid="FaDingDaiBiaoRenShiYongZhe" cf_modelitemname="法定代表人(使用者)">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label item">电话：</label>
                        <div class="col-xs-8 col-sm-10 col-md-11 col-lg-11">
                            <input id="FaDingDaiBiaoRenShiYongDianHua" name="FaDingDaiBiaoRenShiYongDianHua" type="text" value="${banjianInof.data.FaDingDaiBiaoRenShiYongDianHua}" class="form-control fddbrdh" placeholder="法定代表人使用电话" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_text" cf_modelitemid="FaDingDaiBiaoRenShiYongDianHua" cf_modelitemname="法定代表人使用电话">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label item">广告形式：</label>
                        <div class="col-xs-8 col-sm-10 col-md-11 col-lg-11" style="padding-top:8px">
                            <input name="GuangGaoXingShi" type="checkbox" value="挑檐式 " class="cfCheckBox" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_checkbox" cf_modelitemid="GuangGaoXingShi" cf_modelitemname="广告形式" checked="checked">挑檐式
                            <input name="GuangGaoXingShi" type="checkbox" value="檐下式" class="cfCheckBox" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_checkbox" cf_modelitemid="GuangGaoXingShi" cf_modelitemname="广告形式">檐下式
                            <input  name="GuangGaoXingShi" type="checkbox" value="立体浮雕 " class="cfCheckBox" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_checkbox" cf_modelitemid="GuangGaoXingShi" cf_modelitemname="广告形式">立体浮雕
                            <input name="GuangGaoXingShi" type="checkbox" value="遮蓬式  " class="cfCheckBox" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_checkbox" cf_modelitemid="GuangGaoXingShi" cf_modelitemname="广告形式">遮蓬式
                            <input name="GuangGaoXingShi" type="checkbox" value="其他" class="cfCheckBox" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_checkbox" cf_modelitemid="GuangGaoXingShi" cf_modelitemname="广告形式">其他
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label item">广告性质：</label>
                        <div class="col-xs-8 col-sm-10 col-md-11 col-lg-11" style="padding-top:8px">
                            <input name="GuangGaoXingZhi" type="checkbox" value="公益 " class="cfCheckBox" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_checkbox" cf_modelitemid="GuangGaoXingZhi" cf_modelitemname="广告性质">公益
                            <input name="GuangGaoXingZhi" type="checkbox" value="商业" class="cfCheckBox" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_checkbox" cf_modelitemid="GuangGaoXingZhi" cf_modelitemname="广告性质" checked="checked">商业
                            <input name="GuangGaoXingZhi" type="checkbox" value="其它" class="cfCheckBox" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_checkbox" cf_modelitemid="GuangGaoXingZhi" cf_modelitemname="广告性质">其它
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label item">广告类别：</label>
                        <div class="col-xs-8 col-sm-10 col-md-11 col-lg-11" style="padding-top:8px;">
                            <input name="SheZhiBuWei" type="checkbox" value="墙面  " class="cfCheckBox" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_checkbox" cf_modelitemid="SheZhiBuWei" cf_modelitemname="设置部位" checked="checked">墙面
                            <input name="SheZhiBuWei" type="checkbox" value="屋顶" class="cfCheckBox" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_checkbox" cf_modelitemid="SheZhiBuWei" cf_modelitemname="设置部位">屋顶
                            <input name="SheZhiBuWei" type="checkbox" value="地面  " class="cfCheckBox" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_checkbox" cf_modelitemid="SheZhiBuWei" cf_modelitemname="设置部位">地面
                            <input name="SheZhiBuWei" type="checkbox" value=" 其它" class="cfCheckBox" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_checkbox" cf_modelitemid="SheZhiBuWei" cf_modelitemname="设置部位"> 其它
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label item">设置数量：</label>
                        <div class="col-xs-8 col-sm-10 col-md-11 col-lg-11">
                            <input id="SheZhiShuLiang" name="SheZhiShuLiang" type="text" value="一块" class="form-control" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_text" cf_modelitemid="SheZhiShuLiang" cf_modelitemname="设置数量">

                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label item">规格及材料：</label>
                        <div class="col-xs-8 col-sm-10 col-md-11 col-lg-11">
                            <div class="input-group">
                                <div class="input-group-addon">宽</div>
                                <input id="GuiGeJiCaiLiaoKuanLiMi" name="GuiGeJiCaiLiaoKuanLiMi" type="text" value="" class="form-control CustomWidth"  cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_text" cf_modelitemid="GuiGeJiCaiLiaoKuanLiMi" cf_modelitemname="规格及材料宽厘米">
                                <div class="input-group-addon">厘米</div>
                            </div>
                            <div class="input-group">
                                <div class="input-group-addon">高</div>
                                <input id="GuiGeJiCaiLiaoGaoLiMi" name="GuiGeJiCaiLiaoGaoLiMi" type="text" value="" class="form-control CustomWidth" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_text" cf_modelitemid="GuiGeJiCaiLiaoGaoLiMi" cf_modelitemname="规格及材料高厘米">
                                <div class="input-group-addon">厘米</div>
                            </div>
                            <div class="input-group">
                                <div class="input-group-addon">厚</div>
                                <input id="GuiGeJiCaiLiaoHouLiMi" name="GuiGeJiCaiLiaoHouLiMi" type="text" value="" class="form-control CustomWidth" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_text" cf_modelitemid="GuiGeJiCaiLiaoHouLiMi" cf_modelitemname="规格及材料厚厘米">
                                <div class="input-group-addon">厘米</div>
                            </div>
                            <textarea id="GuiGeJiCaiLiao" name="GuiGeJiCaiLiao" value="" class="form-control" cf_fieldlength="500" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_textarea" cf_modelitemid="GuiGeJiCaiLiao" cf_modelitemname="规格及材料" minheight="80" maxheight="200"></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label item">申请设置期限：</label>
                        <div class="col-xs-8 col-sm-10 col-md-11 col-lg-11" style="padding:0;">
                            <span style="font-size: 12px;">自</span>
                            <input type="text" class="span2" value="" id="dpd1" name="ShenQingSheZhiQiXianQiShi"><span style="font-size: 12px;">至</span><input type="text" class="span2" value="" id="dpd2" name="ShenQingSheZhiQiXianJieShu">

                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label item">立面面积：</label>
                        <div class="col-xs-8 col-sm-10 col-md-11 col-lg-11">
                            <div class="input-group">
                                <input id="LiMianMianJiPingFangMi" name="LiMianMianJiPingFangMi" type="text" value="" class="form-control" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_text" cf_modelitemid="LiMianMianJiPingFangMi" cf_modelitemname="立面面积平方米">
                                <div class="input-group-addon">平方米</div>
                            </div>

                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label item">证号：</label>
                        <div class="col-xs-8 col-sm-10 col-md-11 col-lg-11">
                            <input id="ZhengHao" name="ZhengHao" type="text" value="" class="form-control" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_text" cf_modelitemid="ZhengHao" cf_modelitemname="证号">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label item">文书号：</label>
                        <div class="col-xs-8 col-sm-10 col-md-11 col-lg-11">
                            <input id="WenShuHao" name="WenShuHao" type="text" value="" class="form-control" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_text" cf_modelitemid="WenShuHao" cf_modelitemname="文书号">

                        </div>
                    </div>
                </div>

                <%@include file="/WEB-INF/jsp/item/common/serviceListEdit.jsp" %>

        </form>
            <div class="form-group">
            <button id="btnSave" type="button" onclick="submit()" class="btn btn-primary">编辑</button>
            </div>
            <%@include file="/WEB-INF/jsp/item/common/editFormMetailDisplay.jsp" %>
        </div>
    </div>
</div>
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
        checkout.hide();
    }).data('datepicker');
</script>
<%@include file="/WEB-INF/jsp/item/common/editsubmit.jsp"%>
</body>
</html>