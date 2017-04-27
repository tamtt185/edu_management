class Lecturer::ClassSubjectsController < ApplicationController
  layout "lecturer_layout"
  
  before_action :authenticate_lecturer!
  before_action :load_lecturer, only: :index
  before_action :load_class_subject, only: :show
  
  def index
  	@class_subjects = @lecturer.class_subjects
  end

  def show
    @students = @class_subject.students
  end

  private
  def load_lecturer
    @lecturer = Lecturer.find_by id: current_lecturer.id
    unless @lecturer
      flash[:danger] = "Giảng viên không tồn tại"
      redirect_to root_path
    end
  end

  def load_class_subject
    @class_subject = ClassSubject.find_by id: params[:id]
    unless @class_subject
      flash[:danger] = "Lớp học phần không tồn tại"
      redirect_to root_path
    end
  end
end
