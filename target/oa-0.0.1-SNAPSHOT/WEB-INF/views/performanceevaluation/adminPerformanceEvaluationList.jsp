<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<html>
<head>
<title>用户管理</title>
</head>
<body>
	<form id="queryForm" class="form-inline">
		<table>
			<tr>
				<td><label for="id" class="control-label">绩效总评ID:</label></td>
				<td><input type="text" id="id" name="id" class="input-medium" /></td>
				<td><label for="efficiencyScore" class="control-label">效能得分:</label></td>
				<td><input type="text" id="efficiencyScore"
					name="efficiencyScore" class="input-medium" /></td>
				<td><label for="totalScore" class="control-label">总分:</label></td>
				<td><input type="text" id="totalScore" name="totalScore"
					class="input-medium" /></td>
			</tr>
			<tr>
				<td><label for="beEvaluatedName" class="control-label">被评价者:</label></td>
				<td><input type="text" id="beEvaluatedName"
					name="beEvaluatedName" class="input-medium" /></td>
				<td><label for="specialtyScore" class="control-label">专业得分:</label></td>
				<td><input type="text" id="specialtyScore"
					name="specialtyScore" class="input-medium" /></td>
				<td><label for="totalGrade" class="control-label">总评级别:</label></td>
				<td><select id="totalGrade" name="totalGrade" class="span12">
						<option selected="selected"></option>
						<option value="S">S</option>
						<option value="A">A</option>
						<option value="B">B</option>
						<option value="C">C</option>
						<option value="D">D</option>
				</select></td>
			</tr>
			<tr>
				<td><label for="departmentName" class="control-label">部门:</label></td>
				<td><select id="departmentName" name="departmentName"
					class="span12">
						<option value="">----</option>
						<c:forEach items="${department }" var="dep">
							<option value="${dep.name }">${dep.name }</option>
						</c:forEach>
				</select></td>
				<td><label for="leaderAssessmentScore" class="control-label">上级评价得分:</label></td>
				<td><input type="text" id="leaderAssessmentScore"
					name="leaderAssessmentScore" class="input-medium" /></td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td><label for="createTime" class="control-label">时间:</label></td>
				<td><input
					onfocus="new WdatePicker({lang:'zh-cn',dateFmt:'yyyy-MM'})"
					type="text" id="createTime" name="createTime"
					class="input-medium Wdate" /></td>
				<td><label for="satisfactionScore" class="control-label">客户满意得分:</label></td>
				<td><input type="text" id="satisfactionScore"
					name="satisfactionScore" class="input-medium" /></td>
				<td></td>
				<td></td>
			</tr>
		</table>
		<div>
			<button id="btnSearch" type="submit" class="btn">搜索</button>
			<button id="btnExport" type="button" class="btn">导出</button>
		</div>
		<input type="hidden" name="sort" value="totalScore" />
	</form>
	<div id="bar" style="display: none"
		class="progress progress-striped active">
		<div class="bar" style="width: 100%;"></div>
	</div>
	<div id="pager"></div>
	<table id="contentTable"
		class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>序号</th>
				<th>绩效总评ID</th>
				<th>被评价者</th>
				<th>部门</th>
				<th>效能</th>
				<th>专业</th>
				<th>上级评价</th>
				<th>客户满意</th>
				<th>总分</th>
				<th>总评分级</th>
				<th>时间</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody id="tbody">
		</tbody>
	</table>

	<script type="text/x-jquery-tmpl" id="tmplList">
		{{each(i,p) data.content}}
				<tr>
					<td>@{i+1}</td>
					<td>@{p.id}</td>
					<td>@{p.beEvaluatedName}</td>
					<td>@{p.departmentName}</td>
					<td>@{p.efficiencyScore}</td>
					<td>@{p.specialtyScore}</td>
					<td>@{p.leaderAssessmentScore}</td>
					<td>@{p.satisfactionScore}</td>
					<td>@{p.totalScore}</td>
					<td>@{p.totalGrade}</td>
					<td>@{formatDate(p.createTime)}</td>
					<td><a href="detail/@{p.id}">查看</a></td>
				</tr>
		{{/each}}
	</script>
	<script type="text/javascript">
		var pageSize = 10;
		$(function() {
			validate();
			$("#queryForm").submit();
			$("#btnExport")
					.click(
							function() {
								$("#bar").css("display", "block");
								var queryData = $("#queryForm").serialize();
								$
										.ajax({
											type : "POST",
											url : "${ctx}/admin/performanceEvaluation/export",
											data : queryData,
											success : function(data) {
												//	alert(data);
												$("#bar")
														.css("display", "none");
												var url = "${ctx}/admin/performanceEvaluation/download?fileName="
														+ data;
												window.open(url);
											}
										});
							})
		})
		function formatDate(times) {
			var date = new Date(times);
			var fm = date.format('yyyy-MM');
			return fm;
		}
		function getData(pageIndex) {
			var queryData = $("#queryForm").serialize();
			pageIndex = pageIndex - 1;
			queryData = queryData + "&pageIndex=" + pageIndex + "&pageSize="
					+ pageSize;
			var sort = "totalScore";
			$.ajax({
				type : "POST",
				url : "${ctx}/admin/performanceEvaluation",
				data : queryData,
				success : function(data) {
					if (data == null || data.records == 0) {
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
					pager.pageIndex = data.number + 1;//当前页码
					pager.pageSize = data.size;//页大小
					pager.totalCount = data.totalElements;//总条数
					pager.totalPage = data.totalPages;//总页数
					$("#pager").html(pager.creat());
				}
			});
		};
	</script>
	<script type="text/javascript">
		function validate() {
			$("#queryForm").validate({
				rules : {
					id : {
						digits : true
					},
					leaderAssessmentScore : {
						number : true
					},
					efficiencyScore : {
						number : true
					},
					specialtyScore : {
						number : true
					},
					satisfactionScore : {
						number : true
					},
					totalScore : {
						number : true
					},
				//createTime:{date:true}
				},
				messages : {
					leaderAssessmentScore : {
						number : "必须是数字"
					},
					efficiencyScore : {
						number : "必须是数字"
					},
					specialtyScore : {
						number : "必须是数字"
					},
					satisfactionScore : {
						number : "必须是数字"
					},
					totalScore : {
						number : "必须是数字"
					}
				},
				submitHandler : function(form) {
					//alert("submitHandler:function");
					getData(1);
				}
			});
		}
	</script>
	<script src="${ctx}/static/My97/WdatePicker.js"></script>
</body>
</html>
