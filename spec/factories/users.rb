FactoryGirl.define do
  factory :user do
    sequence :username do |n|
      "user#{n}"
    end
    first_name 'name'
    last_name 'surname'
    sequence :email do |n|
      "mail#{n}@mail.com"
    end
    password 'password'
  end
end
