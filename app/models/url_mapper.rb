class UrlMapper < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :url, format: URI::DEFAULT_PARSER.make_regexp(%w[http https]), presence: true

  before_create :add_slug

  def new_token
    loop do
      token = SecureRandom.base64(8)
      break token unless UrlMapper.where(slug: token).exists?
    end
  end

  def add_slug
    self.slug = new_token
  end
end
