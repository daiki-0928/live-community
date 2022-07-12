class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).where(is_deleted: false).page(params[:page]).per(6)
  end

  def show
    @user = User.find(params[:id])
    @q = @user.posts.ransack(params[:q])
    @posts = @q.result(distinct: true).where(user_id: @user).page(params[:page]).per(3)
    @genres = Genre.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user)
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to admin_users_path
    else
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :age, :introduction, :is_deleted)
  end
end
