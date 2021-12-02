class AdminController < ApplicationController
  before_action :check_login, :check_admin

  private

  def check_login
    return if logged_in?

    flash[:warning] = "message.pls_login"
    redirect_to login_path
  end

  def check_admin
    return if current_user.admin?

    flash[:warning] = t ".warning"
    redirect_to root_path
  end
end
