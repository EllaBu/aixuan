<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title></title>
  <link href="../css/bootstrap.min.css" rel="stylesheet"/>
  <link href="../css/bootstrap-responsive.min.css" rel="stylesheet"/>
  <link rel="stylesheet" href="../css/font-awesome.min.css"/>
  <!--[if IE 7]>
  <link rel="stylesheet" href="../css/font-awesome-ie7.min.css"/>
  <![endif]-->
  <!-- page specific plugin styles -->

  <link href="../css/bootstrap.min.css" rel="stylesheet"/>
  <link href="../css/bootstrap-responsive.min.css" rel="stylesheet"/>
  <link rel="stylesheet" href="../css/font-awesome.min.css"/>
  <link rel="stylesheet" href="../css/font-awesome-ie7.min.css"/>


  <!-- ace styles -->
  <link rel="stylesheet" href="../css/ace.min.css"/>
  <link rel="stylesheet" href="../css/ace-responsive.min.css"/>
  <link rel="stylesheet" href="../css/ace-skins.min.css"/>
  <!--[if lt IE 9]>
  <link rel="stylesheet" href="../css/ace-ie.min.css"/>
  <![endif]-->
  <link rel="stylesheet" href="../css/header.css"/>
  <link rel="stylesheet" href="../css/style.css"/>
  <link rel="stylesheet" href="../css/jquery-ui.css"/>


  <script src="../js/jquery-3.3.1.min.js"></script>
  <script src="../js/bootstrap.min.js"></script>
  <!-- page specific plugin scripts -->

  <!--[if lt IE 9]>
  <script type="text/javascript" src="../js/excanvas.min.js"></script>
  <![endif]-->
  <script type="text/javascript" src="../js/xco-1.0.1.js"></script>
  <script type="text/javascript" src="../js/jquery-ui.js"></script>
  <script type="text/javascript" src="../js/xco.databinding-1.0.1.js"></script>
  <script type="text/javascript" src="../js/xco.jquery-1.0.1.js"></script>
  <script type="text/javascript" src="../js/xco.template-1.0.1.js"></script>
  <script type="text/javascript" src="../js/xco.validate-1.0.1.js"></script>
  <script type="text/javascript" src="../js/xco.variable-1.0.1.js"></script>
  <!-- ace scripts -->
  <script src="../js/ace-elements.min.js"></script>
  <script src="../js/ace.min.js"></script>
  <script type="text/javascript" src="../js/bootstrap-datepicker.min.js"
          charset="utf-8"></script>
  <script type="text/javascript" src="../js/bootstrap-timepicker.min.js"></script>
  <script type="text/javascript" src="../js/jqPaginator.js"></script>
  <script type="text/javascript" src="../js/public.js"></script>
  <script type="text/javascript" src="../js/autocomplete.js"></script>
  <script src="../js/layer/layer.js"></script>
</head>
<body>

<div id="main-content" class="clearfix">

  <div id="breadcrumbs">
    <ul class="breadcrumb">
      <#if navigates??>
        <#list navigates as per>
          <li>
            <#if (per_index==0)>
              <i class="icon-leaf"></i>
              <span class="divider"></span>
            </#if>
            <span href="${per.href}">${per.name}</span>
            <span class="divider">
                            <#if (per_index!=navigates?size-1)>
                              <i class="icon-angle-right"></i>
                            <#else >
                              <#assign leaf>
                                ${per.name}
                              </#assign>
                            </#if>
                        </span>
          </li>
        </#list>
      <#else>
        <li><i class="icon-leaf"></i><span class="divider"></span><span href="#">核保管理</span><span
                  class="divider"><i class="icon-angle-right"></i> </span></li>
        <li>
          <span href="../dictionary/labelList.jsp"> 渠道管理</span><span class="divider"><i
                    class="icon-angle-right"></i></span>
        </li>
        <li><span>修改渠道</span><span class="divider">

            </span>
        </li>
      </#if>
    </ul>
  </div>

  <div id="page-content" class="clearfix">
    <div class="page-header position-relative crumbs-nav">
      <h1><i class="icon-edit"></i>${leaf!("修改")}</h1>
    </div>
    <div class="row-fluid">
      <div class="row-fluid mar-t-15">
        <div class="span12">
          <div class="form-inline form-inline-detail bord1dd form-add1 mar-t-15">
            <#list list as per>
              <#if (per.type=="text")>
                <div class="from-group mar-t-15">
                  <label><span
                            style="color:red;"><#if (per.required=="true")>*</#if></span>${per.name}
                  </label>
                  <input type="text" class="form-control" id="${per.code}" placeholder="">
                </div>
              <#elseif (per.type=="textarea")>
                <div class="from-group mar-t-15">
                  <label><span
                            style="color:red;"><#if (per.required=="true")>*</#if></span>${per.name}
                  </label>
                  <textarea id="${per.code}" rows="3"></textarea>
                </div>
              <#elseif (per.type=="radio")>
                <div class="from-group mar-t-15">
                  <label><span
                            style="color:red;"><#if (per.required=="true")>*</#if></span>${per.name}
                  </label>
                  <#if per.values??>
                    <#list per.values as one>
                      <input type="radio" name="${per.code}" value="${one.code}" class="ace">
                      <span class="lbl">${one.name}</span>
                    </#list>
                  </#if>
                </div>
              <#elseif (per.type=="checkbox")>
                <div class="from-group mar-t-15">
                  <label><span
                            style="color:red;"><#if (per.required=="true")>*</#if></span>${per.name}
                  </label>
                  <#if per.values??>
                    <#list per.values as one>
                      <input type="checkbox" name="${per.code}" value="${one.code}">
                      <span class="lbl">${one.name}</span>
                    </#list>
                  </#if>
                </div>
              <#elseif (per.type=="select")>
                <div class="from-group mar-t-15">
                  <label><span
                            style="color:red;"><#if (per.required=="true")>*</#if></span>${per.name}
                  </label>
                  <select class="form-control" id="${per.code}">
                    <option value="-1">请选择</option>
                    <#if (per.values??)>
                      <#list per.values as one>
                        <option value="${one.code}">${one.name}</option>
                      </#list>
                    </#if>
                  </select>
                </div>
              </#if>
            </#list>

            <div class="from-group">
              <button class="user-add-save" id="save">保存</button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<script type="text/javascript">
    $("#save").click(function () {
        var xco = new XCO();
        //参数必填验证
        <#list list as per>
        var ${per.code}=
        $("#${per.code}").val();
        <#if (per.type=="text" || per.type=="textarea")>
        <#if (per.required=="true")>
        if (!${per.code}) {
            axError("请输入${per.name}");
            return;
        }
        </#if>
        <#elseif (per.type=="checkbox")>
        ${per.code}
        = "";
        $("input[name='${per.code}']:checked").each(function () {
            ${per.code}
            += $(this).val() + ",";
        });
        <#if (per.required=="true")>
        if (!${per.code}) {
            axError("请选择${per.name}");
            return;
        }
        </#if>
        <#elseif (per.type=="radio")>
        ${per.code}
        = $("input[name='${per.code}']:checked").val()
        <#if (per.required=="true")>
        if (!${per.code}) {
            axError("请选择${per.name}");
            return;
        }
        </#if>
        <#elseif (per.type=="select")>
        <#if (per.required=="true")>
        if (${per.code}==-1
    )
        {
            axError("请选择${per.name}");
            return;
        }
        </#if>
        </#if>
        xco.set${per.dataType}Value("${per.code}", ${per.code});
        </#list>
        console.log(xco.toString())
        var options = {
            url: "${save_url!(" ")}",
            data: xco,
            success: function (data) {
                if (data.getCode() != 0) {
                    axError(data.getMessage());
                } else {
                    axSuccess("保存成功！");
                }
            }
        };
        axConfirm("确定保存吗?", function () {
            $.doXcoRequest(options);
        })
    })
</script>
</body>

</html>
