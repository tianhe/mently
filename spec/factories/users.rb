FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password "password"
    password_confirmation "password"
  end

  factory :match do
    association :mentor, factory: :user
    association :mentee, factory: :user
    status 1
    start_date Date.today
    end_date Date.tomorrow
  end
end
