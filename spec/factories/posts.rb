FactoryGirl.define do
  factory :post do
    sequence :title do |n|
      "title#{n}"
    end
    content 'content'
    user
    category Category.first
  end
end
