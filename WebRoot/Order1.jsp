<%@page import="order.OrderMgr"%>
<%@page import="order.SalesOrder"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="client.CartItem"%>
<%@page import="client.Cart"%>
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
	
	Cart cc=(Cart)session.getAttribute("cartorder");
	List<CartItem> items=cc.getItems();
	Iterator<CartItem> it=items.iterator();
	while(it.hasNext())
	{
		CartItem ci=it.next();
		int count=ci.getCount();
		//System.out.println(count);
	}
	//System.out.println(u.getAddress());
	
	int orderId=u.buy(cc);
	//买完之后，返回订单号。购买的过程中，将cartItems集合中的多个CartItem传递给商家变成SalesItem
	//组成集合List<SalesItem> salesItems，将这个集合存入订单SalesOrder对象中，返回订单号
	//session.setAttribute("orderId", orderId);
	session.removeAttribute("cartorder");//cart的生命周期结束，销毁

	
	//确认订单的时候，要将购物车中的这些物品删除
	String []ids=(String [])session.getAttribute("checks");
	Cart c=(Cart)session.getAttribute("cart");
	if(c == null)
	{
		c=new Cart();
		session.setAttribute("cart", c);
	}					
	for(int k=0;k<ids.length;k++)
	{
		int id=Integer.parseInt(ids[k]);
		c.deleteItemById(id);
	}
	
	
	String [] paysets=request.getParameterValues("payset");
	String paysetStr=paysets[0];

	//将支付方式存到数据库中
	SalesOrder so=OrderMgr.getInstance().loadById(orderId);
	if(paysetStr != null)
	{
		int payset=Integer.parseInt(paysetStr);
		so.setPaySet(payset);
		OrderMgr.getInstance().update(so);
	}
	response.setHeader("refresh","2;URL=payset.jsp?orderId="+orderId+"&payset="+so.getPaySet());//2秒钟后跳转
	
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link rel="shortcut icon" href="/Gouwu/images/icon/yscx.ico" type="image/x-icon"/>
		<title>艺术创想</title>
		<link rel="stylesheet" type="text/css" href="/Gouwu/css/base.css" />
	</head>
	<body >
		<div class="padpc10">
			<div class="widpc100 textc colb fontw700 fonts22 boxs10 borr20" style="padding-bottom:15%;">
				<div class="backgb" style="height:50px;width:50px;padding-left:2px;padding-top:2px;margin-bottom:10%;">
					<img src="/Gouwu/images/icon/gou1.png" />
				</div>
				<img src="/Gouwu/images/icon/gou.png"/>
				<span style="margin-bottom:12%;">您的订单已成功下单....3秒钟后跳转至支付页面....</span>
			</div>
		</div>
		
		<div class="widpc100 backgbs" style="height:100px;padding-top:30px;background-color:#eafbf6;">
	    	<div class="widpc100 heia">
		    	<div class="flol backgr" style="margin-right:20px;margin-left:45%;border-radius:60%;height:40px;width:40px;">
			    	<a href="" target="_blank" style="position:relative;left:22%;top:22%;">				
						<img src="/Gouwu/images/icon/weibo.png" class="wida" style="height:20px;border-radius:50%">
					</a>
				</div>
				<div class="flol" style="margin-right:20px;border-radius:60%;height:40px;width:40px;background-color:#4867AA;">
					<a href="" target="_blank" style="position:relative;left:20%;top:20%;">				
						<img src="/Gouwu/images/icon/facebook.png" class="wida" style="height:25px;border-radius:50%">
					</a>
				</div>
				<div class="flol backg" style="margin-right:20px;border-radius:60%;height:40px;width:40px;">
					<a href="https://github.com/PioneerR" style="position:relative;left:20%;top:20%;">				
						<img src="/Gouwu/images/icon/github.png" class="wida" style="height:25px;border-radius:50%">
					</a>
				</div>
			</div>
			<div class="flol widpc100 heia martbpc1 fonts14" style="margin-left:38%;">
				Copyright © 2017 艺术创想  Designed by 
				<a href="https://github.com/PioneerR" target="_blank" style="color:#03a9f4;">PioneerR</a>
			</div>
	    </div>

	</body>
</html>


	