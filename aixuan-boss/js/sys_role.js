/*
 * 1.页面掉用
 * 2.数据回显
 * 
 */
//添加用户时候，获取可用的用户角色
var sys_role = {
	role_id:'',
	init:function(role){
		if(role){
			sys_role.role_id = role;
		}
		sys_role.queryRole();
	},
	queryRole:function(roleid){//
		var url = "/system/getRoleListForUser.xco";
		
		var xco = new XCO();
		
		var options = {
			url : url,
			data : xco,
			success : sys_role.roledata
		};
		$.doXcoRequest(options);
	},
	roledata:function(data){//成功回调处理
		if(data.getCode()!=0){
			alert(data.getMessage());
		}else{
			var str = "<option value=0>---请选择---</option>";
			var datas = data.getXCOListValue("$$DATA");
			for(var i = 0;i<datas.length;i++){
				if(sys_role.role_id == datas[i].getLongValue("role_id")){
					str += "<option value='"+ datas[i].getLongValue("role_id")+ "' selected>"+ datas[i].getStringValue("role_name")+ "</option>";
				}else{
					str += "<option value='"+ datas[i].getLongValue("role_id")+ "'>"+ datas[i].getStringValue("role_name")+ "</option>";
				}
			}
		}
		
		$("#role").html(str);
	}
}
//添加用户时候，获取所有的用户角色
var sys_role2 = {
		role_id:'',
		init:function(role){
			if(role){
				sys_role.role_id = role;
			}
			sys_role.queryRole();
		},
		queryRole:function(roleid){
			var url = "/system/getRoleList.xco";
			
			var xco = new XCO();
			
			var options = {
				url : url,
				data : xco,
				success : sys_role.roledata
			};
			$.doXcoRequest(options);
		},
		roledata:function(data){
			if(data.getCode()!=0){
				alert(data.getMessage());
			}else{
				var str = "<option value=0>---请选择---</option>";
				var datas = data.getXCOListValue("$$DATA");
				for(var i = 0;i<datas.length;i++){
					if(sys_role.role_id == datas[i].getLongValue("role_id")){
						str += "<option value='"+ datas[i].getLongValue("role_id")+ "' selected>"+ datas[i].getStringValue("role_name")+ "</option>";
					}else{
						str += "<option value='"+ datas[i].getLongValue("role_id")+ "'>"+ datas[i].getStringValue("role_name")+ "</option>";
					}
				}
			}
			
			$("#role").html(str);
		}
	}