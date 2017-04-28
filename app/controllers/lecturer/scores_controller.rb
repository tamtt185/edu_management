class Lecturer::ScoresController < ApplicationController
  layout "lecturer_layout"
  
  before_action :authenticate_lecturer!
  before_action :load_lecturer, only: :index
  before_action :load_class_subject, only: :index
  
  def index
    @exercise_scores = @class_subject.exercise_scores.oldest
    @mid_semester_scores = @class_subject.mid_semester_scores.oldest
    @end_semester_scores = @class_subject.end_semester_scores.oldest
    @students = @class_subject.students
  end

  def show
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
    @class_subject = ClassSubject.find_by id: params[:class_subject_id]
    unless @class_subject
      flash[:danger] = "Lớp học phần không tồn tại"
      redirect_to root_path
    end
  end
end
