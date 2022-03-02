class User < ApplicationRecord
    has_one :wallet
    has_one :deliveryman_application
    has_one :restaurant
    has_many :addresses, as: :addressable
    has_many :carts

    has_secure_password

    validates :name, :email, :phone, :birthdate, :user_type, presence: true
    validates :email, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }
    validates :cpf, format: { with: /\d{3}\.\d{3}\.\d{3}\-\d{2}/ }
    validates :user_type, inclusion: { in: ["customer", "deliveryman", "restaurant_owner", "admin"] }

    enum user_type: { customer:0, deliveryman:1, restaurant_owner:2, admin:3 }
end
