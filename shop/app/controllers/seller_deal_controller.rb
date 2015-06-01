class SellerDealController < ApplicationController
  include ApplicationHelper

  def index
  	@deal = Deal.where("Seller_id is ?", current_user[:User_id])
	@current_page = 1
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
	@dealList = Deal.select("deals.*, products.Name").joins("LEFT OUTER JOIN products ON products.id = deals.Product_id").where("deals.Seller_id is ?", current_user[:User_id])

  end
  
  def update
	@temp = Deal.find_by_id(params[:deal_id])
	@temp.Receipt = params[:deal_receipt]

	if @temp.save
		redirect_to seller_deal_index_path
    	else
	    render 'seller_home#index'
    	end
  end
end
