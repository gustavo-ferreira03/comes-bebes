class AddRestaurantToCarts < ActiveRecord::Migration[6.1]
  def change
    add_reference :carts, :restaurant, null: false, foreign_key: true
  end
end
