class Order < ActiveRecord::Base
  has_many :order_items
  belongs_to :user
  has_one :shipment

# VALIDATIONS
# --------------------------------------------------------------------
  validates_with OrderValidator, :on => :update
end
