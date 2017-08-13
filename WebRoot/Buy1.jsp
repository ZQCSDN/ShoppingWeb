<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.List"%>
<%@ page import="client.CartItem"%>
<%@ page import="client.Cart"%>
<%@ page import="product.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf8");
	Cart c = (Cart)session.getAttribute("cart");//getAttribute获得的是object类
	if(c==null)
	{
		c=new Cart();
		session.setAttribute("cart", c);
	}

	String action=request.getParameter("action");
	if(action !=null && action.trim().equals("add"))
	{
		int id=Integer.parseInt(request.getParameter("id"));
		int count=Integer.parseInt(request.getParameter("count"));
		session.setAttribute("count", count);//为了产品详情页提交表单后数量不变
		Product p=ProductMgr.getInstance().getProduct(id);
		CartItem ci=new CartItem();
		ci.setProduct(p);
		if(count>=0)
		{
			ci.setCount(count);
		}
		else
		{
			ci.setCount(0);
		}
		c.add(ci);
		return;
	}
	if(action != null && action.trim().equals("delete"))
	{
		int id=Integer.parseInt(request.getParameter("id"));
		c.deleteItemById(id);
	}
	if(action !=null && action.trim().equals("update"))
	{
		for(int i=0;i<c.getItems().size();i++)
		{
			CartItem ci=c.getItems().get(i);
			int count=Integer.parseInt(request.getParameter("product"+ci.getProduct().getId()));
			ci.setCount(count);
		}
	}

	
	//String path=request.getContextPath();
	//String basePath=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	int a=0;
	List<CartItem>items=c.getItems();
	Iterator<CartItem> it=items.iterator();
%>



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>购物车</title>
		<link rel="stylesheet" type="text/css" href="/Gouwu/css/base.css" />
		<style type="text/css">
			td{
				text-align:center;
				border-collapse: collapse;
			}
			hr{		
				border:none;
				border-top:1px dashed #03a9f4;
			}
			.button-1{
			 border-radius:20px;
			 width: 100px;
			 text-align: center;
			 padding:5px;
			 margin: 20px;
			 cursor: pointer;
			}
			input{
			  color:#000;
			  font-size: 18px;
			  border:none;
			  width: 25%;
			  margin:auto;
			  background-color:white; 
			}	
		</style>
		<script type="text/javascript">			
			window.onload=function()
			{
				var checks=document.getElementsByName("check");
				var checkall=document.getElementById("checkall");
				checkall.onclick=function()
				{
					if(checkall.checked==true)
					{
						for(var i=0;i<checks.length;i++)
						{
							checks[i].checked=true;
						}
					}
					else
					{
						for(var i=0;i<checks.length;i++)
						{
							checks[i].checked=false;
						}
					}
				}
				
		
				
				
				 
				
				
			}	
		</script>
		<script type="text/javascript">		
			var request;
			function addCartItem(id)
			{
				var s=document.getElementById(id).id;
				var ss=s.split("+");//获得：id值+"+"+i  整个字符串
				var pid=ss[0];//获得id值
				var i=ss[1];//获得i的值
				
				var productid=document.getElementById(pid);						
				var count=document.getElementById(pid).value;
				count++;
				var url="ChangeCartItem1.jsp?productid="+escape(pid)+"&count="+count;
				
				var itemtotal=document.getElementById("itemtotal"+i);
				var normal=document.getElementById("normalprice"+i).innerText;
				var normalprice=normal.substring(1,normal.length);
				
				init();
				request.open("post",url,true);
				request.onreadystatechange=function()
				{
					if(request.readyState==4 && request.status==200)
					{
						productid.outerHTML="<input type='text' id='"+pid+"' class='backgbs textc' name='"
										   +pid+"' value='"+count+"'></input>";									 
					
						itemtotal.innerText="¥ "+parseFloat(normalprice*count).toFixed(1);
					}
				}
				request.send(null);
				//alert(request.readyState);
				//alert(request.status);
			}
			function deleCartItem(id)
			{
				var s=document.getElementById(id).id;
				var ss=s.split("-");
				var pid=ss[0];
				var i=ss[1];
				
				var productid=document.getElementById(pid);						
				var count=document.getElementById(pid).value;
				count--;
				if(count<0){count=0;}
				
				var url="ChangeCartItem1.jsp?productid="+escape(pid)+"&count="+count;
				
				var itemtotal=document.getElementById("itemtotal"+i);
				var normal=document.getElementById("normalprice"+i).innerText;
				var normalprice=normal.substring(1,normal.length);
				
				init();
				request.open("post",url,true);
				request.onreadystatechange=function()
				{
					if(request.readyState==4 && request.status==200)
					{
						productid.outerHTML="<input type='text' id='"+pid+"' class='backgbs textc' name='"
										   +pid+"' value='"+count+"'></input>";									 
					
						itemtotal.innerText="¥ "+parseFloat(normalprice*count).toFixed(1);
					}
				}
				request.send(null);
			}
			
			function init()
			{
				if(window.XMLHttpRequest)
				{
					request=new XMLHttpRequest();
				}
				else if(window.ActiveXObject)
				{
					request=new ActiveXObject("Microsoft.XMLHTTP");
				}
			}
		</script>	
	</head>
	<body class="padpc5"> 
		<div class="backgb flol" style="height:50px;width:50px;padding-left:15px;padding-top:15px;">
			<img src="/Gouwu/images/background/cart.png" />
		</div>
		<div class="pad10 boxs10 borr10">
			<table class="widpc100">
				<tr>
					<td></td>
					<td class="colb fonts20 fontw700">购物车</td>
					<td>产品名称</td>
					<td>产品单价</td>
					<td>购买数量</td>
					<td>订单总价</td>
					<td></td>
				</tr>
				<tr><td colspan="7"><hr></td></tr>
				<%
					for(int i=0;i<items.size();i++)
					{	
						CartItem ci=items.get(i);
						Product p=ci.getProduct();
				%>
				<tr>
					<td style="width:50px;">
						<input type="checkbox" value="" name="check" id="check<%= i %>"/>
					</td>
					<td style="width:200px;">
						<a href="ShowProductDetail1.jsp?id=<%= p.getId() %>">
						 	<img src="images/product/<%= p.getId()+".jpg" %>" class="borr10" style="height:120px;width:120px;" />
						</a>
					</td>
					<td >
						<a class="fonts24 fontw700 wid300" style="color:#03a9f4;" href="ShowProductDetail1.jsp?id=<%= p.getId() %>">
						<%= ci.getProduct().getName() %></a>
					</td>
					<td class="colgys fonts20" style="width:150px;" id="normalprice<%= i %>">
						¥ <%= ci.getProduct().getNormalPrice() %>
					</td>
					<td class="wid200">
						<input type="button" id="<%= p.getId() %>-<%= i %>" class="backgbs borrl10 colw" value="-" 
							   onclick="deleCartItem(this.id)()"/>
						<input type="text" id="<%= p.getId() %>" class="backgbs textc" value="<%= ci.getCount() %>"/>
						<input type="button" id="<%= p.getId() %>+<%= i %>" class="backgb borrr10 colw" value="+" 
							   onclick="addCartItem(this.id)" />
					</td>
					<td class="colgys fonts20" style="width:150px;" id="itemtotal<%=i %>">
					¥ <%= ci.getProduct().getNormalPrice()*ci.getCount() %></td>
					<td >
						<a href="Buy1.jsp?action=delete&id=<%= ci.getProduct().getId() %>" class="colgys fonts22">x</a>
					</td>
				</tr>
				<tr><td colspan="7"><hr></td></tr>
				<script type="text/javascript">
					var number=document.getElementById("number");
					var ii=document.getElementById(<%= i %>).id;
					
					var checki=document.getElementById("check"+ii);
					checki.onclick=function()
					{
						if(checki.checked==true)
						{
							number.innerText++;						
						}
						else if(checki.checked==false)
						{
							number.innerText--;
							if(number.innerText<0)
							{
								number.innerText=0;
							}
						}							
					}
					
				</script>
				<%
					}
				%>
				<tr>
					<td><input type="checkbox" id="checkall" /></td>
					<td>已选择 <b class="colb" id="number"><%= a %></b> 门课程  </td>
					<td class="textl padlr20">删除选中的课程</td>
					<td></td>
					<td class="colgys fonts20">Total</td>
					<td class="colb fonts22 fontw700" id="total">¥ 0.0</td>
					<td></td>
				</tr>
			</table>
			<a href="Confirm1.jsp">
				<span class="button-1 flor colw marlrpc5 backgb">结算</span>
			</a>
		</div>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
		
	</body>
</html>