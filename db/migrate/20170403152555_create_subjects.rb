class CreateSubjects < ActiveRecord::Migration[5.0]
  def change
    create_table :subjects do |t|
      t.integer :subject_id
      t.string :name
      t.integer :num_of_credit

      t.timestamps
    end
  end
end
