class CreateClassSubjects < ActiveRecord::Migration[5.0]
  def change
    create_table :class_subjects do |t|
      t.string :class_subject_id
      t.references :subject, foreign_key: true
      t.references :lecturer, foreign_key: true
      t.references :semester, foreign_key: true

      t.timestamps
    end
  end
end
