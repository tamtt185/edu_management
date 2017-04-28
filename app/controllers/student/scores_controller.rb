class Student::ScoresController < ApplicationController
  before_action :authenticate_student!
end
