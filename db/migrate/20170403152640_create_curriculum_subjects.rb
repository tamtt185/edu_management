class CreateCurriculumSubjects < ActiveRecord::Migration[5.0]
  def change
    create_table :curriculum_subjects do |t|
      t.string :curriculum_subject_id
      t.references :curriculum, foreign_key: true
      t.references :subject, foreign_key: true

      t.timestamps
    end
  end
end
