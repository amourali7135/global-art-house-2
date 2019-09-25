class CartProduct < ApplicationRecord
  belongs_to :shopping_cart
  belongs_to :art
end
