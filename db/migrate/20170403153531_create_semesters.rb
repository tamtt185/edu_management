class CreateSemesters < ActiveRecord::Migration[5.0]
  def change
    create_table :semesters do |t|
      t.string :semester_id
      t.string :name
      t.string :period
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
