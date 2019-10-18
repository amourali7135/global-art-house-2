class AddArtistTagLink < ActiveRecord::Migration[5.2]
  def change
    add_reference :art_tags, :artists, index: true

  end
end
