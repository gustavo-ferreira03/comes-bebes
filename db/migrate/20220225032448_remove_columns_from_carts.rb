class RemoveColumnsFromCarts < ActiveRecord::Migration[6.1]
  def change
    remove_columns :carts, :payment_method, :paid_at, :secure_token
  end
end
