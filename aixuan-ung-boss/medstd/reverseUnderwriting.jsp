<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String pageName = "医学标准项";
%>
<%@ include file="../common/menu_and_navbar.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<meta charset="utf-8" />
<title>反向核保</title>
<style type="text/css">
.label-danger{
	background-color:#D15B47 !important;
}
.color_01{
	color: blue;
}
.color_02{
	color: black;
}
</style>
</head>
<body>
	<div id="main-content" class="clearfix">

		<div id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="icon-bar-chart"></i> <span>反向核保</span><span class="divider"><i class="icon-angle-right"></i> </span></li>
				<li><span>信息录入 </span><span class="divider"></span></li>
			</ul>
		</div>


		<!--#breadcrumbs-->
		<div id="page-content" class="clearfix">
			<div class="page-header position-relative crumbs-nav">
				<h1>反向核保</h1>
			</div>
			<div class="row-fluid">
				<div class="row-fluid mar-t-15">
					<div class="span12">
						<div class="form-inline bord1dd form-add1 mar-t-15">
							
							<div class="from-group mar-t-15">
								<label>保险类型</label>
								<input style="opacity: inherit;width: 0px;position: inherit;" name="series_no" type="checkbox" value="1" />&nbsp;重疾险&nbsp;&nbsp;
								<input style="opacity: inherit;width: 0px;position: inherit;" name="series_no" type="checkbox" value="2" />&nbsp;寿险&nbsp;&nbsp;
								<input style="opacity: inherit;width: 0px;position: inherit;" name="series_no" type="checkbox" value="3" />&nbsp;防癌险
							</div>
							
							<div class="from-group mar-t-15">
								<label>性别</label>
								<input name="sex" type="radio" value="11" checked style="opacity: 1; height: 16px;"/><label style="width: 30px;">男</label>
								<input name="sex" type="radio" value="10" style="opacity: 1; height: 16px;"/><label style="width: 30px;">女</label>
							</div>							
							
							<div class="from-group mar-t-15">
								<label>年龄</label>
								<input type="text" class="form-control" id="age" oninput = "value=value.replace(/[^\d]/g,'')">
							</div>
							
							<div class="from-group mar-t-15">
								<label>BMI</label>
								<input type="text" class="form-control" id="bmi"><span>&nbsp;%</span>
							</div>
							<div class="from-group mar-t-15">
								<label>DBP</label>
								<input type="text" class="form-control" id="dbp"><span>&nbsp;mmHg</span>
							</div>
							<div class="from-group mar-t-15">
								<label>SBP</label>
								<input type="text" class="form-control" id="sbp"><span>&nbsp;mmHg</span>
							</div>
							<div class="from-group mar-t-15">
								<label>CHO</label>
								<input type="text" class="form-control" id="cho"><span>&nbsp;mmol/L</span>
							</div>
							<div class="from-group mar-t-15">
								<label>HDL</label>
								<input type="text" class="form-control" id="hdl"><span>&nbsp;mmol/L</span>
							</div>
							<div class="from-group mar-t-15">
								<label>LEU</label>
								<input name="leu" type="radio" value="" checked style="opacity: 1; height: 16px;"/><label style="width: 50px;">忽略</label>
								<input name="leu" type="radio" value="10" style="opacity: 1; height: 16px;"/><label style="width: 50px;">阴性</label>
								<input name="leu" type="radio" value="20" style="opacity: 1; height: 16px;"/><label style="width: 50px;">阳性</label>
							</div>
							<div class="from-group mar-t-15">
								<label>SGLU</label>
								<input name="sglu" type="radio" value="" checked style="opacity: 1; height: 16px;"/><label style="width: 50px;">忽略</label>
								<input name="sglu" type="radio" value="10" style="opacity: 1; height: 16px;"/><label style="width: 50px;">阴性</label>
								<input name="sglu" type="radio" value="20" style="opacity: 1; height: 16px;"/><label style="width: 50px;">阳性</label>
							</div>
							<div class="from-group mar-t-15">
								<label>BLD</label>
								<input name="bld" type="radio" value="" checked style="opacity: 1; height: 16px;"/><label style="width: 50px;">忽略</label>
								<input name="bld" type="radio" value="10" style="opacity: 1; height: 16px;"/><label style="width: 50px;">阴性</label>
								<input name="bld" type="radio" value="20" style="opacity: 1; height: 16px;"/><label style="width: 50px;">阳性</label>
							</div>
							<div class="from-group mar-t-15">
								<label>状况描述</label>
								<textarea id="text" rows="3" style="width:1000px;"></textarea>
							</div>
									
							<div class="from-group mar-t-15">
								<label></label>
								<button class="btn btn-success mar-r-15" type="submit" id="addLevelOne">提交</button>
							</div>
							<div class="from-group mar-t-15" id="response_div" style="margin-top: 50px;display:none">
								<label>返回结果</label>
								<textarea id="response" rows="8" style="width:1000px;"></textarea>
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
	//添加按钮点击事件监听
	$("#addLevelOne").click(function(){
		var xco = new XCO();
		xco.setStringValue("ch_id", "3");//加默认渠道
		var series_no = queryCheckedValue();
		if(series_no){
			xco.setStringListValue("series_no", series_no);
		}else{
			axError("请至少选择一个保险类型");
			return;
		}
		var age = $("#age").val();
		if(age){
			xco.setStringValue("req_age",age);//年龄
		}else{
			axError("请输入年龄");
			return;
		}
		var sex = $('input:radio[name=sex]:checked').val();
		xco.setStringValue("req_sex",sex);//性别
		
		var values = [];
		var bmi = $("#bmi").val();//bmi
		var xco_bmi = new XCO();
		xco_bmi.setStringValue("code", "bmi");
		xco_bmi.setStringValue("type", "number");
		xco_bmi.setStringValue("value", bmi);
		xco_bmi.setStringValue("required", "true");
		values.push(xco_bmi);
		
		var dbp = $("#dbp").val();//dbp
		var xco_dbp = new XCO();
		xco_dbp.setStringValue("code", "dbp");
		xco_dbp.setStringValue("type", "number");
		xco_dbp.setStringValue("value", dbp);
		xco_dbp.setStringValue("required", "true");
		values.push(xco_dbp);
		
		var sbp = $("#sbp").val();//sbp
		var xco_sbp = new XCO();
		xco_sbp.setStringValue("code", "sbp");
		xco_sbp.setStringValue("type", "number");
		xco_sbp.setStringValue("value", sbp);
		xco_sbp.setStringValue("required", "true");
		values.push(xco_sbp);
		
		var cho = $("#cho").val();//cho
		var xco_cho = new XCO();
		xco_cho.setStringValue("code", "cho");
		xco_cho.setStringValue("type", "number");
		xco_cho.setStringValue("value", cho);
		xco_cho.setStringValue("required", "true");
		values.push(xco_cho);
		
		var hdl = $("#hdl").val();//hdl
		var xco_hdl = new XCO();
		xco_hdl.setStringValue("code", "hdl");
		xco_hdl.setStringValue("type", "number");
		xco_hdl.setStringValue("value", hdl);
		xco_hdl.setStringValue("required", "true");
		values.push(xco_hdl);
		
		var leu = $('input:radio[name=leu]:checked').val();//leu
		var xco_leu = new XCO();
		xco_leu.setStringValue("code", "leu");
		xco_leu.setStringValue("type", "yinyang");
		xco_leu.setStringValue("value", leu);
		xco_leu.setStringValue("required", "false");
		values.push(xco_leu);
		
		var sglu = $('input:radio[name=sglu]:checked').val();//sglu
		var xco_sglu = new XCO();
		xco_sglu.setStringValue("code", "sglu");
		xco_sglu.setStringValue("type", "yinyang");
		xco_sglu.setStringValue("value", sglu);
		xco_sglu.setStringValue("required", "false");
		values.push(xco_sglu);
		
		var bld = $('input:radio[name=bld]:checked').val();//bld
		var xco_bld = new XCO();
		xco_bld.setStringValue("code", "bld");
		xco_bld.setStringValue("type", "yinyang");
		xco_bld.setStringValue("value", bld);
		xco_bld.setStringValue("required", "false");
		values.push(xco_bld);
		
		xco.setXCOListValue("values",values);
		var text = $("#text").val();//text
		xco.setStringValue("text", text);
		var options = {
			url : "/reverseService/reverseCalculate.xco",
			data : xco,
			success : function(data){
				if(data.getCode()!=0){
					axError(data.getMessage());
				}else{
					var dataList=data.getData();
					$("#response").val(dataList);
					$("#response_div").css("display","");
				}
			}
		};
		axConfirm("确定添加评测吗?",function(){
			$("#response_div").css("display","");
			$.doXcoRequest(options);
			layer.close(layer.index);
		});
	});
	//选择保险类型
	function queryCheckedValue() {
		var str = [];
		var isStr = false;
		$("input:checkbox[name='series_no']:checked").each(function(i) {
			var val = $(this).val();
			str.push(val);
			isStr=true;
		});
		if(isStr){
			return str;
		}
		return;
	}
</script>