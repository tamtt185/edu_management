class Admin::ProfilesController < ApplicationController
  layout "admin_layout"

  before_action :authenticate_admin!
  before_action :load_profile, only: [:index, :edit, :update]

  def index
  end


  def edit
  end

  def update
    if @admin.update_attributes admin_params
      flash[:success] = "Cập nhật thông tin thông tin thành công"
      redirect_to admin_profiles_path
    else
      flash.now[:danger] = "Cập nhật thông tin thông tin thất bại"
      render :edit
    end
  end

  private
  def admin_params
    params.require(:admin).permit :admin_id, :name, :avatar,
      :email, :gender, :birthday, :phone, :address
  end

  def load_profile
    @admin = Admin.find_by id: current_admin.id
    unless @admin
      flash[:danger] = "Admin không tồn tại"
      redirect_to root_path
    end
  end
end
