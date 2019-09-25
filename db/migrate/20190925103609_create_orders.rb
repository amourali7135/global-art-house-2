class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :address_line_1
      t.string :address_line_2
      t.string :address_city
      t.integer :address_zipcode
      t.string :state
      t.string :country
      t.integer :phone_number
      t.jsonb :payment
      t.integer :amount_cents
      t.references :artist, foreign_key: true
      t.references :shopping_cart, foreign_key: true

      t.timestamps
    end
  end
end
