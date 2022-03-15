class User < ApplicationRecord
    has_one :wallet, dependent: :destroy
    has_one :deliveryman_application, dependent: :destroy
    has_one :restaurant, dependent: :destroy
    has_one :cart, dependent: :destroy
    has_many :orders
    has_many :addresses, as: :addressable

    has_secure_password

    validates :name, :email, :phone, :birthdate, :user_type, presence: true
    validates :email, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }
    validates :cpf, format: { with: /\d{3}\.\d{3}\.\d{3}\-\d{2}/ }
    validates :user_type, inclusion: { in: ["customer", "deliveryman", "restaurant_owner", "admin"] }

    enum user_type: { customer:0, deliveryman:1, restaurant_owner:2, admin:3 }

    def verify_deliveryman_application_rejection
        status = self.deliveryman_application.status
        self.destroy and return true if status == 'rejected'
    end
end
