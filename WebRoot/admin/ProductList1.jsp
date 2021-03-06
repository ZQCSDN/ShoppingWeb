<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="product.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="category.*,java.util.*"  %>

<%
	request.setCharacterEncoding("utf8");
	final int pageSize=5;
	int pageNo=1;
	String strPageNo=request.getParameter("pageNo");
	if(strPageNo !=null && !strPageNo.trim().equals(""))
	{
		try
		{
			pageNo=Integer.parseInt(strPageNo);
		}
		catch(NumberFormatException e)
		{
			pageNo=1;
		}
	}
	if(pageNo<0)
	{
		pageNo=1;
	}
	

	List<Product> products=new ArrayList();
	int totalRecords=ProductMgr.getInstance().getProducts(products,pageNo,pageSize);	
	int totalPages=(totalRecords-1)/pageSize+1;
	if(pageNo>totalPages)
	{
		pageNo=totalPages;
	}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" >
		<link rel="shortcut icon" href="/Gouwu/images/icon/yscx.ico" type="image/x-icon"/>
	  	<title>艺术创想校园管理中心</title> 
	    <link rel="stylesheet" type="text/css" href="/Gouwu/css/base.css"> 
		<style type="text/css">
			hr{		
				border:none;
				border-top:1px dashed #03a9f4;
			}
			.input{
				border:none;
				width:50px;
				color:#03a9f4;
				font-size:16px;
				text-align:center;
			}
		</style>
		<script type="text/javascript">
		//checkbox有两个值，勾选为真，不勾选为假
			window.onload=function()
			{
				var checkboxs=document.getElementsByName("delete");
				//getElementByName在火狐浏览器是可以用的
				//checkbox中的checked属性值有true与false，true也可以是true
				var deleteall=document.getElementById("deleteall");
				deleteall.onclick=function()
				{
					if(this.checked==true)
					{
						
						for(var i=0;i<checkboxs.length;i++)//用var进行定义
						{
							checkboxs[i].checked=true;
						}
					}
					else
					{
						for(var i=0;i<checkboxs.length;i++)//用var进行定义
						{
							checkboxs[i].checked=false;
						}
					}
				}
			}
		</script>
		
		<script type="text/javascript">
			var request;
			function changeToInputNP(id)
			{
				var productid=document.getElementById(id);
				var value=productid.value;
				productid.outerHTML="<input type='text' style='color:#03a9f4' id='"+id
								   +"' value='"+value+"' size='5' onblur='changeNP(this.id)' />";
				document.getElementById(id).focus();			
			}
			function changeToInputMP(name)
			{
				var productids=document.getElementsByName(name);
				var productid=productids[0];
				var value=productid.value;
				productid.outerHTML="<input type='text' style='color:#03a9f4' name='"+name
								   +"' value='"+value+"' size='5' onblur='changeMP(this.name)' />";
				document.getElementsByName(name)[0].focus();			
			}	
			
			function changeNP(id)
			{
				var productid=document.getElementById(id);
				var value=productid.value;//获得已经修改过后的价格
				var url="ChangePrice1.jsp?id="+escape(id)+"&normalprice="+value;
				
				init();
				request.open("post", url, true);
				request.onreadystatechange=function()
				{
					if(request.readyState==4 && request.status==200)
					{
						productid.outerHTML="<input type='text' style='border:none;font-size:16px;width:50px;color:#03a9f4;color:#03a9f4;text-align:center;'"
											+" id='"+ id +"' value="+value+" onclick='changeToInputNP(this.id)'></input>";
					}
				}
				request.send(null);
				alert("修改价格成功！");
			}
			function changeMP(name)
			{
				var productids=document.getElementsByName(name);
				var productid=productids[0];
				var value=productid.value;
				var url="ChangePrice1.jsp?id="+escape(name)+"&memberprice="+value;
				
				init();
				request.open("post", url, true);
				request.onreadystatechange=function()
				{
					if(request.readyState==4 && request.status==200)
					{
						productid.outerHTML="<input type='text'style='border:none;width:50px;font-size:16px;color:#03a9f4;text-align:center;'"
											+" name='"+ name +"' value="+value+" onclick='changeToInputMP(this.name)'></input>";									
					}
				}
				request.send(null);
				alert("修改会员价格成功！");
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
	<body>
		<%@ include file="AdminNav.jsp" %>
	  
		<div class="heia wida" style="padding:8% 5% 5% 5%;">
			<div class="boxs10 widpc90 borr10 padpc5">
				<div class="flol colb fonts20 fontw700 martb10" style="margin-left:25px;">
					课程列表
				</div>				
				<div class="flor fonts16" style="margin-right:30px;margin-top:20px; ">
					<a href="ProductAdd1.jsp" style="color:#fff;padding:3px 8px;" 
					   class="borr5 boxs5 backgb">添加新课程</a>
				</div>						
				<div class="pad10 borr10" style="margin-bottom:30px; ">
					<table class="widpc100">
						<tr>	
							<td></td>			
							<td class="colgy">课程名称</td>
							<td class="colgy">课程描述</td>
							<td class="colgy">价格</td>
							<td class="colgy">会员价格</td>					
							<td class="colgy">所属类别</td>
							<td class="colgy">上架时间</td>
							<td></td>
						</tr>
						<tr><td colspan="8"><hr></td></tr>
						<%
							for(int i=0;i<products.size();i++)
							{
								Product p=products.get(i);//集合取出的方式是 get，数组取出方式是[]
								Category c=ProductMgr.getInstance().getCategory(p.getCategoryId());
								//通过产品类别的id号，取得产品类别，进而获取类别属性
						%>
						<tr>
							<td style="width:100px;">
								<a name="modify" href="ProductModify1.jsp?id=<%= p.getId() %>&action=modify">						
									<img src="/Gouwu/images/product/<%= p.getId()+".jpg" %>" class="borr10 boxs5"
									 	  style="height:80px;width:80px;" 
									 	  onerror="javascript:this.src='/Gouwu/images/product/yscx.png'"/>	
								</a> 	  				
							</td>				
							<td style="width:150px;" class="colb fontw700">
								<%= p.getName() %>
							</td>
							<td style="width:300px;" class="textl">					
								<%= p.getDescribe() %>					
							</td>
							<td style="width:80px;">						
								<input type="text" id="<%= p.getId() %>" onclick="changeToInputNP(this.id)" 
								    value="<%= p.getNormalPrice() %>" style="width:50px;" class="textc fonts16 colb input" >
							    </input>
							</td>
							<td style="width:80px;">
								<input type="text" name="<%= p.getId() %>" onclick="changeToInputMP(this.name)" 
									value="<%= p.getMemberPrice() %>" style="width:50px;" class="textc fonts16 colb input">
								</input>
							</td>					
							<td style="width:80px;">
								<% 
									if(c.getName()==null)
									{
										out.println("/");
									}
									else
									{
										out.println(c.getName());
									}
								%>
							</td>
							<td style="width:100px;" class="fonts14">
								<%= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(p.getDate()) %>
							</td>
							<td style="">
							
								<a name="modify" href="ProductModify1.jsp?id=<%= p.getId() %>&action=modify" 
								   style="padding:3px 8px;color:#fff;" class="backgb borr5 boxs5">修改</a>
								   &nbsp;
								<a name="delete1" href="ProductDelete1.jsp?id=<%= p.getId() %>&parameter=1" 
								   onclick="return confirm('真的要删除吗？')" class="borr5 boxs5 backgb" 
								   style="padding:3px 8px;color:#fff;">删除</a>			
							</td>
						</tr>
						<tr><td colspan="8"><hr></td></tr>							
						<%
							}
						%>				
					</table>		
				</div>				
				<form name="form1" method=post action="ProductList1.jsp" style="float:left" >
					<select name="pageNo" onchange="document.form1.submit()" class="textc" >
						<% 
							for(int i=1;i<=totalPages;i++)
							{
						%>
							<option value=<%=i%> <%=(pageNo==i)?"selected":""%>>第<%=i%>页</option>
						<%
							}
						%>
					</select>
				</form>
				<div style="margin-left:33%;" class="flol">
					<a href="ProductList1.jsp?pageNo=<%
									if(pageNo-1>0)
									{
										out.println(pageNo-1);
									}
									%>" class="boxs5 borr5 colgys" style="padding:3px 8px 3px 8px;">上一页</a>
						<%
							int a=1,b=totalPages;//如果不符合以下两个if,那么a=1,b==totalpages,此时
							int m=0;
							m=check(pageNo);
							if(totalPages>10 && m==0)
							{
								a=1;
								b=10;
							}
							else if(totalPages>10 && m>=1)
							{
								a=1+m*10;
								b=(m+1)*10;
								if(b>totalPages)
								{
									b=totalPages;
								}	
							}
							for(int i=a;i<=b;i++)
							{
						%>
							<a href="ProductList1.jsp?pageNo=<%= i %>" class="fonts18" 
								style="color:#03a9f4;margin-left:15px;"><%= i %></a>
						<%
							}
						%>
					<a href="ProductList1.jsp?pageNo=<%
									if(pageNo+1<=totalPages)
									{
										out.println(pageNo+1);
									}
									%>" class="boxs5 borr5 colgys pad5" 
						style="margin-left:15px;padding:3px 8px 3px 8px;">下一页</a>	
				</div>				
				<form name="form2" method=post action="ProductList1.jsp" style="float:right" >
					<input type="text" name="pageNo" class="textc" value="<%= pageNo %>" size=6 />
					<input type="submit" name="submit" value="Go" />
				</form>
			</div>	
		</div>
		
		<%@ include file="/Footer.jsp" %>				
	</body>
</html>





