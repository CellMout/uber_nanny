class NanniesController < ApplicationController

  before_action :set_nanny, only: [:show, :edit, :update, :destroy]

  def index
    @nannies = Nanny.all
  end

  def show
    @nanny = Nanny.find(params[:id])
    @booking = Booking.new
  end

  def new
    @nanny = Nanny.new
  end

  def create
    @nanny = Nanny.new(nanny_params)
    @nanny.user = current_user
    if @nanny.save
      redirect_to profile_path
    else
      render :new, alert: "Creation error"
    end
  end

  def edit
    @nanny = Nanny.find(params[:id])
  end

  def update
    if @nanny.update(nanny_params)
      redirect_to profile_path, notice: 'Nanny successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @nanny = Nanny.find(params[:id])
    @nanny.destroy
    redirect_to nanny_path(@nanny)
  end

  private

  def set_nanny
    @nanny = Nanny.find(params[:id])
  end

  def nanny_params
    params.require(:nanny).permit(:name, :description, :hour_rate)
  end
end
