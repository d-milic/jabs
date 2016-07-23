FactoryGirl.define do
  factory :comment do
    content 'content'
    user
    post
  end
end
