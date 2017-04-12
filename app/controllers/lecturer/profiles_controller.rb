class Lecturer::ProfilesController < ApplicationController
  layout "lecturer_layout"

  before_action :load_profile, only: :show

  def show
  end

  private
  def load_profile
    @lecturer = Lecturer.find_by id: params[:id]
    unless @lecturer
      flash[:danger] = "Giảng viên không tồn tại"
      redirect_to root_path
    end
  end
end
