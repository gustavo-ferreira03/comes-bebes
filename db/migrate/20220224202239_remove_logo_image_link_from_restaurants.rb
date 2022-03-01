class RemoveLogoImageLinkFromRestaurants < ActiveRecord::Migration[6.1]
  def change
    remove_column :restaurants, :logo_image_link, :string
  end
end
