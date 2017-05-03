class Lecturer::ScoresController < ApplicationController
  layout "lecturer_layout"
  
  before_action :authenticate_lecturer!
  before_action :load_class_subject, only: [:new, :create, :edit, :update]
  before_action :load_sub_score, only: [:edit, :update]

  def new
    @score = @class_subject.scores.create
    respond_to do |format|
      format.js
    end
  end

  def create
    if validate_score
      @score = @class_subject.scores.create score_params
      if @score.save
        flash[:success] = "Thêm điểm bài tập thành công"
        redirect_to lecturer_class_subject_path @class_subject
      else
        flash.now[:danger] = "Thêm  điểm bài tập thất bại"
        render :new
      end
    else
      flash[:danger] = "Tổng phần trăm các cột điểm không bằng 100%"
      render :new
    end
  end

  def edit
  end

  def update
    if validate_score
      if @score.update_attributes score_params
        flash[:success] = "Chỉnh sửa điểm bài tập thành công"
        redirect_to lecturer_class_subject_path @class_subject
      else
        flash.now[:danger] = "Chỉnh sửa điểm bài tập thất bại"
        render :edit
      end
    else
      flash[:danger] = "Tổng phần trăm các cột điểm không bằng 100%"
      render :edit
    end
  end
    
  private

  def score_params
    params.require(:score).permit(sub_scores_attributes: [:id, :name, :percent, :_destroy])
  end

  def load_sub_score
    @score = Score.find_by id: params[:id]
    unless @score
      flash[:danger] = "Cột điểm bài tập không tồn tại"
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

  def respond
    load_class_subject
    respond_to do |format|
      format.js
    end
  end

  def validate_score
    sum = 0
    score_params[:sub_scores_attributes].each do |key, value|
      if value[:_destroy].to_i != 1
        sum += value[:percent].to_i
      end
    end
    if sum != 100
      return false
    end
    return true
  end
end
