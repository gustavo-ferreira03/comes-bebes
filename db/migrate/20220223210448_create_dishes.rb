class CreateDishes < ActiveRecord::Migration[6.1]
  def change
    create_table :dishes do |t|
      t.string :name
      t.string :attachment_image_link
      t.string :description
      t.float :value
      t.integer :serving
      t.integer :stock

      t.timestamps
    end
  end
end
