class CommentsController < ApplicationController


  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comments_params)
    @comment.user_id = current_user.id
    @comment.save

      if (@comment.save)
        f.html { redirect_to home_path, notice: "comment created!" }
      else
        render 'new'
      end

  end


  def show
  end

  def destroy
  end

  private

  def comments_params
    params.(:comment).permit(:content)
end
