class CreateLecturers < ActiveRecord::Migration[5.0]
  def change
    create_table :lecturers do |t|
      t.string :lecturer_number
      t.string :name
      t.integer :degree
      t.string :academic_title
      t.integer :position
      t.integer :gender
      t.string :birthday
      t.string :phone
      t.string :email
      t.references :national, foreign_key: true
      t.references :ethnic, foreign_key: true
      t.references :religion, foreign_key: true
      t.references :faculty, foreign_key: true

      t.timestamps
    end
  end
end
