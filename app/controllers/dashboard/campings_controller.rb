class Dashboard::CampingsController < Dashboard::DashboardController
  before_action :set_camping, only: [:show, :edit, :destroy, :update]

  def index
    @campings = Camping.all
  end

  def new
    @camping = Camping.new
  end

  def create
    @camping = Camping.new(camping_params)
    if @camping.save
      redirect_to dashboard_camping_path(@camping.id)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @camping.update(camping_params)
      redirect_to dashboard_camping_path(@camping.id)
    else
      render :edit
    end
  end

  def show
    @key = Rails.configuration.x.googlemap[:key]
    @key = 'https://www.google.com/maps/embed/v1/place?key=' + @key
  end

  def destroy
    @camping.destroy
    redirect_to dashboard_campings_path
  end

  private

  def camping_params
    params.require(:camping).permit(:name, :address, :area, :camping_area, :water,
                                    :description, :electric, :canopy, :expense,
                                    :check, :url, :gmap)
  end

  def set_camping
    @camping = Camping.find(params[:id])
  end
end
