class AddRestaurantToDish < ActiveRecord::Migration[6.1]
  def change
    add_reference :dishes, :restaurant, null: false, foreign_key: true
  end
end
