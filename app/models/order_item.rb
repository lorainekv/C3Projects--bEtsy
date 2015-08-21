class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product
# VALIDATIONS
# --------------------------------------------------------------------
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }


# SCOPES
# --------------------------------------------------------------------


end
# 5 items, 3 merchants. For each merchant, give me their address (origin) and 
# the weight and dimensions of the (package).  Look at the order and tell
# me where its going(destination). package that info like this and pass it to the API 


