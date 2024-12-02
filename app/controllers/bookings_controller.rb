class BookingsController < ApplicationController
  def new
    @nanny = Nanny.find(params[:nanny_id])
    @booking = Booking.new
  end

  def create
    nanny = Nanny.find(params[:nanny_id])
    @booking = Booking.new(booking_params)
    @booking.nanny = @nanny
    if @booking.save
      redirect_to @booking
    else
      render :new
    end
  end

  def accept
    if @booking.update(status: 'accepted')
      redirect_to @booking, notice: 'Réservation acceptée.'
    else
      redirect_to @booking, alert: "Erreur lors de l'acceptation de la réservation."
    end
  end

  def decline
    if @booking.update(status: 'declined')
      redirect_to @booking, notice: 'Réservation déclinée.'
    else
      redirect_to @booking, alert: 'Erreur lors du refus de la réservation.'
    end
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:start_time, :end_time, :address, :status)
  end
end
