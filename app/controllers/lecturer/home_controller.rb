class Lecturer::HomeController < ApplicationController
  layout "lecturer_layout"
  before_action :authenticate_lecturer!
end
