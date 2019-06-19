class User < ApplicationRecord
  has_many :recipes
  has_many :comments
  has_many :ratings

  validates :name, uniqueness: true, presence: true
  validates :email, presence: true, format: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  
  has_secure_password

  def self.create_by_google_pmniauth(auth)
    self.find_or_create_by(name: auth[:info][:email]) do |u|
        u.password = SecureRandom.hex
    end
  end

  def self.create_by_github_omniauth(auth)
    self.find_or_create_by(name: auth[:info][:email]) do |u|
        u.password = SecureRandom.hex
    end
  end
  
end
