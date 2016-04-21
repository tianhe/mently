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

  context '#mentee availability' do
    it 'should return is not availabile if the mentee capacity is 0' do
      user1 = create(:user)
      user1.mentee_profile.update_attributes(capacity: 0)

      expect(user1.is_available_as_mentee?).to eq(false)    
    end

    it 'should return available is the capacity is 1 and no mentors' do
      mentee = create(:user)
      mentee.mentee_profile.update_attributes(capacity: 1)

      expect(mentee.is_available_as_mentee?).to eq(true)    
    end

    it 'should return available is the capacity is 2 and mentors is 1' do
      mentee = create(:user)
      mentee.mentee_profile.update_attributes(capacity: 2)
      match = create(:match, mentee: mentee)

      expect(mentee.is_available_as_mentee?).to eq(true)    
    end

    it 'should return is not available if the capacity is 1 and a new mentor is added' do
      mentee = create(:user)
      mentee.mentee_profile.update_attributes(capacity: 1)
      match = create(:match, mentee: mentee)

      expect(mentee.is_available_as_mentee?).to eq(false)    
    end
  end

  context '#mentor availability' do
    it 'should return is not availabile if the mentee capacity is 0' do
      user1 = create(:user)
      user1.mentor_profile.update_attributes(capacity: 0)

      expect(user1.is_available_as_mentor?).to eq(false)    
    end

    it 'should return available is the capacity is 1 and no mentors' do
      mentor = create(:user)
      mentor.mentor_profile.update_attributes(capacity: 1)
      
      expect(mentor.is_available_as_mentor?).to eq(true)    
    end

    it 'should return available is the capacity is 2 and mentors is 1' do
      mentor = create(:user)
      mentor.mentor_profile.update_attributes(capacity: 2)
      match = create(:match, mentor: mentor)

      expect(mentor.is_available_as_mentor?).to eq(true)    
    end

    it 'should return is not available if the capacity is 1 and a new mentor is added' do
      mentor = create(:user)
      mentor.mentor_profile.update_attributes(capacity: 1)
      match = create(:match, mentor: mentor)

      expect(mentor.is_available_as_mentor?).to eq(false)    
    end
  end

end
