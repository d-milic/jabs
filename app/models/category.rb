# Model class for a post category
class Category < ActiveRecord::Base
  has_many :posts
  belongs_to :parent_category, class_name: 'Category',
                               foreign_key: 'parent_category_id'
  has_many :subcategories, class_name: 'Category',
                           foreign_key: 'parent_category_id'

  validates :name,
            presence: true,
            uniqueness: true
end
