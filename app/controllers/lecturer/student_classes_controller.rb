class Lecturer::StudentClassesController < ApplicationController
  layout "lecturer_layout"
  
  before_action :authenticate_lecturer!
  before_action :load_lecturer, only: :index
  before_action :load_student_class, only: :show

  def index
  	@student_classes = @lecturer.student_classes.newest
  end

  def show
  	@students = @student_class.students
  end

  private
  def load_lecturer
    @lecturer = Lecturer.find_by id: current_lecturer.id
    unless @lecturer
      flash[:danger] = "Giảng viên không tồn tại"
      redirect_to root_path
    end
  end

  def load_student_class
    @student_class = StudentClass.find_by id: params[:id]
    unless @student_class
      flash[:danger] = "Lớp học không tồn tại"
      redirect_to root_path
    end
  end
end
