require "net/http"
class User < ActiveRecord::Base
  validates :username, presence: true, uniqueness: true
  has_secure_password
  has_many :orders

  enum role: %w(default admin)
end
