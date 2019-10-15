class AddPhotosToArtsMultiple < ActiveRecord::Migration[5.2]
  def change
    add_column :photos, :art, :string
  end
end
