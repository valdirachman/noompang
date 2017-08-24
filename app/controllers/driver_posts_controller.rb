class DriverPostsController < ApplicationController
  before_action :set_post, only: [:destroy]

  def new
    @post = DriverPost.new
  end

  def create
    @post = DriverPost.new(post_params)
    @post.user_id = current_user.id # assign the post to the user who created it
    respond_to do |f|
      if (@post.save)
        f.html { redirect_to home_path, notice: "Ride created!" }
        # friends = current_user.friends
        # friends.each do |friend|
        #   DriverPostMailer.delay.post_email(friend, @post)
        # end
      else
        f.html { redirect_to home_path, notice: "Error: Ride Not Saved."}
      end
    end
  end

  def create_with_indirect_booking
    @post = DriverPost.new(post_params)
    @post.user_id = current_user.id # assign the post to the user who created it
    respond_to do |f|
      if (@post.save)
        @indirect_booking = IndirectBooking.create(driver_post_id: @post.id, user_id: indirect_params[:user_id], post_id: indirect_params[:post_id], status: 0)
        f.html { redirect_to home_path, notice: "Ride created!" }
        # friends = current_user.friends
        # friends.each do |friend|
        #   DriverPostMailer.delay.post_email(friend, @post)
        # end
      else
        f.html { redirect_to home_path, notice: "Error: Ride Not Saved."}
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to home_path, notice: 'Ride was successfully deleted.' }
    end
  end

  # def repost
  #   post = DriverPost.find(params[:id])
  #   flash[:notice] = post.repost_by(current_user)
  #   redirect_to(:back)
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = DriverPost.find(params[:id])
    end

    def post_params
      params.require(:driver_post).permit(:from, :destination, :note, :date, :time, :price, :quantity)
    end

    def indirect_params
      params.require(:driver_post).permit(:user_id, :post_id)
    end
end
