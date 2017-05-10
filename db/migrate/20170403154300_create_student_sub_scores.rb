class CreateStudentSubScores < ActiveRecord::Migration[5.0]
  def change
    create_table :student_sub_scores do |t|
      t.float :score
      t.integer :is_confirm, default: 0
      t.references :student, foreign_key: true
      t.references :sub_score, foreign_key: true

      t.timestamps
    end
  end
end
