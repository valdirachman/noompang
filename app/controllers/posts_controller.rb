class PostsController < ApplicationController
  before_action :set_post, only: [:destroy]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id # assign the post to the user who created it
    respond_to do |f|
      if (@post.save)
        f.html { redirect_to home_ride_requests_path, notice: "Ride created!" }
        friends = current_user.friends
        friends.each do |friend|
        PostMailer.delay.post_email(friend, @post)
        end
      else
        f.html { redirect_to home_ride_requests_path, notice: "Error: Ride Not Saved."}
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to home_path, notice: 'Ride was successfully deleted.' }
    end
  end

  def repost
    post = Post.find(params[:id])
    flash[:notice] = post.repost_by(current_user)
    redirect_to(:back)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end
  def post_params
    params.require(:post).permit(:user_id, :from, :destination, :note, :date, :time)
  end
end
