class Match < ActiveRecord::Base
  belongs_to :mentor, class_name: "User"
  belongs_to :mentee, class_name: "User"

  after_save :update_availability
  
  enum status: [:dating, :dated, :waiting_to_confirm, :active, :inactive]

  def update_availability    
    self.mentor.update_availability 
    self.mentee.update_availability
  end

  def self.greedy_match
    dating_mentees = Match.dating.map(&:mentee).uniq
    
    dating_mentees.each do |mentee|
      mentor_match = mentee.mentor_matches.dating.find do |mentor_match|
        mentor_match.mentor.is_available_as_mentor?
      end

      if mentor_match
        mentee.match_with_mentor(mentor_match.mentor)
      end
    end
  end
end