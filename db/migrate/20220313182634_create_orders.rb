class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :payment_method

      t.timestamps
    end
    create_table :orders_restaurants, id: false do |t|
      t.belongs_to :order
      t.belongs_to :restaurant
    end
  end
end
