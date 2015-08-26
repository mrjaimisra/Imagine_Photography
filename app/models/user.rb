class User < ActiveRecord::Base
  has_secure_password
  has_many :orders
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true

  enum role: %w(default business_admin photographer platform_admin)

  scope :customers,      -> { where(role: 0) }
  scope :photographers,  -> { where(role: 2) }
end
