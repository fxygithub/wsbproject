<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<c:forEach var="metail" items="${banjianInof.metail}"><%--数组中有数组  材料信息显示--%>
    <c:forEach items="${metail}" var="file">
        <label class="col-xs-6 col-sm-6 col-md-6 col-lg-6">${file.name}</label>
        <div class="form-group">
           <%-- <label class="col-xs-6 col-sm-6 col-md-6 col-lg-6">${file.name}</label>--%>
            <div class="col-xs-3 col-md-3 col-lg-3" style="padding-left:0;">
                <a class="fancybox" style="position: relative;" href="${pageContext.request.contextPath}/item/lookMetail.html?docPath=${file.docPath}&fileName=${file.fileName}" data-fancybox-group="gallery" title="">
                    <img src="${pageContext.request.contextPath}/images/chakan.gif" alt="" />
                    <span class="chakan" style="position: absolute;top: 0;color: #fff;left: 25%;letter-spacing: 3px;">查看</span>
                </a>
            </div>
        </div>
    </c:forEach>
</c:forEach>
