class CreateStudentSubScores < ActiveRecord::Migration[5.0]
  def change
    create_table :student_sub_scores do |t|
      t.float :score
      t.references :student, foreign_key: true
      t.references :sub_score, foreign_key: true

      t.timestamps
    end
  end
end
