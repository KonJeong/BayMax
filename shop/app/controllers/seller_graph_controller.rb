class SellerGraphController < ApplicationController
  def index
  	@data = [1,2,3,4,5,6,7,8,9,10,11,12]
	
	@seller = Deal.where(:Seller_id => current_user[:User_id])

	@m1 = 0
	@m2 = 0
	@m3 = 0
	@m4 = 0
	@m5 = 0
	@m6 = 0
	@m7 = 0
	@m8 = 0
	@m9 = 0
	@m10 = 0
	@m11 = 0
	@m12 = 0

	@seller.each do |f|
		if Date.parse(f.created_at.to_s) < Date.parse('2015-02-01') #1
 			@m1 += f.Total_price.to_i * f.Product_num.to_i
		elsif Date.parse(f.created_at.to_s) < Date.parse('2015-03-01') #2
			@m2 += f.Total_price.to_i * f.Product_num.to_i
		elsif Date.parse(f.created_at.to_s) < Date.parse('2015-04-01') #3
			@m3 += f.Total_price.to_i * f.Product_num.to_i
		elsif Date.parse(f.created_at.to_s) < Date.parse('2015-05-01') #4
			@m4 += f.Total_price.to_i * f.Product_num.to_i
		elsif Date.parse(f.created_at.to_s) < Date.parse('2015-06-01') #5
			@m5 += f.Total_price.to_i * f.Product_num.to_i
		elsif Date.parse(f.created_at.to_s) < Date.parse('2015-07-01') #6
			@m6 += f.Total_price.to_i * f.Product_num.to_i
		elsif Date.parse(f.created_at.to_s) < Date.parse('2015-08-01') #7
			@m7 += f.Total_price.to_i * f.Product_num.to_i
		elsif Date.parse(f.created_at.to_s) < Date.parse('2015-09-01') #8
			@m8 += f.Total_price.to_i * f.Product_num.to_i
		elsif Date.parse(f.created_at.to_s) < Date.parse('2015-10-01') #9
			@m9 += f.Total_price.to_i * f.Product_num.to_i
		elsif Date.parse(f.created_at.to_s) < Date.parse('2015-11-01') #10
			@m10 += f.Total_price.to_i * f.Product_num.to_i
		elsif Date.parse(f.created_at.to_s) < Date.parse('2015-12-01') #11
			@m11 += f.Total_price.to_i * f.Product_num.to_i
		else
			@m12 += f.Total_price.to_i * f.Product_num.to_i
		end
	end

  end

  def index2
	@notice = Notice.where("Seller_id is ?", current_user[:User_id])
	

  end
end
