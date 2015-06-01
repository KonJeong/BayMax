class AdminManageController < ApplicationController
	def member_index
		i = 0
		list_cnt = 5
		@Total = Member.all.count
		@ListArr = []
		while i*list_cnt<@Total
			@ListArr.push(i+1)
			i += 1
		end
		
		if params[:current_page].present?
			@current_page = params[:current_page]
		else
			@current_page = 1
		end

		if params[:flag] != "true" or params[:searchStr] == ''
			offs = @current_page.to_i - 1
			offs = offs*list_cnt
			@memberList = Member.limit(list_cnt).offset(offs)
		else
			@current_page = 1
			@ListArr = []
			if params[:column] == "아이디"
				@memberList = Member.where("User_id is ?", params[:searchStr])
			elsif params[:column] == "이름"
				@memberList = Member.where("Name is ?", params[:searchStr])
			elsif params[:column] == "전화번호"
				@memberList = Member.where("Phone is ?", params[:searchStr])
			else
				@memberList = Member.where("Email is ?", params[:searchStr])
			end
		end
	end
	def search_member
		p = params[:search]
		column = p[:column]
		searchStr = p[:searchStr]
		redirect_to manage_member_path(:searchStr => searchStr, :column => column, :flag => "true")
	end
	def destroy_member
		@member = Member.find_by_User_id(params[:User_id])
		@member.destroy
		redirect_to manage_member_path
	end

	def notice_index
		i = 0
		list_cnt = 10
		@Total = Notice.all.count
		@ListArr = []
		while i*list_cnt < @Total
			@ListArr.push(i+1)
			i += 1
		end

		if params[:current_page].present?
			@current_page = params[:current_page]
		else
			@current_page = 1
		end

		if params[:flag] != "true" or params[:searchStr] == ''
			offs = @current_page.to_i - 1
			offs = offs*list_cnt
			@noticeList = Notice.select("notices.id, notices.Title, members.User_id, members.Name, members.Phone, members.Email").joins("LEFT OUTER JOIN members ON members.User_id = notices.Seller_id").limit(list_cnt).offset(offs)
		else
			@current_page = 1
			@ListArr = []
			if params[:column] == "아이디"
				@noticeList = Notice.select("notices.id, notices.Title, members.User_id, members.Name, members.Phone, members.Email").joins("LEFT OUTER JOIN members ON members.User_id = notices.Seller_id").where("members.User_id is ?", params[:searchStr])
			elsif params[:column] == "이름"
				@noticeList = Notice.select("notices.id, notices.Title, members.User_id, members.Name, members.Phone, members.Email").joins("LEFT OUTER JOIN members ON members.User_id = notices.Seller_id").where("members.Name is ?", params[:searchStr])
			elsif params[:column] == "전화번호"
				@noticeList = Notice.select("notices.id, notices.Title, members.User_id, members.Name, members.Phone, members.Email").joins("LEFT OUTER JOIN members ON members.User_id = notices.Seller_id").where("members.Phone is ?", params[:searchStr])
			else
				@noticeList = Notice.select("notices.id, notices.Title, members.User_id, members.Name, members.Phone, members.Email").joins("LEFT OUTER JOIN members ON members.User_id = notices.Seller_id").where("notices.Title like ?", "%" + params[:searchStr] + "%")
			end
		end
	end
	def search_notice
		p = params[:search]
		column = p[:column]
		searchStr = p[:searchStr]
		redirect_to manage_notice_path(:searchStr => searchStr, :column => column, :flag => "true")
	end
	def destroy_notice
		@notice = Notice.find_by_id(params[:id])
		@notice.destroy
		redirect_to manage_notice_path
	end
end
