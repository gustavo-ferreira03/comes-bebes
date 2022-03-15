class Cart < ApplicationRecord
    belongs_to :user
    belongs_to :restaurant
    has_many :cart_items, dependent: :destroy
    has_many :dishes, through: :cart_items

    validates :discount, numericality: { in: 0..1 }
    validates :subtotal, numericality: { greater_than_or_equal_to: 0 }
    before_save :set_subtotal

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

    def subtotal
        cart_items.to_a.sum{|item| item.value}*(1-(discount || 0))
    end

    private
        def set_subtotal
            self[:subtotal] = subtotal
        end
end
