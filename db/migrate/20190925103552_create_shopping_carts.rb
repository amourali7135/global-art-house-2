class CreateShoppingCarts < ActiveRecord::Migration[5.2]
  def change
    create_table :shopping_carts do |t|
      t.integer :total_price_cents
      t.integer :count
      t.string :status
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
