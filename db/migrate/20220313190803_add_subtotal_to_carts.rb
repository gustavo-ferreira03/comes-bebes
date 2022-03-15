class AddSubtotalToCarts < ActiveRecord::Migration[6.1]
  def change
    add_column :carts, :subtotal, :float
  end
end
