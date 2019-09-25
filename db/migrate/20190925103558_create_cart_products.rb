class CreateCartProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :cart_products do |t|
      t.references :shopping_cart, foreign_key: true
      t.references :art, foreign_key: true

      t.timestamps
    end
  end
end
