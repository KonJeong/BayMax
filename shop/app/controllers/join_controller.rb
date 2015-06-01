class JoinController < ApplicationController
	def index
	end
	
	def new
		
	end

	def create
		@member = Member.new
		p = params[:member]
		@member.User_id = p[:User_id]
		@member.Name = p[:Name]
		@member.Sex = p[:Sex]
		@member.Birth = p[:Birth]
		@member.Email = p[:Email]
		@member.Phone = p[:Phone]
		@member.Address = p[:Address]
		@member.Mileage = 0
		@member.Class = p[:Class]
		
		id_check = Member.find_by_User_id(p[:User_id])
		if !id_check.nil?
			flash.now[:alert] = "중복된 아이디가 존재합니다."
			render 'new'

		elsif p[:Password] == p[:Password_chk]
			@member.Password = p[:Password]
			if @member.save
				flash.now[:alert] = "회원가입 성공!"
				log_in @member
				render 'new'
			else
				flash.now[:alert] = "회원가입 실패..."
				render 'new'
			end
		else
			flash.now[:alert] = "비밀번호를 다시 확인하세요."
			render 'new'
		end

		#redirect_to root_path

	end

	def edit
		@member = Member.find(params[:id])
	end

	def update
		p = params[:member]
		@member = Member.find_by_User_id(p[:User_id])
		if p[:Password_prev] != @member.Password
			flash.now[:alert] = "비밀번호가 틀렸습니다."
			render 'edit'
		elsif p[:Password] == p[:Password_chk]
			if p[:Password] != ""
				@member.Password = p[:Password]
			end
			@member.Name = p[:Name]
			@member.Sex = p[:Sex]
			@member.Birth = p[:Birth]
			@member.Email = p[:Email]
			@member.Phone = p[:Phone]
			@member.Address = p[:Address]
			@member.Class = p[:Class]
			@member.save
			flash.now[:alert] = "정보가 수정되었습니다."
			
			render 'edit'
		else
			flash.now[:alert] = "비밀번호를 다시 확인하세요."
			render 'edit'
		end
	end

	private
		def member_params
			params.require(:member).permit(:User_id, :Password, :Name, :Sex, :Birth, :Email, :Phone, :Address, :Class)
		end
end
