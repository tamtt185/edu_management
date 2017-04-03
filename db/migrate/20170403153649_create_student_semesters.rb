class CreateStudentSemesters < ActiveRecord::Migration[5.0]
  def change
    create_table :student_semesters do |t|
      t.string :school_year
      t.integer :total_credit
      t.float :avg_score
      t.references :student, foreign_key: true
      t.references :semester, foreign_key: true

      t.timestamps
    end
  end
end
