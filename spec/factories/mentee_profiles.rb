FactoryGirl.define do
  factory :mentee_profile do
    user
    capacity 1
    is_available false
    mentor_criteria "MyText"
  end
end
