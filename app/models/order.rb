class Order < ActiveRecord::Base
  has_many :order_items
  belongs_to :user

  include ActiveModel::Validations
  validates_with OrderValidator
end
