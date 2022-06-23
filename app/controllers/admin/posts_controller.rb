class Admin::PostsController < ApplicationController

  def index
   @q = Post.ransack(params[:q])
   @posts = @q.result(distinct: true)
   @genres = Genre.all
  end

  def show
   @user = User.find(params[:id])
   @post = Post.find(params[:id])
   @post_comments = @post.post_comments
  end

  def edit
   @post = Post.find(params[:id])
   @genres = Genre.all
  end

  def update
   @post = Post.find(params[:id])
    if @post.update(post_params)
     redirect_to admin_post_path(@post)
    else
     render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      redirect_to admin_user_path(@post.user)
    else
      render :edit
    end
  end

  private

  def post_params
    params.require(:post).permit(:image, :title, :body, :genre_id)
  end
end
