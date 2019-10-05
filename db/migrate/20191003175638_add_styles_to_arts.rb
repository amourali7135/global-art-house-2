class AddStylesToArts < ActiveRecord::Migration[5.2]
  def change
    add_column :arts, :styles, :string
  end
end
