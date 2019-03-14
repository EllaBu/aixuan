<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String pageName = "";
%>
<%@ include file="../common/menu_and_navbar.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<base href="<%=basePath%>">
<meta charset="utf-8" />
<title>生成文件</title>
</head>
<body>
	<div id="main-content" class="clearfix">

		<div id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="icon-heart"></i><span class="divider"></span><span>生成文件</span>
					<span class="divider"><i class="icon-angle-right"></i> </span>
				</li>
				<li><span>生成文件</span><span class="divider"></span>
				</li>
			</ul>
		</div>


		<!--#breadcrumbs-->
		<div id="page-content" class="clearfix">
			<div class="page-header position-relative crumbs-nav">
				<h1><i class="icon-th-list"></i>生成文件列表</h1>
			</div>

			<div class="row-fluid">
				<div class="row-fluid mar-t-15">
					<div class="span12">
						<div class="form-inline form-inline-list">
 							 <div class="row-fluid" id="resultDiv">
	                            <div class="span4">
	                                <label>开始ID</label> 
									<input type="text" class="form-control mar-t-15 Wdate w150" id="min" >
	                            </div>
	                            <div class="span4">
	                                <label>结束ID</label> 
									<input type="text" class="form-control mar-t-15 Wdate w150" id="max" >
	                            </div>	                            
                         	</div> 
                         	<div class="row-fluid" id="btnDiv" style="margin-top: 20px">
	                            <div class="span4">
	                            	<button class="btn btn-info" id="createFile" type="reset">生成数据</button>
									<button class="btn btn-info" id="resetState" onclick="resetStatus()" type="reset">重置状态</button>
									<button class="btn btn-info" id="deleteData" onclick="deleteData()" type="reset">清除数据</button>
	                            </div>
	                            <span id="resultSpan"></span>
                         	 </div>                       	
                         	
						</div>
				</div>

				<div class="row-fluid">
					<div class="row-fluid">
						<div class="span12">
							<table id="table_bug_report"
								class="table table-striped table-bordered table-hover">
								<thead>
									<tr>
										<th>SN</th>
										<th>文件名</th>
										<th>操作</th>
									</tr>
								</thead>
								<tbody id="datalist">
									<!-- <tr>
										<td>@{getIndex}</td>
										<td>@{getName}</td>
										<td>@{getLink}</td>
									</tr> -->
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
<script type="text/javascript">
    XCOTemplate.pretreatment(['datalist']);
	getFileList();
	//获取文件列表
	function getFileList() {
		var xco = new XCO();
		var options = {
			url : "/tagService/selectFile.xco",
			data : xco,
			success : doRequestCallBack
		};
		$.doXcoRequest(options);
	}
	function doRequestCallBack(data){
		if(0 != data.getCode()){
			axError(data.getMessage());
			return;
		}
		data = data.getData();
		var dataList=data.get("list");
		var path = data.get("path");
		if(!dataList){
			dataList=new Array();	
		}
		var index = 1;
	    var html = '';
	    var ext = {
			getLink: function(name){
				var str ='';
				var deleteFile = "deleteFile('"+name+"')";
				str += '<a href="/'+path+'/'+name+'">下载</a>&nbsp;&nbsp;';
				str += '<a onclick="'+deleteFile+'">删除</a>';
				return str;
			},
			getIndex: function(){
				return index++;
			},
			getName: function(name){
				return name;
			}
	    };
	    for (var i = 0; i < dataList.length; i++) {
        	html += XCOTemplate.execute("datalist", dataList[i], ext);
    	}
   		document.getElementById("datalist").innerHTML = html;
	}
	//生成数据
	$("#createFile").click(function(){
    	var xco = new XCO();
		var options = {
			url : "/tagService/exportTag.xco",
			data : xco,
			success : function(data){
				if(data.getCode()!=0){
					axError(data.getMessage());
				}else{
					axSuccess("生成数据成功！",function(){
						data=data.getData();
						var min = data.get("min");
						var max = data.get("max");
						var num = data.get("num");
						var resultSpan = min+","+max+","+num;
						$("#resultSpan").text(resultSpan);
						
					});
				}
			}
		};
		axConfirm("确定生成数据吗?",function(){
			$.doXcoRequest(options);
			layer.close(layer.index);
		})
	});
	//删除文件
	function deleteFile(name){
    	var xco = new XCO();
    	xco.setStringValue("name",name);
		var options = {
			url : "/tagService/deleteFile.xco",
			data : xco,
			success : function(data){
				if(data.getCode()!=0){
					axError(data.getMessage());
				}else{
					axSuccess("删除文件成功！",function(){
						window.location.reload();
					});
				}
			}
		};
		axConfirm("确定删除文件吗?",function(){
			$.doXcoRequest(options);
			layer.close(layer.index);
		})
	}
	
	function resetStatus(name){
    	var xco = new XCO();
    	var min = $("#min").val();
		if(min){
			if(isNaN(min)){ 
				axError("开始ID请输入数字");
				document.getElementById("min").focus();
				return;
			}else{
				xco.setIntegerValue("min", min);
			}
		}else{
			axError("请输入开始ID");
			return;
		}	
    	var max = $("#max").val();
 		if(max){
			if(isNaN(max)){ 
				axError("结束ID请输入数字");
				document.getElementById("max").focus();
				return;
			}else{
				xco.setIntegerValue("max", max);
			}
		}else{
			axError("请输入结束ID");
			return;
		}   	
		var options = {
			url : "/tag/resetStatus.xco",
			data : xco,
			success : function(data){
				if(data.getCode()!=0){
					axError(data.getMessage());
				}else{
					axSuccess("重置状态成功！",function(){
						window.location.reload();
					});
				}
			}
		};
		axConfirm("确定重置状态吗?",function(){
			$.doXcoRequest(options);
			layer.close(layer.index);
		})
	}	
	
	//清除数据
	function deleteData(name){
    	var xco = new XCO();
    	var min = $("#min").val();
		if(min){
			if(isNaN(min)){ 
				axError("开始ID请输入数字");
				document.getElementById("min").focus();
				return;
			}else{
				xco.setIntegerValue("min", min);
			}
		}else{
			axError("请输入开始ID");
			return;
		}	
    	var max = $("#max").val();
 		if(max){
			if(isNaN(max)){ 
				axError("结束ID请输入数字");
				document.getElementById("max").focus();
				return;
			}else{
				xco.setIntegerValue("max", max);
			}
		}else{
			axError("请输入结束ID");
			return;
		}   	
		var options = {
			url : "/tag/cleanTag.xco",
			data : xco,
			success : function(data){
				if(data.getCode()!=0){
					axError(data.getMessage());
				}else{
					axSuccess("清除数据成功！",function(){
						window.location.reload();
					});
				}
			}
		};
		axConfirm("确定清除数据吗?",function(){
			$.doXcoRequest(options);
			layer.close(layer.index);
		})
	}
    
</script>
