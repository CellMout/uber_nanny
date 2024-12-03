class BookingsController < ApplicationController
  before_action :set_booking, only: [:accept, :decline]

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
      redirect_to nanny_path(@nanny), notice: "Réservation créée avec succès."
    else
      render 'nannies/show'
    end
  end
  
  def accept
    if @booking.update(status: 'accepted')
      redirect_to profile_path, notice: 'Réservation acceptée.'
    else
      redirect_to profile_path, alert: "Erreur lors de l'acceptation de la réservation."
    end
  end

  def decline
    if @booking.update(status: 'declined')
      redirect_to profile_path, notice: 'Réservation déclinée.'
    else
      redirect_to profile_path, alert: 'Erreur lors du refus de la réservation.'
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
