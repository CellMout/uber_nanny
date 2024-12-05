class BookingsController < ApplicationController
  before_action :set_booking, only: [:accept, :decline, :edit, :update, :destroy, :show]

  def show
  end

  def new
    @nanny = Nanny.find(params[:nanny_id])
    @booking = Booking.new
  end

  def create
    @nanny = Nanny.find(params[:nanny_id])
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.nanny = @nanny
    if @booking.save!
      redirect_to profile_path, notice: "Booking successfully sent."
    else
      render 'nannies/show', alert: "Booking could not be sent."
    end
  end

  def accept
    if @booking.update(status: 'accepted')
      redirect_to profile_path, notice: 'Booking accepted.'
    else
      redirect_to profile_path, alert: "Booking could not be accepted."
    end
  end

  def decline
    if @booking.update(status: 'declined')
      redirect_to profile_path, notice: 'Booking declined.'
    else
      redirect_to profile_path, alert: 'Booking could not be declined.'
    end
  end

  def edit
  end

  def update
    if @booking.update(booking_params)
      redirect_to profile_path, notice: 'Booking updated successfully.'
    else
      render :edit, alert: "Booking could not be updated."
    end
  end

  def destroy
    @booking.destroy

    redirect_to profile_path, notice: 'Booking successfully deleted.'
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:start_time, :end_time, :address, :status)
  end
end
