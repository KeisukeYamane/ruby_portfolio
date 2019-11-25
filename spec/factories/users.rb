FactoryBot.define do
  factory :user do
    name "Jhon"
    sequence(:email) { |n| "tester#{n}@example.com"}
    password "1111"
    password_confirmation "1111"
  end

  trait :many_posts_with_user do
    after(:create) { |user| create_list(:post, 5, user: user) }
  end

  trait :image do
    image nil
  end

  trait :invaild_name do
    name nil
  end

end
