class Restaurant < ApplicationRecord
    belongs_to :user
    
    has_one :image, as: :imageable, dependent: :destroy
    has_one :address, as: :addressable, dependent: :destroy
    has_many :dishes, dependent: :destroy
    has_and_belongs_to_many :orders

    validates :name, :cnpj, :restaurant_type, presence: true
    validates :restaurant_type, inclusion: { in: ["fast_food", "italian", "japanese", "vegan"] }
    validates :cnpj, format: { with: /\d{2}\.\d{3}\.\d{3}\/\d{4}\-\d{2}/ }

    enum restaurant_type: { fast_food:0, italian:1, japanese:2, vegan:3 }
end
