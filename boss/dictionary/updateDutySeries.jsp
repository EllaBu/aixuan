<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String pageName = "映射维护";
%>
<%@ include file="../common/menu_and_navbar.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<base href="<%=basePath%>">
<meta charset="utf-8" />
<title>绑定映射</title>
</head>
<body>
	<div id="main-content" class="clearfix">

		<div id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="icon-bar-chart"></i> <a href="#">数据字典</a><span
					class="divider"><i class="icon-angle-right"></i> </span></li>
				<li><a href="../dictionary/dutySeriesList.jsp">映射维护</a><span class="divider"><i
						class="icon-angle-right"></i>
				</span>
				</li>
				<li><a>绑定映射</a><span class="divider"></span>
				</li>
			</ul>
		</div>


		<!--#breadcrumbs-->
		<div id="page-content" class="clearfix">
			<div class="page-header position-relative crumbs-nav">
				<h1>绑定映射</h1>
			</div>

			<div class="row-fluid">
				<div class="row-fluid mar-t-15">
					<div class="span12">
						<div class="form-inline bord1dd form-add1 mar-t-15">
							<div class="from-group mar-t-15">
								<label style="width: 15%;">产品类型</label>
								<span id="seriesName"></span>
							</div>
							<div class="from-group mar-t-15" style="position: relative;">
								<label style="display: inline-block;width: 15%;position: absolute;top: 0px;">一级责任项</label>
								<div id="listgroup" style="display: inline-block;width: 83%;margin-left: 15%;padding-left:22px;">
									<!-- 
										<label class="pos-rel" style="text-align: left;width: auto;">
											<input type="checkbox" class="ace" name="oneLevelDuty" value="#{list[i].duty_id}" />
											<span class="lbl">#{list[i].duty_name}</span>
										</label>
									 -->
								</div>
							</div>
							<div class="from-group mar-t-15">
								<label></label>
								<button class="btn btn-success mar-r-15" type="submit" id="bindDutySeries">绑定</button>
								<button class="btn mar-l-15 btn-info" type="submit" id="exit">返回</button>
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
	var seriesNo = getURLparamEncoder("seriesNo");//二级分类ID
	var seriesName = getURLparamEncoder("seriesName");//二级分类别名
	
	$("#seriesName").text(seriesName);
	
	getOneLevelDutyList();
	
	/* 获取一级责任项列表，渲染多选框 */
	function getOneLevelDutyList(){
		var xco = new XCO();
		
		var options = {
			url : "/dic/oneLevelDutyList.xco",
			data : xco,
			success : getOneLevelDutyListCallBack
		};
		$.doXcoRequest(options);
	}
	
	/* 获取一级责任项列表，渲染多选框 */
	function getOneLevelDutyListCallBack(data){
		if(data.getCode()!=0){
			axError(data.getMessage());
		}else{
			data = data.getData();
			var len = 0;
			var list = data.getXCOListValue("list");
		
			var html = "";
			if (list) {
				len = list.length;
			}
			
			for (var i = 0; i < len; i++) {
				data.setIntegerValue("i", i);
				html += XCOTemplate.execute('listgroup', data, null);
			}
			document.getElementById('listgroup').innerHTML = html;
			getTwoLvDutySeriesList();
		}
	}

	/* 获取二级分类下已绑定的一级责任项 */
	function getTwoLvDutySeriesList(){
		var xco = new XCO();
		xco.setLongValue("twoLevelSeriesId",seriesNo);
		
		var options = {
			url : "/dic/getTwoLvDutySeriesList.xco",
			data : xco,
			success : getTwoLvDutySeriesListCallBack
		};
		$.doXcoRequest(options);
	}
	
	/* 获取二级分类下已绑定的一级责任项成功回调 */
	function getTwoLvDutySeriesListCallBack(data){
		if(data.getCode()!=0){
			axError(data.getMessage());
		}else{
			data = data.getData();
			var list = data.getXCOListValue("list");
			var len = 0;
			len = list.length;
			if(len!=0){
				for ( var i = 0; i<len; i++) {
					var dutyId = list[i].getLongValue("duty_id");
					$("input[name='oneLevelDuty'][value='"+dutyId+"']").attr('checked','true');
				}
			}
		}
	}
	
	//绑定按钮点击事件监听
	$("#bindDutySeries").click(function(){
		var oneLevelDutyIdArray = [];//被选中的一级责任项ID数组
		
		$("input[name='oneLevelDuty']:checked").each(function(index, element) {
            var xco = new XCO();
            xco.setLongValue("oneLevelDutyId",$(this).val());
            oneLevelDutyIdArray.push(xco);
        });
		
		var xco = new XCO();
		
		xco.setStringValue("twoLevelSeriesId",seriesNo);
		
		if(oneLevelDutyIdArray.length==0){
			axError("请选择一级责任项");
			return;
		}else{
			xco.setXCOArrayValue("oneLevelDutyIdArray",oneLevelDutyIdArray);
		}
		
		xco.setStringValue("sys_op_log","绑定映射关系-绑定："+seriesName);
		
		var options = {
			url : "/dic/bindDutySeries.xco",
			data : xco,
			success : function(data){
				if(data.getCode()!=0){
					axError(data.getMessage());
				}else{
					axSuccess("绑定成功！",function(){
						location.href="../dictionary/dutySeriesList.jsp";
					});
				}
			}
		};
		axConfirm("确定绑定映射关系吗?",function(){
			$.doXcoRequest(options);
			layer.close(layer.index);
		})

	});
	/* 返回按钮点击事件监听 */
	$("#exit").click(function(){
		location.href="../dictionary/dutySeriesList.jsp";
	})
	
</script>