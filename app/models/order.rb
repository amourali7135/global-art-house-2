class Order < ApplicationRecord
  belongs_to :artist
  belongs_to :shopping_cart
end
