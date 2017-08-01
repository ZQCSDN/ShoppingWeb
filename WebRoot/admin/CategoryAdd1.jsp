<%@ page import="category.CategoryService"%>
<%@ page import="category.Category" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>


<%
	request.setCharacterEncoding("utf8");
	String action=request.getParameter("action");
	if(action!=null && action.equals("add"))
	{
		String name=request.getParameter("category");
		String describe=request.getParameter("describe");
		
		Category c=new Category();
		c.setPid(0);
		c.setName(name);
		c.setDescribe(describe);
		c.setGrade(1);
		
		CategoryService service=CategoryService.getInstance();
		service.add(c);
		out.println("恭喜您，添加类别成功！");
		return;
	}
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>添加类别</title>
		<style type="text/css">
			.table{
				border:solid 1px blue;
				border-collapse: collapse;
			}
			td{		
				border:solid 3px #fff1cc;
			}		
		</style>
	</head>
	<body>
		<form action="CategoryAdd1.jsp" method="post"  >
			<input type=hidden name="action" value="add" />
			<table class="table" width="100%" style="border:1px solid #fff1cc;">
				<tr style="border:1px;background-color:#fff1cc;">
					<th colspan=2>添加类别-必填内容</th>
				</tr>
				<tr>
					<td style="border:1px;background-color:#fff1cc;">类别名称：</td>
					<td><input type="text" size=158% name="category" /></td>
				</tr>
				<tr>
					<td style="border:1px;background-color:#fff1cc;">类别描述：</td>
					<td><textarea cols=117% rows=5 name="describe"></textarea></td>
				</tr>				
			</table>
			<input type="submit" name="submit" value="提交" />
		</form>
	</body>
</html>