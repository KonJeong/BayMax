module SessionsHelper
	
	# Logs in the given user.
	def log_in(user)
		session[:user_id] = user.id
	end

	def chk_class
		if session[:user_id]
			@chk_class = Member.find_by(id: session[:user_id])[:Class]
		end
	end

	# Returns the current logged-in user (if any).
	def current_user
		@current_user ||= Member.find_by(id: session[:user_id])
	end

	def logged_in?
		!current_user.nil?
	end

	def log_out
		session.delete(:user_id)
		@current_user = nil
	end
end
