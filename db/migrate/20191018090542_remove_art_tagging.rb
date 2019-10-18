class RemoveArtTagging < ActiveRecord::Migration[5.2]
  def change
    remove_column :tags, :artist_tagging
    rename_column :tags, :art_tagging, :name
  end
end
