class MypageController < ApplicationController
	include ApplicationHelper

	def index
	end

	def delete_mypage
		log_out
		@member = Member.find_by_id(params[:id])
		@member.destroy
		redirect_to delete_end_path
	end
	
	def seller_index
	
	end
	
	def delete_seller_mypage
		log_out
		@member = Member.find_by_id(params[:id])
		@member.destroy
		redirect_to delete_end_path
	end

	def mileage
		@member = Member.find_by_id(params[:id])
		@member.Mileage += 100000
		@member.save
		redirect_to root_path
	end

	def delete_end

	end

	def recent

	end

	def user_deal
		@deal = Deal.where("Buyer_id is ?", current_user[:User_id])
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
		@dealList = Deal.select("deals.*, products.Name").joins("LEFT OUTER JOIN products ON products.id = deals.Product_id").where("deals.Buyer_id is ?", current_user[:User_id])
	end

	def user_deal_update
		@temp = Deal.find_by_id(params[:deal_id])
		@temp.Return = params[:deal_return]
		@temp.Receipt = params[:deal_receipt]
	
		if @temp.save
			redirect_to user_deal_path(@temp)
		else
			render 'home#index'
		end
	end
end
