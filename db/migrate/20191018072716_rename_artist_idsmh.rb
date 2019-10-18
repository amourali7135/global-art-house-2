class RenameArtistIdsmh < ActiveRecord::Migration[5.2]
  def change
    rename_column :art_tags, :artists_id, :artist_id
  end
end
