class CategoryMainController < ApplicationController
	def index
		if params[:search] == ""
			if params[:param_category] == "통합검색"
				@notice = Notice.all
				#@test = "통합모두검색"
			else
				@notice = Notice.where("Category is ?", params[:param_category]).all
				#@test = "조건모두검색"
			end
		elsif !params[:search].present?
			@notice = Notice.where("Category is ?", params[:param_category]).all
			#@test = "category 클릭"
		else
			if params[:param_category] == "통합검색"
				@notice = Notice.where("Title like ?", "%" + params[:search] + "%").all
			else
				@notice = Notice.where("Category is ? and Title like ?", params[:param_category], "%" + params[:search] + "%").all
			end
			#@test = "조건검색어검색"
		end
		@hot_item=@notice.order('Sell_count DESC').limit(5)

		@notice_list = @notice.order('Id DESC')
		@order_lowprice = @notice.order('Price ASC')
		@order_highprice = @notice.order('Price DESC')
	end
end
