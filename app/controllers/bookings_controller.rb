class BookingsController < ApplicationController
  before_action :set_booking, only: [:accept, :decline, :edit, :update, :destroy]

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
      render 'nannies/show', alert: "Erreur lors de la création de la réservation."
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

  def edit
  end

  def update
    if @booking.update(booking_params)
      redirect_to profile_path, notice: 'Réservation mise à jour.'
    else
      render :edit, alert: "Erreur lors de la mise à jour de la réservation."
    end
  end

  def destroy
    @booking.destroy

    redirect_to profile_path, notice: 'booking successfully deleted.'

  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:start_time, :end_time, :address, :status)
  end
end
