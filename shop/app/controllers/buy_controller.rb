class BuyController < ApplicationController
  def new
	@total_price = 0
	@member = Member.where("User_id is ?", current_user[:User_id])

	if params[:commit] == "삭제하기"
		if params[:shoppingbag_ids]
			redirect_to shoppingbag_delete_path(:shoppingbag_ids => params[:shoppingbag_ids])
		else
			redirect_to shoppingbag_path
		end

	elsif params[:commit] == "주문하기"
		if params[:shoppingbag_ids]
			@shoppingbag = Shoppingbag.find(params[:shoppingbag_ids])
		else
			redirect_to shoppingbag_path
		end

	else
		@notice = Notice.where("id is ?", params[:param_noticeid])
		@product_select= Product.where("id is ?", params[:param_product_select_id])
		@product_num=params[:param_product_num]
	end
  end


  def index
	flash.now[:alert] = "주문완료"
  end

  def create
	@total_price = 0
	
	if params[:shoppingbag_ids]
		@shoppingbag_list = Shoppingbag.find(params[:shoppingbag_ids])
		@shoppingbag_list.each do |s|
			@deal = Deal.new
			p = params[:buy]
			@notice = Notice.find(s.Notice_id)
			@deal.Seller_id = @notice.Seller_id #다른거
			@deal.Buyer_id=current_user[:User_id]
			@deal.Receiptor_name=p[:Receiptor_name]
			@deal.Total_price=s.Product_price + s.Deliver_charge #shoppingbag table에서 상품배송비 더해
			@deal.Product_id=s.Product_id #있음
			@deal.Product_num=s.Product_num #있
			@deal.Message=p[:Message]
			@deal.Phone=p[:Phone]

			if p[:Address]=="pre"
				@deal.Address=p[:Addresspre]
			else
				@deal.Address=p[:Addressnew]
			end

			@deal.Receipt=0
			@deal.Return=0

			@deal.Notice_id = s.Notice_id #있
			@deal.Notice_name = s.Notice_title #있

			@notice.Sell_count = @notice.Sell_count + s.Product_num #

			@product = Product.find(s.Product_id)
			@product.Stock = @product.Stock - s.Product_num #

			@total_price = @total_price + @deal.Total_price

			@deal.save
			@notice.save
			@product.save

			@shoppingbag = Shoppingbag.find(s.id)
			@shoppingbag.destroy
		end

		@member = Member.find_by_User_id(current_user[:User_id])
		@member.Mileage = current_user[:Mileage] - @total_price
		@member.save
	else
		@deal = Deal.new
		p = params[:buy]
		@deal.Seller_id = params[:param_sellerid]
		@deal.Buyer_id=current_user[:User_id]
		@deal.Receiptor_name=p[:Receiptor_name]
		@deal.Total_price=params[:param_totalprice]
		@deal.Product_id=params[:param_productid]
		@deal.Product_num=params[:param_productnum]
		@deal.Message=p[:Message]
		@deal.Phone=p[:Phone]

		if p[:Address]=="pre"
			@deal.Address=p[:Addresspre]
		else
			@deal.Address=p[:Addressnew]
		end

		@deal.Receipt=0
		@deal.Return=0

		@deal.Notice_id = params[:param_noticeid]
		@deal.Notice_name=params[:param_noticename]

		@notice = Notice.find(params[:param_noticeid])
		@notice.Sell_count = @notice.Sell_count + 1

		@product = Product.find(params[:param_productid])
		@product.Stock = @product.Stock - 1

		@member = Member.find_by_User_id(current_user[:User_id])
		@member.Mileage = params[:param_remainmileage]

		@deal.save
		@member.save
		@notice.save
		@product.save
	end

	redirect_to buy_path
  end

  private
  	def deal_params
		params.require(:deal).permit(:Seller_id, :Buyer_id, :Receiptor_name, :Total_price, :Product_id, :Product_num,
		:Message, :Phone, :Address, :Receipt, :Return, :picture, :Notice_id, :Notice_name)
	end
end
