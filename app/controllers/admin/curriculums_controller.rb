class Admin::CurriculumsController < ApplicationController
layout "admin_layout"
  
  before_action :authenticate_admin!
  before_action :load_curriculum, only: [:edit, :update, :destroy, :show]
  before_action :load_faculties, only: [:new, :edit]

  def index
    @curriculums = Curriculum.search(name_cont: params[:curriculum_search]).result
      .newest.page(params[:page]).includes :faculty
    respond_to do |format|
      format.html{request.referer}
      format.js
    end
  end

  def new
    @curriculum = Curriculum.new
  end

  def create
    @curriculum = Curriculum.new curriculum_params
    if @curriculum.save
      flash[:success] = "Thêm chương trình đào tạo thành công"
      redirect_to admin_curriculums_path
    else
      flash.now[:danger] = "Thêm chương trình đào tạo thất bại"
      load_faculties
      render :new
    end
  end
  
  def edit
  end

  def update
    if @curriculum.update_attributes curriculum_params
      flash[:success] = "Cập nhật thông tin chương trình đào tạo thành công"
      redirect_to admin_curriculums_path
    else
      flash.now[:danger] = "Cập nhật thông tin chương trình đào tạo thất bại"
      load_faculties
      render :edit
    end
  end

  def show
  	@curriculum_subjects = @curriculum.curriculum_subjects.includes(:subject).semester_asc
  end

  def destroy
    if @curriculum.destroy
      flash[:success] = "Xóa chương trình đào tạo thành công"
    else
      flash[:danger] = "Xóa chương trình đào tạo thất bại"
    end
    redirect_to admin_curriculums_path
  end

  private
  def curriculum_params
    params.require(:curriculum).permit :curriculum_id, :name, :faculty_id
  end

  def load_curriculum
    @curriculum = Curriculum.find_by id: params[:id]
    unless @curriculum
      flash[:danger] = "Không tìm thấy chương trình đào tạo"
      redirect_to admin_curriculums_path      
    end
  end

  def load_faculties 
    @faculties = Faculty.all
  end
end
