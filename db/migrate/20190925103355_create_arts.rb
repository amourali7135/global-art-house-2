class CreateArts < ActiveRecord::Migration[5.2]
  def change
    create_table :arts do |t|
      t.string :title
      t.text :description
      t.date :completion_date
      t.text :inspiration
      t.boolean :available
      t.references :artist, foreign_key: true

      t.timestamps
    end
  end
end
