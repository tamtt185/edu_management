class CreateSubScores < ActiveRecord::Migration[5.0]
  def change
    create_table :sub_scores do |t|
      t.string :name
      t.integer :percent
      t.references :score, foreign_key: true

      t.timestamps
    end
  end
end
