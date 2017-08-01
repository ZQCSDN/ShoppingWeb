package product;

import category.Category;

import java.util.Date;

public class Product {

	private int id;
	private String name;
	private String describe;
	private double normalPrice;//�۸�һ����double
	private double memberPrice;
	private Date pdate;
	private int categoryId;
	private Category category;
	
	public void setId(int id)
	{
		this.id=id;
	}
	public void setName(String name)
	{
		this.name=name;
	}
	public void setDescribe(String describe)
	{
		this.describe=describe;
	}
	public void setNormalPrice(double normalPrice)
	{
		this.normalPrice=normalPrice;
	}
	public void setMemberPrice(double memberPrice)
	{
		this.memberPrice=memberPrice;
	}
	public void setDate(Date pdate)
	{
		this.pdate=pdate;
	}
	public void setCategoryId(int categoryId)
	{
		this.categoryId=categoryId;
	}
	
	
	public int getId()
	{
		return id;
	}
	public String getName()
	{
		return name;
	}
	public String getDescribe()
	{
		return describe;
	}
	public double getNormalPrice()
	{
		return normalPrice;
	}
	public double getMemberPrice()
	{
		return memberPrice;
	}
	public Date getDate()
	{
		return pdate;
	}
	public int getCategoryId()
	{
		return categoryId;
	}
	
	
	public void setCategory(Category category)
	{
		this.category=category;
	}
	public Category getCategory()
	{
		return category;
	}
	

	
	
}
