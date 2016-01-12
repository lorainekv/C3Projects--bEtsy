class Shipment < ActiveRecord::Base
  belongs_to :order

  # Validations ----------
  validates :address, :city, :state, :zipcode, :country, :order_id, presence: true
  validates_with ShipmentValidator
end
