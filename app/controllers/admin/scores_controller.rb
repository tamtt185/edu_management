class Admin::ScoresController < ApplicationController
  layout "admin_layout"

  before_action :authenticate_admin!
  before_action :load_class_subject, only: [:index, :create, :scoring, :confirm]
  before_action :get_list_student, only: [:scoring, :confirm]
  before_action :get_column_scores, only: [:scoring, :confirm]

  def index
    @students = @class_subject.students.search(name_or_student_id_cont: params[:student_search]).result
      .newest.page(params[:page]).includes(:student_class)
    respond_to do |format|
      format.html{request.referer}
      format.js
    end
    @scores = @class_subject.scores.includes(:sub_scores)
  end
 
  def create
    student_score_params.each do |id, value|
      @student_sub_score = StudentSubScore.find_student_sub_score(value["student_id"].to_i, value["sub_score_id"].to_i).first
      if @student_sub_score.present?
        @student_sub_score.score = value["score"].to_i
        @student_sub_score.is_confirm = value["is_confirm"]
        unless @student_sub_score.save
          flash[:danger] =  "Cập nhật thông tin điểm không thành công" 
          redirect_to admin_class_subject_scores_path params[:class_subject_id]
        end
        flash[:success] =  "Cập nhật thông tin điểm thành công" 
      else
        @student_sub_score = StudentSubScore.new value.symbolize_keys
        unless @student_sub_score.save
          flash[:danger] =  "Nhập điểm không thành công" 
          redirect_to admin_class_subject_scores_path params[:class_subject_id]
        end
          flash[:success] =  "Cập nhật thông tin điểm thành công" 
      end
    end
    redirect_to admin_class_subject_scores_path params[:class_subject_id]
  end

  def scoring
    @students.each do |student|
      # Get đối tượng student_class_subject để lưu điểm của SV trong HP này
      get_student_class_subjet(student, @class_subject.id)
      
      # xac nhan diem
      if params[:confirm_params].to_i == 1
        @student_class_subject.is_confirm = 1
      end

      # Tính điểm trung bình bài tập
      if @exercise_score.present?
        avg_exercise_score = 0
        @exercise_score.sub_scores.each do |exercise_score|
          if get_score_of_student(exercise_score, student.id).present?
            avg_exercise_score = get_score_of_student(exercise_score, student.id).score * exercise_score.percent / 100
          end
        end
        # Lưu điểm đã tính vào đối tượng
        @student_class_subject.avg_exercise_score = avg_exercise_score
      end

      # Tính điểm trung bình cột điểm giữa kỳ
      if @mid_semester_score.present?
        avg_mid_semester_score = 0
        @mid_semester_score.sub_scores.each do |mid_semester_score|
          if get_score_of_student(mid_semester_score, student.id).present?
            avg_mid_semester_score = get_score_of_student(mid_semester_score, student.id).score * mid_semester_score.percent / 100
          end
        end
        # Lưu điểm đã tính vào đối tượng
        @student_class_subject.avg_mid_semester_score = avg_mid_semester_score
      end

      # Tính điểm trung bình cột điểm cuối kỳ
      if @end_semester_score.present?
        avg_end_semester_score = 0
        @end_semester_score.sub_scores.each do |end_semester_score|
          if get_score_of_student(end_semester_score, student.id).present?
            avg_end_semester_score = get_score_of_student(end_semester_score, student.id).score * end_semester_score.percent / 100
          end
        end
        # Lưu điểm đã tính vào đối tượng
        @student_class_subject.avg_end_semester_score = avg_end_semester_score
      end

      # Tính điểm trung bình cột điểm chuyên cần
      if @diligence_score.present?
        avg_diligence_score = 0
        @diligence_score.sub_scores.each do |diligence_score|
          if get_score_of_student(diligence_score, student.id).present?
            avg_diligence_score = get_score_of_student(diligence_score, student.id).score * diligence_score.percent / 100
          end
        end
        # Lưu điểm đã tính vào đối tượng
        @student_class_subject.avg_diligence_score = avg_diligence_score
      end

      # Tính điểm trung bình cột điểm bảo vệ
      if @protect_score.present?
        avg_protect_score = 0
        @protect_score.sub_scores.each do |protect_score|
          if get_score_of_student(protect_score, student.id).present?
            avg_protect_score = get_score_of_student(protect_score, student.id).score * protect_score.percent / 100
          end
        end
        # Lưu điểm đã tính vào đối tượng
        @student_class_subject.avg_protect_score = avg_protect_score
      end

      # Tính điểm trung bình cột điểm đồ án
      if @project_score.present?
        avg_project_score = 0
        @project_score.sub_scores.each do |project_score|
          if get_score_of_student(project_score, student.id).present?
            avg_project_score = get_score_of_student(project_score, student.id).score * project_score.percent / 100
          end
        end
        # Lưu điểm đã tính vào đối tượng
        @student_class_subject.avg_project_score = avg_project_score
      end
      
      # Tính điểm thang 10
      if @class_subject.lecturer_subject.subject.theory?
        avg_score = avg_exercise_score * 0.2 + avg_mid_semester_score * 0.2 + avg_end_semester_score * 0.6
      elsif @class_subject.lecturer_subject.subject.practice?
        avg_score = avg_end_semester_score
      elsif @class_subject.lecturer_subject.subject.project?
        avg_score = avg_project_score * 0.7 + avg_end_semester_score * 0.3
      elsif @class_subject.lecturer_subject.subject.intership?
        avg_score = avg_diligence_score * 0.7 + avg_protect_score * 0.3
      end

      # Lưu điểm đã tính vào đối tượng
        @student_class_subject.avg_score = avg_score

      # Tính điểm thang 4 và điểm chữ
      if avg_score >= 9.5
        @student_class_subject.gpa_score = 4.0
        @student_class_subject.letter_score = "A+"
      elsif avg_score >= 8.5
        @student_class_subject.gpa_score = 4.0
        @student_class_subject.letter_score = "A"
      elsif avg_score >= 8.0
        @student_class_subject.gpa_score = 3.5
        @student_class_subject.letter_score = "B+"
      elsif avg_score >= 7.0
        @student_class_subject.gpa_score = 3.0
        @student_class_subject.letter_score = "B"
      elsif avg_score >= 6.5
        @student_class_subject.gpa_score = 2.5
        @student_class_subject.letter_score = "C+"
      elsif avg_score >=5.5
        @student_class_subject.gpa_score = 2.0
        @student_class_subject.letter_score = "C"
      elsif avg_score >= 5.0
        @student_class_subject.gpa_score = 1.5
        @student_class_subject.letter_score = "D+"
      elsif avg_score >= 4.0
        @student_class_subject.gpa_score = 1.0
        @student_class_subject.letter_score = "D"
      else
        @student_class_subject.gpa_score = 0.0
        @student_class_subject.letter_score = "F"
      end

      #Lưu lại
      unless @student_class_subject.save
        flash[:danger] = "Tính điểm của sinh viên trong học phần này không thành công"
        redirect_to lecturer_class_subject_path params[:class_subject_id]
      end
    end
    redirect_to admin_class_subject_scores_path params[:class_subject_id]
  end

  private
  def score_params
    params.require(:score).permit(sub_scores_attributes: [:id, :name, :percent, :_destroy])
  end

  def student_score_params
    JSON.parse params.require :student_scores
  end

  def load_class_subject
    @class_subject = ClassSubject.find_by(id: params[:class_subject_id])
    unless @class_subject
      flash[:danger] = "Lớp học phần không tồn tại"
      redirect_to root_path
    end
  end

  def get_list_student
    @students = @class_subject.students.includes :student_class
    unless @students
      flash[:danger] = "Không tìm thấy sinh viên nào trong lớp học phần này"
      redirect_to lecturer_class_subject_path params[:class_subject_id]
    end
  end

  def get_column_scores
    @exercise_score = @class_subject.scores.get_exercise_score.first
    @mid_semester_score = @class_subject.scores.get_mid_semester_score.first
    @end_semester_score = @class_subject.scores.get_end_semester_score.first
    @diligence_score = @class_subject.scores.get_diligence_score.first
    @protect_score = @class_subject.scores.get_protect_score.first
    @project_score = @class_subject.scores.get_project_score.first
  end

  def get_score_of_student sub_score, student_id
    sub_score.student_sub_scores.score_of_student student_id
  end

  def get_student_class_subjet student, class_subject_id
    @student_class_subject = student.student_class_subjects.of_class_subject class_subject_id
  end
end
