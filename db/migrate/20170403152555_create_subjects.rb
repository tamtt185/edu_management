class CreateSubjects < ActiveRecord::Migration[5.0]
  def change
    create_table :subjects do |t|
      t.string :subject_id
      t.string :name
      t.float :num_of_credit
      t.integer :parallel_subject_id
      t.integer :prerequisite_subject_id
      t.integer :study_first_subject_id
      t.integer :is_elective, default: 0
      t.integer :subject_type, default: 0

      t.timestamps
    end
  end
end
