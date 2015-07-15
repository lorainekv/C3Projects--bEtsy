class User < ActiveRecord::Base
  has_many :products
  has_many :orders

  validates :username, presence: true
  validates :email, presence: true
end
