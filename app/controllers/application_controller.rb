class ApplicationController < ActionController::Base
  include SessionsHelper
  include CartsHelper

  before_action :set_locale

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def check_admin
    return if current_user.admin?

    flash[:warning] = t "application.check_admin.warning"
    redirect_to root_path
  end
end
