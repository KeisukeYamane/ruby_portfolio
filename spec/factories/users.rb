FactoryBot.define do
  factory :user do
    name "Jhon"
    sequence(:email) { |n| "tester#{n}@example.com"}
    password "1111"
  end

  trait :many_posts_with_user do
    after(:create) { |user| create_list(:post, 5, user: user) }
  end

end
