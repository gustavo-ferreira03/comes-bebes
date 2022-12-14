class CreateImages < ActiveRecord::Migration[6.1]
  def change
    create_table :images do |t|
      t.string :image_link
      t.references :imageable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
