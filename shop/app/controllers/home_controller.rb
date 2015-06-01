class HomeController < ApplicationController
	def index
	end
	def create
		if params[:search][:main_search] != ""
			@hot = Hottopic.new
			@hot.Search_word = params[:search][:main_search]
			@hot.Search_date = Time.now
			@hot.save
		end

		redirect_to category_main_path(:search => params[:search][:main_search], :param_category => params[:search][:param_category])
	end
	def show
		@week = Time.now - 7.days
		@hot = Hottopic.select('distinct Search_word, Search_date').where("Search_date > ?", @week)

		@ArrWord = []
		@ArrCnt = []
		@hot.each do |f|
			@total_word = Hottopic.where("Search_word is ?", f.Search_word).count
			@ArrWord.push(f.Search_word)
			@ArrCnt.push(@total_word.to_i)
		end

		# Recommendation

		# Recommendation 데이터
		if logged_in?
			@data = Recommendation.where(:User_id => current_user[:User_id])
			
			if @data[0].nil?
				@recommend_item = Notice.order("Sell_count DESC").limit(5)
			else
				@Sex_max = @data.select("count(Sex) as cnt, Sex").group("Sex").order("cnt DESC")
				@Age_max = @data.select("count(Age) as cnt, Age").group("Age").order("cnt DESC")
				@Category_max = @data.select("count(Category) as cnt, Category").group("Category").order("cnt DESC")
				
				@recommend_item = Notice.where("Sex is ? and Age is ? and Category is ?", @Sex_max[0].Sex, @Age_max[0].Age, @Category_max[0].Category).order("created_at DESC").limit(5)
			end
			
		else
			@recommend_item = Notice.order("Sell_count DESC").limit(5)
		end
	end
end
