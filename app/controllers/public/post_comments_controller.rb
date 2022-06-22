class Public::PostCommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @post_comment = PostComment.new(post_comment_params)
    @post_comment.user_id = current_user.id
    @post_comment.post_id = @post.id
    @post_comments = @post.post_comments
    if @post_comment.save
      @message = "コメントしました。"
    end
  end

  def destroy
    @post_comment = PostComment.find_by(id: params[:id], post_id: params[:post_id])
    @post = Post.find(params[:post_id])
    @post_comments = @post.post_comments
    if @post_comment.destroy
      @message = "コメントを削除しました。"
    end
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
