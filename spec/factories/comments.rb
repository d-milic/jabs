FactoryGirl.define do
  factory :comment do
    content 'content'
    user
    post
  end

  factory :invalid_comment, parent: :comment do
    content ''
  end
end
