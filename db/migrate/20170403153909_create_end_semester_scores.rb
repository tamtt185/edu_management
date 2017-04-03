class CreateEndSemesterScores < ActiveRecord::Migration[5.0]
  def change
    create_table :end_semester_scores do |t|
      t.string :name
      t.integer :percent
      t.references :class_subject, foreign_key: true

      t.timestamps
    end
  end
end
