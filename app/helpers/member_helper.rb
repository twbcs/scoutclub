module MemberHelper
  def new_btn
    if @year
      link_to '新增', new_dashboard_admin_member_path(year: @year), class: 'btn btn-success'
    else
      link_to '新增', new_dashboard_admin_member_path, class: 'btn btn-success'
    end
  end
end
