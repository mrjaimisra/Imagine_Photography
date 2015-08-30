class Store < ActiveRecord::Base
  has_many :photos

  has_attached_file :avatar, styles: { medium: "300x300#",
                                       thumb: "150x150#" },
                                       default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  has_attached_file :header, styles: { xlarge: "2000x800"},
                                       default_url: "/images/:style/missing.png"
  validates_attachment_content_type :header, content_type: /\Aimage\/.*\Z/

  before_validation :generate_url

  def generate_url
    self.url = name.parameterize
  end
end
