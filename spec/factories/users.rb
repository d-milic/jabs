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

    factory :user_with_posts do
      transient do
        posts_count 5
      end

      after(:create) do |user, evaluator|
        # evaluator.posts_count.times(FactoryGirl.create(:post, user: user))
        create_list(:post, evaluator.posts_count, user: user)
      end
    end
  end
end
