class Admin::StudentClassstudent_class_subjectsController < ApplicationController
layout "admin_layout"
  
  before_action :authenticate_admin!
  before_action :load_class_subject, only: [:new, :create]
  before_action :load_student_class_subject, only: :destroy

  def new
    binding.pry
    @student_class_subject = @class_subject.student_class_subjects.new
    @students = Student.all
  end

  def create
    @student_class_subject = student_class_subject.new student_class_subject_params
    if @student_class_subject.save
      flash[:success] = "Thêm sinh viên lớp học phần thành công"
      redirect_to admin_student_class_subjects_path
    else
      flash.now[:danger] = "Thêm sinh viên lớp học phần thất bại"
      render :new
    end
  end
  
  def destroy
    if @student_class_subject.destroy
      flash[:success] = "Xóa sinh viên lớp học phần thành công"
    else
      flash[:danger] = "Xóa sinh viên lớp học phần thất bại"
    end
    redirect_to admin_student_class_subjects_path
  end

  private
  def student_class_subject_params
    params.require(:student_class_subject).permit :student_id
  end

  def load_class_subject
    @class_subject = ClassSubject.find_by(id: params[:class_subject_id])
    unless @class_subject
      flash[:danger] = "Lớp học phần không tồn tại"
      redirect_to root_path
    end
  end

  def load_student_class_subject
    @student_class_subject = StudentClassSubject.find_by id: params[:id]
    unless @student_class_subject
      flash[:danger] = "Không tìm thấy sinh viên lớp học phần"
      redirect_to admin_student_class_subjects_path      
    end
  end
end