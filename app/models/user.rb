class User < ActiveRecord::Base
  has_many :products
  has_many :orders
  has_secure_password
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: /@/

end
