<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String pageName = "发起核保请求";
%>
<%@ include file="../common/menu_and_navbar.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
	<base href="<%=basePath%>">
	<meta charset="utf-8" />
	<title>新增核保请求</title>
</head>
<body>
<div id="main-content" class="clearfix">

	<div id="breadcrumbs">
		<ul class="breadcrumb">
			<li><span href="#">核保系统</span><span
					class="divider"><i class="icon-angle-right"></i> </span></li>
			<li><span href="../dictionary/labelList.jsp"> 新增核保请求</span><span class="divider"><i
					class="icon-angle-right"></i>
			</span>
			</li>
			<li><span>新增核保请求</span><span class="divider"></span>
			</li>
		</ul>
	</div>

	<!--#breadcrumbs-->
	<div id="page-content" class="clearfix">
		<div class="page-header position-relative crumbs-nav">
			<h1>新增/修改</h1>
		</div>
		<div class="row-fluid">
			<div class="row-fluid mar-t-15">
				<div class="span12">
					<div class="form-inline bord1dd form-add1 mar-t-15">
						<div class="from-group mar-t-15">
							<label>身份证号</label>
							<input type="text" class="form-control mar-t-15" id="id_card" style="width:366px;" placeholder="">
						</div>
						<div class="from-group mar-t-15">
							<label>年龄</label>
							<input type="number"  class="form-control mar-t-15" id="req_age" style="width:366px;" placeholder="">
						</div>
						<div class="from-group mar-t-15">
							<label>性别</label>
							<input type="radio" name="req_sex" value="11" checked style="opacity: 1;position: static;  z-index: 12;width: 15px;height: 15px;">
							<span style="vertical-align: -webkit-baseline-middle;">男</span>
							<input type="radio" name="req_sex" value="10" style="opacity: 1;position: static;  z-index: 12;width: 15px;height: 15px;">
							<span style="vertical-align: -webkit-baseline-middle;">女</span>
						</div>
						<div class="from-group mar-t-15">
							<label>核保模式</label>
							<select class="form-control w150" id="rule_model">
								<option value="3" selected>评级</option>
							</select>
						</div>
						<div class="from-group mar-t-15">
							<label>渠道</label>
							<select class="form-control w150" id="ch_id">
								<option value="3" selected>流程测试channel_01</option>
							</select>
						</div>
						<div class="from-group mar-t-15">
							<label>产品类目</label>
							<select class="form-control w150" id="series_no">
								<option value="0" selected>请选择</option>
								<option value="1">重疾险</option>
								<option value="2">寿险</option>
								<option value="3">癌症险</option>
							</select>
						</div>

					</div>
					<div class="from-group mar-t-15">
						<label></label>
						<button class="btn mar-t-15 mar-l-15  btn-success" id="add" type="reset">发起核保请求</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>
<script type="text/javascript">
    /* channelRequest();
    function channelRequest(){
       var xco = new XCO();
       var options = {
           url : "/security/getAllChannel.xco",
           data : xco,
           success : channelRequestCallBack
       };
       $.doXcoRequest(options);
    }

    function channelRequestCallBack(data){
       if(0 != data.getCode()){
           // TODO 错误提示
           return;
       }
       var dataList = data.getData();
       var html = '<option value="0">请选择</option>';
        for (var i = 0; i < dataList.length; i++) {
           html += XCOTemplate.execute("ch_id", dataList[i], null);
       }

          document.getElementById("ch_id").innerHTML = html;
    } */
    $("#add").click(function(){
        var xco = new XCO();
        var data=$("#ch_id").val();
        /* var ch_id=ch_id.substring(ch_id.length-1,ch_id.length); */
        xco.setStringValue("req_sn_ext", ""+parseInt(Math.random()*100000));
        xco.setLongValue("ch_id", data);
        xco.setLongValue("org_no", 105);
        xco.setStringValue("up_ext_pno", "P00"+data);
        xco.setLongValue("series_no", $("#series_no").val());//传入
        xco.setLongValue("sub_series_no", 0);
        var id_card=$("#id_card").val();
        if(id_card){
            xco.setStringValue("id_card",id_card);
        }else{
            axError("请输入身份证编号");
            return;
        }
        var req_age=$("#req_age").val()
        if(req_age){
			if(req_age<=100){
				xco.setIntegerValue("req_age", req_age);
			}else{
				axError("最大年龄不能超过100");
				return;
			}
		}else{
			axError("请输入年龄");
			return;
		}
        var rule_model=$("#rule_model").val()
        if(rule_model>0){
            xco.setIntegerValue("rule_model",$("#rule_model").val());
        }else{
            axError("请选择核保模式");
            return;
        }
        // var rule_id=$("#rule_id").val()
        // if(rule_id>0){
        // 	xco.setLongValue("rule_id",$("#rule_id").val());
        // }else{
        // 	axError("请选择核保规则");
        // 	return;
        // }

        var series_no=$("#series_no").val()
        // if(series_no>0){
        // 	xco.setIntegerValue("series_no",$("#series_no").val());
        // }else{
        // 	axError("请选择类型");
        // 	return;
        // }

        xco.setIntegerValue("req_sex",$("input[name='req_sex']").val());
        var options = {
            url : "/securityService/securityRequest.xco",
            data : xco,
            success : function(data){
                if(data.getCode()!=0){
                    axError(data.getMessage());
                }else{
                    axSuccess("添加成功！",function(){
                        location.href="../ungstd/ruquestList.jsp";
                    });
                }
            }
        };
        axConfirm("确定添加核保请求吗?",function(){
            $.doXcoRequest(options);
            layer.close(layer.index);
        })
    })
</script>
