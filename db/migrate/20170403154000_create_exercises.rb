class CreateExercises < ActiveRecord::Migration[5.0]
  def change
    create_table :exercises do |t|
      t.references :class_subject, foreign_key: true

      t.timestamps
    end
  end
end
