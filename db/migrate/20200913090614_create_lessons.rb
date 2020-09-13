class CreateLessons < ActiveRecord::Migration[6.0]
  def change
    create_table :lessons do |t|
      t.string :title
      t.string :subdescription
      t.text :description
      t.text :learnings
      t.integer :rating
      t.integer :students
      t.text :prerequisites
      t.boolean :free
      t.integer :price_cents
      t.references :artist, null: false, foreign_key: true

      t.timestamps
    end
  end
end
