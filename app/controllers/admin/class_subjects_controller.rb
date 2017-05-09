class Admin::ClassSubjectsController < ApplicationController
  layout "admin_layout"
  
  before_action :load_collections, only: [:new, :edit]
  before_action :load_class_subject, only: [:edit, :update, :destroy]

  def index
    @class_subjects = ClassSubject.search(class_subject_id_cont: params[:class_subject_search]).result
      .newest.page(params[:page])
    respond_to do |format|
      format.html{request.referer}
      format.js
    end
  end

  def new
    @class_subject = ClassSubject.new
  end

  def create
    @class_subject = ClassSubject.new class_subject_params
    if @class_subject.save
      flash[:success] = "Thêm lớp học phần thành công"
      redirect_to admin_class_subjects_path
    else
      flash.now[:danger] = "Thêm lớp học phần thất bại"
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
    params.require(:class_subject).permit :class_subject_id, :subject_id, :lecturer_id, :semester_id
  end

  def load_class_subject
    @class_subject = ClassSubject.find_by id: params[:id]
    unless @class_subject
      flash[:danger] = "Không tìm thấy lớp học phần"
      redirect_to admin_class_subjects_path      
    end
  end

  def load_collections
    @subjects = Subject.all
    @lecturers = Lecturer.all
    @semesters = Semester.newest
  end
end
