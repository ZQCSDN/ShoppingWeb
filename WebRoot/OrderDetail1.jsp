<%@ page import="category.CategoryService"%>
<%@ page import="category.Category"%>
<%@ page import="product.Product"%>
<%@ page import="order.SalesItem"%>
<%@ page import="java.util.List"%>
<%@ page import="order.SalesOrder"%>
<%@ page import="order.OrderMgr"%>
<%@ page import="client.CartItem"%>
<%@ page import="client.Cart"%>
<%@ page import="user.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%
	request.setCharacterEncoding("utf8");
	User u=(User)session.getAttribute("user");
	if(u == null)
	{
		response.sendRedirect("UserLogin1.jsp");
		return;
	}
	
	String orderIdStr=request.getParameter("orderId");
	SalesOrder so=null;
	
	if(orderIdStr != null)
	{
		int orderId=Integer.parseInt(orderIdStr);
		so=OrderMgr.getInstance().loadById(orderId);
	}
	
	String [] payset={"其他","微信支付","支付宝支付"};
	List<SalesItem> items=OrderMgr.getInstance().getSalesItems(so);
	
	double sum=0.0;
	for(int i=0;i<items.size();i++)
	{
		SalesItem si=items.get(i);
		Product p=si.getProduct();
		sum=sum+p.getNormalPrice()*si.getCount();
	}
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link rel="shortcut icon" href="/Gouwu/images/icon/yscx.ico" type="image/x-icon"/>
		<title>艺术创想</title>
		<link type="text/css" rel="stylesheet" href="/Gouwu/css/base.css" />
		<style type="text/css">
			hr{		
			 border:none;
			 border-top:1px dashed #03a9f4;
			}
		</style>
	</head>
	<body >
		<%@ include file="Nav.jsp" %>
	
		<div style="padding:10% 5% 5% 5%;">
			<div class="boxs10 borr10">	
				<div class="backgb" style="height:50px;width:50px;padding-left:5px;padding-top:5px;">
					<img src="/Gouwu/images/background/info.png" />
				</div>
				
				<div class="pad20">	
					<table style="margin-top:2%;padding-left:10px;padding-right:10px;margin-bottom:3%;">
						<tr>
							<td class="colb fonts20 fontw700 textl" colspan=5 style="margin-left:13px;">
								收货地址
							</td>
						</tr>
						<tr>
							<td class="textc" style="width:150px;"><%= u.getUsername() %></td>
							<td class="wid200 textl"><%= u.getAddress() %></td>
							<td class="wid100 textl"><%= u.getPhone() %></td>
						</tr>
					</table>
					
					<div class="padtbpc2" style="margin-bottom:5%;">
						<div class="colb fonts20 fontw700 textl" style="margin-bottom:20px;margin-left:13px;">					
							支付信息						
						</div>
						<div class="flol" style="margin-left:13px;">
							实付金额：<b class="colr">¥ <%= sum %></b>
						</div>
						<div class="flol" style="margin-left:435px;">
							支付方式：<%= payset[so.getPaySet()] %>
						</div>
					</div>
					
					<table class="widpc100" style="padding-left:10px;padding-right:10px; ">
						<tr>
							<td class="colb fonts20 fontw700 textl" colspan=5 style="margin-left:13px;">
								报名详情
							</td>
						</tr>
						<tr>
							<td></td>
							<td>课程名称</td>
							<td>课程价格</td>
							<td>购买数量</td>
							<td>总价</td>
						</tr>
						<tr><td colspan="5"><hr></td></tr>
						<%
							for(int i=0;i<items.size();i++)
							{
								SalesItem si=items.get(i);
								Product p=si.getProduct();
						%>
						<tr>					
							<td style="width:100px;">						
								<img src="images/product/<%= p.getId()+".jpg" %>" 
									 class="borr10" style="height:100px;width:100px;" />						
							</td>
							<td class="fonts20 wid200" >
								<%= p.getName() %>
							</td>
							<td class="colgys fonts20" style="width:150px;" id="normalprice<%= i %>">
								¥ <%= p.getNormalPrice() %>
							</td>
							<td class="wid100 fonts20">
								<%= si.getCount() %>
							</td>
							<td class="colgys fonts20" style="width:150px;" id="itemtotal<%=i %>" name="itemtotal">
							¥ <%= p.getNormalPrice()*si.getCount() %></td>					
						</tr>	
						<tr><td colspan="5"><hr></td></tr>					
						<%
							}
						%>
					</table>				
				</div>			
			</div>
			<a href="Orderstatus1.jsp" class="flor marpc1 backgb padlr30 boxs5 textc borr5" 
			   style="margin-right:30px;padding-bottom:5px;padding-top:5px;color:#fff;" >
				返回
			</a>
		</div>
		
		<%@ include file="Footer.jsp" %>
	</body>
</html>