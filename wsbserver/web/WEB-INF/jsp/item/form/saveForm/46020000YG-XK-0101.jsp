<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@include file="/WEB-INF/jsp/item/common/common.jsp" %>
    <title>烟草专卖零售许可证-新办</title>
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
            <div class="sx_title"><h3>烟草专卖零售许可证-新办</h3></div>
            <form class="form-horizontal" name="市烟草局_烟草专卖零售许可证新办（综合）" method="post" onsubmit="return false" action="http://199.224.253.9:8081/cform/view?formId=ShiYanCaoJu_YanCaoZMLXKZXBZH" cf_elementtype="form" cf_themeid="default" cf_iscreatetable="1" cf_fieldcounter="18" id="ShiYanCaoJu_YanCaoZMLXKZXBZH" cf_appcode="INSPUR-DZZW-YSL" cf_iscreateid="1" cf_modelid="ShiYanCaoJu_YanCaoZMLXKZXBZH" cf_modelname="市烟草局_烟草专卖零售许可证新办（综合）">
            <div class="form-group">
                <label class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label item">审批事项：</label>
                <div class="col-xs-8 col-sm-10 col-md-11 col-lg-11">
                    <input id="ShenPiShiXiang" name="ShenPiShiXiang" value="${doc.name}" class="form-control" placeholder="审批事项" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_text" cf_modelitemid="ShenPiShiXiang" cf_modelitemname="审批事项" type="text">

                </div>
            </div>
            <div class="form-group">
                <label class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label item">工商执照编号：</label>
                <div class="col-xs-8 col-sm-10 col-md-11 col-lg-11">
                    <input id="GongShangZhiZhaoBianHao" name="GongShangZhiZhaoBianHao" type="text" value="" class="form-control" placeholder="工商执照编号" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_text" cf_modelitemid="GongShangZhiZhaoBianHao" cf_modelitemname="工商执照编号">

                </div>
            </div>
            <div class="form-group">
               <label class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label item">企业名称(字号)：</label>
               <div class="col-xs-8 col-sm-10 col-md-11 col-lg-11">
                   <input id="QiYeMingChenZiHao" name="QiYeMingChenZiHao" type="text" value="${company.enterpriseName}" class="form-control" placeholder="企业名称（字号）" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_text" cf_modelitemid="QiYeMingChenZiHao" cf_modelitemname="企业名称（字号）">

               </div>
            </div>
            <div class="form-group">
                <label class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label item">经营地址：</label>
                <div class="col-xs-8 col-sm-10 col-md-11 col-lg-11">
                    <input id="JingYingDiZhi" name="JingYingDiZhi" type="text" value="${company.enterpriserAddress}" class="form-control" placeholder="经营地址" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_text" cf_modelitemid="JingYingDiZhi" cf_modelitemname="经营地址">

                </div>
            </div>
            <div class="form-group">
               <label class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label item">场地权属：</label>
               <div class="col-xs-8 col-sm-10 col-md-11 col-lg-11" style="padding-top:8px;">
                   <input name="ChangDiQuanShu" type="radio" value="自有" class="cfRadio" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_radio" cf_modelitemid="ChangDiQuanShu" cf_modelitemname="场地权属" checked="checked">自有
                   <input name="ChangDiQuanShu" type="radio" value="租赁" class="cfRadio" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_radio" cf_modelitemid="ChangDiQuanShu" cf_modelitemname="场地权属">租赁
                   <input name="ChangDiQuanShu" type="radio" value="无偿使用" class="cfRadio" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_radio" cf_modelitemid="ChangDiQuanShu" cf_modelitemname="场地权属">无偿使用

               </div>
            </div>
                <div class="form-group">
                    <label class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label item">租赁(无偿)期限：</label>
                    <div class="col-xs-8 col-sm-10 col-md-11 col-lg-11">
                        <input id="ZuLinWuChangShiYongQiXian" name="ZuLinWuChangShiYongQiXian" value="" class="form-control" placeholder="租赁(无偿使用)期限" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_text" cf_modelitemid="ZuLinWuChangShiYongQiXian" cf_modelitemname="租赁(无偿使用)期限" type="text">

                    </div>
                </div>
                <div class="form-group">
                    <label class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label item">负责人(经营者)：</label>
                    <div class="col-xs-8 col-sm-10 col-md-11 col-lg-11">
                        <input id="FuZeRenJingYingZhe" name="FuZeRenJingYingZhe" type="text" value="${company.legalPersonName}" class="form-control" placeholder="负责人(经营者)" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_text" cf_modelitemid="FuZeRenJingYingZhe" cf_modelitemname="负责人（经营者）">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label item">身份证号码：</label>
                    <div class="col-xs-8 col-sm-10 col-md-11 col-lg-11">
                        <input id="FuZeRenShenFenZhengHaoMa" name="FuZeRenShenFenZhengHaoMa" type="text" value="${company.legalPersonId}" class="form-control sfzhm" placeholder="负责人身份证号码" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_text" cf_modelitemid="FuZeRenShenFenZhengHaoMa" cf_modelitemname="负责人身份证号码">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label item">身份证住址：</label>
                    <div class="col-xs-8 col-sm-10 col-md-11 col-lg-11">
                        <input id="ShenFenZhengZhuZhi" name="ShenFenZhengZhuZhi" type="text" value="" class="form-control" placeholder="身份证住址" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_text" cf_modelitemid="ShenFenZhengZhuZhi" cf_modelitemname="身份证住址">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label item">现 住 址&nbsp;：</label>
                    <div class="col-xs-8 col-sm-10 col-md-11 col-lg-11">
                        <input id="XianZhuZhi" name="XianZhuZhi" type="text" value="" class="form-control" placeholder="现住址" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_text" cf_modelitemid="XianZhuZhi" cf_modelitemname="现住址">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label item">经营场所面积：</label>
                    <div class="col-xs-8 col-sm-10 col-md-11 col-lg-11">
                        <input id="JingYingChangSuoMianJi" name="JingYingChangSuoMianJi" type="text" value="" class="form-control" placeholder="经营场所面积" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_text" cf_modelitemid="JingYingChangSuoMianJi" cf_modelitemname="经营场所面积">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label item">联系电话：</label>
                    <div class="col-xs-8 col-sm-10 col-md-11 col-lg-11">
                        <input id="LianXiDianHua" name="LianXiDianHua" type="text" value="${company.legalPersonPhone}" class="form-control frlxdh" placeholder="联系电话" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_text" cf_modelitemid="LianXiDianHua" cf_modelitemname="联系电话">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label item">委托代理人：</label>
                    <div class="col-xs-8 col-sm-10 col-md-11 col-lg-11">
                        <input id="WeiTuoDaiLiRen" name="WeiTuoDaiLiRen" type="text" value="${userVertifyInfo.identity}" class="form-control" placeholder="委托代理人" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_text" cf_modelitemid="WeiTuoDaiLiRen" cf_modelitemname="委托代理人">
                    </div>
                </div>

                <%@include file="/WEB-INF/jsp/item/common/serviceListSave.jsp" %>

                <div class="form-group">
                    <label class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label item">备注：</label>
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
<script>
    var nowTemp = new Date();
    var now = new Date(nowTemp.getFullYear(), nowTemp.getMonth(), nowTemp.getDate(), 0, 0, 0, 0);
    var checkin = $('#dpd1').fdatepicker({
        format: 'yyyy-mm-dd',
        onRender: function (date) {
            return date.valueOf() <= now.valueOf() ? '' : '';
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
            return date.valueOf() <= checkin.date.valueOf() ? '' : '';
        }
    }).on('changeDate', function (ev) {
        checkout.hide();
    }).data('datepicker');
</script>
<%@include file="/WEB-INF/jsp/item/common/submit.jsp"%>
</body>
</html>