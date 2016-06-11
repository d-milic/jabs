# Model class for a post comment
class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
end
