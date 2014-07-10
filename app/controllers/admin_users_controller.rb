class AdminUsersController < ApplicationController
  layout 'admin'
  
  before_action :confirm_logged_in
  
  def index
    @admin_users = AdminUser.sorted
  end
  
  def edit
    @admin_user = AdminUser.find(params[:id])
  end
  
  def create
    @admin_user = AdminUser.new(admin_user_params)
    if @admin_user.save
      flash[:notice] = "Admin User created successfully"
      redirect_to :action => 'index'
     else
       flash[:notice] ="Could not create!"
       redirect_to :action => 'new'
    end
  end
  
  def update
   @admin_user = AdminUser.find(params[:id])
   if @admin_user.update(admin_user_params)
     flash[:notice] = "User successfully updated"
     redirect_to :action => 'index'
   else
     flash[:notice] ="error"
     redirect_to :action=> 'edit', :id => params[:id]
   end
  end
  
  def new
    @admin_user = AdminUser.new
  end
  
  def delete
    @admin_user = AdminUser.find(params[:id])
  end
  
  def destroy
    @admin_user = AdminUser.find(params[:id])
    if @admin_user.destroy
      flash[:notice]="User Successfully deleted"
      redirect_to :action=>'index'
    else
      flash[:notice] = "Could not delete user"
      redirdect_to :action=>'delete'
    end
  end
  
  def admin_user_params
    params.require(:admin_user).permit(:first_name, :last_name, :username, :password)
  end
    
    private
    
    def confirm_logged_in
      unless session[:user_id]
        flash[:notice] = "Please login"
        redirect_to :action => 'access_controller/login'
        return false
      else
        return true
      end
    end
    
end
