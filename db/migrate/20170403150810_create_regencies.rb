class CreateRegencies < ActiveRecord::Migration[5.0]
  def change
    create_table :regencies do |t|
      t.string :name
      t.integer :plus_point

      t.timestamps
    end
  end
end
