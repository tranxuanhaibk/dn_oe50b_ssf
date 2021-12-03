class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(new create)
  before_action :load_user, except: %i(index new create)
  before_action :correct_user, only: %i(edit update)
  before_action :check_admin, only: :destroy

  def new
    @user = User.new
  end

  def index
    @users = User.paginate page: params[:page],
       per_page: Settings.per_page.users
  end

  def show; end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t ".info"
      redirect_to root_url
    else
      flash[:warning] = t ".warning"
      render :new
    end
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t ".success"
      redirect_to @user
    else
      flash.now[:danger] = t ".danger"
      render :edit
    end
  end

  def destroy
    if @user&.destroy
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".danger"
    end
    redirect_to users_url
  end

  private

  def check_admin
    return if current_user.admin?

    flash[:warning] = t "message.is_admin"
    redirect_to root_path
  end

  def user_params
    params.require(:user)
          .permit(:email, :password, :password_confirmation,
                  :name, :address, :country, :phone)
  end

  def correct_user
    return if current_user?(@user)

    flash[:danger] = t ".danger"
    redirect_to root_url
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user.present?

    flash[:warning] = t ".warning"
    redirect_to root_url
  end
end
