class CreateStudents < ActiveRecord::Migration[5.0]
  def change
    create_table :students do |t|
      t.string :student_number
      t.string :name
      t.string :avatar
      t.integer :gender
      t.string :birthday
      t.string :phone
      t.string :email
      t.string :address
      t.string :second_language
      t.references :national, foreign_key: true
      t.references :ethnic, foreign_key: true
      t.references :religion, foreign_key: true
      t.references :account, foreign_key: true
      t.references :specialization, foreign_key: true
      t.references :student_class, foreign_key: true
      t.references :curriculum, foreign_key: true

      t.timestamps
    end
  end
end
