class CreateExerciseScores < ActiveRecord::Migration[5.0]
  def change
    create_table :exercise_scores do |t|
      t.string :name
      t.integer :percent
      t.references :exercise, foreign_key: true

      t.timestamps
    end
  end
end
