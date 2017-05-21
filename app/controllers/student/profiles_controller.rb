class Student::ProfilesController < ApplicationController
  before_action :authenticate_student!
  before_action :load_profile, only: [:index, :edit, :update]
  before_action :load_collection, only: [:edit, :update]

  def index
  end

  def edit
  end

  def update
    if @student.update_attributes student_params
      flash[:success] = "Cập nhật thông tin thành công"
      redirect_to student_profiles_path
    else
      flash.now[:danger] = "Cập nhật thông tin thất bại"
      render :edit
    end
  end

  private
  def student_params
    params.require(:student).permit :student_id, :name, :email, :gender, :birthday,
      :phone, :address, :second_language, :ethnic_id, :national_id, :avatar,
      :specialization_id, :student_class_id, :religion_id, :regency_id, :course_id
  end

  def load_profile
    @student = Student.find_by id: current_student.id
    unless @student
      flash[:danger] = "Sinh viên không tồn tại"
      redirect_to root_path
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