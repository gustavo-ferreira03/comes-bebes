class Dish < ApplicationRecord
    belongs_to :restaurant
    
    has_many :images, as: :imageable
    has_many :cart_items
    has_many :carts, through: :cart_items

    validates :name, :description, :value, :stock, :serving, presence: true
    validates :description, length: { in: 10..200 }
    validates :value, :stock, numericality: { greater_than_or_equal_to: 0 }
    validates :serving, inclusion: { in: ["small", "medium", "large"] }

    enum serving: { small:0, medium:1, large:2 }
end
