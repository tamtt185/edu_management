class Lecturer::SubjectScoresController < ApplicationController
  layout "lecturer_layout"
  
  before_action :authenticate_lecturer!
  before_action :load_class_subject, only: :index
  before_action :load_sub_score, only: [:edit, :update]

  def index
    @exercise_score = @class_subject.scores.get_exercise_score
    @mid_semester_score = @class_subject.scores.get_mid_semester_score
    @end_semester_score = @class_subject.scores.get_end_semester_score	
    @students = @class_subject.students
  end

  private
  def score_params
    params.require(:score).permit(sub_scores_attributes: [:id, :name, :percent, :_destroy])
  end

  def load_class_subject
    @class_subject = ClassSubject.find_by id: params[:class_subject_id]
    unless @class_subject
      flash[:danger] = "Lớp học phần không tồn tại"
      redirect_to root_path
    end
  end
end
