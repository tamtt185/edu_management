class HomeController < ApplicationController
  before_action :authenticate_student!
end
