FactoryGirl.define do
  factory :post do
    sequence :title do |n|
      "title#{n}"
    end
    content 'content'
    user
    category
  end

  factory :invalid_post, parent: :post do
    title ''
    content ''
  end
end
