class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :photo
      t.references :artist, null: false, foreign_key: true

      t.timestamps
    end
  end
end
