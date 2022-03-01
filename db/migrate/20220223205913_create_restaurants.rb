class CreateRestaurants < ActiveRecord::Migration[6.1]
  def change
    create_table :restaurants do |t|
      t.string :logo_image_link
      t.integer :restaurant_type
      t.string :cnpj

      t.timestamps
    end
  end
end
