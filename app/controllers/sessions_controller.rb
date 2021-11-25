class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate params[:session][:password]
      check_activated user
    else
      flash.now[:danger] = t ".invalid"
      render :new
    end
  end

  def destroy
    log_out if logged_in?

    redirect_to root_url
  end

  def check_activated user
    if user.activated
      log_in user
      redirect_back_or user
    else
      flash[:warning] = t ".warning"
      redirect_to root_url
    end
  end
end
