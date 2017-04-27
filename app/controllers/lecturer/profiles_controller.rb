class Lecturer::ProfilesController < ApplicationController
  layout "lecturer_layout"

  before_action :authenticate_lecturer!
  before_action :load_profile, only: [:index, :edit, :update]
  before_action :load_collection, only: :edit

  def index
  end


  def edit
  end

  def update
    if @lecturer.update_attributes lecturer_params
      flash[:success] = "Chỉnh sửa thông tin thành công"
      redirect_to lecturer_profiles_path
    else
      flash.now[:danger] = "Chỉnh sửa thông tin thất bại"
      render :edit
    end
  end

  private
  def lecturer_params
    params.require(:lecturer).permit :lecturer_id, :name, :degree, :academic_title, :avatar,
      :email, :gender, :birthday, :phone, :address, :ethnic_id, :national_id, :religion_id, :faculty_id
  end

  def load_profile
    @lecturer = Lecturer.find_by id: current_lecturer.id
    unless @lecturer
      flash[:danger] = "Giảng viên không tồn tại"
      redirect_to root_path
    end
  end

  def load_collection
    @ethnics = Ethnic.all
    @nationals = National.all
    @religions = Religion.all
    @faculties = Faculty.all
  end
end
