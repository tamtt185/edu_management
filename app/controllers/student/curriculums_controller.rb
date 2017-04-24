class Student::CurriculumsController < ApplicationController
  before_action :authenticate_student!
  before_action :load_curriculum, only: :index

  def index
  end

  def load_curriculum
    @curriculum = current_student.curriculum
    unless @curriculum
      flash[:danger] = "Chương trình đào tạo không tồn tại"
      redirect_to root_path
    end
  end
end
