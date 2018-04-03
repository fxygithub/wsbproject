<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@include file="/WEB-INF/jsp/item/common/common.jsp" %>
    <title>《食品经营许可证》首次发放</title>
    <meta charset="UTF-8">
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
            <div class="sx_title"><h3>《食品经营许可证》首次发放</h3></div>
            <form class="form-horizontal" name="市受理表单" method="post" onsubmit="return false"
                  action="${pageContext.request.contextPath}/item/saveItem.html"
                  cf_elementtype="form" cf_themeid="cool" cf_iscreatetable="1"
                  id="ShiShouLiBiaoDan" cf_appcode="INSPUR-DZZW-YSL" cf_iscreateid="1"
                  cf_modelid="ShiShouLiBiaoDan" cf_modelname="市受理表单" cf_fieldcounter="13">

            <div class="form-group">
                <label class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label item">事项名称：</label>
                <div class="col-xs-8 col-sm-10 col-md-11 col-lg-11">
                    <input id="ShiXiangMingChen" name="ShiXiangMingChen" value="${doc.name}" class="form-control" placeholder="事项名称" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_text" cf_modelitemid="ShiXiangMingChen" cf_modelitemname="事项名称" type="text">
                </div>
            </div>

            <div class="form-group">
                <label class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label item">申请事项内容：</label>
                <div class="col-xs-8 col-sm-10 col-md-11 col-lg-11">
                    <input id="ShenQingShiXiangNaRong" name="ShenQingShiXiangNaRong" value="" class="form-control" placeholder="申请事项内容" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_text" cf_modelitemid="ShenQingShiXiangNaRong" cf_modelitemname="申请事项内容" type="text">

                </div>
            </div>
            <div class="form-group">
               <label class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label item">个人/单位名称：</label>
               <div class="col-xs-8 col-sm-10 col-md-11 col-lg-11">
                   <input id="GeRenDanWeiMingChen" name="GeRenDanWeiMingChen" value="${company.enterpriseName}" class="form-control" placeholder="个人/单位名称" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_text" cf_modelitemid="GeRenDanWeiMingChen" cf_modelitemname="个人/单位名称" type="text">

               </div>
            </div>
            <div class="form-group">
                <label class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label item">经办人：</label>
                <div class="col-xs-8 col-sm-10 col-md-11 col-lg-11">
                    <input id="JingBanRen" name="JingBanRen" value="${userVertifyInfo.name}" class="form-control" placeholder="经办人" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_text" cf_modelitemid="JingBanRen" cf_modelitemname="经办人" type="text">

                </div>
            </div>
            <div class="form-group">
               <label class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label item">经办人联系电话：</label>
               <div class="col-xs-8 col-sm-10 col-md-11 col-lg-11">
                   <input id="JingBanRenLianXiDianHua" name="JingBanRenLianXiDianHua" value="${userVertifyInfo.tel}"class="form-control jbrdh" placeholder="经办人联系电话" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_text" cf_modelitemid="JingBanRenLianXiDianHua" cf_modelitemname="经办人联系电话 " type="text">

               </div>
            </div>
                <div class="form-group">
                    <label class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label item">法定代表人：</label>
                    <div class="col-xs-8 col-sm-10 col-md-11 col-lg-11">
                        <input id="FaDingDaiBiaoRen" name="FaDingDaiBiaoRen" value="${company.legalPersonName}" class="form-control" placeholder="法定代表人" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_text" cf_modelitemid="FaDingDaiBiaoRen" cf_modelitemname="法定代表人" type="text">

                    </div>
                </div>
                <div class="form-group">
                    <label class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label item">法人联系电话：</label>
                    <div class="col-xs-8 col-sm-10 col-md-11 col-lg-11">
                        <input id="FaRenLianXiDianHua" name="FaRenLianXiDianHua" value="${company.legalPersonPhone}" class="form-control frlxdh" placeholder="法人联系电话" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_text" cf_modelitemid="FaRenLianXiDianHua" cf_modelitemname="法人联系电话" type="text">

                    </div>
                </div>
                <div class="form-group">
                    <label class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label item">联系地址：</label>
                    <div class="col-xs-8 col-sm-10 col-md-11 col-lg-11">
                        <input id="LianXiDiZhi" name="LianXiDiZhi" value="" class="form-control" placeholder="联系地址"  cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_text" cf_modelitemid="LianXiDiZhi" cf_modelitemname="联系地址" type="text">

                    </div>
                </div>
                <div class="form-group">
                    <label class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label item">注册地址：</label>
                    <div class="col-xs-8 col-sm-10 col-md-11 col-lg-11">
                        <input id="ZhuCeDiZhi" name="ZhuCeDiZhi" value="${company.enterpriserAddress}" class="form-control" placeholder="注册地址" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_text" cf_modelitemid="ZhuCeDiZhi" cf_modelitemname="注册地址" type="text">

                    </div>
                </div>
                <div class="form-group">
                    <label class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label item">仓库地址：</label>
                    <div class="col-xs-8 col-sm-10 col-md-11 col-lg-11">
                        <input id="CangKuDiZhi" name="CangKuDiZhi" value="" class="form-control" placeholder="仓库地址" cf_fieldlength="100" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_text" cf_modelitemid="CangKuDiZhi" cf_modelitemname="仓库地址" type="text">

                    </div>
                </div>
                <div class="form-group">
                    <label class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label item">许可内容：</label>
                    <div class="col-xs-8 col-sm-10 col-md-11 col-lg-11">
                        <textarea id="XuKeNaRong" name="XuKeNaRong" value="" class="form-control"  cf_fieldlength="500" cf_elementtype="field" cf_iscreateid="1" cf_widgetid="cf_textarea" cf_modelitemid="XuKeNaRong" cf_modelitemname="许可内容" minheight="80" maxheight="200"></textarea>

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
<%@include file="/WEB-INF/jsp/item/common/submit.jsp"%>
</body>
</html>