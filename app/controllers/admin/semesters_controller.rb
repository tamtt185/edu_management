class Admin::SemestersController < ApplicationController
  layout "admin_layout"
  
  before_action :authenticate_admin!
  before_action :semester_params, only: :create
  before_action :load_semester, only: [:edit, :update, :destroy]

  def index
    @semesters = Semester.search(name_or_semester_id_cont: params[:semester_search]).result
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
    semester_id = semester_params[:period][2..3] + semester_params[:period][7..8]
    semester_id += case semester_params[:name]
    when "Học kỳ 1"
      "10"
    when "Học kỳ 2"
      "20"
    when "Học kỳ hè"
      "21"
    end
    
    @semester = Semester.new semester_params
    @semester.semester_id = semester_id 
    if @semester.save
      flash[:success] = "Thêm học kỳ thành công"
      redirect_to admin_semesters_path
    else
      flash.now[:danger] = "Thêm học kỳ thất bại"
      render :new
    end
  end
  
  def edit
  end

  def update
    if semester_params[:period].present?
      semester_id = semester_params[:period][2..3] + semester_params[:period][7..8]
      semester_id += case semester_params[:name]
      when "Học kỳ 1"
        "10"
      when "Học kỳ 2"
        "20"
      when "Học kỳ hè"
        "21"
      end
      @semester.semester_id = semester_id
    end
    if @semester.update_attributes semester_params
      flash[:success] = "Cập nhật thông tin học kỳ thành công"
      redirect_to admin_semesters_path
    else
      flash.now[:danger] = "Cập nhật thông tin học kỳ thất bại"
      render :edit
    end
  end

  def destroy
    if @semester.destroy
      flash[:success] = "Xóa học kỳ thành công"
    else
      flash[:danger] = "Xóa học kỳ thất bại"
    end
    redirect_to admin_semesters_path
  end

  private
  def semester_params
    params.require(:semester).permit :name, :status, :period
  end

  def load_semester
    @semester = Semester.find_by id: params[:id]
    unless @semester
      flash[:danger] = "Không tìm thấy học kỳ"
      redirect_to admin_semesters_path      
    end
  end
end
