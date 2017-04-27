class Lecturer::ExerciseScoresController < ApplicationController
  
  before_action :authenticate_lecturer!
  before_action :load_class_subject, only: [:new, :create, :edit]
  before_action :load_exercise_score, only: [:edit, :update, :destroy]

  def new
    @exercise_score = @class_subject.exercise_scores.new
    respond_to do |format|
      format.js
    end
  end

  def create
    @exercise_score = @class_subject.exercise_scores.build exercise_score_params
    if @exercise_score.save
      flash[:success] = "Thêm cột điểm bài tập thành công"
    else
      flash[:danger] = "Thêm cột điểm giữa kỳ thất bại"
    end
    respond
  end

  def edit
  end

  def update
    if @exercise_score.update_attributes exercise_score_params
      flash[:success] = "Cập nhật cột điểm bài tập thành công"
    else
      flash[:danger] = "Cập nhật cột điểm bài tập thất bại"
    end
    respond
  end

  def destroy
     if @exercise_score.destroy
      flash[:success] = "Xóa cột điểm bài tập thành công"
    else
      flash[:danger] = "Xóa cột điểm bài tập thất bại"
    end
    respond
  end

  private

  def exercise_score_params
    params.require(:exercise_score).permit :name, :percent
  end

  def load_class_subject
    @class_subject = ClassSubject.find_by id: params[:class_subject_id]
    unless @class_subject
      flash[:danger] = "Lớp học phần không tồn tại"
      redirect_to root_path
    end
  end

  def load_exercise_score
    @exercise_score = ExerciseScore.find_by id: params[:id]
    unless @exercise_score
      flash[:danger] = "Cột điểm này không tồn tại"
      redirect_to root_path
    end
  end

  def respond
    load_class_subject
    respond_to do |format|
      format.js
    end
  end
end
