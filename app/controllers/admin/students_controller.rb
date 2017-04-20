class Admin::StudentsController < ApplicationController
  layout "admin_layout"
  
  before_action :student_params, only: :create
  before_action :load_student, only: [:edit, :update, :destroy, :show]
  before_action :load_collection, only: [:new, :create, :edit, :update]

  def index
    @students = Student.all.page(params[:page])
  end

  def new
    @student = Student.new
  end

  def create
    @student = Student.new student_params
    if @student.save
      flash[:success] = "Thêm sinh viên thành công"
      redirect_to admin_students_path
    else
      flash.now[:danger] = "Thêm sinh viên thất bại"
      render :new
    end
  end
  
  def edit
  end

  def update
    if @student.update_attributes student_params
      flash[:success] = "Chỉnh sửa sinh viên thành công"
      redirect_to admin_students_path
    else
      flash.now[:danger] = "Chỉnh sửa sinh viên thất bại"
      render :edit
    end
  end

  def show
  end

  def destroy
    if @student.destroy
      flash[:success] = "Xóa sinh viên thành công"
    else
      flash[:danger] = "Xóa sinh viên thất bại"
    end
    redirect_to admin_students_path
  end

  def import
    Student.import(params[:file])
    flash[:success] = "Import sinh viên thành công"
    redirect_to admin_students_path
  end

  private
  def student_params
    params.require(:student).permit :student_id, :password, :name, :email, :gender, 
      :phone, :address, :second_language, :ethnic_id, :national_id, :avatar,
      :specialization_id, :student_class_id, :religion_id, :regency_id, :course_id
  end

  def load_student
    @student = Student.find_by id: params[:id]
    unless @student
      flash[:danger] = "Không tìm thấy sinh viên"
      redirect_to admin_students_path      
    end
  end

  def load_collection
    @ethnics = Ethnic.all
    @nationals = National.all
    @specializations = Specialization.all
    @student_classes = StudentClass.all
    @religions = Religion.all
    @regencies = Regency.all
    @courses = Course.all
  end
end
