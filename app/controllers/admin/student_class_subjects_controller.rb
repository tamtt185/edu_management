class Admin::StudentClassSubjectsController < ApplicationController
  layout "admin_layout"

  before_action :authenticate_admin!
  before_action :load_class_subject, only: [:new, :create, :edit, :update]
  before_action :load_student_class_subject, only: [:edit, :update, :destroy]
  before_action :load_student, only: [:create, :update]

  def new
    @student_class_subject = @class_subject.student_class_subjects.new
    @students = Student.all
  end

  def create
    @student_class_subject = @class_subject.student_class_subjects.new student_class_subject_params
    @student_class_subject.student_class_subject_id = @student.student_id + "." + @class_subject.class_subject_id
    if @student_class_subject.save
      flash[:success] = "Thêm sinh viên lớp học phần thành công"
      redirect_to admin_class_subject_path params[:class_subject_id]
    else
      flash.now[:danger] = "Thêm sinh viên lớp học phần thất bại"
      @students = Student.all
      render :new
    end
  end
  
  def edit
    @students = Student.all
  end

  def update
     @student_class_subject.student_class_subject_id = @student.student_id + "." + @class_subject.class_subject_id
    if @student_class_subject.update_attributes student_class_subject_params
      flash[:success] = "Cập nhật sinh viên lớp học phần thành công"
      redirect_to admin_class_subject_path params[:class_subject_id]
    else
      flash.now[:danger] = "Cập nhật sinh viên lớp học phần thất bại"
      @students = Student.all
      render :edit
    end
  end

  def destroy
    if @student_class_subject.destroy
      flash[:success] = "Xóa sinh viên lớp học phần thành công"
    else
      flash[:danger] = "Xóa sinh viên lớp học phần thất bại"
    end
    redirect_to admin_class_subject_path params[:class_subject_id]
  end

  private
  def student_class_subject_params
    params.require(:student_class_subject).permit :student_id
  end

  def load_class_subject
    @class_subject = ClassSubject.find_by(id: params[:class_subject_id])
    unless @class_subject
      flash[:danger] = "Lớp học phần không tồn tại"
      redirect_to admin_class_subject_path params[:class_subject_id]
    end
  end

  def load_student
    @student = Student.find_by id: student_class_subject_params[:student_id]
    unless @student
      flash[:danger] = "Sinh viên không tồn tại"
      redirect_to admin_class_subject_path params[:class_subject_id]
    end
  end

  def load_student_class_subject
    @student_class_subject = StudentClassSubject.find_by id: params[:id]
    unless @student_class_subject
      flash[:danger] = "Không tìm thấy sinh viên lớp học phần"
      redirect_to admin_class_subject_path params[:class_subject_id]      
    end
  end
end