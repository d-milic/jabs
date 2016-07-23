# Model class for a blog post
class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :comments

  validates :title, :content,
            presence: true
  validates :title, uniqueness: {
    scope: :user_id,
    message: 'You can\'t have two posts with the same name'
  }
end
