<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>      
<%
 	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
 	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>服务设置-故障报表</title>
    <link rel="stylesheet" type="text/css" href="<%=basePath%>/css/common.css">
    <link rel="stylesheet" type="text/css" href="<%=basePath%>/css/style.css">
	<script type="text/javascript" src="<%=basePath%>js/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/opts.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/spin.js"></script>
	<script type="text/javascript">
		$(function(){
			timeSet();
			edit();
		});
		function edit(id,showin){
			var showins=0;
			if(showin==1){
				showins=0;
			}
			if(showin==0){
				showins=1;
			}
			$.ajax({
				type:'post',
				url:'<%=basePath%>/ReportSet/updateShowin.do',
				data:{"id":id,"showin":showins},
				success:function(data){
					var result = JSON.parse(data);
					var msg=result.message;
					if(msg=="更新成功"){
						timeSet();
					}else{
						alert(msg);
					}
				}
			});
		}
	function editColunm(id,showin){
		var showins=0;
		if(showin==1){
			showins=0;
		}
		if(showin==0){
			showins=1;
		}
		$.ajax({
			type:'post',
			url:'<%=basePath%>/ReportSet/updateFormColnum.do',
			data:{"id":id,"showin":showins},
			success:function(data){
				var result = JSON.parse(data);
				var msg=result.message;
				if(msg=="更新成功"){
					window.location.reload();
				}else{
					alert(msg);
				}
			}
		});
	}
		function timeSet(){
			$("#loading").show(); 
			$.ajax({
				type:'post',
				url:'<%=basePath%>/ReportSet/listFormTime.do',
				data:{"form_type":0,"showin":0},
				success:function(data){
					$("#loading").hide(); 
					var result = JSON.parse(data);
					var msg=result.message;
					var list=result.responseData.formTimeList;
					if(msg=="获取成功"){
						var str="";
						str+="<p class='p_style01'>时间单位设置</p><p class='p_style02  clearfix'>";
						$.each(list,function(i,list){
							str+="<label class='label_input02'><input class='input_chk' name='showin' id='showin' title="+list.id+" type='checkbox' onchange=edit('"+list.id+"','"+list.showin+"') ";
							if(list.showin==1){
								str+="checked";
							}
							str+="></input><span class='style01'></span></label><a>"+list.time_name+"</a>";
						});
						str+="</p>";
						$("#timeset").html(str);
					}else{
						alert(msg);
					}
				}});
		}
	</script>
</head>
<body>
	<!-- 头部内容home -->
    <!-- 头部内容end -->
    <div class="main_box clearfix">
        <!-- 左侧菜单 -->
        <!-- 左侧菜单end -->
        <!-- 右侧内容 -->
         <div class="right_main_div">
            <div class="W_width">
				<div class="height_H">
				<div id="loading" style="margin:100px 400px;"></div>
                <div id="timeset">
        		</div>
        		<div id="showFieldSettings">
        		</div>
                </div>
                <!-- 时间单位设置/显示字段设置 -->
                <!-- 新增/编辑弹窗 -->
                <!-- 新增/编辑弹窗end -->
            </div>
        </div>
        <!-- 右侧内容end -->
    </div>


</body>
</html>