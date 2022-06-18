class Admin::PostsController < ApplicationController

  def index
   @post = Post.all
  end

  def show
   @post = Post.find(params[:id])
  end

  def edit
   @post = Post.find(params[:id])
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
