class SellerArticleController < ApplicationController
  
  include ApplicationHelper
  
  def index
    @articles = Article.where("Seller_id is ?", current_user[:User_id]) 
    @totalCnt = @articles.count
    @current_page = 1
    @totalPageList = getTotalPageList(@totalCnt, rowsPerPage)

    i=0
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
    @articleList = Article.where("Seller_id is ?", current_user[:User_id]).order('created_at DESC')

  end

  def update
    p = params[:article]
  	@article = Article.find_by_id(p[:article_id])
	@article.Reply = p[:article_reply]

	if @article.save
		redirect_to seller_article_path
	end
  end

  private
  	def article_params
		params.require(:article).permit(:User_id, :Seller_id, :Title,
				:Contents, :Reply, :Product_id, :Category)
	end
end
