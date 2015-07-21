class Order < ActiveRecord::Base
  has_many :order_items
  belongs_to :user

  validates_with OrderValidator, :on => :update
end
