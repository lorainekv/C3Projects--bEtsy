class Order < ActiveRecord::Base
  has_many :order_items
  belongs_to :user

# VALIDATIONS
# --------------------------------------------------------------------
  validates_with OrderValidator, :on => :update


end
