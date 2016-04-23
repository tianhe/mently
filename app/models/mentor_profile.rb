class MentorProfile < ActiveRecord::Base
  belongs_to :user

  before_save :update_availability, if: :capacity_changed?

  def update_availability
    if self.capacity > 0
      self.is_available = self.capacity > user.mentees.where("matches.start_date <= ? and matches.end_date >= ?", Date.today, Date.today).count
    else
      self.is_available = false
    end
    true
  end
end
