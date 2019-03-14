<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String a = request.getParameter("oc_score_type");
	String pageName = "责任分打分配置";
	if("2".equals(a)){
		pageName = "病种分打分配置";
	}
%>
<%@ include file="../common/menu_and_navbar_ung.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<base href="<%=basePath%>">
<meta charset="utf-8" />
<title>配置详情</title>
<style>
.t-title {
	display:box;
	display:-webkit-box;
	display:-webkit-flex;
	display:-moz-box;
	display:-ms-flexbox;
	display:flex; 
	margin: 15px 0 10px 0;
	font-weight: bold;
	font-size: 16px;
}
.t-title li {
	-prefix-box-flex: 1; 
	-webkit-box-flex: 1; 
	-webkit-flex: 1; 
	-moz-box-flex: 1; 
	-ms-flex: 1; 
	flex: 1;
	list-style: none;
	margin: 0;
}
.t-title li:last-of-type {
	text-align: right;
	font-weight: normal;
}
.t-title li:last-of-type a {
	font-size: 14px;
	color: red;
	margin-left: 6px;
}
.t-title span {
	font-weight: normal;
}
.table {
	margin-top: 0;
}
.table td {
	width: 25%;
}
</style>
</head>
<body>
	<div id="main-content" class="clearfix">

		<div id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="icon-signal"></i><span class="divider"></span><span>打分管理</span>
					<span class="divider"><i class="icon-angle-right"></i> </span>
				</li>
				<li><span id="oc_score_type"></span><span>打分配置</span><span class="divider"><i class="icon-angle-right"></i></span>
				</li>
				<li><span>配置详情</span><span class="divider"></span>
				</li>
			</ul>
		</div>


		<!--#breadcrumbs-->
		<div id="page-content" class="clearfix">
			<div class="page-header position-relative crumbs-nav">
				<h1><i class="icon-th-list"></i><span id="series_name"></span></h1>
				<div class="form-add-new">
	                <button class="btn btn-success" onclick="addOptionCatg()" type="reset">+新增</button>
           		</div>
			</div>

			<div class="row-fluid">

				<div class="row-fluid">
					<div class="row-fluid">
						<div class="span12" id="listgroup">
						
			<!-- 							
							<ul class="t-title">
								<li>[@{getOcType}]#{oc_name}</li>
								<li>选择类型：<span>@{getContentType}</span></li>
								<li>分项顺序：<span>#{oc_sort}</span></li>
								<li>
									<a	onclick="updateOptionCatg(#{oc_id})">编辑</a>
									<a	onclick="deleteGOptionCatg(#{oc_id},'#{oc_name}')">删除</a>
									<a  onclick="addOptionValue(#{oc_id},'#{oc_name}','#{oc_type}')">添加子项</a>
								</li>
							</ul>
							<table class="table table-striped table-bordered table-hover">
								<thead id="th_#{oc_id}">
									<tr>
										<th>选择项目</th>
										<th>对应分数</th>
										<th>选项顺序</th>
										<th>操作</th>
									</tr>
								</thead>
								<tbody id="tb_#{oc_id}">
									@{getOptionValue}
								</tbody>
							</table> -->
							
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
<script type="text/javascript">
	var series_no = getURLparam("series_no");//二级分类
	var series_name = getURLparamEncoder("series_name");//二级分类名称
	var oc_score_type = getURLparam("oc_score_type");//打分类型[1:责任, 2:病种]
	$("#series_name").text(series_name);
	if(oc_score_type==1){
		$("#oc_score_type").text("责任分");
	}
	if(oc_score_type==2){
		$("#oc_score_type").text("病种分");
	}	
	
	var oc_arr = [];//没有选项的分项
    XCOTemplate.pretreatment('listgroup');
    
	getOptionList();
	
	/*获取责任（疾病）分类列表*/
	function getOptionList() {
		var xco = new XCO();
		xco.setIntegerValue("sub_type_id", series_no);//二级分类ID
		xco.setIntegerValue("oc_score_type", oc_score_type);//打分类型[1:责任, 2:病种]
		var options = {
			url : "/grade/getOptionList.xco",
			data : xco,
			success :getOptionListCallBack
		};
		$.doXcoRequest(options);
	}

	/*获取责任（疾病）分类列表回调*/
	function getOptionListCallBack(data) {
		if (data.getCode() != 0) {
			axError(data.getMessage());
			return;
		} 
		data = data.getData();
		var list1 = data.getXCOListValue("list1");
		if(list1 == null || list1.length ==0){
			return;
		}
		var list2 = data.getXCOListValue("list2");
		var html = "";
		var extendedFunction = {
			getOcType: function(xco){
				var oc_type = xco.get("oc_type");
				var name = "";
				if(oc_type==1){
					name = "基本信息";
				}
				if(oc_type==2){
					name = "保险责任";
				}
				if(oc_type==3){
					name = "免除责任";
				}
				if(oc_type==4){
					name = "创新点";
				}
				if(oc_type==11){
					name = "重疾（癌症）";
				}
				if(oc_type==12){
					name = "轻症";
				}
				if(oc_type==13){
					name = "病种创新";
				}				
				return name;						
			},
			getRatio: function(xco){
				var oc_ratio = xco.get("oc_ratio");
				oc_ratio = parseInt(oc_ratio)/100;
				return oc_ratio;						
			},	
			getContentType: function(xco){
				var oc_content_type = xco.get("oc_content_type");
				var name = "";
				if(oc_content_type==1){
					name = "列表";
				}
				if(oc_content_type==2){
					name = "单选";
				}
				if(oc_content_type==3){
					name = "复选";
				}
				return name;						
			},					
			getOptionValue: function(xco){
				var str = "";
				var noValue = true;
				var oc_id = xco.get("oc_id");
				var oc_name = xco.get("oc_name");
				var oc_type = xco.get("oc_type");
				if(list2!=null && list2.length !=0){
					for(var i = 0; i <list2.length;i++){
						var oc_id_2 = list2[i].get("oc_id");
						if(oc_id == oc_id_2){
							noValue = false;
							var ov_id = list2[i].get("ov_id");
							var ov_name = list2[i].get("ov_name");
							var ov_value = list2[i].get("ov_value");
							ov_value = parseInt(ov_value);
							ov_value = ov_value/10000;								
							var ov_sort = list2[i].get("ov_sort"); 
							var name = "'"+ov_name+"'";
							var updateOptionValue = "updateOptionValue("+ov_id+",'"+oc_name+"','"+oc_type+"')";	
							var deleteGOptionValue = "deleteGOptionValue("+ov_id+",'"+ov_name+"')";		
							str+="<tr>";
							str+=	"<td>"+ov_name+"</td>";
							str+=	"<td>"+ov_value+"</td>";
							str+=	"<td>"+ov_sort+"</td>";
							str+=	"<td>";
							str+=		"<a onclick="+updateOptionValue+">编辑</a>&nbsp;&nbsp;";
							str+=		"<a onclick="+deleteGOptionValue+">删除</a>";
							str+=	"</td>";
						}
					}
				}
				if(noValue){
					oc_arr.push(oc_id);
				}				
				return str;
			},
		};
		for (var i = 0; i < list1.length; i++) {
			html += XCOTemplate.execute('listgroup', list1[i], extendedFunction);
		}
		document.getElementById('listgroup').innerHTML = html;
		for(var i = 0;i< oc_arr.length; i++){//将没有选择项的分项th和tb置为不可见
			$("#th_"+oc_arr[i]).css("display","none");
			$("#tb_"+oc_arr[i]).css("display","none");		
		}
	}
	
	/*新增分项*/
	function addOptionCatg() {
    	var param = "";
    	param +="?series_no="+series_no;
    	param +="&series_name="+series_name;
	    param +="&oc_score_type="+oc_score_type;
		var url ="grade/addOptionCatg.jsp";
		window.location.href=url+param; 	
	}
	/*修改分项*/
	function updateOptionCatg(oc_id) {
    	var param = "";
    	param +="?series_no="+series_no;
    	param +="&series_name="+series_name;
	    param +="&oc_score_type="+oc_score_type;
	    param +="&oc_id="+oc_id;
		var url ="grade/updateOptionCatg.jsp";
		window.location.href=url+param; 	
	}
	/*删除分项*/
	function deleteGOptionCatg(oc_id,oc_name) {
		var xco = new XCO();
		xco.setIntegerValue("oc_id", oc_id);
		if(oc_score_type ==1){
			xco.setStringValue("sys_op_log","删除责任分分项-："+oc_name);
		}else{
			xco.setStringValue("sys_op_log","删除病种分分项-："+oc_name);
		}		
		var options = {
			url : "/grade/deleteGOptionCatg.xco",
			data : xco,
			success : function(data){
				if(data.getCode()!=0){
					axError(data.getMessage());
				}else{
					axSuccess("删除成功！",function(){
						location.href="../grade/optionList.jsp?series_no="+series_no+"&series_name="+series_name+"&oc_score_type="+oc_score_type;
					});
				}
			}
		};
		axConfirm("如果删除该分项后，同时会删除之前相关的打分记录，您确定要删除吗？",function(){
			$.doXcoRequest(options);
			layer.close(layer.index);
		})	
	}	
	/*新增选项*/
	function addOptionValue(oc_id,oc_name,oc_type) {
    	var param = "";
    	param +="?oc_id="+oc_id;
    	param +="&series_no="+series_no;
    	param +="&series_name="+series_name;
	    param +="&oc_score_type="+oc_score_type;
	    param +="&oc_name="+oc_name; 
    	param +="&oc_type="+oc_type;
		var url ="grade/addOptionValue.jsp";
		window.location.href=url+param;   	
	}
	
	/*修改选项*/
	function updateOptionValue(ov_id,oc_name,oc_type) {
    	var param = "";
    	param +="?ov_id="+ov_id;
    	param +="&series_no="+series_no;
    	param +="&series_name="+series_name;
	    param +="&oc_score_type="+oc_score_type;
	    param +="&oc_name="+oc_name; 
    	param +="&oc_type="+oc_type;
		var url ="grade/updateOptionValue.jsp";
		window.location.href=url+param;   		
	}	
	/*删除选项*/
	function deleteGOptionValue(ov_id,ov_name) {
		var xco = new XCO();
		if(oc_score_type ==1){
			xco.setStringValue("sys_op_log","删除责任分选项-："+ov_name);
		}else{
			xco.setStringValue("sys_op_log","删除病种分选项-："+ov_name);
		}			
		xco.setIntegerValue("ov_id", ov_id);
		var options = {
			url : "/grade/deleteGOptionValue.xco",
			data : xco,
			success : function(data){
				if(data.getCode()!=0){
					axError(data.getMessage());
				}else{
					axSuccess("删除成功！",function(){
						location.href="../grade/optionList.jsp?series_no="+series_no+"&series_name="+series_name+"&oc_score_type="+oc_score_type;
					});
				}
			}
		};
		axConfirm("如果删除该选择项后，同时会删除之前相关的打分记录，您确定要删除吗？",function(){
			$.doXcoRequest(options);
			layer.close(layer.index);
		})	
	}	
		
	
</script>