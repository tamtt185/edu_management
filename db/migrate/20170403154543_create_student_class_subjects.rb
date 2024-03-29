class CreateStudentClassSubjects < ActiveRecord::Migration[5.0]
  def change
    create_table :student_class_subjects do |t|
      t.string :student_class_subject_id
      t.float :avg_exercise_score
      t.float :avg_mid_semester_score
      t.float :avg_end_semester_score
      t.float :avg_diligence_score
      t.float :avg_protect_score
      t.float :avg_project_score
      t.integer :is_confirm, default: 0
      t.float :avg_score
      t.float :gpa_score
      t.string :letter_score

      t.references :student, foreign_key: true
      t.references :class_subject, foreign_key: true

      t.timestamps
    end
  end
end
