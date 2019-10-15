class RemovePriceOneFromArtsPartTwo < ActiveRecord::Migration[5.2]
  def change
          remove_column :arts, :price_cents
  end
end
