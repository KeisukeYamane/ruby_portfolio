FactoryBot.define do
  factory :post do
    title "Hello"
    content "Hello World"
    post_image "test.jpeg"
    association :user
  end

  trait :empty do
    post_image nil
  end
  
end