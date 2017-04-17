class CreateStudentClasses < ActiveRecord::Migration[5.0]
  def change
    create_table :student_classes do |t|
      t.string :student_class_id
      t.string :name
      t.references :faculty, foreign_key: true

      t.timestamps
    end
  end
end
