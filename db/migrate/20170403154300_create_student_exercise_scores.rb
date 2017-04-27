class CreateStudentExerciseScores < ActiveRecord::Migration[5.0]
  def change
    create_table :student_exercise_scores do |t|
      t.float :score
      t.references :student, foreign_key: true
      t.references :exercise_score, foreign_key: true

      t.timestamps
    end
  end
end
