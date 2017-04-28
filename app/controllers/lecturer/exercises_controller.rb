class Lecturer::ExercisesController < ApplicationController
  layout "lecturer_layout"
  before_action :load_class_subject, only: [:new, :create]

  def new
    @exercise = @class_subject.exercise
  end

  def create
    @exercise = @class_subject.build_exercise exercise_params
  end

  private

  def exercise_params
    params.require(:exercise).permit(:name, :percent, exercise_scores_attributes: [:name, :percent, :_destroy])
  end

  def load_class_subject
    @class_subject = ClassSubject.find_by id: params[:class_subject_id]
    unless @class_subject
      flash[:danger] = "Lớp học phần không tồn tại"
      redirect_to root_path
    end
  end
end
