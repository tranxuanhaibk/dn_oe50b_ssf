class PasswordResetsController < ApplicationController
  before_action :load_user, :valid_user, :check_expiration,
                only: %i(edit update)
  def new; end

  def edit; end

  def create
    @user = User.find_by email: params[:password_reset][:email].downcase
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t "password_resets.create.info"
      redirect_to root_url
    else
      flash.now[:danger] = t "password_resets.create.danger"
      render :new
    end
  end

  def update
    if user_params[:password].empty?
      @user.errors.add :password, t("password_resets.update.error_blank")
      render :edit
    elsif @user.update user_params
      log_in @user
      flash[:success] = t "password_resets.update.success"
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit :password, :password_confirmation
  end

  def load_user
    @user = User.find_by email: params[:email]

    return if @user

    flash[:danger] = t "password_resets.load_user.danger"
    redirect_to root_path
  end

  def valid_user
    if @user.authenticated?(:reset, params[:id])
      return if @user.activated?

      flash[:danger] = t "password_resets.valid_user.danger_activated"
    else
      flash[:danger] = t "password_resets.valid_user.danger_link"
    end
    redirect_to root_path
  end

  def check_expiration
    return unless @user.password_reset_expired?

    flash[:danger] = t "password_resets.check_expiration.danger"
    redirect_to new_password_reset_url
  end
end
