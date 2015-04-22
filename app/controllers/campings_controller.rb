class CampingsController < ApplicationController
  before_action :set_camping, only: [:show]
  def index
    @campings = Camping.all
  end

  def show
    @key = Rails.configuration.x.googlemap[:key]
    @key = 'https://www.google.com/maps/embed/v1/place?key=' + @key
  end

  private

  def set_camping
    @camping = Camping.find(params[:id])
  end
end
