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
<title>修改选项</title>
<style>
.f-tip {
	color: #2679b5;
	margin-left: 20px;
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
			<li><span id="oc_score_type"></span><span>打分配置</span><span class="divider"><i class="icon-angle-right"></i></span></li>
			<li><span>修改选项</span><span class="divider"></span></li>
		</ul>
	</div>

<!--#breadcrumbs-->
	<div id="page-content" class="clearfix">
		<div class="page-header position-relative crumbs-nav">
			<h1><i class="icon-plus"></i><span>修改 </span>&nbsp;&nbsp;<span id="series_name"></span>-[<span id="oc_type"></span>]<span id="oc_name"></span></h1>
<!-- 			<div class="form-add-new">
                <button class="btn btn-info" type="reset">保存 ✔</button>
         	</div> -->
		</div>
		<div class="row-fluid">
				<div class="row-fluid">
					<div class="span12">
						<div class="form-inline form-inline-detail bord1dd form-add1 mar-t-15">
							<div class="from-group mar-t-15">
								<label><span style="color:red;">*</span>选项内容</label>
								<input type="text" class="" id="ov_name" placeholder="">
							</div>
							<div class="from-group mar-t-15">
								<label><span style="color:red;">*</span>选项分值</label>
								<input type="text" class="form-control" id="ov_value" placeholder="">
							</div>
							<div class="from-group mar-t-15">
								<label><span style="color:red;">*</span>选项顺序</label>
								<input type="text" class="form-control" id="ov_sort" placeholder="">
								<span class="f-tip">建议以10为单位递增</span>
							</div>
							<div class="from-group">
								<button class="user-add-save" id="update" type="reset">保存</button>
							</div>
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
	var oc_name = getURLparamEncoder("oc_name");//分项名称
	var oc_type = getURLparam("oc_type");//分项类型
	var ov_id = getURLparam("ov_id");//选项id
	$("#series_name").text(series_name);
	$("#oc_name").text(oc_name);
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
	$("#oc_type").text(name);
	if(oc_score_type==1){
		$("#oc_score_type").text("责任分");
	}
	if(oc_score_type==2){
		$("#oc_score_type").text("病种分");
	}	
	getOneOptionCatg();
	/*获取单个选项*/
	function getOneOptionCatg() {
		var xco = new XCO();
		xco.setIntegerValue("ov_id", ov_id);
		var options = {
			url : "/grade/getOneOptionValue.xco",
			data : xco,
			success :function(data){
				if(data.getCode()==0){
					var obj=data.getData().getXCOListValue("list");
					obj = obj[0];
					$("#ov_name").val(obj.get("ov_name"));
					var ov_value = parseInt(obj.get("ov_value"));
					ov_value = ov_value/10000;	
					$("#ov_value").val(ov_value);
					$("#ov_sort").val(obj.get("ov_sort"));
				}else{
					axError(data.getMessage());
				}			
			}
		};
		$.doXcoRequest(options);
	}	
	
	
	$("#update").click(function(){
		var xco = new XCO();
		var ov_name=$("#ov_name").val();
		if(ov_name){
			xco.setStringValue("ov_name",ov_name);
		}else{
			axError("请输入选项内容");
			return;
		}
		var ov_value=$("#ov_value").val();
		if(isNaN(ov_value)){
			axError("选项分请输入数字");
			document.getElementById("ov_value").focus();
			return;
		}			
		if(ov_value){
			ov_value = parseInt(ov_value);
			ov_value = ov_value * 10000;		
			xco.setIntegerValue("ov_value",ov_value);
		}else{
			axError("请输入选项分");
			return;
		}		
		var ov_sort=$("#ov_sort").val();
		if(isNaN(ov_sort)){
			axError("选项顺序请输入数字");
			document.getElementById("ov_sort").focus();
			return;
		}
		if(ov_sort){
			xco.setIntegerValue("ov_sort",ov_sort);
		}else{
			axError("请输入选项顺序");
			return;
		}
		if(oc_score_type ==1){
			xco.setStringValue("sys_op_log","编辑责任分选项-："+ov_name);
		}else{
			xco.setStringValue("sys_op_log","编辑病种分选项-："+ov_name);
		}		
		xco.setIntegerValue("ov_id", ov_id);
		var options = {
			url : "/grade/updateGOptionValue.xco",
			data : xco,
			success : function(data){
				if(data.getCode()!=0){
					axError(data.getMessage());
				}else{
					axSuccess("修改成功！",function(){
						location.href="../grade/optionList.jsp?series_no="+series_no+"&series_name="+series_name+"&oc_score_type="+oc_score_type;
					});
				}
			}
		};
		axConfirm("确定修改选项吗?",function(){
			$.doXcoRequest(options);
			layer.close(layer.index);
		})
	})
</script>
