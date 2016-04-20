require 'rails_helper'

RSpec.describe User, type: :model do
  it 'should create a mentor profile by default' do
    user = create(:user)
    expect(user.mentor_profile).to_not be(nil)
  end

  it 'should create a mentee profile by default' do
    user = create(:user)
    expect(user.mentee_profile).to_not be(nil)
  end

  it 'should create a general profile by default' do
    user = create(:user)
    expect(user.profile).to_not be(nil)

  end

  it 'should return users who are available as mentors' do
    user1 = create(:user)
    user2 = create(:user)
    user1.mentor_profile.update_attributes(is_available: true)
    expect(User.is_available_as_mentor(true).to_a).to eq([user1])
  end

  it 'should return users who are available as mentees' do
    user1 = create(:user)
    user2 = create(:user)
    user1.mentee_profile.update_attributes(is_available: true)
    expect(User.is_available_as_mentee(true).to_a).to eq([user1])
  end

  it 'should return users who are of a department' do
    user1 = create(:user)
    user2 = create(:user)
    user2.profile.update_attributes(department: 'Tech')
    expect(User.by_department('Tech').to_a).to eq([user2])
  end
end
