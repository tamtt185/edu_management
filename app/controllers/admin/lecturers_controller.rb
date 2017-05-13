class Admin::LecturersController < ApplicationController
  layout "admin_layout"
  
  before_action :authenticate_admin!
  before_action :lecturer_params, only: :create
  before_action :load_lecturer, only: [:edit, :update, :destroy, :show]
  before_action :load_collection, only: [:new, :create, :edit, :update]

  def index
    @lecturers = Lecturer.search(name_cont: params[:lecturer_search]).result
      .newest.page(params[:page])
    respond_to do |format|
      format.html{request.referer}
      format.js
    end
  end

  def new
    @lecturer = Lecturer.new
  end

  def create
    @lecturer = Lecturer.new lecturer_params
    if @lecturer.save
      flash[:success] = "Thêm giảng viên thành công"
      redirect_to admin_lecturers_path
    else
      flash.now[:danger] = "Thêm giảng viên thất bại"
      render :new
    end
  end
  
  def edit
  end

  def update
    if @lecturer.update_attributes lecturer_params
      flash[:success] = "Chỉnh sửa giảng viên thành công"
      redirect_to admin_lecturer_path @lecturer
    else
      flash.now[:danger] = "Chỉnh sửa giảng viên thất bại"
      render :edit
    end
  end

  def show 
  end
  
  def destroy
    if @lecturer.destroy
      flash[:success] = "Xóa giảng viên thành công"
    else
      flash[:danger] = "Xóa giảng viên thất bại"
    end
    redirect_to admin_lecturers_path
  end

  def import
    Lecturer.import(params[:file])
    flash[:success] = "Import giảng viên thành công"
    redirect_to admin_lecturers_path
  end

  private
  def lecturer_params
    params.require(:lecturer).permit :lecturer_id, :password, :name, :degree, :academic_title, :avatar,
      :email, :gender, :birthday, :phone, :address, :ethnic_id, :national_id, :religion_id, :faculty_id
  end

  def load_lecturer
    @lecturer = Lecturer.find_by id: params[:id]
    unless @lecturer
      flash[:danger] = "Không tìm thấy giảng viên"
      redirect_to admin_lecturers_path      
    end
  end

  def load_collection
    @ethnics = Ethnic.all
    @nationals = National.all
    @religions = Religion.all
    @faculties = Faculty.all
  end
end
