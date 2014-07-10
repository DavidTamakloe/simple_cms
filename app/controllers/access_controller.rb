class AccessController < ApplicationController
	layout 'admin'

   before_action :confirm_logged_in, :except => [:login, :attempt_login, :logout]
    
   def index
   	#display text and links
   
   end

   def login
      @adminuser = AdminUser.find(1)
   	#display login form
   end

   def attempt_login
   	if params[:username].present? && params[:password].present?
   		found_user = AdminUser.where(:username => params[:username]).first
   		if found_user
   			authorized_user = found_user.authenticate(params[:password])
   		end
   	end
   	if authorized_user
   		# mark user as loggedin 
   		session[:user_id] = authorized_user.id 
   		session[:username] = authorized_user.id
   		flash[:notice] = "you are now logged in."
   		redirect_to(:action => 'index')
   	else
   		flash[:notice] = "Invalid username/password combination."
   		redirect_to(:action => 'login')
    end
   end

   def logout
   	# mark user as logged out
   	session[:username] = nil
   	session[:user_id] = nil
   	flash[:notice] = "Logged out"
   	redirect_to(:action => "login")
   end


 private

 def confirm_logged_in
 	unless session[:user_id]
 		flash[:notice]="Please log In"
 		redirect_to :action => 'login'
 		return false
 	else
 		return true
    end
 end

end
