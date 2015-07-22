class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product
# VALIDATIONS
# --------------------------------------------------------------------
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }


# SCOPES
# --------------------------------------------------------------------
  scope :user_order_items, -> { where(user_id: session[:user_id] )}



# Order's with OrderItems that have a user_id attribute that matches session[:user_id]

# records where the OrderItem.user_id = session[:user_id]
end
