class NanniesController < ApplicationController

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
    @nanny.save
    redirect_to nanny_path @nanny
  end

  def edit
    @nanny = Nanny.find(params[:id])
  end

  def destroy
    @nanny = Nanny.find(params[:id])
    @nanny.destroy
    redirect_to nanny_path(@nanny)
  end

  private
  def nanny_params
    params.require(:nanny).permit(:name, :description)
  end
end
