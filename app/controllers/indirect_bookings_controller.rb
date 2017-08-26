class IndirectBookingsController < ApplicationController
  before_action :set_indirect_booking, only: [:destroy, :accept, :reject]

  def new
    @indirect_booking = IndirectBooking.new
  end

  # def create
  #   if DriverPost.find(indirect_booking_params[:driver_post_id]).available?
  #     @indirect_booking = IndirectBooking.new(indirect_booking_params)
  #     @indirect_booking.status = 0
  #     #@indirect_booking.user_id = current_user.id # assign the post to the user who created it
  #     respond_to do |f|
  #       if (@indirect_booking.save)
  #         f.html { redirect_to home_path, notice: "Booking created!" }
  #       else
  #         f.html { redirect_to home_path, notice: "Error: Booking Not Saved."}
  #       end
  #     end
  #   else
  #     respond_to do |f|
  #       f.html { redirect_to home_path, notice: "The Ride is full!" }
  #     end
  #   end
  # end

  def accept
    if (@indirect_booking.user == current_user)
      @indirect_booking.accept
      PostMailer.delay.accept_pickup(@indirect_booking.driver_post.user, @indirect_booking.driver_post, current_user)
      respond_to do |format|
        format.html { redirect_to notification_path, notice: 'Booking was successfully accepted.' }
      end
    else
      respond_to do |format|
        format.html { redirect_to home_path, notice: 'You don\'t have access to accept this booking' }
      end
    end
  end

  def reject
    if (@indirect_booking.user == current_user)
      @indirect_booking.reject
      PostMailer.delay.reject_pickup(@indirect_booking.driver_post.user, @indirect_booking.driver_post, current_user)
      respond_to do |format|
        format.html { redirect_to notification_path, notice: 'Booking was successfully rejected.' }
      end
    else
      respond_to do |format|
        format.html { redirect_to home_path, notice: 'You don\'t have access to reject this booking' }
      end
    end
  end

  def destroy
    @indirect_booking.destroy
    respond_to do |format|
      format.html { redirect_to home_path, notice: 'Booking was successfully deleted.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_indirect_booking
      @indirect_booking = IndirectBooking.find(params[:id])
    end

    def indirect_booking_params
      params.require(:indirect_booking).permit(:user_id, :driver_post_id, :post_id)
    end
end
