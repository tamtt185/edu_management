class Lecturer::SubjectScoresController < ApplicationController
  layout "lecturer_layout"
  
  before_action :authenticate_lecturer!
  before_action :load_class_subject, only: [:index, :scoring]
  before_action :get_list_student, only: [:index, :scoring]
  before_action :get_column_scores, only: [:index, :scoring]

  def index
  end

  def scoring
    @students.each do |student|
      # Get đối tượng student_class_subject để lưu điểm của SV trong HP này
      get_student_class_subjet(student, @class_subject.id)

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
      
      # Tính điểm thang 10
        avg_score = avg_exercise_score * 0.2 + avg_mid_semester_score * 0.2 + avg_end_semester_score * 0.6
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
    redirect_to lecturer_class_subject_subject_scores_path params[:class_subject_id]
  end

  private
  def score_params
    params.require(:score).permit(sub_scores_attributes: [:id, :name, :percent, :_destroy])
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
    @exercise_score = @class_subject.scores.get_exercise_score
    @mid_semester_score = @class_subject.scores.get_mid_semester_score
    @end_semester_score = @class_subject.scores.get_end_semester_score
  end

  def get_score_of_student sub_score, student_id
    sub_score.student_sub_scores.score_of_student student_id
  end

  def get_student_class_subjet student, class_subject_id
    @student_class_subject = student.student_class_subjects.of_class_subject class_subject_id
  end
end
