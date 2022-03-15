class Order < ApplicationRecord
    has_many :cart_items
    has_and_belongs_to_many :restaurants
end
