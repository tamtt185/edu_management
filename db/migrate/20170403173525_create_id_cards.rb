class CreateIdCards < ActiveRecord::Migration[5.0]
  def change
    create_table :id_cards do |t|
      t.string :number_id
      t.string :date_of_issued
      t.references :student, foreign_key: true
      t.references :province, foreign_key: true

      t.timestamps
    end
  end
end
