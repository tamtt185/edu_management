class CreateStudentEndSemesterScores < ActiveRecord::Migration[5.0]
  def change
    create_table :student_end_semester_scores do |t|
      t.float :score
      t.references :student, foreign_key: true
      t.references :end_semester_score, foreign_key: true

      t.timestamps
    end
  end
end
