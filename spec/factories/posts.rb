FactoryBot.define do
  factory :post do
    title "Hello"
    content "Hello World"
    post_image "test.jpeg"
    association :user
  end

  trait :empty do
    user_id nil
    post_image nil
  end
end