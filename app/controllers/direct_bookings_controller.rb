class DirectBookingsController < ApplicationController
  before_action :set_direct_booking, only: [:destroy, :accept, :reject]

  def new
    @direct_booking = DirectBooking.new
  end

  def create
    if DriverPost.find(direct_booking_params[:driver_post_id]).available?
      @direct_booking = DirectBooking.new(direct_booking_params)
      @direct_booking.status = 0
      respond_to do |f|
        if (@direct_booking.save)
          f.html { redirect_to home_path, notice: "Your join request has been sent! Waiting for driver's approval" }
          PostMailer.delay.new_join(@direct_booking.driver_post.user, DriverPost.find(direct_booking_params[:driver_post_id]), @direct_booking.user)
        else
          f.html { redirect_to home_path, notice: "Error: Booking Not Saved."}
        end
      end
    else
      respond_to do |f|
        f.html { redirect_to home_path, notice: "This Ride is full!" }
      end
    end
  end

  def accept
    if (@direct_booking.driver_post.user == current_user)
      @direct_booking.accept
      PostMailer.delay.accept_join(current_user, @direct_booking.driver_post, @direct_booking.user)
      respond_to do |format|
        format.html { redirect_to driver_post_path(@direct_booking.driver_post.id), notice: 'Booking was successfully accepted.' }
      end
    else
      respond_to do |format|
        format.html { redirect_to home_path, notice: 'You don\'t have access to accept this booking' }
      end
    end
  end

  def reject
    if (@direct_booking.driver_post.user == current_user)
      @direct_booking.reject
      PostMailer.delay.reject_join(current_user, @direct_booking.driver_post, @direct_booking.user)
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
    @direct_booking.destroy
    respond_to do |format|
      format.html { redirect_to home_path, notice: 'Booking was successfully deleted.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_direct_booking
      @direct_booking = DirectBooking.find(params[:id])
    end

    def direct_booking_params
      params.require(:direct_booking).permit(:user_id, :driver_post_id)
    end
end
