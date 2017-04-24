class CreateCurriculumSubjects < ActiveRecord::Migration[5.0]
  def change
    create_table :curriculum_subjects do |t|
      t.integer :parallel_subject_id
      t.integer :prerequisite_subject_id
      t.integer :study_first_subject_id
      t.integer :is_elective, default: 0

      t.references :curriculum, foreign_key: true
      t.references :subject, foreign_key: true

      t.timestamps
    end
  end
end
