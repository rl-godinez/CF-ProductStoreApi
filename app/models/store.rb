class Store < ApplicationRecord
  validates :name, presence: true

  has_one :owner
  has_many :employees
  has_many :products
end
