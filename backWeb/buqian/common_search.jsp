<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!-- 通用部分 -->
<div class="search-common">
	<dl class="search-wrap">
        <dt>所属器官</dt>
        <dd>
        	<label><input type="checkbox" />肝</label>
         	<label><input type="checkbox" />子宫</label>
         	<label><input type="checkbox" />甲状腺</label>
         	<label><input type="checkbox" />肝</label>
         	<label><input type="checkbox" />子宫</label>
         	<label><input type="checkbox" />甲状腺</label>
         	<label><input type="checkbox" />肝</label>
         	<label><input type="checkbox" />子宫</label>
         	<label><input type="checkbox" />甲状腺</label>
         	<label><input type="checkbox" />肝</label>
         	<label><input type="checkbox" />子宫</label>
         	<label><input type="checkbox" />甲状腺</label>
         	<label><input type="checkbox" />肝</label>
         	<label><input type="checkbox" />子宫</label>
         	<label><input type="checkbox" />甲状腺</label>
         	<label><input type="checkbox" />肝</label>
         	<label><input type="checkbox" />子宫</label>
         	<label><input type="checkbox" />甲状腺</label>
         	<label><input type="checkbox" />肝</label>
         	<label><input type="checkbox" />子宫</label>
         	<label><input type="checkbox" />甲状腺</label>
        </dd>			
     </dl>
     <dl class="search-wrap">
         <dt>所属检查项</dt>
         <dd>
         	
         	<label><input type="checkbox" />腹部彩超</label>
         	<label><input type="checkbox" />子宫彩超</label>
         	<label><input type="checkbox" />乳腺钼靶</label>
         </dd>			
     </dl>
     <dl class="search-wrap">
         <dt>所属险种</dt>
         <dd>
         	<input class="ace" type="checkbox" /><span class="lbl">重疾</span>
         	<input class="ace" type="checkbox" /><span class="lbl">防癌</span>
         	<input class="ace" type="checkbox" /><span class="lbl">其他</span>
         </dd>			
     </dl>
     <dl class="search-wrap">
         <dt>核保影响</dt>
         <dd>
         	<input class="ace" type="checkbox" /><span class="lbl">拒保</span>
         	<input class="ace" type="checkbox" /><span class="lbl">预警</span>
         	<input class="ace" type="checkbox" /><span class="lbl">通过</span>
         </dd>			
     </dl>
     <dl class="search-wrap">
         <dt>适用数据源</dt>
         <dd>
         	<input class="ace" type="checkbox" /><span class="lbl">体检</span>
         	<input class="ace" type="checkbox" /><span class="lbl">医院</span>
         	<input class="ace" type="checkbox" /><span class="lbl">告知</span>
         </dd>			
     </dl>
     <dl class="search-wrap">
         <dt>适用性别</dt>
         <dd>
         	<input type="radio" class="ace"><span class="lbl">不限</span>
			<input type="radio" class="ace"><span class="lbl">男性</span>
			<input type="radio" class="ace"><span class="lbl">女性</span>
        </dd>			
     </dl>
     <dl class="search-wrap">
         <dt>年龄标签</dt>
         <dd>
         	<input class="ace" type="checkbox" /><span class="lbl">不限</span>
         	<input class="ace" type="checkbox" /><span class="lbl">婴儿</span>
         	<input class="ace" type="checkbox" /><span class="lbl">儿童</span>
         </dd>			
     </dl>
     <dl class="search-wrap">
         <dt>相关子集</dt>
         <dd>
         	<input class="ace" type="checkbox" /><span class="lbl">爱康</span>
         	<input class="ace" type="checkbox" /><span class="lbl">天方达</span>
         </dd>			
     </dl>
	<a class="search-fold" href="javascript:;">展开</a>
</div>
<!-- 通用部分 -->
<script src="/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript">
	$(".search-common>dl:gt(1)").hide();
	$(".search-fold").attr("fold", "off")
	$(".search-fold").bind("click", function() {
	console.log(11)
		if($(this).attr("fold") == "off") {
			$(this).attr("fold", "on").text("收起")
			$(".search-common>dl").show();
		} else {
			$(this).attr("fold", "off").text("展开")
			$(".search-common>dl:gt(1)").hide();
		}
		console.log($(this).attr("fold"))
		
	})
</script>