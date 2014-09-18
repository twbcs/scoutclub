class DoingTypesController < ApplicationController
	before_action :set_doing_type, only: [:edit, :update, :destroy]

  def index
  	@doing_types = DoingType.all
  end

  def new
  	@doing_type = DoingType.new
  end

  def create
  	@doing_type = DoingType.new(doing_type_params)
  	if @doing_type.save
  		redirect_to doing_types_url
  	else
  		render new
  	end
  end

  def edit
  end

  def update
  	if @doing_type.update(doing_type_params)
  		redirect_to doing_types_url
  	else
  		render edit
  	end
  end

  def destroy
  	@doing_type.destroy

  	redirect_to doing_types_url
  end

  private

  def set_doing_type
  	@doing_type = DoingType.find(params[:id])
  end

  def doing_type_params
  	params.require(:doing_type).permit(:title)
  end


end
