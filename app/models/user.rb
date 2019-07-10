class User < ApplicationRecord
  has_many :recipes
  has_many :comments
  has_many :ratings

  validates :name, presence: true

  validates :email, uniqueness: true, presence: true, format: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  validates :email, confirmation: true
  
  has_secure_password

  def self.find_or_create_by_omniauth(auth_hash)
    self.where(uid: auth_hash['uid']).first_or_create do |user|
      user.password = SecureRandom.hex
    end
  end
  
end
