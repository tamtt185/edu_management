class Lecturer::SessionsController < Devise::SessionsController
  layout "lecturer_layout"

  before_action :authenticate_lecturer!

  def new
    super
  end

  def create
    super
  end

  private
  def after_sign_in_path_for lecturer
  	lecturer_path
  end

  def after_sign_out_path_for lecturer
    lecturer_path
  end
end