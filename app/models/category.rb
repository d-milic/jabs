# Model class for a post category
class Category < ActiveRecord::Base
  has_many :posts

  validates :name,
            presence: true,
            uniqueness: true
end
