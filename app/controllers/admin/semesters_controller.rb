class Admin::SemestersController < ApplicationController
layout "admin_layout"
  
  before_action :semester_params, only: :create
  before_action :load_semester, only: [:edit, :update, :destroy]

  def index
    @semesters = Semester.search(name_cont: params[:semester_search]).result
      .newest.page(params[:page])
    respond_to do |format|
      format.html{request.referer}
      format.js
    end
  end

  def new
    @semester = Semester.new
  end

  def create
    @semester = Semester.new semester_params
    if @semester.save
      flash[:success] = "Thêm học phần thành công"
      redirect_to admin_semesters_path
    else
      flash.now[:danger] = "Thêm học phần thất bại"
      render :new
    end
  end
  
  def edit
  end

  def update
    if @semester.update_attributes semester_params
      flash[:success] = "Chỉnh sửa học phần thành công"
      redirect_to admin_semesters_path
    else
      flash.now[:danger] = "Chỉnh sửa học phần thất bại"
      render :edit
    end
  end

  def destroy
    if @semester.destroy
      flash[:success] = "Xóa học phần thành công"
    else
      flash[:danger] = "Xóa học phần thất bại"
    end
    redirect_to admin_semesters_path
  end

  def import
    semester.import(params[:file])
    flash[:success] = "Import học phần thành công"
    redirect_to admin_semesters_path
  end

  private
  def semester_params
    params.require(:semester).permit :semester_id, :name, :num_of_credit, :semester_type,
      :parallel_semester_id, :prerequisite_semester_id, :study_first_semester_id, :is_elective
  end

  def load_semester
    @semester = semester.find_by id: params[:id]
    unless @semester
      flash[:danger] = "Không tìm thấy học phần"
      redirect_to admin_semesters_path      
    end
  end
end
