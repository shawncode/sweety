<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<style>
body {
	background: white;
	color: black;
	padding: 40px;
	margin: 0;
	font-family: Gotham, Helvetica, Arial, sans-serif;
	line-height: 1;
}

h1 {
	font-weight: bold;
	text-transform: uppercase;
	font-size: 20px;
	margin: 0 0 5px 0;
}

h2 {
	font-family: "Lucida Grande", Verdana, sans-serif;
	font-size: 10px;
	color: #777777;
	margin: 0 0 20px 0;
}

h2 b {
	color: #279919;
}

h3 {
	font-size: 18px;
	margin: 10px 0px;
	border-top: 1px solid #CCC;
	padding-top: 10px;
	color: #666;
}

h3 em {
	color: #CCC;
	font-size: 9px;
}

h3 .hapi {
	margin-left: 20px;
}

div.content {
	margin-left: 10px;
}

div.right-content {
	margin-left: 10px;
}

.hidden {
	display: none;
}

.clear {
	clear: both;
}

.api .api_method {
	font-weight: bold;
	color: #804000;
}

.api .api_uri {
	color: #008040;
}

.hapi .api_method {
	color: #804000;
	font-size: 11px;
}

.hapi .api_uri {
	color: #008040;
	font-size: 11px;
}

.module {
	margin: 20px 0px;
	list-style: none;
	color: #6d8fb0;
}

.module a {
	color: #6d8fb0;
}

.module.highlight {
	background: #ffffa5;
}

#modules {
	float: right;
	background: #f3f7fb;
	padding: 0px;
	position: fixed;
	right: 20px;
	top: 6px;
	font-size: 9px;
}

#modules li {
	margin: 10px 20px;
	list-style: none;
	color: #6d8fb0;
}

#apis {
	padding: 0px;
	margin: 0px;
	margin-right: 10px;
}

#apis li {
	list-style: none;
}

p {
	margin: 10px 0px;
}

pre {
	margin: 10px 0px;
	line-height: 1.5em;
	background: #EEEEEE;
	border: 1px solid #E6E6E6;
	color: #333;
	padding: 10px;
	font-size: 12px;
}

pre.ok {
	background: #D9EDF7;
	border-color: #BCE8F1;
}

pre.error {
	background: #F9DFDB;
}

p.api_meta {
	font-size: 10px;
}

p.api_meta input {
	font-size: 10px;
	color: #999;
	width: 120px;
	height: 14px;
	border: 1px solid #EFEFEF;
}

h4 {
	margin: 10px 0px;
	font-size: 14px;
}

table.params {
	margin: 10px 0px;
	padding: 0;
	border-collapse: collapse;
}

table.params th {
	font: bold 16px "Trebuchet MS", Verdana, Arial, Helvetica, sans-serif;
	color: #FFFFFF;
	border-right: 1px solid #C1DAD7;
	border-bottom: 1px solid #C1DAD7;
	border-top: 1px solid #C1DAD7;
	letter-spacing: 2px;
	text-transform: uppercase;
	text-align: center;
	padding: 2px 6px 2px 6px;
	background: #CF5738 no-repeat;
}

table.params td {
	border: 1px solid #ececec;
	background: #fff;
	padding: 4px 6px 4px 6px;
	color: #AAA;
	font-size: 16px;
}

table.params td.select_param {
	cursor: pointer;
}

table.params tr.selected td {
	color: #4f6b72;
}

table.params td input.example_input {
	width: 160px;
}

table.params td .example_value:hover {
	background: #CFEEEA;
	color: #1F3035;
}

.menu {
	position: absolute;
	list-style-type: none;
	margin: 0px;
	padding: 0px;
	border: 1px solid #008000;
}

.menu li {
	list-style-type: none;
	padding: 3px 10px;
	font-size: 12px;
	background: #fff;
	cursor: pointer;
}

.menu li.hover {
	background: #DBE8F3;
}

.api_desc {
	text-align: left;
	display: inline;
	padding-right: 100px;
}

.api_sub_desc_value {
	color: #FE6200;
}

.api_desc_div {
	padding-bottom: 10px;
}

.big_title {
	display: inline;
}

.big_title_h1 {
	width: 80%;
}

.big_title_h4 {
	width: 80%;
}

.main-content {
	display: inline;
	float: left;
}

#content {
	width: 80%;
}

#right-content {
	width: 17%;
	margin-left: 10px;
}
</style>
<script src="./js/jquery-1.4.4.min.js"></script>
<style type="text/css">
</style>
<script src="./js/ajaxfileupload.js"></script>
<script src="./js/jquery.md5.js"></script>
<link href="./css/bootstrap.css" rel="stylesheet">
<link href="./css/bootstrap-responsive.css" rel="stylesheet">
<script>
	function syntaxHighlight(json) {
		if (typeof json != 'string') {
			json = JSON.stringify(json, undefined, 4);
		}
		//json = json.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
		return json
				.replace(
						/("(\\u[a-zA-Z0-9]{4}|\\[^u]|[^\\"])*"(\s*:)?|\b(true|false|null)\b|-?\d+(?:\.\d*)?(?:[eE][+\-]?\d+)?)/g,
						function(match) {
							var cls = 'number';
							if (/^"/.test(match)) {
								if (/:$/.test(match)) {
									//"key"
									cls = 'text-error';
								} else {
									//"string"
									cls = 'text-info';
								}
							} else if (/true|false/.test(match)) {
								cls = 'text-warning';
							} else if (/null/.test(match)) {
								cls = 'text-success';
							}
							return '<span class="' + cls + '">' + match
									+ '</span>';
						});
	}
	$(document).ready(function() {
		var val = $("[id='api_result_71']").text();
		val = jQuery.parseJSON(val);
		//val = JSON.stringify(val,null,4);
		val = syntaxHighlight(val);
		$("[id='api_result_71']").html(val);
		var radioType = $("[id='radioType']").text();
		var radioObject = $("[title='radiobutton']");
		for ( var i = 0; i < radioObject.length; i++) {
			if (radioObject[i].value == radioType) {
				radioObject[i].checked = true;
				break;
			}
		}
	});
</script>
<body>
	<h2>阿里O2O搜索接口</h2>
	<form method="post"
		action="<%=request.getContextPath()%>/o2o.do?method=q">
		<table id="api_params_71" class="params">
			<thead>
				<tr>
					<th>参数</th>
					<th>说明</th>
					<th>值</th>
				</tr>
			</thead>
			<tbody>
				<tr class="">
					<td>q:</td>
					<td>查询串</td>
					<td><input type="text" title="q" id="q" value=${q}></td>
				</tr>
				<tr class="">
					<td>start:</td>
					<td>第几条结果开始</td>
					<td><input type="text" title="start" id="start" value=${start}></td>
				</tr>
				<tr class="">
					<td>limit:</td>
					<td>条目数</td>
					<td><input type="text" title="limit" id="limit" value=${limit}></td>
				</tr>
				<tr class="">
					<td>category:</td>
					<td>类目</td>
					<td><input type="text" title="category" id="category"
						value=${category}></td>
				</tr>
				<tr class="">
					<td>radius:</td>
					<td>搜索区域(默认10KM,最大50KM)</td>
					<td><input type="text" title="radius" id="radius"
						value=${radius}></td>
				</tr>
				<tr class="">
					<td>deal:</td>
					<td>是否有团购</td>
					<td><input type="text" title="deal" id="deal" value=${deal}></td>
				</tr>
				<tr class="">
					<td>city:</td>
					<td>城市</td>
					<td><input type="text" title="city" id="city" value=${city}></td>
				</tr>
				<tr class="">
					<td>loc:</td>
					<td>经纬度</td>
					<td><input type="text" title="loc" id="loc" value=${loc}></td>
				</tr>
				<tr class="">
					<td>coupon:</td>
					<td>是否有优惠券</td>
					<td><input type="text" title="coupon" id="coupon"
						value=${coupon}></td>
				</tr>
				<tr class="">
					<td>reservation:</td>
					<td>是否支持在线预订</td>
					<td><input type="text" title="reservation" id="reservation"
						value=${reservation}></td>
				</tr>
				<tr class="">
					<td>sort:</td>
					<td>排序类型</td>
					<td><input type="text" title="sort" id="sort" value=${sort}></td>
				</tr>
				<tr class="">
					<td>region:</td>
					<td>区域名</td>
					<td><input type="text" title="region" id="region"
						value=${region}></td>
				</tr>
			</tbody>
		</table>
		<p class="api_test">
			<input class="btn btn-success" type="submit" value="Request">
			<input type="radio" title="radiobutton" value="business" checked>
			商户 <input type="radio" title="radiobutton" value="deal"> 团购 <span
				id="radioType" style="visibility: hidden">${radio}</span>
	</form>
	<pre id="api_result_71" class="brush: js;">${searchModel}</pre>
</body>
</html>
