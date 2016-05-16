require 'rails_helper'

RSpec.describe Match, type: :model do
  it 'should match mentees with their topic picks if the pick is available' do    
    top_match = create(:match, mentor_rank: 1)
    mentee = top_match.mentee
    top_mentor = top_match.mentor

    second_mentor = create(:user)
    second_match = create(:match, mentor: second_mentor, mentee: mentee, mentor_rank: 2)

    top_mentor.mentor_profile.update_attributes(capacity: 1)
    second_mentor.mentor_profile.update(capacity: 2)
    mentee.mentee_profile.update(capacity: 1)

    Match.greedy_match
    
    expect(top_match.reload.status).to eq('waiting_to_confirm')
    expect(second_match.reload.status).to eq('dated')
  end

  it 'should match mentees with their second picks if their first pick isn\'t available' do
    top_match = create(:match, mentor_rank: 1)
    mentee = top_match.mentee
    top_mentor = top_match.mentor

    second_mentor = create(:user)
    second_match = create(:match, mentor: second_mentor, mentee: mentee, mentor_rank: 2)

    top_mentor.mentor_profile.update_attributes(capacity: 0)
    second_mentor.mentor_profile.update(capacity: 2)
    mentee.mentee_profile.update(capacity: 1)

    Match.greedy_match
    
    expect(top_match.reload.status).to eq('dated')
    expect(second_match.reload.status).to eq('waiting_to_confirm')
  end

  it 'should match mentees with no one if none of their picks are available' do
    top_match = create(:match, mentor_rank: 1)
    mentee = top_match.mentee
    top_mentor = top_match.mentor

    second_mentor = create(:user)
    second_match = create(:match, mentor: second_mentor, mentee: mentee, mentor_rank: 2)

    top_mentor.mentor_profile.update_attributes(capacity: 0)
    second_mentor.mentor_profile.update(capacity: 0)
    mentee.mentee_profile.update(capacity: 1)

    Match.greedy_match
    
    expect(top_match.reload.status).to eq('dating')
    expect(second_match.reload.status).to eq('dating')
  end

  it 'should mark mentees who didnt get first pick' do
    
  end
end
