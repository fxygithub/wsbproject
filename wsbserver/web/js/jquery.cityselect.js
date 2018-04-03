
var city = [
{
  "name": "三亚市烟草局", "city": [
	{"name": "三亚市烟草局1", "area": []},
	{"name": "三亚市烟草局2", "area": []},
	{"name": "三亚市烟草局3", "area": []},
	{"name": "三亚市烟草局4", "area": []},
	{"name": "三亚市烟草局6", "area": []},
	{"name": "三亚市烟草局7", "area": []}
	]
},
{
  "name": "三亚市执法局", "city": [
	{"name": "三亚市执法局6","value":"1code", "area": []},
	{"name": "三亚市执法局7","value":"2code", "area": []}
	]
},
{
  "name": "三亚市食药监局", "city": [
	{"name": "三亚市食药监局1", "area": []}
	]
}
];
	var sheng = document.getElementById("loc_province");
	var shi = document.getElementById("loc_city");
	var qu = document.getElementById("loc_town");
	var area = document.getElementById("city_5");
	area.appendChild(sheng);
	area.appendChild(shi);
	area.appendChild(qu);
	sheng.options[0] = new Option("全部");
	shi.options[0] = new Option("请选择");
	qu.options[0] = new Option("请选择");

	// 循环第一步,把省循环进select
	for (var i = 0; i < city.length; i++) {
		sheng.options[sheng.length] = new Option(city[i].name);/*(显示文本，值)*/
		// 循环第二步,把所有的市都循环进select
		sheng.onchange = function(){
            var pro = city[sheng.selectedIndex-1].name;
            alert(pro);
			shi.options.length = 0;
			shi.options[shi.length] = new Option("请选择");
			for (var j = 0; j < city[sheng.selectedIndex-1].city.length; j++) {
                var cs = city[sheng.selectedIndex-1].city[j].name;
                var csCode = cs;
                if(csCode!=null){
                    csCode = city[sheng.selectedIndex-1].city[j].value;
                }
				shi.options[shi.length] = new Option(cs,csCode);
			}

		};
		shi.onchange = function(){
			qu.options.length = 0;
			qu.options[qu.length] = new Option("请选择");
			for (var k = 0; k < city[sheng.selectedIndex-1].city[shi.selectedIndex-1].area.length; k++) {
				qu.options[qu.length] = new Option(city[sheng.selectedIndex-1].city[shi.selectedIndex-1].area[k]);	
			}
		}
	}