class CreateSemesters < ActiveRecord::Migration[5.0]
  def change
    create_table :semesters do |t|
      t.integer :name
      t.string :begin_time
      t.string :end_time

      t.timestamps
    end
  end
end
