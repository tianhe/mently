FactoryGirl.define do
  factory :mentor_profile do
    user
    capacity 1
    is_available false
    mentee_criteria "MyText"
  end

end
