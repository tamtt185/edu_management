class Lecturer::MidSemesterScoresController < ApplicationController
  before_action :authenticate_lecturer!
  before_action :load_class_subject, only: [:new, :create, :edit]
  before_action :load_mid_semester_score, only: [:edit, :update, :destroy]

  def new
    @mid_semester_score = @class_subject.mid_semester_scores.new
    respond_to do |format|
      format.js
    end
  end

  def create
    @mid_semester_score = @class_subject.mid_semester_scores.build mid_semester_score_params
    if @mid_semester_score.save
      flash[:success] = "Thêm cột điểm giữa kỳ thành công"
    else
      flash[:danger] = "Thêm cột điểm giữa kỳ thất bại"
    end
    respond
  end

  def edit
  end

  def update
    if @mid_semester_score.update_attributes mid_semester_score_params
      flash[:success] = "Cập nhật cột điểm giữa kỳ thành công"
    else
      flash[:danger] = "Cập nhật cột điểm giữa kỳ thất bại"
    end
    respond
  end

  def destroy
     if @mid_semester_score.destroy
      flash[:success] = "Xóa cột điểm giữa kỳ thành công"
    else
      flash[:danger] = "Xóa cột điểm giữa kỳ thất bại"
    end
    respond
  end

  private

  def mid_semester_score_params
    params.require(:mid_semester_score).permit :name, :percent
  end

  def load_class_subject
    @class_subject = ClassSubject.find_by id: params[:class_subject_id]
    unless @class_subject
      flash[:danger] = "Lớp học phần không tồn tại"
      redirect_to root_path
    end
  end

  def load_mid_semester_score
    @mid_semester_score = MidSemesterScore.find_by id: params[:id]
    unless @mid_semester_score
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
