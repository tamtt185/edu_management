class Lecturer::StudentClassSubjectsController < ApplicationController
  layout "lecturer_layout"
  
  before_action :authenticate_lecturer!
 
  def index
  end
end
