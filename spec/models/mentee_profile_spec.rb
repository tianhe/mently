require 'rails_helper'

RSpec.describe MenteeProfile, type: :model do
  it 'should update is_available to false if capacity is 0' do
    mentee = create(:user)
    mentee.mentee_profile.update_attributes(capacity: 0)
    expect(mentee.mentee_profile.is_available).to eq(false)
  end

  it 'should upate is_available to true if no mentors and capacity is updated to 1' do
    mentee = create(:user)
    mentee.mentee_profile.update_attributes(capacity: 1)    
    expect(mentee.mentee_profile.is_available).to eq(true)
  end

  it 'should update is_available to false if has 1 mentor and capacity is updated to 1' do
    mentee = create(:user)
    create(:match, mentee: mentee)
    mentee.mentee_profile.update_attributes(capacity: 1)

    expect(mentee.mentee_profile.is_available).to eq(false)
  end
end
