<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String pageName = "核保规则";
%>
<%@ include file="../common/menu_and_navbar.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<base href="<%=basePath%>">
<meta charset="utf-8" />
<title>正常值定义（数值型）</title>
</head>
<body>
	<div id="main-content" class="clearfix">

		<div id="breadcrumbs">
			<ul class="breadcrumb">
				<li>
					<i class="icon-leaf"></i>
				<span class="divider"></span><span href="#">核保管理</span><span class="divider"><i class="icon-angle-right"></i></span>
				</li>
				<li>	
					<span href="../dictionary/labelList.jsp">核保规则</span>
					<span class="divider"><i class="icon-angle-right"></i> </span>
				</li>
       			<li>
       				<span href="../dictionary/labelList.jsp">正常值</span>
       				<span class="divider"><i class="icon-angle-right"></i></span>
				</li>
		        <li>
		        	<span>正常值定义（数值型）</span><span class="divider"></span>
			    </li>
   			 </ul>
		</div>

		<!--#breadcrumbs-->
		<div id="page-content" class="clearfix">
			<div class="page-header position-relative crumbs-nav">
				<h1><i class="icon-edit"></i>正常值定义（数值型）</h1>
			</div>
      		<div class="row-fluid">
              <div class="row-fluid">
              <div class="span12">
                <!-- <p style="color:#2679b5;font-size:16px;font-weight:bold;float:right;" onclick="openDefinition()">批量设置</p> -->
             	 <table id="table_bug_report" class="table table-striped table-bordered table-hover">
		              <thead>
		                <tr>
		                  <th>ID</th>
		                  <th>性别</th>
		                  <th>年龄</th>
		                  <th>范围1</th>
		                  <th>范围2</th>
	                	  <th>操作</th>
		                </tr>
		              </thead>
		              <tbody id="datalist">
		                <!-- <tr>
		                  <td name="rnd_id">#{rnd_id}</td>
		                  <td>
		                  	 @{getSex}
		                  <td>
		                    <input type="text" name="rnd_age" class="form-control"  value="@{getAge}" style="width: 100px;">
		                  </td>
		                  <td>
							<div class="from-group mar-t-15">
								<label style="display: inline-block;">单位：</label>
								<input type="text" class="form-control"  name="rnd_unit"  value="#{rnd_unit}" >
							</div>
							<div class="from-group mar-t-15">
								<label style="display: inline-block;">下限：</label>
								<input type="text" class="form-control"  name="rnd_val_min" value="#{rnd_val_min}" >
							</div>
							<div class="from-group mar-t-15">
								<label style="display: inline-block;">上限：</label>
								<input type="text" class="form-control" name="rnd_val_max" value="#{rnd_val_max}" >
							</div>
		                  </td>
		                  <td>
							<div class="from-group mar-t-15">
								<label style="display: inline-block;">单位：</label>
								<input type="text" class="form-control"  name="rnd_unit1"  value="#{rnd_unit1}" >
							</div>
							<div class="from-group mar-t-15">
								<label style="display: inline-block;">下限：</label>
								<input type="text" class="form-control"  name="rnd_val1_min" value="#{rnd_val1_min}" >
							</div>
							<div class="from-group mar-t-15">
								<label style="display: inline-block;">上限：</label>
								<input type="text" class="form-control"  name="rnd_val1_max" value="#{rnd_val1_max}" >
							</div>
		                  </td>
		                  <td>@{getLink}</td>
		                </tr> -->
		              </tbody>
           		 </table>
            <jsp:include page="../common/page.jsp"/>
          </div>
        </div>
      </div>
		</div>
	</div>
</body>
</html>
<script type="text/javascript">
 	var rn_id = getURLparam("rn_id");
	XCOTemplate.pretreatment(['datalist']);
	xdoRequest();
	function xdoRequest() {
		var xco = new XCO();
		xco.setIntegerValue("rn_id", rn_id);
		var options = {
			url : "/rulecalculate/getNormalDefByNormalId.xco",
			data : xco,
			success : doRequestCallBack
		};
		$.doXcoRequest(options);
	}
	
	function doRequestCallBack(data){
		//var xco=new XCO();
		//xco.fromXML(data);
		//var data = xco.getData();
		
		if(0 != data.getCode()){
			// TODO 错误提示
			return;
		}
		
		var dataList=data.getData();
		if(!dataList){
			dataList=new Array();	
		}
	    var html = '';
	    var ext = {
				getSex: function(xco){
				var str = '<select  name="sex" style="width:100px;margin:0;">';
					if(xco.get("rnd_sex")==0){
					str +='<option value="0" selected="selected">不限</option>'  +
								              '<option value="11">男</option>' +
								              '<option value="10">女</option></select>';
					}
					if(xco.get("rnd_sex")==11){
					str +='<option value="0">不限</option>'  +
								              '<option selected="selected" value="11">男</option>' +
								              '<option value="10">女</option></select>';
					}
					if(xco.get("rnd_sex")==10){
					str +='<option value="0">不限</option>'  +
								              '<option value="11">男</option>' +
								              '<option selected="selected" value="10">女</option></select>';
					}
					return 	str;	
			},
			getAge: function(xco){
				if(xco.get("rnd_age")==0){
					return "不限";
				}else{
					return xco.get("rnd_age");
				}
			},
			getLink:function(xco){
				return '<a href="javascript:;" onclick="updateDef(this)">保存<a>';
			}
	    };
	    for (var i = 0; i < dataList.length; i++) {
        	html += XCOTemplate.execute("datalist", dataList[i], ext);
    	}
   		document.getElementById("datalist").innerHTML = html;
   			  
	}
	
	function updateDef(obj){
		var el=$(obj).parent().parent();
		var rnd_id=$(el).find("td[name='rnd_id']").text();
		var rnd_sex=$(el).find("select[name='sex']").val();
		var rnd_age=$(el).find("input[name='rnd_age']").val();
		var rnd_unit=$(el).find("input[name='rnd_unit']").val();
		var rnd_val_min=$(el).find("input[name='rnd_val_min']").val();
		var rnd_val_max=$(el).find("input[name='rnd_val_max']").val();
		var rnd_unit1=$(el).find("input[name='rnd_unit1']").val();
		var rnd_val1_min=$(el).find("input[name='rnd_val1_min']").val();
		var rnd_val1_max=$(el).find("input[name='rnd_val1_max']").val();
		var xco=new XCO();
		xco.setLongValue("rnd_id", rnd_id);
		xco.setIntegerValue("rnd_sex",rnd_sex);
		xco.setIntegerValue("rnd_age", rnd_age=='不限'?0:rnd_age);
		xco.setStringValue("rnd_unit", rnd_unit);
		xco.setStringValue("rnd_val_max", rnd_val_max);
		xco.setStringValue("rnd_val_min", rnd_val_min);
		xco.setStringValue("rnd_unit1", rnd_unit1);
		xco.setStringValue("rnd_val1_max", rnd_val1_max);
		xco.setStringValue("rnd_val1_min", rnd_val1_min);
		var options = {
			url : "/rules/updateNormalDef.xco",
			data : xco,
			success : doupdateCallBack
		};
		axConfirm("确定修改正常值定义吗?",function(){
			$.doXcoRequest(options);
			layer.close(layer.index);
		})
	}
	  
	  
	function doupdateCallBack(data){
		if(data.getCode()==0){
			axSuccess("修改成功！",function(){
				location.href="/ungstd/normalNumberic.jsp?rn_id="+rn_id;;
			});
		}else{
			axError("修改失败!");
		}
	}
	 
	function deleteDef(opt,opt2){
		var xco = new XCO();
		xco.setIntegerValue("rnd_id", opt);
		xco.setIntegerValue("rn_id", opt2);
		var options = {
			url : "/rulecalculate/deleteNormalDef.xco",
			data : xco,
			success : doDeleteCallBack
		};
		$.doXcoRequest(options);
	
	}
	
	function doDeleteCallBack(data){
		if(data.getCode()==0){
			window.location.reload();
		}else{
		// TODO 错误提示
			return;
		}
	}
	  
    $("#search").click(function(){
		renderPage = true;
		xdoRequest(0,pageSize);
	});
    
</script>
