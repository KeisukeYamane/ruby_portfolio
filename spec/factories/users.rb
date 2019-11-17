FactoryBot.define do
  factory :user do
    name "Jhon"
    sequence(:email) { |n| "tester#{n}@example.com"}
    password "1111"
  end
end
