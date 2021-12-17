class User < ApplicationRecord
  has_secure_password

  validates :email, :password_digest, :age, :type, presence: true
  validates :email, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :age, numericality: { only_integer: true, greater_than_or_equal_to: 18, less_than_or_equal_to: 100 }
  validates :type, inclusion: { in: %w[Employee Owner] }

  belongs_to :store
  has_many :tokens

  accepts_nested_attributes_for :store
end
