class Admin::ClassSubjectsController < ApplicationController
  layout "admin_layout"
  
  before_action :authenticate_admin!
  before_action :load_collections, only: [:new, :edit]
  before_action :load_class_subject, only: [:edit, :show, :update, :destroy]
  before_action :load_lecturer_subject, only: :create
  before_action :load_semester, only: :create

  def index
    @class_subjects = ClassSubject.search(class_subject_id_cont: params[:class_subject_search]).result
      .newest.page(params[:page]).includes(:semester, :lecturer_subject)
    respond_to do |format|
      format.html{request.referer}
      format.js
    end
  end

  def show
  end

  def new
    @class_subject = ClassSubject.new
    respond_to do |format|
      format.html{request.referer}
      format.js
    end
  end

  def create
    @class_subject = @lecturer_subject.class_subjects.new class_subject_params
    # Dem so LHP cua hoc phan nay, ma giang vien tham gia giang day
    num_class_of_lecturer_subject = ClassSubject.get_class_of_lecturer_subject(@lecturer_subject.id).count.to_s

    # Ma LHP = Ma HP giang vien giang day + . + So lop hoc phan giang vien giang day
    @class_subject.class_subject_id = @lecturer_subject.lecturer_subject_id + "." + num_class_of_lecturer_subject
    
    if @class_subject.save
      if @class_subject.lecturer_subject.subject.theory?
        bt = @class_subject.scores.create(name: "Bài tập", score_type: :exercise, percent: 20)
        gk = @class_subject.scores.create(name: "Giữa kỳ", score_type: :mid_semester, percent: 20)
        ck = @class_subject.scores.create(name: "Cuối kỳ", score_type: :end_semester, percent: 60)
        bt.sub_scores.create(name: "BT", percent: 100)
        gk.sub_scores.create(name: "GK", percent: 100)
        ck.sub_scores.create(name: "CK", percent: 100)
      elsif @class_subject.lecturer_subject.subject.practice?
        ck = @class_subject.scores.create(name: "Cuối kỳ", score_type: :end_semester, percent: 100)
        ck.sub_scores.create(name: "CK", percent: 100)
      elsif @class_subject.lecturer_subject.subject.project?
        dda = @class_subject.scores.create(name: "Điểm ĐA", score_type: :project, percent: 70)
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
      flash[:success] = "Cập nhật thông tin lớp học phần thành công"
      redirect_to admin_class_subjects_path
    else
      flash.now[:danger] = "Cập nhật thông tin lớp học phần thất bại"
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
    params.require(:class_subject).permit :semester_id
  end

  def load_class_subject
    @class_subject = ClassSubject.find_by id: params[:id]
    unless @class_subject
      flash[:danger] = "Không tìm thấy lớp học phần"
      redirect_to admin_class_subjects_path      
    end
  end

  def load_collections
    @semesters = Semester.non_confirmed.newest
    @subjects = Subject.all
    @lecturers = []
    if params[:selected_subject_id]
      @subject = Subject.find_by id: params[:selected_subject_id]
      @lecturers = @subject.lecturers
      params[:selected_subject_id] = nil
    end
  end

   def load_semester
    @semester = Semester.find_by id: class_subject_params[:semester_id]
    unless @semester
      flash[:danger] = "Không tìm thấy học kỳ"
      redirect_to admin_class_subjects_path      
    end
  end

  def load_lecturer_subject
    if params[:lecturer_id].present? && params[:subject_id].present?
      @lecturer_subject = LecturerSubject.get_lecturer_subject(params[:lecturer_id], params[:subject_id]).first
      unless @lecturer_subject
        flash[:danger] = "Không tìm thấy giảng viên dạy học phần này"
        redirect_to admin_class_subjects_path
        return
      end
    else
      flash[:danger] = "Không tìm thấy giảng viên dạy học phần này"
      redirect_to admin_class_subjects_path
    end
  end
end
