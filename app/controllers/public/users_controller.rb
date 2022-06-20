class Public::UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
     redirect_to user_path(@user.id)
    else
     render :edit
    end
  end

  def confirm
    @user = current_user
  end

  def withdraw
    @user = current_user
    @user.update(is_deleted: false)
    reset_session
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :age, :introduction )
  end
end
