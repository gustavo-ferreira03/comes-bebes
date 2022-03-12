class Cart < ApplicationRecord
    belongs_to :user
    has_many :cart_items
    has_many :dishes, through: :cart_items

    validates :discount, numericality: { in: 0..1 }
    
    def total_price
        cart_items.to_a.sum{|item| item.value}*(1-(cart.discount || 0))
    end
end
