class Lecturer::EndSemesterScoresController < ApplicationController
  before_action :authenticate_lecturer!
  before_action :load_class_subject, only: [:new, :create, :edit]
  before_action :load_end_semester_score, only: [:edit, :update, :destroy]

  def new
    @end_semester_score = @class_subject.end_semester_scores.new
    respond_to do |format|
      format.js
    end
  end

  def create
    @end_semester_score = @class_subject.end_semester_scores.build end_semester_score_params
    if @end_semester_score.save
      flash[:success] = "Thêm cột điểm cuối kỳ thành công"
    else
      flash[:danger] = "Thêm cột điểm cuối kỳ kỳ thất bại"
    end
    respond
  end

  def edit
  end

  def update
    if @end_semester_score.update_attributes end_semester_score_params
      flash[:success] = "Cập nhật cột điểm cuối kỳ thành công"
    else
      flash[:danger] = "Cập nhật cột điểm cuối kỳ thất bại"
    end
    respond
  end

  def destroy
     if @end_semester_score.destroy
      flash[:success] = "Xóa cột điểm cuối kỳ thành công"
    else
      flash[:danger] = "Xóa cột điểm cuối kỳ thất bại"
    end
    respond
  end

  private

  def end_semester_score_params
    params.require(:end_semester_score).permit :name, :percent
  end

  def load_class_subject
    @class_subject = ClassSubject.find_by id: params[:class_subject_id]
    unless @class_subject
      flash[:danger] = "Lớp học phần không tồn tại"
      redirect_to root_path
    end
  end

  def load_end_semester_score
    @end_semester_score = EndSemesterScore.find_by id: params[:id]
    unless @end_semester_score
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
