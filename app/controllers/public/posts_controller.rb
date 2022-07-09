class Public::PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true).page(params[:page]).per(6).order(created_at: "DESC")
    @genres = Genre.all
  end

  def show
    @post = Post.find(params[:id])
    @post_comments = @post.post_comments.page(params[:post_comment_page]).per(5).order(created_at: "DESC")
    @post_comment = PostComment.new
  end

  def new
    @post = Post.new
    @genres = Genre.all
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @genres = Genre.all

    if @post.save
      redirect_to post_path(@post), notice: "投稿しました。"
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    @genres = Genre.all
  end

  def update
    @post = Post.find(params[:id])
    @genres = Genre.all
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "投稿を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      redirect_to user_path(current_user), notice: "投稿を削除しました。"
    else
      render :edit
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :genre_id)
  end

  def ensure_correct_user
    @post = Post.find(params[:id])
    unless @post.user == current_user
      redirect_to posts_path, notice: "権限がありません。"
    end
  end

end
