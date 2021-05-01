class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  
  def logged_in_user(url)
    unless logged_in?
      store_location
      flash[:danger] = "ログインしてください。"
      redirect_to url
    end
  end
  
  def correct_user(url)
    flash[:danger] = "権限がありません。"
    redirect_to(url) unless current_user?(@user)
  end
  
  def admin_user
    redirect_to root_url unless current_user.nil? || current_user.admin?
  end
    
end
