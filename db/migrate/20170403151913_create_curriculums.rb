class CreateCurriculums < ActiveRecord::Migration[5.0]
  def change
    create_table :curriculums do |t|
      t.string :curriculum_id
      t.string :name
      t.references :faculty, foreign_key: true

      t.timestamps
    end
  end
end
