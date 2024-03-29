class Lecturer::LecturerSubjectsController < ApplicationController
  layout "lecturer_layout"
  
  before_action :authenticate_lecturer!
  before_action :load_lecturer, only: [:index, :create, :update]
  before_action :load_subjects, only: [:new, :edit]
  before_action :load_lecturer_subject, only: [:edit, :update, :destroy]
  before_action :load_subject, only: [:create, :update]

  def index
  	@lecturer_subjects = @lecturer.lecturer_subjects.includes :subject
  end

  def new
    @lecturer_subject = LecturerSubject.new
  end

  def create
    @lecturer_subject = @lecturer.lecturer_subjects.new lecturer_subject_params
    @lecturer_subject.lecturer_subject_id = @lecturer.lecturer_id + "." + @subject.subject_id
    if @lecturer_subject.save
      flash[:success] = "Thêm học phần thành công"
      redirect_to lecturer_lecturer_subjects_path
    else
      flash.now[:danger] = "Thêm học phần thất bại"
      load_subjects
      render :new
    end
  end
  
  def edit
  end

  def update
    @lecturer_subject.lecturer_subject_id = @lecturer.lecturer_id + @subject.subject_id
    if @lecturer_subject.update_attributes lecturer_subject_params
      flash[:success] = "Cập nhật thông tin học phần thành công"
      redirect_to lecturer_lecturer_subjects_path
    else
      flash.now[:danger] = "Cập nhật thông tin học phần thất bại"
      load_subjects
      render :edit
    end
  end

  def destroy
    if @lecturer_subject.destroy
      flash[:success] = "Xóa học phần thành công"
    else
      flash[:danger] = "Xóa học phần thất bại"
    end
    redirect_to lecturer_lecturer_subjects_path
  end

  private
  def lecturer_subject_params
    params.require(:lecturer_subject).permit :subject_id
  end

  def load_lecturer_subject
    @lecturer_subject = LecturerSubject.find_by id: params[:id]
    unless @lecturer_subject
      flash[:danger] = "Không tìm thấy học phần"
      redirect_to lecturer_lecturer_subjects_path      
    end
  end

  def load_lecturer
    @lecturer = Lecturer.find_by id: current_lecturer.id
    unless @lecturer
      flash[:danger] = "Giảng viên không tồn tại"
      redirect_to lecturer_lecturer_subjects_path
    end
  end
  
  def load_subject
    @subject = Subject.find_by id: lecturer_subject_params[:subject_id]
    unless @subject
      flash[:danger] = "Học phần không tồn tại"
      redirect_to lecturer_lecturer_subjects_path
    end
  end

  def load_subjects
  	@subjects = Subject.all
  end
end
