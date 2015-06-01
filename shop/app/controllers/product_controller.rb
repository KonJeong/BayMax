class ProductController < ApplicationController
  def index
  	@product = Product.where("Notice_id is ?", params[:param_noticeid]).all
	@productList = @product.order('created_at DESC')
  end

  def show
	@product = Product.where("Notice_id is ?", params[:param_noticeid]).all
	@productList = @product.order('id DESC')
  end

  def new
  end
  
  def create
  	
  	@product = Product.new
	p = params[:product]
	@product.Name = p[:Name]
	@product.Stock = p[:Stock]
	@product.Price = p[:Price]
	@product.Show_picture = p[:Show_picture]
	@product.picture = p[:picture]
	@product.Notice_id = p[:Notice_id]

	if @product.save
		redirect_to product_index_path({:param_noticeid => p[:Notice_id]})
	else
		flash[:error] = "Failed to create product"
	end
  end
 
  def edit
  	@product = Product.find(params[:id])
  end

  def update
	p = params[:product]
	@product = Product.find(p[:id])

	if p[:picture] != nil
		@product.picture = p[:picture]
	end
	if p[:Name] != ''
		@product.Name = p[:Name]
	end
	if p[:Price] != nil
		@product.Price = p[:Price]
	end
	if p[:Stock] != nil
		@product.Stock = p[:Stock]
	end
	
	@product.Show_picture = p[:Show_picture]
	
	if @product.save
		redirect_to product_index_path({:param_noticeid => p[:Notice_id]})
	else
		render 'edit'
	end
  end

  def destroy
  	@product = Product.find(params[:product_id])
	notice_id = @product.Notice_id
	@product.destroy

	redirect_to product_index_path({:param_noticeid => notice_id})
  end

  private
  	def product_params
		params.require(:product).permit(:Name, :Notice_id, :Stock, :Price, :Show_picture, :picture)
	end

end
