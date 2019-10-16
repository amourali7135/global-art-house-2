class AddKindsToArts < ActiveRecord::Migration[5.2]
  def change
    add_column :arts, :kind, :string
  end
end
