<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@include file="/WEB-INF/jsp/item/common/common.jsp" %>
    <title>烟草专卖零售许可证-歇业</title>
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
            <div class="sx_title"><h3>烟草专卖零售许可证-歇业</h3></div>
            <form class="form-horizontal" name="市烟草局_烟草专卖零售许可证停业恢复营业补办歇业(综合)" method="post" onsubmit="return false" action="http://199.224.253.9:8081/cform/view?formId=ShiYanCaoJu_TYHFYYBBXYZH" cf_elementtype="form" cf_themeid="default" cf_iscreatetable="1" cf_fieldcounter="24" id="ShiYanCaoJu_TYHFYYBBXYZH" cf_appcode="INSPUR-DZZW-YSL" cf_iscreateid="1" cf_modelid="ShiYanCaoJu_TYHFYYBBXYZH" cf_modelname="市烟草局_烟草专卖零售许可证停业恢复营业补办歇业（综合）">
            <div class="form-group">
                <label class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label item">审批事项：</label>
                <div class="col-xs-8 col-sm-10 col-md-11 col-lg-11">
                    <input id="ShenPiShiXiang" name="ShenPiShiXiang" type="text" value="${banjianInof.data.ShenPiShiXiang}" class="form-control" placeholder="审批事项" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_text" cf_modelitemid="ShenPiShiXiang" cf_modelitemname="审批事项">

                </div>
            </div>
            <div class="form-group">
                <label class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label item">许可证号码：</label>
                <div class="col-xs-8 col-sm-10 col-md-11 col-lg-11">
                    <input id="XuKeZhengHaoMa" name="XuKeZhengHaoMa" value="${banjianInof.data.XuKeZhengHaoMa}" class="form-control" placeholder="申请事项内容" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_text" cf_modelitemid="XuKeZhengHaoMa" cf_modelitemname="许可证号码" type="text">

                </div>
            </div>
            <div class="form-group">
               <label class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label item">负责人(经营者)：</label>
               <div class="col-xs-8 col-sm-10 col-md-11 col-lg-11">
                   <input id="FuZeRenJingYingZhe" name="FuZeRenJingYingZhe" value="${banjianInof.data.FuZeRenJingYingZhe}" class="form-control" placeholder="负责人（经营者）" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_text" cf_modelitemid="FuZeRenJingYingZhe" cf_modelitemname="负责人（经营者）" type="text">

               </div>
            </div>
            <div class="form-group">
                <label class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label item">联系电话：</label>
                <div class="col-xs-8 col-sm-10 col-md-11 col-lg-11">
                    <input id="LianXiDianHua" name="LianXiDianHua" value="${banjianInof.data.LianXiDianHua}" class="form-control frlxdh" placeholder="联系电话" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_text" cf_modelitemid="LianXiDianHua" cf_modelitemname="联系电话" type="text">

                </div>
            </div>
            <div class="form-group">
               <label class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label item">委托代理人：</label>
               <div class="col-xs-8 col-sm-10 col-md-11 col-lg-11">
                   <input id="WeiTuoDaiLiRen" name="WeiTuoDaiLiRen" value="${banjianInof.data.WeiTuoDaiLiRen}" class="form-control" placeholder="委托代理人" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_text" cf_modelitemid="WeiTuoDaiLiRen" cf_modelitemname="委托代理人 " type="text">

               </div>
            </div>
                <div class="form-group">
                    <label class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label item">身份证号码：</label>
                    <div class="col-xs-8 col-sm-10 col-md-11 col-lg-11">
                        <input id="ShenFenZhengHaoMa" name="ShenFenZhengHaoMa" value="${banjianInof.data.ShenFenZhengHaoMa}" class="form-control sfzhm" placeholder="身份证号码" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_text" cf_modelitemid="ShenFenZhengHaoMa" cf_modelitemname="身份证号码" type="text">

                    </div>
                </div>
                <div class="form-group">
                <label class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label item">歇业事由：</label>
                <div class="col-xs-8 col-sm-10 col-md-11 col-lg-11" style="font-size:12px;">
                    事由：
                    <label style="font-weight: normal;">
                        <input  name="XieYeShiYou" type="radio" value="遗失" ${banjianInof.data.XieYeShiYou=='遗失'?'checked':''} class="shiyou cfRadio" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_radio" cf_modelitemid="XieYeShiYou" cf_modelitemname="歇业事由">遗失
                        <span class="CheckBoxs" style="font-size: 12px;">(
                                    <c:choose>
                                        <c:when test="${banjianInof.data.XieYeShiYou!='遗失'}">
                                            <input name="XieYeYiShi" type="checkbox" value="许可证正本" class="cfCheckBox" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_checkbox" cf_modelitemid="XieYeYiShi" cf_modelitemname="歇业遗失">许可证正本
                                            <input id="XieYeYiShi" name="XieYeYiShi" type="checkbox" value="副本" class="cfCheckBox" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_checkbox" cf_modelitemid="XieYeYiShi" cf_modelitemname="歇业遗失">副本
                                        </c:when>

                                        <c:when test="${banjianInof.data.XieYeShiYou=='遗失'&&banjianInof.data.XieYeYiShi.size()==2}">
                                            <input name="XieYeYiShi" type="checkbox" value="许可证正本" class="cfCheckBox" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_checkbox" cf_modelitemid="XieYeYiShi" cf_modelitemname="歇业遗失" checked>许可证正本
                                            <input id="XieYeYiShi" name="XieYeYiShi" type="checkbox" value="副本" class="cfCheckBox" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_checkbox" cf_modelitemid="XieYeYiShi" cf_modelitemname="歇业遗失" checked>副本
                                        </c:when>

                                        <c:when test="${banjianInof.data.XieYeShiYou=='遗失'&&banjianInof.data.XieYeYiShi=='许可证正本'}">
                                            <input name="XieYeYiShi" type="checkbox" value="许可证正本" class="cfCheckBox" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_checkbox" cf_modelitemid="XieYeYiShi" cf_modelitemname="歇业遗失" checked>许可证正本
                                            <input id="XieYeYiShi" name="XieYeYiShi" type="checkbox" value="副本" class="cfCheckBox" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_checkbox" cf_modelitemid="XieYeYiShi" cf_modelitemname="歇业遗失">副本
                                        </c:when>
                                        <c:when test="${banjianInof.data.XieYeShiYou=='遗失'&&banjianInof.data.XieYeYiShi=='副本'}">
                                            <input name="XieYeYiShi" type="checkbox" value="许可证正本" class="cfCheckBox" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_checkbox" cf_modelitemid="XieYeYiShi" cf_modelitemname="歇业遗失" >许可证正本
                                            <input id="XieYeYiShi" name="XieYeYiShi" type="checkbox" value="副本" class="cfCheckBox" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_checkbox" cf_modelitemid="XieYeYiShi" cf_modelitemname="歇业遗失" checked>副本
                                        </c:when>
                                    </c:choose>
                            <span>)</span>
                        </span>
                    </label>

                    <label style="font-weight: normal;">
                        <input name="XieYeShiYou" type="radio" value="毁损" ${banjianInof.data.XieYeShiYou=='毁损'?'checked':''} class="huisun cfRadio" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_radio" cf_modelitemid="XieYeShiYou" cf_modelitemname="歇业事由" cf_ismirrorfield="true">毁损
                        <span class="CheckBoxs" style="font-size: 12px;">(
                              <c:choose>
                                  <c:when test="${banjianInof.data.XieYeShiYou!='毁损'}">
                                      <input name="XieYeYiShi" type="checkbox" value="许可证正本" class="cfCheckBox" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_checkbox" cf_modelitemid="XieYeYiShi" cf_modelitemname="歇业遗失">许可证正本
                                      <input id="XieYeYiShi" name="XieYeYiShi" type="checkbox" value="副本" class="cfCheckBox" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_checkbox" cf_modelitemid="XieYeYiShi" cf_modelitemname="歇业遗失">副本
                                  </c:when>

                                  <c:when test="${banjianInof.data.XieYeShiYou=='毁损'&&banjianInof.data.XieYeYiShi.size()==2}">
                                      <input name="XieYeYiShi" type="checkbox" value="许可证正本" class="cfCheckBox" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_checkbox" cf_modelitemid="XieYeYiShi" cf_modelitemname="歇业遗失" checked>许可证正本
                                      <input id="XieYeYiShi" name="XieYeYiShi" type="checkbox" value="副本" class="cfCheckBox" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_checkbox" cf_modelitemid="XieYeYiShi" cf_modelitemname="歇业遗失" checked>副本
                                  </c:when>

                                  <c:when test="${banjianInof.data.XieYeShiYou=='毁损'&&banjianInof.data.XieYeYiShi=='许可证正本'}">
                                      <input name="XieYeYiShi" type="checkbox" value="许可证正本" class="cfCheckBox" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_checkbox" cf_modelitemid="XieYeYiShi" cf_modelitemname="歇业遗失" checked>许可证正本
                                      <input id="XieYeYiShi" name="XieYeYiShi" type="checkbox" value="副本" class="cfCheckBox" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_checkbox" cf_modelitemid="XieYeYiShi" cf_modelitemname="歇业遗失">副本
                                  </c:when>
                                  <c:when test="${banjianInof.data.XieYeShiYou=='毁损'&&banjianInof.data.XieYeYiShi=='副本'}">
                                      <input name="XieYeYiShi" type="checkbox" value="许可证正本" class="cfCheckBox" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_checkbox" cf_modelitemid="XieYeYiShi" cf_modelitemname="歇业遗失" >许可证正本
                                      <input id="XieYeYiShi" name="XieYeYiShi" type="checkbox" value="副本" class="cfCheckBox" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_checkbox" cf_modelitemid="XieYeYiShi" cf_modelitemname="歇业遗失" checked>副本
                                  </c:when>
                              </c:choose>
                            <span>)</span>
                            </span>
                    </label>
                    <textarea id="TingYeShiYou" name="TingYeShiYou" value="" class="form-control" cf_fieldlength="500" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_textarea" cf_modelitemid="TingYeShiYou" cf_modelitemname="歇业事由" minheight="80" maxheight="200">${banjianInof.data.TingYeShiYou}</textarea>
                </div>
            </div>

                <%@include file="/WEB-INF/jsp/item/common/serviceListEdit.jsp" %>


                <div class="form-group">
                    <label class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label item">备注：</label>
                    <div class="col-xs-8 col-sm-10 col-md-11 col-lg-11">
                        <textarea id="BeiZhu" name="BeiZhu" value="" class="form-control" cf_fieldlength="500" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_textarea" cf_modelitemid="BeiZhu" cf_modelitemname="备注" minheight="80" maxheight="200">${banjianInof.data.BeiZhu}</textarea>

                    </div>
                </div>
                <%@include file="/WEB-INF/jsp/item/common/displayForm.jsp" %>
        </form>

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
<script>
    $(function(){

    })
    $(function(){
        $('.cfCheckBox').attr("disabled","disabled");
        $(".shiyou").click(function(){
            $('.huisun').next('.CheckBoxs').find('.cfCheckBox').removeAttr("checked");
            $('.huisun').next('.CheckBoxs').find('.cfCheckBox').attr("disabled","disabled");
            $(this).next('.CheckBoxs').find('.cfCheckBox').removeAttr("disabled","disabled");

        });
        $(".huisun").click(function(){
            $('.shiyou').next('.CheckBoxs').find('.cfCheckBox').removeAttr("checked");
            $('.shiyou').next('.CheckBoxs').find('.cfCheckBox').attr("disabled","disabled");
            $(this).next('.CheckBoxs').find('.cfCheckBox').removeAttr("disabled","disabled");
        })
    })
</script>
</html>