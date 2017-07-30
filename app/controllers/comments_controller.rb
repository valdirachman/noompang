class CommentsController < ApplicationController


  def new
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment.user_id = current_user.id
    @comment = @post.comments.create(comments_params)
    redirect_to home_path, notice: "Comment created!"
  end

  private

  def comments_params
    params.require(:comment).permit(:user_id, :content)
  end
end
