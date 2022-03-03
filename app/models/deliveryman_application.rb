class DeliverymanApplication < ApplicationRecord
  belongs_to :user

  validates :vehicle_type, :cnh, presence: true
  validates :cnh, format: { with: /\d{11}/ }
  validates :vehicle_type, inclusion: { in: ["motorcycle", "car"] }
  validates :status, inclusion: { in: ["pending", "accepted", "rejected"]}

  enum vehicle_type: { motorcycle:0, car:1 }
  enum status: { pending:0, accepted:0, rejected:0 }
end
