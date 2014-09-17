class TitlesController < ApplicationController
	before_action :set_title, only: [:edit, :update, :destroy]

  def index
  	@titles = Title.all.order_by_level
  end

  def new
  	@title = Title.new
  end

  def create
  	@title = Title.new(title_params)

  	if @title.save
  		redirect_to titles_url, notice: '資料已新增'
  	else
  		render new
  	end
  end

  def edit

  end

  def update
  	if @title.update(title_params)
  		redirect_to titles_url, notice: '資料已更新'
  	else
  		render edit
  	end
  end

  def destroy
  	@title.destroy

  	redirect_to titles_url
  end

  private

  def set_title
  	@title = Title.find(params[:id])
  end

  def title_params
  	params.require(:title).permit(:title, :description, :level)
  end

end
