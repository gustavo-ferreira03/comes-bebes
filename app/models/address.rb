class Address < ApplicationRecord
    belongs_to :addressable, polymorphic: true

    validates :street, :number, :city, :state, :zip_code, presence: true
    validates :zip_code, format: { with: /[0-9]{5}+-+[0-9]{3}/ }
end
