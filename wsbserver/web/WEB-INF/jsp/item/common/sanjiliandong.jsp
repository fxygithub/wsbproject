<%@ page import="net.sf.json.JSONObject" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" pageEncoding="utf-8"%>
<html>
<head>
    <title>三级联动js</title>
<body>
<%
    List<JSONObject> ss= (List)request.getAttribute("json");
%>
<script>
    var cc = <%=ss%>;
    var aa = [  {
        "name":"全部","city":[
        ]
    }];
    var city = aa.concat(cc);//连接两个或多个数组
    console.log(city);
    var sheng = document.getElementById("loc_province");
    var shi = document.getElementById("loc_city");
    var qu = document.getElementById("loc_town");

    var area = document.getElementById("city_5");//包含三级联动的div

    area.appendChild(sheng);
    area.appendChild(shi);
    area.appendChild(qu);

    // sheng.options[0] = new Option("全部","全部");
    shi.options[0] = new Option("请选择");
    qu.options[0] = new Option("暂无数据");

    // 循环第一步,把省循环进select
    for (var i = 0; i < city.length; i++) {
        sheng.options[sheng.length] = new Option(city[i].name,city[i].name);/*(显示文本，值)*/
        // 循环第二步,把所有的市都循环进select
        sheng.onchange = function(){
            var pro = city[sheng.selectedIndex].name;
            var cit = "请选择";
            var result = '';
            $('.listsP').empty();
            $('.lists').empty();
            $.ajax({
                type: 'GET',
                url:'${pageContext.request.contextPath}/item/findByGI.html?gsj='+pro+'&item='+cit,
                dataType: 'json',
                success: function(data){
                    var arrLen = data.length;
                    // alert(arrLen);
                    var id=0;
                    if(arrLen > 0){
                        for(var j=0;j<arrLen; j++){
                            id++;
                            var codeJ=data[j].code;
                            var banshiGuide=lookItem(codeJ);
                            result += '<tr>'
                                +'<th width=15% scope="row" >'+id+'</th>'
                                +'<td width=52% class="content_tt">'+data[j].name+'</td>'
                                +'<td width=33% class="bszn">'+'<a href='+banshiGuide
                                +' class="btn btn-primary btn-xs" title='+data[j].title+'>'+'查看'+'</a>'
                                +'<a href='+'${pageContext.request.contextPath}/item/shenbao.html?code='+codeJ
                                +' class="sbsx_linka btn btn-success btn-xs" title='+data[j].title+'>'+'申报'+'</a>'+'</td>'
                                +'</tr>';
                        }
                    }
                    $('.listsP').append(result);
                },
                error: function(xhr, type){
                    alert('查询出错！');
                }
            })
            shi.options.length = 0;
            shi.options[shi.length] = new Option("请选择");
            for (var j = 0; j < city[sheng.selectedIndex].city.length; j++) {
                var cs = city[sheng.selectedIndex].city[j].name;
                var csCode = cs;
                if(csCode!=null){
                    csCode = city[sheng.selectedIndex].city[j].value;
                }
                shi.options[shi.length] = new Option(cs,csCode);
            }

        };
        shi.onchange = function(){
            //alert("市："+city[sheng.selectedIndex].city[shi.selectedIndex-1].value);
            var pro =city[sheng.selectedIndex].name;
            var cit=city[sheng.selectedIndex].city[shi.selectedIndex-1].value;
            // alert("市："+city);
            var result = '';
            $('.listsP').empty();
            $('.lists').empty();
            $.ajax({
                type: 'GET',
                url:'${pageContext.request.contextPath}/item/findByGI.html?gsj='+pro+'&item='+cit,
                dataType: 'json',
                success: function(data){
                    var arrLen = data.length;
                    // alert(arrLen);
                    var id=0;
                    if(arrLen > 0){
                        for(var j=0;j<arrLen; j++){
                            id++;
                            var codeJ=data[j].code;
                            var banshiGuide=lookItem(codeJ);
                            result += '<tr>'
                                +'<th width=15% scope="row" >'+id+'</th>'
                                +'<td width=52% class="content_tt">'+data[j].name+'</td>'
                                +'<td width=33% class="bszn">'+'<a href='+banshiGuide
                                +' class="btn btn-primary btn-xs" title='+data[j].title+'>'+'查看'+'</a>'
                                +'<a href='+'${pageContext.request.contextPath}/item/shenbao.html?code='+codeJ
                                +' class="sbsx_linka btn btn-success btn-xs" title='+data[j].title+'>'+'申报'+'</a>'+'</td>'
                                +'</tr>';
                        }
                    }
                    $('.listsP').append(result);
                },
                error: function(xhr, type){
                    alert('查询出错！');
                }
            })

            qu.options.length = 0;
            qu.options[qu.length] = new Option("请选择");
           /* for (var k = 0; k < city[sheng.selectedIndex-1].city[shi.selectedIndex-1].area.length; k++) {
                qu.options[qu.length] = new Option(city[sheng.selectedIndex-1].city[shi.selectedIndex-1].area[k]);
            }*/
        }
    }
</script>
</body>
</head>
</html>