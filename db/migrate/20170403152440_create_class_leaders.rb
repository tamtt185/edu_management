class CreateClassLeaders < ActiveRecord::Migration[5.0]
  def change
    create_table :class_leaders do |t|
      t.references :lecturer, foreign_key: true
      t.references :student_class, foreign_key: true

      t.timestamps
    end
  end
end
