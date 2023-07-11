class User < ApplicationRecord
  attr_accessor :remember_token

  has_secure_password
  validates :first_name, :last_name, presence: true, length: { maximum: 254 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }, presence: true, length: { maximum: 254 }
  validates :password, :password_confirmation, presence: true, length: { minimum: 6 }, allow_nil: true
  
  def digest(string)
    ActiveModel::SecurePassword.min_cost ? cost = BCrypt::Engine::MIN_COST : cost = BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  def new_token
    SecureRandom.urlsafe_base64
  end

  def admin?
    admin
  end

  def remember
    self.remember_token = new_token
    update_attribute(:remember_digest, digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?

    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end
end
