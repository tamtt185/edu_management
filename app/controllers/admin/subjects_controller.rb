class Admin::SubjectsController < ApplicationController
  layout "admin_layout"
  
  before_action :authenticate_admin!
  before_action :subject_params, only: :create
  before_action :load_subject, only: [:edit, :update, :destroy]

  def index
    @subjects = Subject.search(name_cont: params[:subject_search]).result
      .newest.page(params[:page])
    respond_to do |format|
      format.html{request.referer}
      format.js
    end
  end

  def new
    @subject = Subject.new
    @subjects = Subject.all
  end

  def create
    @subject = Subject.new subject_params
    if @subject.save
      flash[:success] = "Thêm học phần thành công"
      redirect_to admin_subjects_path
    else
      flash.now[:danger] = "Thêm học phần thất bại"
      render :new
    end
  end
  
  def edit
    @subjects = Subject.all
  end

  def update
    if @subject.update_attributes subject_params
      flash[:success] = "Chỉnh sửa học phần thành công"
      redirect_to admin_subjects_path
    else
      flash.now[:danger] = "Chỉnh sửa học phần thất bại"
      render :edit
    end
  end

  def destroy
    if @subject.destroy
      flash[:success] = "Xóa học phần thành công"
    else
      flash[:danger] = "Xóa học phần thất bại"
    end
    redirect_to admin_subjects_path
  end

  def import
    Subject.import(params[:file])
    flash[:success] = "Import học phần thành công"
    redirect_to admin_subjects_path
  end

  private
  def subject_params
    params.require(:subject).permit :subject_id, :name, :num_of_credit, :subject_type,
      :parallel_subject_id, :prerequisite_subject_id, :study_first_subject_id, :is_elective
  end

  def load_subject
    @subject = Subject.find_by id: params[:id]
    unless @subject
      flash[:danger] = "Không tìm thấy học phần"
      redirect_to admin_subjects_path      
    end
  end
end
