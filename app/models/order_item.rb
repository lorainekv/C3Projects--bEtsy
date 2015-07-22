class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product
# VALIDATIONS
# --------------------------------------------------------------------
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }


# SCOPES
# --------------------------------------------------------------------

end
