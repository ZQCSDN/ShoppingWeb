<%@ page import="category.CategoryService" %>
<%@ page import="category.Category" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>

<%
	request.setCharacterEncoding("utf8");
	int id=Integer.parseInt(request.getParameter("id"));
	Category c=CategoryService.getInstance().loadById(id);
	String action=request.getParameter("action");	
	if(action!=null && action.trim().equals("modify"))
	{
		String name=request.getParameter("category");
		String describe=request.getParameter("describe");
		
		c.setName(name);
		c.setDescribe(describe);
		c.update();			
		
		out.println("<div style='padding:10% 5% 5% 5%;box-shadow:0 0 10px #B5B4B4;border-radius:10px;width:80%;height:200px;margin-left:5%;margin-top:5%;'");
		out.println("<div style=''>");
		out.println("<h2 style='color:#03a9f4;text-align:center;padding:6%;'>"+"修改类别成功！~"+"</h2>");
		out.println("</div></div>");
		
		out.println("<a href='javascript:window.history.go(-2)' style='text-decoration:none;");
		out.println("background:#03a9f4;padding-bottom:5px;padding-top:5px;color:#fff;float:right;");
		out.println("margin:2% 5% 5% 5%;padding-left:30px;padding-right:30px;text-align:center;border-radius:5px;'>");
		out.println("返回</a>");
		return;
	}
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link rel="shortcut icon" href="/Gouwu/images/icon/yscx.ico" type="image/x-icon"/>
  		<title>艺术创想校园管理中心</title> 
    	<link rel="stylesheet" type="text/css" href="/Gouwu/css/base.css"> 			
	</head>
	<body>
		<div style="padding:5% 5% 5% 5%;">
			<div class="boxs10 borr10">	
				<div class="backgb" style="height:50px;width:50px;padding-left:5px;padding-top:5px;">
					<img src="/Gouwu/images/background/info.png" />
				</div>
				
				<div class="pad20 overfh" style="margin-left:100px; ">	
					<div>
						<div class="colb fonts20 fontw700 textl" style="margin-left:13px;">
							修改类别
						</div>						
					</div>	
								
					<form method="post" action="CategoryModify1.jsp" name="form1">
					<input type=hidden name="action" value="modify" />
					<input type=hidden name="id" value="<%= id %>"/>	
					<table style="margin-top:20px;padding-left:10px;padding-right:10px;margin-bottom:3%;">						
						<tr style="">
							<td class="colb fonts16 textl" style="margin-left:13px;">
								类别名称：
							</td>
							<td class="textl" style="width:250px;">
								<input type="text" name=category style="width:390px;" value="<%= c.getName() %>" />
							</td>			
						</tr>
						<tr>
							<td class="colb fonts16 textl" style="margin-left:13px;">
								类别描述：
							</td>							
							<td class="wid100 textl">
								<textarea cols=45px rows=5 name="describe"><%= c.getDescribe() %></textarea>								
							</td>							
						</tr>					
					</table>	
										
				</div>			
			</div>
			<a href="javascript:window.form1.submit()" class="flor marpc1 backgb padlr30 boxs5 textc borr5" 
			   style="margin-right:30px;padding-bottom:5px;padding-top:5px;color:#fff;">
				保存
			</a>
			</form>
			<a href="javascript:window.history.go(-1)" class="flor marpc1 backgw padlr30 colgy boxs5 textc borr5" 
			   style="margin-right:10px;padding-bottom:5px;padding-top:5px;" >
				返回
			</a>
		</div>
	
	</body>
</html>