class AddArtistTaggingColumn < ActiveRecord::Migration[5.2]
  def change
    add_column :tags, :artist_tagging, :string
  end
end
