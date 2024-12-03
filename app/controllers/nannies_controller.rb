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

    if params[:nanny][:photo].present?
      uploaded_file = params[:nanny][:photo]
      upload_result = Cloudinary::Uploader.upload(uploaded_file.path)
      @nanny.photo_url = upload_result['secure_url']
      @nanny.save
      redirect_to @nanny, notice: 'Nanny successfully created!'
    else
      render :new, alert: "Creation error"
    end
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
    params.require(:nanny).permit(:name, :description, :hour_rate, :photo_url)
  end
end
