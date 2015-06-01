class ShoppingbagController < ApplicationController
  def index
	@shoppingbag = Shoppingbag.select("shoppingbags.*, notices.picture").joins("LEFT OUTER JOIN notices ON shoppingbags.Notice_id = notices.id").where("User_id is ?", current_user[:User_id])
	@total_product_price = 0
	@total_deliver_charge = 0
  end

  def create
	@shoppingbag = Shoppingbag.new
	@shoppingbag.Notice_id = params[:param_noticeid]
	@shoppingbag.Notice_title = params[:param_noticetitle]
	@shoppingbag.Product_id = params[:param_product_select_id]
	@shoppingbag.Product_name = params[:param_productname]
	@shoppingbag.Product_num = params[:param_productnum]
	@shoppingbag.Product_price = params[:param_productprice]
	@shoppingbag.Deliver_charge = params[:param_deliver]
	@shoppingbag.User_id = current_user[:User_id]
	@shoppingbag.save
	redirect_to shoppingbag_path
  end

  def destroy
	@shoppingbag_list = Shoppingbag.find(params[:shoppingbag_ids])
	@shoppingbag_list.each do |s|
		@shoppingbag = Shoppingbag.find_by_id(s.id)
		@shoppingbag.destroy
	end

	redirect_to shoppingbag_path
  end

  private
  	def shoppingbag_params
		params.require(:shoppingbag).permit(:Notice_id, :Notice_title, :Product_id, :Product_name, :Product_num,
		:Product_price, :Deliver_charge, :User_id, :picture)
	end
end
