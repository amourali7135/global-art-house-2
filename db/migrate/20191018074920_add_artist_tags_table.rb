class AddArtistTagsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :artist_tags do |t|
      t.references :artist, foreign_key: true
      t.references :tag, foreign_key: true

      t.timestamps
    end
  end
end
