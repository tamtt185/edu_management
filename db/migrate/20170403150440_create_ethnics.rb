class CreateEthnics < ActiveRecord::Migration[5.0]
  def change
    create_table :ethnics do |t|
      t.string :name
      t.references :national, foreign_key: true

      t.timestamps
    end
  end
end
