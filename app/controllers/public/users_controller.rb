class Public::UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :confirm, :out]

  def index
    @q = User.ransack(params[:q])
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @genres = Genre.all

    @q = Post.ransack(params[:q])
    # @q = @user.posts.ransack(params[:q])
    # 投稿一覧
    @posts = @q.result(distinct: true).where(user_id: @user)
    # いいね一覧
    @favorite_posts = @q.result(distinct: true).joins(:favorites).where(favorites: {user_id: @user.id})
    # コメント一覧
    @comment_posts = @q.result(distinct: true).joins(:post_comments).where(post_comments: {user_id: @user.id})
  end

  def edit
    @user = current_user
  end

  def update
     @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "ユーザー情報を更新しました。"
    else
      render "edit"
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
