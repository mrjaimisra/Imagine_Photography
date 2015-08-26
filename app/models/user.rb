class User < ActiveRecord::Base
  has_secure_password
  has_many :orders
  has_many :user_roles
  has_many :roles, through: :user_roles

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
end
