class AddPriceToArtsTwo < ActiveRecord::Migration[5.2]
  def change
    add_monetize :arts, :price, currency: { present: false }
  end
end
