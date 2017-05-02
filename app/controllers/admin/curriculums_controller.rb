class Admin::CurriculumsController < ApplicationController
layout "admin_layout"
  
  before_action :load_curriculum, only: [:edit, :update, :destroy, :show]

  def index
    @curriculums = Curriculum.newest.page(params[:page])
  end

  def new
    @curriculum = Curriculum.new
    @faculties = Faculty.all
  end

  def create
    binding.pry
    @curriculum = Curriculum.new curriculum_params
    if @curriculum.save
      flash[:success] = "Thêm chương trình đào tạo thành công"
      redirect_to admin_curriculums_path
    else
      flash.now[:danger] = "Thêm chương trình đào tạo thất bại"
      render :new
    end
  end
  
  def edit
  end

  def update
    if @curriculum.update_attributes curriculum_params
      flash[:success] = "Chỉnh sửa chương trình đào tạo thành công"
      redirect_to admin_curriculums_path
    else
      flash.now[:danger] = "Chỉnh sửa chương trình đào tạo thất bại"
      render :edit
    end
  end

  def show
  	@curriculum_subjects = @curriculum.curriculum_subjects.page(params[:page])
  end

  def destroy
    if @curriculum.destroy
      flash[:success] = "Xóa chương trình đào tạo thành công"
    else
      flash[:danger] = "Xóa chương trình đào tạo thất bại"
    end
    redirect_to admin_curriculums_path
  end

  def import
    Curriculum.import(params[:file])
    flash[:success] = "Import chương trình đào tạo thành công"
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
end
