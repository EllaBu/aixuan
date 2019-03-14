<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String pageName = "爱康产品推荐";
%>
<%@ include file="../common/menu_and_navbar.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<base href="<%=basePath%>">
<meta charset="utf-8" />
<title>爱康产品推荐列表</title>
</head>
<body>
	<div id="main-content" class="clearfix">

    <div id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="icon-lock"></i><span class="divider"></span><span href="#">爱康管理</span><span
					class="divider"><i class="icon-angle-right"></i> </span>
				</li>
				<li>
				<span>爱康产品推荐</span><span class="divider"></span>
				</li>
			</ul>
		</div>


		<!--#breadcrumbs-->
		<div id="page-content" class="clearfix">
			<div class="page-header position-relative crumbs-nav">
				<h1><i class="icon-th-list"></i>产品推荐列表</h1>
				<div class="form-add-new">
	                <button class="btn btn-success" onclick="window.location.href='ungstd/addAikangProduct.jsp'"  type="reset">+新增</button>
           		</div>
			</div>
      <div class="row-fluid">
      			<!-- <div class="row-fluid mar-t-15">
					<div class="span12">
						<div  class="form-inline">
                          	<div class="form-group">
                                <button class="btn mar-t-15 mar-l-15  btn-success" onclick="window.location.href='ungstd/addAikangProduct.jsp'"  type="reset">+新增</button>
	                       </div>
                        </div>
					</div>
				</div> -->
				<div class="row-fluid">
                    <div class="row-fluid">
                        <div class="span12">
                            <table id="table_bug_report" class="table table-striped table-bordered table-hover">
								<thead>
									<tr>
										<th>ID</th>
					                    <th>产品编号</th>
										<th>产品名称</th>
										<th>核保模式</th>
										<th>产品分类</th>
										<th>规则ID</th>
										<th>创建时间</th>
										<th>操作</th>
									</tr>
								</thead>
								<tbody id="datalist">
									<!-- <tr>
										<td ctr="ap_id">#{ap_id}</td>
										<td ctr="ap_pno">#{ap_pno}</td>
										<td ctr="ap_pname">#{ap_pname}</td>
										<td ctr="Model">@{getModel}</td>
										<td ctr="type">@{getType}</td>
										<td ctr="rule_id">#{rule_id}</td>
										<td>#{create_time@formatdate}</td>
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
	xdoRequest();
	getRules();
	var rules;
	function getRules(){
		var xco = new XCO();
		var options = {
			url : "/rules/selectRulesND.xco",
			data : xco,
			success : ruleRequestCallBack
		};
		$.doXcoRequest(options);
	}
	
	function xdoRequest(start,pagesize) {
		var xco = new XCO();
		var options = {
			url : "/rules/selectAllProduct.xco",
			data : xco,
			success : doRequestCallBack
		};
		$.doXcoRequest(options);
	}
	
	function ruleRequestCallBack(data){
		if(data.getCode()==0){
			rules=data.getData();
		}
	}
	function doRequestCallBack(data){
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
			getLink:function(xco){
					return '<a ctr="update" href="javascript:;" onclick="modify(this)">编辑</a><a  style="display:none" ctr="add"  href="javascript:;" onclick="save(this)">保存</a>';
				
			},
			getType:function(xco){
				if(xco.get("series_no")==1){
					return "重疾险";
				}
				if(xco.get("series_no")==2){
					return "寿险";
				}
				if(xco.get("series_no")==3){
					return "癌症险";
				}
			},
			getModel:function(xco){
				if(xco.get("rule_model")==1){
					return "预警";
				}
				if(xco.get("rule_model")==2){
					return "评点";
				}
				if(xco.get("rule_model")==3){
					return "预警+评级";
				}
				if(xco.get("rule_model")==5){
					return "评点+评级";
				}
				if(xco.get("rule_model")==6){
					return "评级";
				}
			}
	    };
	    for (var i = 0; i < dataList.length; i++) {
        	html += XCOTemplate.execute("datalist", dataList[i], ext);
    	}
   		document.getElementById("datalist").innerHTML = html;
	}
	  
	function modify(obj){
		
		$(obj).parent().find("a[ctr='add']").show();
		$(obj).parent().find("a[ctr='update']").hide();
		var pobj=$(obj).parent().parent();
		
		var ap_pno=$(pobj).find("td[ctr='ap_pno']").text();
		$(pobj).find("td[ctr='ap_pno']").html('<input style="width:50px;" type="text" name="ap_pno" value='+ap_pno+'></input>');
		
		var ap_pname=$(pobj).find("td[ctr='ap_pname']").text();
		$(pobj).find("td[ctr='ap_pname']").html('<input style="width:50px;" type="text" name="ap_pname" value='+ap_pname+'></input>');
		
		var Model=$(pobj).find("td[ctr='Model']").text();
		var str='<select  name="rule_model" style="width:100px;"><option value="0">请选择</option>';
			str+='<option value="1">预警</option>';
			str+='<option value="2">评点</option>';
			str+='<option value="3">预警+评级</option>';
			str+='<option value="5">评点+评级</option>';
			str+='<option value="6">评级</option></select>';
			
		$(pobj).find("td[ctr='Model']").html(str);
		$(pobj).find("select[name='rule_model']").find("option").each(function(i,el){
			if($(el).text()==Model){
				$(el).prop("selected","selected");
			}
		})
		var type=$(pobj).find("td[ctr='type']").text();
		var str2='<select name="series_no"><option value="0">请选择</option>';
			str2+='<option value="1">重疾险</option>';
			str2+='<option value="2">寿险</option>';
			str2+='<option value="3">癌症险</option></select>';
		$(pobj).find("td[ctr='type']").html(str2);
		
		$(pobj).find("select[name='series_no']").find("option").each(function(i,el){
			if($(el).text()==type){
				$(el).prop("selected","selected");
			}
		})
		
		var rule_id=$(pobj).find("td[ctr='rule_id']").text();
		var st='<select name="rule_id" style="width:100px;">';
		for(var i=0;i<rules.length;i++){
			if(rules[i].get("rule_id")==rule_id){
				st+='<option selected="selected" value='+rules[i].get("rule_id")+'>'+rules[i].get("rule_id")+'</option>'
			}else{
				st+='<option  value='+rules[i].get("rule_id")+'>'+rules[i].get("rule_id")+'</option>'
			}
		}
		$(pobj).find("td[ctr='rule_id']").html(st);
	}
	
	function save(obj){
		var xco = new XCO();
		var temp=$(obj).parent().parent();
		var ap_id=$(temp).find("td[ctr='ap_id']").text();
		var ap_pno=$(temp).find("input[name='ap_pno']").val();
		xco.setIntegerValue("ap_id", ap_id);
		if(ap_pno){
			xco.setStringValue("ap_pno",ap_pno);
		}else{
			axError("请填写产品编号");
			return;
		}
		var ap_pname=$(temp).find("input[name='ap_pname']").val();
		if(ap_pname){
			xco.setStringValue("ap_pname",ap_pname);
		}else{
			axError("请填写产品名称");
			return;
		}
		var rule_model=$(temp).find("select[name='rule_model']").val();
		if(rule_model!=0){
			xco.setIntegerValue("rule_model",rule_model);
		}else{
			axError("请选择核保模式");
			return;
		}
		var series_no=$(temp).find("select[name='series_no']").val();
		xco.setIntegerValue("series_no",series_no);
		var rule_id=$(temp).find("select[name='rule_id']").val();
		if(rule_id!=0){
			xco.setLongValue("rule_id",rule_id);
		}else{
			axError("请选择核保规则");
			return;
		}
		 var options = {
			url : "/rules/updateAkangRecProduct.xco",
			data : xco,
			success : function(data){
				if(data.getCode()!=0){
					axError(data.getMessage());
				}else{
					axSuccess("修改成功！",function(){
						location.href="../ungstd/aikangProductList.jsp";
					});
				}
			}
		};
		$.doXcoRequest(options);
	}
	
	function formatdate(time){
		var date = new Date(time);
	    var year =  date.getFullYear(),
			        month = date.getMonth() + 1,//月份是从0开始的
			        day = date.getDate(),
			        hour = date.getHours(),
			        min = date.getMinutes(),
			        sec = date.getSeconds();
		        	if(day<10) day='0'+day;	
			        if(month<10) month='0'+month;
			        if(hour<10) hour= '0'+hour;
			        if(min<10) min= '0'+min;
			        if(sec<10) sec= '0'+sec;
		var newTime = year + '-' +  month + '-' +day + ' ' +
				                hour + ':' +min + ':' +sec;
	    return newTime;         
	}

</script>
