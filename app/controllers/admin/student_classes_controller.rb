class Admin::StudentClassesController < ApplicationController
  layout "admin_layout"
  
  before_action :authenticate_admin!
  before_action :student_class_params, only: :create
  before_action :load_student_class, only: [:edit, :update, :destroy, :show]
  before_action :load_faculties, only: [:create, :edit]

  def index
    @student_classes = StudentClass.search(name_or_student_class_id_cont: params[:student_class_search]).result
      .newest.page(params[:page]).includes :faculty
    respond_to do |format|
      format.html{request.referer}
      format.js
    end
  end

  def new
    @student_class = StudentClass.new
  end

  def create
    @student_class = StudentClass.new student_class_params
    if @student_class.save
      flash[:success] = "Thêm lớp sinh hoạt thành công"
      redirect_to admin_student_classes_path
    else
      flash.now[:danger] = "Thêm lớp sinh hoạt thất bại"
      render :new
    end
  end
  
  def edit
  end

  def update
    if @student_class.update_attributes student_class_params
      flash[:success] = "Cập nhật thông tin lớp sinh hoạt thành công"
      redirect_to admin_student_classes_path
    else
      flash.now[:danger] = "Cập nhật thông tin lớp sinh hoạt thất bại"
      render :edit
    end
  end

  def show
  end

  def destroy
    if @student_class.destroy
      flash[:success] = "Xóa lớp sinh hoạt thành công"
    else
      flash[:danger] = "Xóa lớp sinh hoạt thất bại"
    end
    redirect_to admin_student_classes_path
  end

  def import
    StudentClass.import(params[:file])
    flash[:success] = "Import lớp sinh hoạt thành công"
    redirect_to admin_student_classes_path
  end

  private
  def student_class_params
    params.require(:student_class).permit :student_class_id, :name, :faculty_id
  end

  def load_student_class
    @student_class = StudentClass.find_by id: params[:id]
    unless @student_class
      flash[:danger] = "Không tìm thấy lớp sinh hoạt"
      redirect_to admin_student_classs_path      
    end
  end

  def load_faculties
    @faculties = Faculty.all
  end
end
