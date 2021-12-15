class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: :create
  before_action :configure_account_update_params, only: :update

  def create
    super
  end

  def update
    super
  end

  protected

  def configure_sign_up_params
    added_attrs = [:name, :phone, :email, :password,
      :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit(:sign_up, keys: added_attrs)
  end

  def configure_account_update_params
    added_attrs = [:name, :phone, :email, :password,
      :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit(:account_update, keys: added_attrs)
  end
end
