class CreateCurriculumSubjects < ActiveRecord::Migration[5.0]
  def change
    create_table :curriculum_subjects do |t|
      t.references :curriculum, foreign_key: true
      t.references :subject, foreign_key: true

      t.timestamps
    end
  end
end
