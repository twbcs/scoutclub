class MusicsController < ApplicationController
  def index
    @musics = Music.all.includes(:user)
  end
  
  def show
    @music = Music.find(params[:id])
  end
end
