class CreateServices < ActiveRecord::Migration[6.0]
  def change
    create_table :services do |t|
      t.string :title
      t.text :description
      t.integer :price_cents
      t.string :length
      t.string :photo
      t.references :artist, null: false, foreign_key: true

      t.timestamps
    end
  end
end
