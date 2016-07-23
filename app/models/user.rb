# Model class for a blog user
class User < ActiveRecord::Base
  has_secure_password

  has_many :posts
  has_many :comments

  validates :username, :password, :email, :first_name, :last_name,
            presence: true
  validates :username, :email,
            uniqueness: true
end
