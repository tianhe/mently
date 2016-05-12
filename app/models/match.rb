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
    dating_mentees = Match.dating.map(&:mentees).uniq
    dating_mentees.each do |mentee|
      mentee.mentors.dating
    end
  end
end