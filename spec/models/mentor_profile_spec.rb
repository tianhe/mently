require 'rails_helper'

RSpec.describe MentorProfile, type: :model do
  it 'should update is_available to false if capacity is 0' do
    mentor = create(:user)
    mentor.mentor_profile.update_attributes(capacity: 0)
    expect(mentor.mentor_profile.is_available).to eq(false)
  end

  it 'should upate is_available to true if capacity is 1 and mentors is 0' do
    mentor = create(:user)
    mentor.mentor_profile.update_attributes(capacity: 1)    
    expect(mentor.mentor_profile.is_available).to eq(true)
  end

  it 'should update is_available to false if capacity is 1 and mentors is 1' do
    mentor = create(:user)
    create(:match, mentor: mentor)
    mentor.mentor_profile.update_attributes(capacity: 1)
    
    expect(mentor.mentor_profile.is_available).to eq(false)
  end
end
