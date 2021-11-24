class UsersController < ApplicationController
  before_action :logged_in_user, :load_user, except: %i(new create)
  before_action :correct_user, only: %i(edit update)

  def new
    @user = User.new
  end

  def show; end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t "user_controller.check_email"
      redirect_to root_url
    else
      flash[:warning] = t "user_controller.create_fail"
      render :new
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:success] = t "users_control.update"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user&.destroy
      flash[:success] = t "users_control.destroy.success"
    else
      flash[:danger] = t "users_control.destroy.danger"
    end
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user)
          .permit(:name, :email, :password, :password_confirmation, :phone)
  end

  def correct_user
    redirect_to(root_url) unless current_user?(@user)
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user.present?

    flash[:warning] = t "user_controller.user_not_found"
    redirect_to root_url
  end
end
