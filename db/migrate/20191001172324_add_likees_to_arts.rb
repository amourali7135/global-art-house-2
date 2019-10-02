class AddLikeesToArts < ActiveRecord::Migration[5.2]
  def change
    add_column :arts, :likees_count, :integer, :default => 0
  end
end
