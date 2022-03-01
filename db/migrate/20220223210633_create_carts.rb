class CreateCarts < ActiveRecord::Migration[6.1]
  def change
    create_table :carts do |t|
      t.float :discount
      t.integer :status
      t.integer :payment_method
      t.date :paid_at
      t.string :secure_token

      t.timestamps
    end
  end
end
