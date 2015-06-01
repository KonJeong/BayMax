class SellerNoticeController < ApplicationController
  include ApplicationHelper

  def index
   @notice = Notice.where("Seller_id is ?", current_user[:User_id]).all
   @current_page = 1
   @totalCnt = @notice.count
   @totalPageList = getTotalPageList(@totalCnt, rowsPerPage)

   i = 0
   list_cnt = 10
   @ListArr = []
   while i * list_cnt < @totalCnt
   	@ListArr.push(i+1)
	i += 1
   end
   if params[:current_page].present?
   	 @current_page = params[:current_page]
   else
   	 @current_page = 1
   end

   offs = @current_page.to_i - 1
   offs = offs * list_cnt
   @noticeList = @notice.order('created_at DESC').limit(list_cnt).offset(offs)
  end

  def show
  end	

  def new
  end

  def create
  	@notice = Notice.new
	p = params[:notice]	
	@notice.Seller_id = current_user[:User_id]
	@notice.Title = p[:Title]
	@notice.Price = p[:Price]
	@notice.Sex = p[:Sex]
	@notice.Age = p[:Age]
	@notice.Category = p[:Category]
	@notice.picture = p[:picture]
	@notice.Deliver_charge = p[:Deliver_charge]
	@notice.Sell_count = 0

	if @notice.save
		flash[:success] = "Notice is created!"
		redirect_to seller_notice_index_path
	else
		flash[:error] = "Failed to create seller notice!"		
	end
	
  end
  
  def edit
   @notice = Notice.find(params[:id])
  end
  
  def update
	
	p = params[:notice]

	@notice = Notice.find(p[:id])

	if p[:picture] != nil
		@notice.picture = p[:picture]
	end
	if p[:Title] != ''
		@notice.Title = p[:Title]
	end
	if p[:Price] != nil
		@notice.Price = p[:Price]
	end
	if p[:Deliver_charge] != nil
		@notice.Deliver_charge = p[:Deliver_charge]
	end
	if p[:Sex] != nil
		@notice.Sex = p[:Sex]
	end
	if p[:Age] != nil
		@notice.Age = p[:Age]
	end

	@notice.Category = p[:Category]

	if @notice.save
		redirect_to seller_notice_index_path
	else
		render 'edit'
	end
	
  end
  
  def destroy
  	@notice = Notice.find_by_id(params[:id])
	@notice.destroy

	redirect_to seller_notice_index_path
  end

  private
		def notice_params
			params.require(:notice).permit(:Seller_id, :Title, :Price, :Sex, :Age, 
					:Category, :picture, :Sell_count, :Deliver_charge)
		end
end
