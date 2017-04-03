class CreateStudentClasses < ActiveRecord::Migration[5.0]
  def change
    create_table :student_classes do |t|
      t.string :name
      t.integer :total_student
      t.integer :number_month_school
      t.references :faculty, foreign_key: true
      t.references :course, foreign_key: true

      t.timestamps
    end
  end
end
