class SellerReturnController < ApplicationController
  include ApplicationHelper

  def index
	@current_page = 1
	@deal = Deal.where(:Seller_id => current_user[:User_id], :Return => 1..2)
	@totalCnt = @deal.count
	@totalPageList = getTotalPageList(@totalCnt, rowsPerPage)

	i = 0
	list_cnt = 10
	@ListArr = []
	while i * list_cnt < @totalCnt
		@ListArr.push(i + 1)
		i += 1
	end

	if params[:current_page].present?
		@current_page = params[:current_page]
	else
		@current_page = 1
	end

	offs = @current_page.to_i - 1
	offs *= list_cnt
	
	@dealList = Deal.select("deals.*, products.Name, products.picture").joins("LEFT OUTER JOIN products ON products.id = deals.Product_id").where("deals.Seller_id is ?", current_user[:User_id])
  end


  def update
	@temp = Deal.find_by_id(params[:deal_id])
	
        if @temp.Return == 1
          @member = Member.find_by_User_id(params[:buyer_id])
          @member.Mileage += params[:price].to_i
          
          @notice = Notice.find_by_id(params[:notice_id])
          @notice.Sell_count -= 1

          @product = Product.find_by_id(params[:product_id])
          @product.Stock += 1
          @temp.destroy
          @member.save
          @notice.save
          @product.save

          redirect_to seller_return_path
        else
          @temp.Return = 3
          @temp.save

 	  redirect_to seller_return_path(@temp)
        end

       
    	
  end
end
