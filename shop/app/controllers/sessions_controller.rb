class SessionsController < ApplicationController
  include SessionsHelper
  def new
  end

  def create
  	member = Member.find_by(User_id: params[:session][:login_id].downcase)
	#if member && member.authenticate(params[:session][:login_pw])
	#	login member
	#	redirect_to member
	
	if member.nil?
		flash[:danger] = "id fail"
		redirect_to root_path
	elsif member[:Password] == params[:session][:login_pw]
		log_in member
		redirect_to root_path

	else 
  		flash[:danger] = "pw fail"
		redirect_to root_path
	end
  end

  def destroy
  	log_out
	redirect_to root_path
  end
end
