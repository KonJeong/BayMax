class NoticeMainController < ApplicationController
	include ApplicationHelper

	def index
		@notice = Notice.find_by_id(params[:param_noticeid])
		
		if logged_in?
			@recommend = Recommendation.new
			@recommend.User_id = current_user[:User_id]
			@recommend.Sex = @notice.Sex
			@recommend.Age = @notice.Age
			@recommend.Category = @notice.Category
			@recommend.Notice_id = @notice.id
			@recommend.save
		end


		
		@notice = Notice.where("id is ?", params[:param_noticeid])
		@current_page = 1
		@totalCnt = Article.where("Notice_id like ?", params[:param_noticeid]).count
		@totalPageList = getTotalPageList(@totalCnt, rowsPerPage)

		@product_list = Product.where("Notice_id is ?", params[:param_noticeid])

		@product_select_id=params[:param_product_select_id]
		@product_select = Product.where("id is ?", params[:param_product_select_id])
		

		if params[:param_ok]
			@product_num=params[:param_product_num]
		else
			@product_num=1
		end
		
		i = 0
		list_cnt = 10
		@ListArr = []
		while i*list_cnt < @totalCnt
			@ListArr.push(i+1)
			i += 1
		end

		if params[:current_page].present?
			@current_page = params[:current_page]
		else
			@current_page = 1
		end


		if params[:q]
			@QnAList = Article.where("Notice_id is ? and Title like ?", params[:param_noticeid], "%" + params[:q] + "%").order('id DESC')
		else
			offs = @current_page.to_i - 1
			offs = offs*list_cnt
			@QnAList = Article.where("Notice_id like ?", params[:param_noticeid]).order('id DESC').limit(list_cnt).offset(offs)
		end
		@ArticleCnt = @QnAList.count
	end

	def new
	end

	def create
		@article = Article.new
		p = params[:article]
		@article.Category = p[:Category]
		@article.User_id = current_user[:User_id]
		@seller = Notice.find_by_id(p[:Notice_id])
		@article.Seller_id = @seller.Seller_id
		@article.Title = p[:Title]
		@article.Contents = p[:Contents]
		@article.Reply = ""
		@article.Notice_id = p[:Notice_id]		

		if @article.save
			redirect_to notice_main_path({:param_noticeid => p[:Notice_id]})
		else
			flash[:error] = "Failed to create seller notice!"
		end
 	end
	
	def destroy
		@article = Article.find_by_id(params[:param_articleid])
		@article.destroy

		redirect_to notice_main_path({:param_noticeid => params[:param_noticeid]})
	end

	private
  		def article_params
			params.require(:article).permit(:User_id, :Seller_id, :Title,
					:Contents, :Reply, :Notice_id, :Category)
		end
end
