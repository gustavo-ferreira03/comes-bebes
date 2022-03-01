class Image < ApplicationRecord
  belongs_to :imageable, polymorphic: true

  validates :image_link, presence: true
end
