class AddSkuToArts < ActiveRecord::Migration[5.2]
  def change
    add_column :arts, :sku, :string
  end
end
