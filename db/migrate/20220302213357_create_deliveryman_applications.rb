class CreateDeliverymanApplications < ActiveRecord::Migration[6.1]
  def change
    create_table :deliveryman_applications do |t|
      t.string :cnh
      t.integer :vehicle_type
      t.integer :status, default: 0
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
