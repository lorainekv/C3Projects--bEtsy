class Product < ActiveRecord::Base
  has_and_belongs_to_many :category
  belongs_to :user
  has_many :reviews

  # ____ VALIDATIONS ____

  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, numericality: {only_decimal: true, greater_than: 0}
  validates :user_id, presence: true
  validates :status, inclusion: { in: %w(active retired)}

  # ____ SCOPES ____

  scope :active, -> { where(status: "active")}

end
