class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  include SessionsHelper
  
  private
  
  def require_user_logged_in  # 複数のControllerで使いたいメソッドなので、ApplicationControllerに書く
    unless logged_in?
      redirect_to login_url
    end
  end
  
end
