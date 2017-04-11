class Student::ProfilesController < ApplicationController
  before_action :load_profile, only: :show

  def show
  end

  private

  def load_profile
    @student = Student.find_by id: params[:id]
    unless @student
      flash[:danger] = "Sinh vien khong ton tai"
    end
  end
end