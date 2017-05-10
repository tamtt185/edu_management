class Admin::ClassSubjectsController < ApplicationController
  layout "admin_layout"
  
  before_action :load_collections, only: [:new, :edit]
  before_action :load_class_subject, only: [:edit, :update, :destroy]

  def index
    @class_subjects = ClassSubject.search(class_subject_id_cont: params[:class_subject_search]).result
      .newest.page(params[:page]).includes(:semester, :lecturer_subject)
    respond_to do |format|
      format.html{request.referer}
      format.js
    end
  end

  def new
    @class_subject = ClassSubject.new
    respond_to do |format|
      format.html{request.referer}
      format.js
    end
  end

  def create
    @lecturer_subject = LecturerSubject.get_lecturer_subject(params[:lecturer_id], params[:subject_id]).first
    unless @lecturer_subject
      flash[:danger] = "Không tìm thấy giảng viên dạy học phần này"
      redirect_to admin_class_subjects_path
      return
    end

    @class_subject = @lecturer_subject.class_subjects.new class_subject_params
    if @class_subject.save
      if @class_subject.lecturer_subject.subject.theory?
        bt = @class_subject.scores.create(name: "Bài tập", percent: 20)
        gk = @class_subject.scores.create(name: "Giữa kỳ", percent: 20)
        ck = @class_subject.scores.create(name: "Cuối kỳ", percent: 60)
        bt.sub_scores.create(name: "BT", score_type: :exercise, percent: 100)
        gk.sub_scores.create(name: "GK", score_type: :mid_semester, percent: 100)
        ck.sub_scores.create(name: "CK", score_type: :end_semester, percent: 100)
      elsif @class_subject.lecturer_subject.subject.practice?
        ck = @class_subject.scores.create(name: "Cuối kỳ", score_type: :end_semester, percent: 100)
        ck.sub_scores.create(name: "CK", percent: 100)
      elsif @class_subject.lecturer_subject.subject.project?
        dda = @class_subject.scores.create(name: "Điểm ĐÀ", score_type: :project, percent: 70)
        ck = @class_subject.scores.create(name: "Cuối kỳ", score_type: :end_semester, percent: 30)
        dda.sub_scores.create(name: "DDA", percent: 100)
        ck.sub_scores.create(name: "CK", percent: 100)
      elsif @class_subject.lecturer_subject.subject.intership?
        dcc = @class_subject.scores.create(name: "Điểm CC", score_type: :diligence, percent: 70)
        dbv = @class_subject.scores.create(name: "Điểm BV", score_type: :protect, percent: 30)
        dcc.sub_scores.create(name: "DCC", percent: 100)
        dbv.sub_scores.create(name: "DBV", percent: 100)
      end

      flash[:success] = "Thêm lớp học phần thành công"
      redirect_to admin_class_subjects_path
    else
      flash.now[:danger] = "Thêm lớp học phần thất bại"
      load_collections
      render :new
    end
  end
  
  def edit
  end

  def update
    if @class_subject.update_attributes class_subject_params
      flash[:success] = "Chỉnh sửa lớp học phần thành công"
      redirect_to admin_class_subjects_path
    else
      flash.now[:danger] = "Chỉnh sửa lớp học phần thất bại"
      render :edit
    end
  end

  def destroy
    if @class_subject.destroy
      flash[:success] = "Xóa lớp học phần thành công"
    else
      flash[:danger] = "Xóa lớp học phần thất bại"
    end
    redirect_to admin_class_subjects_path
  end

  def import
    ClassSubject.import(params[:file])
    flash[:success] = "Import lớp học phần thành công"
    redirect_to admin_class_subjects_path
  end

  private
  def class_subject_params
    params.require(:class_subject).permit :class_subject_id, :semester_id
  end

  def load_class_subject
    @class_subject = ClassSubject.find_by id: params[:id]
    unless @class_subject
      flash[:danger] = "Không tìm thấy lớp học phần"
      redirect_to admin_class_subjects_path      
    end
  end

  def load_collections
    @semesters = Semester.newest
    @subjects = Subject.all
    @lecturers = []
    if params[:selected_subject_id]
      @subject = Subject.find_by id: params[:selected_subject_id]
      @lecturers = @subject.lecturers
      params[:selected_subject_id] = nil
    end
  end
end
