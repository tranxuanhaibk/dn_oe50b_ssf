class SessionsController < ApplicationController
  def new
    redirect_to root_url if current_user
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate params[:session][:password]
      check_activated user
    else
      flash[:danger] = t "email_password_invalid"
      redirect_to action: :new
    end
  end

  def destroy
    log_out if logged_in?

    redirect_to root_url
  end

  private

  def check_activated user
    if user.activated
      login user
      redirect_back_or user
    else
      flash[:warning] = t ".warning"
      redirect_to root_url
    end
  end
end
