class Dashboard::Admin::MembersController < Dashboard::Admin::AdminController
	before_action :set_member, only: [:edit, :update, :destroy]

  def index
		if params[:year]
			@year = params[:year]
			@members = Member.where(year: params[:year])
		else
			@members = Member.all.order_by_year
		end
		@years = Member.all.order_by_year.group(:year).select(:year)
  end

  def new
		if params[:year]
			@member = Member.new(year: params[:year])
		else
			@member = Member.new
		end
  end

  def create
  	@member = Member.new(member_params)
  	if @member.save
  		redirect_to dashboard_admin_members_url(year: @member.year), notice: '資料已新增'
  	else
  		render :new
  	end
  end

  def edit
  end

  def update
  	if @member.update(member_params)
  		redirect_to dashboard_admin_members_url, notice: '資料已更新'
  	else
  		render :edit
  	end
  end

  def destroy
		@member.destroy
    redirect_to dashboard_admin_members_url
  end

  private
  def set_member
  	@member = Member.find(params[:id])
  end

  def member_params
  	params.require(:member).permit(:name, :nname, :fname, :th, :sex, :year, :user_id,
      :title_ths_attributes => [:id, :member_id, :title_id, :title_year, :_destroy])
  end

end
