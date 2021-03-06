<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<html>
<head>
<script src="${ctx }/static/My97/WdatePicker.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>评价列表</title>
</head>
<body>
	<form action="list" method="post" id="queryForm">
		<table>
			<tr>
				<td><label class="control-label">上级评价ID</label></td>
				<td><input type="text" id="id" name="search_EQ_id" value="${searchParams.EQ_id }"></td>
				<td><label class="control-label">评价时间</label></td>
				<td>
					<input class="Wdate" id="firstTime" type="text" onfocus="new WdatePicker({lang:'zh-cn',dateFmt:'yyyy-MM-dd'})" 
						name="search_GTE_evaluatedTime" value="${searchParams.GTE_evaluatedTime }"/> ~
					<input class="Wdate" id="lastTime" type="text" onfocus="new WdatePicker({lang:'zh-cn',dateFmt:'yyyy-MM-dd'})" 
						name="search_LTE_evaluatedTime" value="${searchParams.LTE_evaluatedTime }"/>
				</td>
			</tr>
			<tr>
				<td><label class="control-label">评价者</label></td>
				<td><input type="text" id="mt" name="search_EQ_mt" value="${searchParams.EQ_mt }"></td>
				<td><label class="control-label">总分</label></td>
				<td><input type="text" id="score" name="search_EQ_totalScore" value="${searchParams.EQ_totalScore }"></td>
			</tr>
			<tr>
				<td><label class="control-label">被评价者</label></td>
				<td><input type="text" name="search_EQ_beEvaluatedName" value="${searchParams.EQ_beEvaluatedName }"></td>
				<td><label class="control-label">部门</label></td>
				<td>
					<select id="mtSelector" name="search_EQ_departmentName">
						<option value="">全部</option>
						<c:forEach items="${departments }" var="list" >
							<option value="${list.name }">${list.name }</option>
						</c:forEach>
					</select>
				</td>
			</tr>
		</table>
		<button class="btn">搜索</button>
					<button class="btn" type="button" onclick="resetSearch();">清空</button>
	</form>
	</br>
	<table class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<td>序号</td>
				<td>上级评价ID</td>
				<td>被评价者</td>
				<td>部门</td>
				<td>评价者</td>
				<td>评价时间</td>
				<td>总分</td>
				<td>评语</td>
				<td>操作</td>
			</tr>
		</thead>
		<tbody id="tbody">
		</tbody>
	<div id="pager"></div>
	<script type="text/x-jquery-tmpl" id="tmplList">
		{{each(i,p) data.content}}
				<tr>
					<td>@{i+1}</td>
					<td>@{p.id}</td>
					<td>@{p.beEvaluatedName}</td>
					<td>@{p.departmentName}</td>
					<td>@{p.mt}</td>
					<td>@{formatDate(p.evaluatedTime)}</td>
					<td>@{p.totalScore }</td>
					<td>@{p.comment}</td>
					<td><a href="viewPage/@{p.id}">查看</a></td>
				</tr>
		{{/each}}
	</script>
	</table>
	
	<script type="text/javascript">
		var pageSize = 10;
		$(function() {
			validate();
			$("#queryForm").submit();
		})
		
		//转化时间格式
		function formatDate(times) {
			if (times) {
				var date = new Date(times);
				var fm = date.format('yyyy-MM-dd hh:mm:ss');
				return fm;
			} else {
				return "";
			}
		}
		
		//分页方法
		function getData(pageIndex) {
			var queryData = $("#queryForm").serialize();
			pageIndex = pageIndex - 1;
			queryData = queryData + "&pageIndex=" + pageIndex + "&pageSize=" + pageSize;
			var sort = "totalScore";
			$.ajax({
				type : "POST",
				url : "${ctx}/admin/leaderAssessment/list",
				data : queryData,
				success : function(data) {
					if (data == null) {
						$("#tbody").html("暂无记录");
					} else {
						$("#tbody").html($("#tmplList").tpl({
							data : data
						}));
					}
					
					//分页控件
					var pager = new pagination(function() {
						getData($(this).attr("data-index"));
					});
					pager.pageIndex = data.number + 1;	//当前页码
					pager.pageSize = data.size;	//页大小
					pager.totalCount = data.totalElements;  //总条数
					pager.totalPage = data.totalPages;	//总页数
					$("#pager").html(pager.creat());
				}
			});
		};
	</script>
	<script>
	function validate() {
		$("#queryForm").validate({
			rules:{
				search_EQ_id:{
					digits:true
				},
				search_EQ_totalScore:{
					digits:true,
					number:true
				},
			/* 	search_GTE_evaluatedTime:{
					date:true
				},
				search_LTE_evaluatedTime:{
					date:true
				} */
			},
			messages:{
				search_EQ_id: {
					number:"必须是整数"
				},
				search_EQ_totalScore:{
					number:"必须是数字"
				},
				/* search_GTE_evaluatedTime:{
					date:"必须输入正确的时间格式"
				},
				search_LTE_evaluatedTime:{
					date:"必须输入正确的时间格式"
				} */
			},
			submitHandler:function(form){
				getData(1);
			}
		});
	}
	
	//清空表单
	function resetSearch() {
		$("input").val('');
		$("#mtSelector").val("");
	}
	</script>
</body>

</html>