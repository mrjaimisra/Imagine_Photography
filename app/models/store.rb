class Store < ActiveRecord::Base
  has_many :photos
  has_many :users

  has_attached_file :avatar, styles: { medium: "300x300#",
                                       thumb: "150x150#" },
                                       default_url: "/images/:style/jorge.jpg"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  has_attached_file :header, styles: { xlarge: "2000x800"},
                                       default_url: "/images/:style/header-0.jpg"
  validates_attachment_content_type :header, content_type: /\Aimage\/.*\Z/

  validates :name, presence: true,
                   length: { maximum: 80 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }

  before_validation :generate_url

  def generate_url
    self.url = name.parameterize
  end

  def sample_photos
    self.photos.sample(4)
  end
end
