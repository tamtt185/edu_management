class CreateScores < ActiveRecord::Migration[5.0]
  def change
    create_table :scores do |t|
      t.integer :score_type
      t.string :name
      t.integer :percent
      t.references :class_subject, foreign_key: true

      t.timestamps
    end
  end
end
