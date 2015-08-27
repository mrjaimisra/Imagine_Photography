class User < ActiveRecord::Base
  after_save :set_default_role

  has_secure_password
  has_many :orders
  has_many :user_roles
  has_many :roles, through: :user_roles

  validates :name, presence: true,
                     length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                  uniqueness: { case_sensitive: false },
                      length: { maximum: 255 },
                      format: { with: VALID_EMAIL_REGEX }

  validates :password, presence: true,
                         length: { maximum: 50 }

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
