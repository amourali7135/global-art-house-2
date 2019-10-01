class AddLikeesCountToArtist < ActiveRecord::Migration[5.2]
  def change
      add_column :artists, :likees_count, :integer, :default => 0
  end
end
