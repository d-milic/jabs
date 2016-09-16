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

  factory :fixed_title_post, parent: :post do
    title 'fixed_title'
    content 'cnt'
    category
  end

  factory :updated_fixed_title_post, parent: :fixed_title_post do
    content '123'
  end
end
