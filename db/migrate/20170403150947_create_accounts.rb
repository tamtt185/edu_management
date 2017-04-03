class CreateAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :accounts do |t|
      t.string :user_name
      t.string :password
      t.integer :role
      t.references :student, foreign_key: true
      t.references :lecturers, foreign_key: true

      t.timestamps
    end
  end
end
