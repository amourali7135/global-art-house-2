class DropArtistTagOriginalReference < ActiveRecord::Migration[5.2]
  def change
    remove_column :art_tags, :artist_id
  end
end
