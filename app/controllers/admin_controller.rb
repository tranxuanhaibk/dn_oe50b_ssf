class AdminController < ApplicationController
  before_action :check_login
  before_action :check_admin

  private

  def check_login
    return if logged_in?

    flash[:warning] = t "admin.check_login.warning"
    redirect_to login_path
  end

  def check_admin
    return if current_user.admin?

    flash[:warning] = t "admin.check_admin.warning"
    redirect_to root_path
  end
end
