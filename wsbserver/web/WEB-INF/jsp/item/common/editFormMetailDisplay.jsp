<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
    <form class="form-horizontal" >
        <div class="form-groupa">
            <c:forEach var="metail" items="${banjianInof.metail}">
            <span class="spanbb" style="background-color: #297555;color: #FFFFFF">上传/修改</span>
            <c:forEach items="${metail}" var="file">
            <div class="form-group" style="margin-top:10px;">
                <label class="col-xs-9 col-sm-9 col-md-9 col-lg-9">${file.name}</label>
                <input type="text" class="nn" value="${file.id}" hidden/>
                <c:if test="${file.flag!='first'}">
                    <div class="col-xs-3 col-md-3 col-lg-3" style="padding-left:0;">
                        <a class="fancybox" style="position: relative;" href="${pageContext.request.contextPath}/item/lookMetail.html?docPath=${file.docPath}&fileName=${file.fileName}" data-fancybox-group="gallery" title="">
                            <img src="${pageContext.request.contextPath}/images/chakan.gif" alt="" />
                            <span class="chakan" style="position: absolute;top: 0;color: #fff;left: 25%;letter-spacing: 3px;">查看</span>
                        </a>
                    </div>
                </c:if>
            </div>
            </c:forEach>
            </c:forEach>
    </form>
</div>







