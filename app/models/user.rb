class User < ActiveRecord::Base
  after_create :set_default_role

  has_secure_password
  has_many :orders
  has_many :user_roles
  has_many :roles, through: :user_roles

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true

  def set_default_role
    self.roles << Role.find_by(name: "registered_user")
  end

  def registered_user?
    roles.exists?(name: 'registered_user')
  end

  def store_admin?
    roles.exists?(name: 'store_admin')
  end

  def platform_admin?
    roles.exists?(name: 'platform_admin')
  end

  def self.registered_users
    all.joins(:roles).where(roles: { name: "registered_user" })
  end

  def self.store_admins
    all.joins(:roles).where(roles: { name: "store_admin" })
  end

  def self.platform_admins
    all.joins(:roles).where(roles: { name: "platform_admin" })
  end

end
