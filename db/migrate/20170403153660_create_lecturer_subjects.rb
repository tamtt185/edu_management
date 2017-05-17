class CreateLecturerSubjects < ActiveRecord::Migration[5.0]
  def change
    create_table :lecturer_subjects do |t|
      t.string :lecturer_subject_id
      t.references :lecturer, foreign_key: true
      t.references :subject, foreign_key: true

      t.timestamps
    end
  end
end
