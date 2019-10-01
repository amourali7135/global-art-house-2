class AddFolloweesCountToArtist < ActiveRecord::Migration[5.2]
  def change
      add_column :artists, :followees_count, :integer, :default => 0
  end
end
