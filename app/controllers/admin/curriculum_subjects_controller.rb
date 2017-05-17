class Admin::CurriculumSubjectsController < ApplicationController
  layout "admin_layout"
  
  before_action :authenticate_admin!
  before_action :curriculum_subject_params, only: :create
  before_action :load_curriculum, only: [:new, :create, :edit, :update, :destroy, :import]
  before_action :load_curriculum_subject, only: [:edit, :update, :destroy]
  before_action :load_subjects, only: [:new, :edit]

  def new
    @curriculum_subject = @curriculum.curriculum_subjects.build
  end

  def create
    @curriculum_subject = @curriculum.curriculum_subjects.new curriculum_subject_params
    @curriculum_subject.curriculum_subject_id = "HP_CTDT" + @curriculum.id.to_s + curriculum_subject_params[:subject_id].to_s
    if @curriculum_subject.save
      flash[:success] = "Thêm học phần của chương trình đào tạo thành công"
      redirect_to admin_curriculum_path @curriculum
    else
      flash.now[:danger] = "Thêm học phần của chương trình đào tạo thất bại"
      load_subjects
      render :new
    end
  end

  def edit
  end

  def update
    if @curriculum_subject.update_attributes curriculum_subject_params
      flash[:success] = "Cập nhật học phần của chương trình đào tạo thành công"
      redirect_to admin_curriculum_path @curriculum
    else
      flash.now[:danger] = "Cập nhật học phần của chương trình đào tạo thất bại"
      load_subjects
      render :edit
    end
  end
  
  def destroy
    if @curriculum_subject.destroy
      flash[:success] = "Xóa học phần của chương trình đào tạo thành công"
    else
      flash[:danger] = "Xóa học phần của chương trình đào tạo thất bại"
    end
      redirect_to admin_curriculum_path @curriculum
  end

  def import
    CurriculumSubject.import(params[:file])
    flash[:success] = "Import học phần của chương trình đào tạo thành công"
      redirect_to admin_curriculum_path @curriculum
  end

  private
  def curriculum_subject_params
    params.require(:curriculum_subject).permit :semester, :subject_id
  end

  def load_curriculum_subject
    @curriculum_subject = CurriculumSubject.find_by id: params[:id]
    unless @curriculum_subject
      flash[:danger] = "Không tìm thấy học phần của chương trình đào tạo"
      redirect_to admin_curriculum_path @curriculum
    end
  end

  def load_curriculum
    @curriculum = Curriculum.find_by id: params[:curriculum_id]
    unless @curriculum
      flash[:danger] = "Không tìm thấychương trình đào tạo"
      redirect_to admin_curriculum_path @curriculum
    end
  end

  def load_subjects
  	@subjects = Subject.all
  end
end

