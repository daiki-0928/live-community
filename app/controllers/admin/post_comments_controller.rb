class Admin::PostCommentsController < ApplicationController

  def destroy
    @post_comment = PostComment.find_by(id: params[:id], post_id: params[:post_id])
    @post = Post.find(params[:post_id])
    if @post_comment.destroy
      redirect_to admin_post_path(@post), notice: "コメントを削除しました。"
    end
  end

end