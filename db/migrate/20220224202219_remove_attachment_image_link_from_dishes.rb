class RemoveAttachmentImageLinkFromDishes < ActiveRecord::Migration[6.1]
  def change
    remove_column :dishes, :attachment_image_link, :string
  end
end
