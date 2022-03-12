class Cart < ApplicationRecord
    belongs_to :user
    has_many :cart_items
    has_many :dishes, through: :cart_items

    validates :status, presence: true
    validates :status, inclusion: { in: ["open", "closed"] }
    validates :discount, numericality: { in: 0..1 }
    
    enum status: { open:0, closed:1 }

    def add_item(dish_id, quantity)
        quantity = quantity.to_i
        cart_item = cart_items.find_by(dish_id: dish_id)
        if cart_item
            cart_item.quantity += quantity
        else
            cart_item = cart_items.build(dish_id: dish_id, quantity: quantity)
        end
        cart_item
    end

    def total_price
        cart_items.to_a.sum{|item| item.value}*(1-(cart.discount || 0))
    end
end
