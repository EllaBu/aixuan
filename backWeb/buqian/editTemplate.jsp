<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String pageName = "医学标准项";
%>
<%@ include file="../common/menu_and_navbar.jsp"%>
<!DOCTYPE html>
<html>
<head>
  <base href="<%=basePath%>">
  <meta charset="utf-8" />
  <title></title>
</head>
<body>
<div id="main-content" class="clearfix">

  <div id="breadcrumbs">
    <ul class="breadcrumb">
              <li>
          <i class="icon-heart"></i>
          <span class="divider"></span>
          <span>医学管理</span>
          <span class="divider"><i class="icon-angle-right"></i></span>
        </li>
        <li>
          <span>标准项管理</span>
          <span class="divider"><i class="icon-angle-right"></i></span>
        </li>
        <li>
          <span>修改标准项</span>
          <span class="divider"></span>
        </li>

    </ul>
  </div>

  <!--#breadcrumbs-->
  <div id="page-content" class="clearfix">
    <div class="page-header position-relative crumbs-nav">
      <h1><i class="icon-edit"></i>修改</h1>
    </div>
    <div class="row-fluid">
      <div class="row-fluid">
        <div class="span12">
          <div class="form-inline form-inline-detail bord1dd form-add1 mar-t-15">

              <div class="from-group mar-t-15">
                <label>
                    <span style="color:red;">*</span>
                  标准项编码
                </label>
                  <input type="text" class="" id="std_code" placeholder="请输入标准项编码">

              </div>
              <div class="from-group mar-t-15">
                <label>
                  分类
                </label>
                  <select class="form-control" id="std_type">
                    <option value="-1">请选择</option>
                        <option value="1">启用</option>
                        <option value="2">停用</option>
                        <option value="3">启用</option>
                        <option value="4">停用</option>
                  </select>

              </div>
              <div class="from-group mar-t-15">
                <label>
                  描述
                </label>
                  <input type="text" class="" id="std_desc" placeholder="请输入描述">

              </div>
              <div class="from-group mar-t-15">
                <label>
                  状态
                </label>
                      <input type="radio" name="std_state" value="1" class="ace">
                      <span class="lbl">启用</span>
                      <input type="radio" name="std_state" value="0" class="ace">
                      <span class="lbl">停用</span>

              </div>


            <div class="from-group">
              <button class="user-add-save" id="save" type="reset">保存</button>
            </div>
          </div>

        </div>
      </div>
    </div>
  </div>
</div>
<script>

    doGetInfo();
    function doGetInfo() {
        var xco = new XCO();
        xco.setLongValue("std_id",1);
        var options = {
            // url: "",
            url: "/standard/selectStdDetail.xco",
            data: xco,
            success: function (data) {
                if(data.getCode()==0) {
                    var xco=data.getData();
                    $("#std_code").val(xco.get("std_code"));
                    $("#std_type").val(xco.get("std_type"));
                    $("#std_desc").val(xco.get("std_desc"));
                    $("#std_state").val(xco.get("std_state"));
                    $("input[name=std_state]").each(function () {
                        if($(this).val()==xco.get("std_state")){
                            $(this).prop("checked",true);
                        }
                    })
                } else {
                    axError("服务异常");
                }
            }
        };
        $.doXcoRequest(options);
    }

    $("#save").click(function () {
        var xco = new XCO();
        var std_code = $("#std_code").val();
        if (!std_code) {
            axError("请输入标准项编码");
            return;
        }



        xco.setStringValue("std_code", std_code);
        console.log(std_code )
        var std_type = $("#std_type").val();

        xco.setStringValue("std_type", std_type);
        console.log(std_type )
        var std_desc = $("#std_desc").val();



        xco.setStringValue("std_desc", std_desc);
        console.log(std_desc )
        var std_state = $("#std_state").val();
        std_state = $("input[name='std_state']:checked").val()


        xco.setStringValue("std_state", std_state);
        console.log(std_state )

        console.log(xco.toString())
        var options = {
            url: "",
            data: xco,
            success: function (data) {
                if (data.getCode() != 0) {
                    axError(data.getMessage());
                } else {
                    axSuccess("修改成功！",function(){
                        location.href="";
                    });
                }
            }
        }
        axConfirm("确定修改吗?", function () {
            $.doXcoRequest(options);
            layer.close(layer.index);
        })
    })

</script>
</body>


</html>
