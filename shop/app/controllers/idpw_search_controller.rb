class IdpwSearchController < ApplicationController
  def index
  end
  
  def id_search
  end

  def id_search_result
  	p = params[:search]
	@member = Member.find_by_Email(p[:Email])

	if @member
		
	else
		flash.now[:alert] = "이메일이 존재하지 않습니다."
		render 'id_search'
	end
  end

  def pw_search_result
  	require 'rubygems'
	require 'mail'

	p = params[:search]
	@member = Member.find_by_User_id(p[:User_id])

	if @member
		if @member.Email == p[:Email]
			rand_pw = rand(100000..999999)
			email = @member.Email
			title = "12번가 비밀번호가 변경되었습니다."
			content = "변경된 비밀번호는"
			content += rand_pw.to_s
			content += "입니다."
			
			Mail.defaults do
				delivery_method :smtp, {
					:address => 'smtp.gmail.com',
					:port => '587',
					:domain => 'gmail.com',
					:user_name => '12stmember@gmail.com',
					:password => '123456456',
					:authentication => :plain,
					:enable_starttls_auto => true
				}
			end
			Mail.deliver do
				from '12stmember@gmail.com'
				to email
				subject title
				body content
			end
			@member.Password = rand_pw
			@member.save
			

		else
			flash.now[:alert] = "이메일을 확인하세요."
		end
	else
		flash.now[:alert] = "아이디가 존재하지 않습니다."
		render 'pw_search'
	end
  end

  def pw_search
  end
end
