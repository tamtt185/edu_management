class Student::ScoresController < ApplicationController
  before_action :authenticate_student!
  
  before_action :load_student, only: :index
  before_action :load_class_subjects, only: :index

  def index
    
  end

  private
  def load_student
    @student = Student.find_by id: current_student.id
    unless @student
      flash[:danger] = "Không tìm thấy sinh viên này"
      redirect_to root_path
    end
  end

  def load_class_subjects
    @class_subjects = @student.class_subjects
  end
end
