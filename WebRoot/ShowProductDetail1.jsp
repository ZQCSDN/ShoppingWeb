<%@ page import="product.ProductMgr"%>
<%@ page import="product.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%
	String id=request.getParameter("id");
    Product p=null;
    int count=1;
	if(id!= null)
	{
		try
		{
			int productid=Integer.parseInt(id);
			p=ProductMgr.getInstance().getProduct(productid);
		}
		catch(NumberFormatException e)
		{
			e.printStackTrace();
		}
	}
	else
	{
		out.println("<h3>没有您要找的商品！~</h3>");
		return;
	}
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>产品详情</title>
		<link rel="stylesheet" type="text/css" href="/Gouwu/css/base.css" />
		<style type="text/css">
		.button-1{
		 border-radius:50px;
		 width: 200px;
		 text-align: center;
		 padding:5px;
		 margin:0 23px;
		}
		td{
		  text-align:center;
		}
		input{
		  color:#000;
		  font-size: 18px;
		  width: 25%;
		  border-bottom: solid #B5B4B4 1px;
		  margin:auto;
		}		
		</style>
		<script type="text/javascript">
			function aler()
			{
				alert("已成功加入购物车！~");
			}
		</script>	
	</head>
	<body class="padlrpc5">
		<div class="boxs10 heia wida borr20 martbpc5" style="overflow:hidden;padding:5% 8%;">
		   
		    <div class="flol hei400 wid500" style="overflow:hidden;padding-top:50px;">
			    <div>
				  <img src="images/product/<%= p.getId()+".jpg" %>" class="wida" style="height:450px;"/>
				</div>
			</div>
			
			<div class="flol" style="margin-left:10%;width:40%">
				
				<div>	
					<div style="height:50px" class="textc">
						<b class="colgys" style="font-size:40px;"><%= p.getName() %></b>
					</div>
					<div style="height:200px;">
						<p class="textl colgys fonts20" style="padding:0;" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<%= p.getDescribe() %>
						</p>
					</div>
				</div>
				
				<div style="margin-left:15%;">
					<form name="form1" action="Buy1.jsp" method="post">
					<input type="hidden" name="action" value="add"/>
					<input type="hidden" name="id" value="<%= p.getId() %>"/>
					<table>	
						<tr style="height:50px;">
							<td><b class="colr fonts28">¥<%= p.getNormalPrice() %></b></td>
						</tr>
						<tr style="height:50px">
							<td>
								<form name="form2" method="post" action="ShowProductDetail1.jsp">
								<input type="hidden" name="action" value="add"/>
								<input type="hidden" name="id" value="<%= p.getId() %>"/>			
								<b class="fonts20">-&nbsp;</b>
								<input type="text" id="count" name="count" class="textc" value="<%= count %>"/>
								<b>&nbsp;+</b>
								</form>
							</td>
						</tr>
						<tr style="height:50px">
							<td>
								<a href="javascript:document.form2.submit()" onclick="aler()" >
									<div class="button-1 backgy" style="cursor:pointer;">				            
							          	<div class="title-text colw" style="font-size:16px;">加入购物车</div>
							        </div>
						        </a>
							</td>
						</tr>
						<tr style="height:50px">
							<td>                      <% 这里的form2也要提交 %>
								<a href="Buy1.jsp" onclick="document.form1.submit();">
									<div class="button-1 backgr" style="cursor:pointer;">				     
							          	<div class="title-text colw" style="font-size:16px;">立刻下单</div>
							        </div>
								</a>
							</td>
						</tr>				
					</table>
					</form>
		    	</div>
		    	
		   </div>
		 </div>	
	</body>
</html>